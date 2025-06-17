/**
 * Invoice PDF Generator
 * Generates professional PDF invoices using jsPDF
 */

class InvoiceGenerator {
    constructor() {
        this.companyInfo = {
            name: "DuckDuckStore",
            address: "Via Roma, 123",
            city: "84084 Fisciano (SA)",
            partitaIVA: "IT12345678901",
            email: "info@duckduckstore.com",
            telefono: "+39 089 123456",
            website: "www.duckduckstore.com"
        };

        this.ivaRate = 0.22; // 22% IVA
    }

    /**
     * Generates a PDF invoice for the given order
     * @param {Object} orderData - Order information
     * @param {Object} customerData - Customer information
     * @param {Array} products - Array of products in the order
     * @param {Object} deliveryData - Delivery information (optional)
     * @param {Object} paymentData - Payment information (optional)
     */
    async generateInvoice(orderData, customerData, products, deliveryData = null, paymentData = null) {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        try {
            // Set document properties
            doc.setProperties({
                title: `Fattura #${orderData.orderId}`,
                subject: 'Fattura DuckDuckStore',
                author: 'DuckDuckStore',
                creator: 'DuckDuckStore Invoice System'
            });

            this.addHeader(doc);
            this.addCompanyInfo(doc);
            this.addInvoiceInfo(doc, orderData);
            this.addCustomerInfo(doc, customerData, deliveryData);
            this.addProductsTable(doc, products);
            this.addTotalSummary(doc, products, orderData.total);
            this.addFooter(doc, paymentData);

            // Open PDF in new window
            const pdfOutput = doc.output('bloburl');
            window.open(pdfOutput, '_blank');

        } catch (error) {
            console.error('Errore durante la generazione del PDF:', error);
            alert('Errore durante la generazione della fattura. Riprova più tardi.');
        }
    }

    addHeader(doc) {
        // Company logo placeholder (you can add actual logo later)
        doc.setFillColor(254, 232, 110); // DuckDuckStore blue
        doc.rect(20, 20, 50, 15, 'F');

        doc.setTextColor(255, 255, 255);
        doc.setFontSize(16);
        doc.setFont('helvetica', 'bold');
        doc.text('DuckDuckStore', 25, 30);

        // Reset text color
        doc.setTextColor(0, 0, 0);

        // Invoice title
        doc.setFontSize(24);
        doc.setFont('helvetica', 'bold');
        doc.text('FATTURA', 150, 30);
    }

    addCompanyInfo(doc) {
        const startY = 50;
        doc.setFontSize(10);
        doc.setFont('helvetica', 'normal');

        doc.text(this.companyInfo.name, 20, startY);
        doc.text(this.companyInfo.address, 20, startY + 5);
        doc.text(this.companyInfo.city, 20, startY + 10);
        doc.text(`P.IVA: ${this.companyInfo.partitaIVA}`, 20, startY + 15);
        doc.text(`Email: ${this.companyInfo.email}`, 20, startY + 20);
        doc.text(`Tel: ${this.companyInfo.telefono}`, 20, startY + 25);
        doc.text(`Web: ${this.companyInfo.website}`, 20, startY + 30);
    }

    addInvoiceInfo(doc, orderData) {
        const startY = 50;
        const startX = 150;

        doc.setFontSize(10);
        doc.setFont('helvetica', 'bold');
        doc.text('Numero Fattura:', startX, startY);
        doc.text('Data Fattura:', startX, startY + 8);
        doc.text('Data Ordine:', startX, startY + 16);

        doc.setFont('helvetica', 'normal');
        doc.text(`#${orderData.orderId}`, startX + 35, startY);
        doc.text(this.formatDate(new Date()), startX + 35, startY + 8);
        doc.text(this.formatDate(orderData.orderDate), startX + 35, startY + 16);
    }

    addCustomerInfo(doc, customerData, deliveryData = null) {
        const startY = 95;

        doc.setFontSize(12);
        doc.setFont('helvetica', 'bold');
        doc.text('FATTURATO A:', 20, startY);

        doc.setFontSize(10);
        doc.setFont('helvetica', 'normal');

        // Use delivery data if available, otherwise customer data
        if (deliveryData && deliveryData.nome && deliveryData.cognome) {
            doc.text(`${deliveryData.nome} ${deliveryData.cognome}`, 20, startY + 10);

            if (deliveryData.via && deliveryData.citta && deliveryData.cap) {
                doc.text(`${deliveryData.via}`, 20, startY + 18);
                doc.text(`${deliveryData.cap} ${deliveryData.citta}`, 20, startY + 26);
            }

            if (deliveryData.telefono) {
                doc.text(`Tel: ${deliveryData.telefono}`, 20, startY + 34);
            }
        } else {
            // Fallback to customer data
            doc.text(`${customerData.nome} ${customerData.cognome}`, 20, startY + 10);
            doc.text(customerData.email, 20, startY + 18);

            if (customerData.indirizzo) {
                doc.text(customerData.indirizzo, 20, startY + 26);
            }
        }

        // Always show customer email if available
        if (customerData.email && deliveryData) {
            doc.text(`Email: ${customerData.email}`, 20, startY + 42);
        }
    }

    addProductsTable(doc, products) {
        const tableData = products.map(product => {
            const basePrice = parseFloat(product.prezzo);
            const discount = parseInt(product.sconto) || 0;
            const discountedPrice = basePrice - (basePrice * discount / 100);
            const quantity = parseInt(product.quantita);
            const subtotal = discountedPrice * quantity;
            const ivaAmount = subtotal * this.ivaRate;
            const total = subtotal + ivaAmount;

            return [
                product.nome,
                this.formatCurrency(basePrice),
                `${quantity}`,
                discount > 0 ? `${discount}%` : '-',
                this.formatCurrency(discountedPrice),
                this.formatCurrency(subtotal),
                '22%',
                this.formatCurrency(ivaAmount),
                this.formatCurrency(total)
            ];
        });

        const columns = [
            'Descrizione',
            'Prezzo Unit.',
            'Qta',
            'Sconto',
            'Prezzo Scont.',
            'Imponibile',
            'IVA %',
            'IVA €',
            'Totale'
        ];

        doc.autoTable({
            head: [columns],
            body: tableData,
            startY: 145,
            styles: {
                fontSize: 9,
                cellPadding: 3,
            },
            headStyles: {
                fillColor: [254, 232, 110],
                textColor: [255, 255, 255],
                fontStyle: 'bold'
            },
            columnStyles: {
                0: { cellWidth: 40 }, // Descrizione
                1: { cellWidth: 20, halign: 'right' }, // Prezzo Unit.
                2: { cellWidth: 15, halign: 'center' }, // Qta
                3: { cellWidth: 18, halign: 'center' }, // Sconto
                4: { cellWidth: 22, halign: 'right' }, // Prezzo Scont.
                5: { cellWidth: 22, halign: 'right' }, // Imponibile
                6: { cellWidth: 15, halign: 'center' }, // IVA %
                7: { cellWidth: 18, halign: 'right' }, // IVA €
                8: { cellWidth: 20, halign: 'right' } // Totale
            },
            alternateRowStyles: {
                fillColor: [245, 245, 245]
            },
            margin: { left: 10, right: 20 }
        });
    }

    addTotalSummary(doc, products, orderTotal) {
        const finalY = doc.lastAutoTable.finalY + 20;

        // Calculate totals
        let totalImponibile = 0;
        let totalIVA = 0;

        products.forEach(product => {
            const basePrice = parseFloat(product.prezzo);
            const discount = parseInt(product.sconto) || 0;
            const discountedPrice = basePrice - (basePrice * discount / 100);
            const quantity = parseInt(product.quantita);
            const subtotal = discountedPrice * quantity;
            const ivaAmount = subtotal * this.ivaRate;

            totalImponibile += subtotal;
            totalIVA += ivaAmount;
        });

        const totalWithIVA = totalImponibile + totalIVA;

        // Summary box
        const boxX = 130;
        const boxY = finalY;
        const boxWidth = 60;
        const boxHeight = 25;

        doc.setDrawColor(254, 232, 110);
        doc.setLineWidth(1);
        doc.rect(boxX, boxY, boxWidth, boxHeight);

        doc.setFontSize(10);
        doc.setFont('helvetica', 'bold');

        doc.text('Totale Imponibile:', boxX + 2, boxY + 6);
        doc.text('Totale IVA (22%):', boxX + 2, boxY + 12);
        doc.text('TOTALE FATTURA:', boxX + 2, boxY + 20);

        doc.text(this.formatCurrency(totalImponibile), boxX + boxWidth - 2, boxY + 6, { align: 'right' });
        doc.text(this.formatCurrency(totalIVA), boxX + boxWidth - 2, boxY + 12, { align: 'right' });
        doc.text(this.formatCurrency(totalWithIVA), boxX + boxWidth - 2, boxY + 20, { align: 'right' });
    }

    addFooter(doc, paymentData = null) {
        const pageHeight = doc.internal.pageSize.height;
        const footerY = pageHeight - 40;

        doc.setFontSize(8);
        doc.setFont('helvetica', 'normal');
        doc.setTextColor(128, 128, 128);

        // Payment info if available
        if (paymentData && paymentData.cardHolder) {
            doc.text(`Pagamento effettuato con carta intestata a: ${paymentData.cardHolder}`, 20, footerY - 10);
            if (paymentData.maskedCardNumber) {
                doc.text(`Carta utilizzata: ${paymentData.maskedCardNumber}`, 20, footerY - 5);
            }
        }

        doc.text('Grazie per aver scelto DuckDuckStore!', 20, footerY);
        doc.text('Per qualsiasi informazione contattaci al nostro numero verde o via email.', 20, footerY + 5);

        // Page number
        const pageCount = doc.internal.getNumberOfPages();
        doc.text(`Pagina 1 di ${pageCount}`, 170, footerY + 10);
    }

    formatDate(date) {
        if (typeof date === 'string') {
            date = new Date(date);
        }
        return date.toLocaleDateString('it-IT', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric'
        });
    }

    formatCurrency(amount) {
        return `€ ${parseFloat(amount).toFixed(2)}`;
    }
}

// Global function to be called from HTML (New version using embedded JSON data)
async function generateInvoicePDFFromOrderData(orderId) {
    try {
        // Get order data from embedded JSON
        const orderDataElement = document.getElementById(`orderData-${orderId}`);
        if (!orderDataElement) {
            throw new Error('Dati ordine non trovati');
        }

        const orderData = JSON.parse(orderDataElement.textContent);

        // Parse products from scontrino
        const products = parseScontrino(orderData.scontrino);

        // Customer data is already available in the JSON
        const customerData = orderData.customer;

        // Prepare order data for PDF generation
        const pdfOrderData = {
            orderId: orderData.orderId,
            orderDate: new Date(orderData.orderDate),
            total: parseFloat(orderData.total)
        };

        // Generate invoice
        const generator = new InvoiceGenerator();
        await generator.generateInvoice(pdfOrderData, customerData, products, orderData.delivery, orderData.payment);

    } catch (error) {
        console.error('Errore durante la generazione della fattura:', error);
        alert('Errore durante la generazione della fattura. Riprova più tardi.');
    }
}

// Legacy function for backwards compatibility (deprecated)
async function generateInvoicePDFFromOrder(buttonElement) {
    try {
        const orderId = buttonElement.getAttribute('data-order-id');
        const orderDate = buttonElement.getAttribute('data-order-date');
        const orderTotal = buttonElement.getAttribute('data-order-total');
        const scontrino = buttonElement.getAttribute('data-scontrino');
        const userId = buttonElement.getAttribute('data-user-id');

        // Parse products from scontrino
        const products = parseScontrino(scontrino);

        // Get customer data (fallback for legacy calls)
        const customerData = await getCustomerDataFallback(userId);

        // Prepare order data
        const orderData = {
            orderId: orderId,
            orderDate: new Date(orderDate),
            total: parseFloat(orderTotal)
        };

        // Generate invoice
        const generator = new InvoiceGenerator();
        await generator.generateInvoice(orderData, customerData, products);

    } catch (error) {
        console.error('Errore durante la generazione della fattura:', error);
        alert('Errore durante la generazione della fattura. Riprova più tardi.');
    }
}

// Legacy function for backwards compatibility (deprecated)
async function generateInvoicePDF(orderId, orderDate, orderTotal, scontrino, userId) {
    try {
        // Parse products from scontrino
        const products = parseScontrino(scontrino);

        // Get customer data (fallback for legacy calls)
        const customerData = await getCustomerDataFallback(userId);

        // Prepare order data
        const orderData = {
            orderId: orderId,
            orderDate: new Date(orderDate),
            total: parseFloat(orderTotal)
        };

        // Generate invoice
        const generator = new InvoiceGenerator();
        await generator.generateInvoice(orderData, customerData, products);

    } catch (error) {
        console.error('Errore durante la generazione della fattura:', error);
        alert('Errore durante la generazione della fattura. Riprova più tardi.');
    }
}

// Fallback function to get customer data for legacy calls
async function getCustomerDataFallback(userId) {
    // This is a fallback for legacy calls - in practice this should not be used anymore
    // since we now embed the data in the page
    return {
        nome: 'Cliente',
        cognome: 'Non Specificato',
        email: 'N/A',
        indirizzo: 'Indirizzo non disponibile'
    };
}

// Function to parse scontrino string into products array
function parseScontrino(scontrino) {
    try {
        // Decode HTML entities if necessary
        const decodedScontrino = decodeHTMLEntities(scontrino);

        // Parse JSON
        const products = JSON.parse(decodedScontrino);

        // Ensure it's an array
        const productArray = Array.isArray(products) ? products : [products];

        // Validate and normalize product data
        return productArray.map(product => ({
            nome: product.nome || 'Prodotto sconosciuto',
            prezzo: parseFloat(product.prezzo) || 0,
            quantita: parseInt(product.quantita) || 1,
            sconto: parseInt(product.sconto) || 0,
            ID: product.ID || 0
        }));

    } catch (error) {
        console.error('Errore nel parsing dello scontrino:', error);
        console.error('Scontrino ricevuto:', scontrino);

        // Fallback: create a simple product entry
        return [{
            nome: 'Prodotto non specificato',
            prezzo: 0,
            quantita: 1,
            sconto: 0,
            ID: 0
        }];
    }
}

// Helper function to decode HTML entities
function decodeHTMLEntities(text) {
    const textArea = document.createElement('textarea');
    textArea.innerHTML = text;
    return textArea.value;
}
