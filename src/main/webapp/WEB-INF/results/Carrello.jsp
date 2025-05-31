<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="it">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>DuckDuckStore | Carrello</title>
                <!-- Core styles -->
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/design-system.css">
                <!-- Component-specific styles -->
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css">
                <!-- Fonts -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">
            </head>

            <body>
                <%@ include file="header.jsp" %>
                    <% String errormsg=(String) request.getAttribute("errore"); Carrello carrello=(Carrello)
                        session.getAttribute("carrello"); ArrayList<Prodotto> listaProdottiCarrello = (ArrayList
                        <Prodotto>) carrello.getProdotti();

                            double subtotale = 0.0;
                            boolean isUtenteAutenticato = session.getAttribute("Utente") != null;
                            double saldoUtente = isUtenteAutenticato ? ((Utente)
                            session.getAttribute("Utente")).getSaldo() : 0.0;

                            for (Prodotto p : listaProdottiCarrello) {
                            double prezzo = p.getPrezzo();
                            if (p.getSconto() != 0) {
                            prezzo -= (prezzo / 100 * p.getSconto());
                            }
                            subtotale += prezzo * p.getQuantita();
                            }

                            double iva = subtotale * 0.22;
                            double totale = subtotale + iva;
                            %>

                            <main class="main">
                                <div class="container">
                                    <h1 class="page-title">Il Mio Carrello</h1>

                                    <% if (listaProdottiCarrello.isEmpty()) { %>
                                        <div class="cart-empty">
                                            <div class="cart-empty-icon">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64"
                                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                    stroke-width="1" stroke-linecap="round" stroke-linejoin="round">
                                                    <circle cx="9" cy="21" r="1"></circle>
                                                    <circle cx="20" cy="21" r="1"></circle>
                                                    <path
                                                        d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6">
                                                    </path>
                                                </svg>
                                            </div>
                                            <h2 class="cart-empty-title">Il tuo carrello è vuoto</h2>
                                            <p class="cart-empty-text">Sembra che non hai ancora aggiunto prodotti al
                                                tuo carrello.</p>
                                            <a href="home" class="btn btn-primary">Continua lo Shopping</a>
                                        </div>
                                        <% } else { %>
                                            <div class="cart-content">
                                                <div class="cart-items">
                                                    <div class="cart-header">
                                                        <span class="cart-header-product">Prodotto</span>
                                                        <span class="cart-header-price">Prezzo</span>
                                                        <span class="cart-header-quantity">Quantità</span>
                                                        <span class="cart-header-total">Totale</span>
                                                        <span class="cart-header-actions">Azioni</span>
                                                    </div>

                                                    <form id="cartForm" action="carrello" method="post">
                                                        <input type="hidden" name="action" value="checkout">
                                                        <% for (Prodotto p : listaProdottiCarrello) { double
                                                            prezzo=p.getPrezzo(); if (p.getSconto() !=0) { prezzo
                                                            -=(prezzo / 100 * p.getSconto()); } double
                                                            prezzoTotale=prezzo * p.getQuantita(); %>
                                                            <div class="cart-item">
                                                                <div class="cart-item-product">
                                                                    <img src="<%= p.getImg() %>"
                                                                        alt="<%= p.getNome() %>" class="cart-item-img">
                                                                    <div class="cart-item-details">
                                                                        <h3 class="cart-item-name">
                                                                            <%= p.getNome() %>
                                                                        </h3>
                                                                        <p class="cart-item-category">
                                                                            <%= p.getCategoria() %>
                                                                        </p>
                                                                    </div>
                                                                </div>

                                                                <div class="cart-item-price">
                                                                    <span>&euro;<%= String.format("%.2f", prezzo) %>
                                                                    </span>
                                                                </div>

                                                                <div class="cart-item-quantity">
                                                                    <div class="quantity-input">
                                                                        <button type="button"
                                                                            class="quantity-btn quantity-decrease"
                                                                            onclick="decreaseQuantity(<%= p.getID() %>, <%= prezzo %>)">-</button>
                                                                        <input type="number"
                                                                            id="quantity_<%= p.getID() %>"
                                                                            name="quantity_<%= p.getID() %>" min="1"
                                                                            max="99" value="<%= p.getQuantita() %>"
                                                                            onchange="updateQuantity(this, <%= p.getID() %>, <%= prezzo %>)"
                                                                            class="quantity-value">
                                                                        <button type="button"
                                                                            class="quantity-btn quantity-increase"
                                                                            onclick="increaseQuantity(<%= p.getID() %>, <%= prezzo %>)">+</button>
                                                                    </div>
                                                                </div>

                                                                <div class="cart-item-total">
                                                                    <span id="total_<%= p.getID() %>">&euro;<%=
                                                                            String.format("%.2f", prezzoTotale) %>
                                                                    </span>
                                                                </div>

                                                                <div class="cart-item-actions">
                                                                    <button type="button" class="remove-item-btn"
                                                                        onclick="window.location.href='carrello?action=removeitem&ID=<%= p.getID() %>'">
                                                                        <svg xmlns="http://www.w3.org/2000/svg"
                                                                            width="20" height="20" viewBox="0 0 24 24"
                                                                            fill="none" stroke="currentColor"
                                                                            stroke-width="2" stroke-linecap="round"
                                                                            stroke-linejoin="round">
                                                                            <polyline points="3 6 5 6 21 6"></polyline>
                                                                            <path
                                                                                d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2">
                                                                            </path>
                                                                            <line x1="10" y1="11" x2="10" y2="17">
                                                                            </line>
                                                                            <line x1="14" y1="11" x2="14" y2="17">
                                                                            </line>
                                                                        </svg>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                            <% } %>
                                                    </form>

                                                    <div class="cart-actions">
                                                        <a href="home" class="btn btn-outline">Continua lo Shopping</a>
                                                        <button type="button" class="btn btn-outline-primary"
                                                            onclick="updateCart()">Aggiorna Carrello</button>
                                                    </div>
                                                </div>

                                                <div class="cart-summary">
                                                    <h2 class="summary-title">Riepilogo Ordine</h2>

                                                    <div class="summary-row">
                                                        <span class="summary-label">Subtotale</span>
                                                        <span class="summary-value" id="subtotale">&euro;<%=
                                                                String.format("%.2f", subtotale) %></span>
                                                    </div>

                                                    <div class="summary-row">
                                                        <span class="summary-label">IVA (22%)</span>
                                                        <span class="summary-value" id="iva">&euro;<%=
                                                                String.format("%.2f", iva) %></span>
                                                    </div>

                                                    <div class="summary-row summary-total">
                                                        <span class="summary-label">Totale</span>
                                                        <span class="summary-value" id="totale">&euro;<%=
                                                                String.format("%.2f", totale) %></span>
                                                    </div>

                                                    <% if (isUtenteAutenticato) { %>
                                                        <div class="summary-row summary-balance">
                                                            <span class="summary-label">Saldo Disponibile</span>
                                                            <span class="summary-value">&euro;<%= String.format("%.2f",
                                                                    saldoUtente) %></span>
                                                        </div>

                                                        <button type="button" class="btn btn-primary checkout-btn"
                                                            onclick="document.getElementById('cartForm').submit()">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="20"
                                                                height="20" viewBox="0 0 24 24" fill="none"
                                                                stroke="currentColor" stroke-width="2"
                                                                stroke-linecap="round" stroke-linejoin="round">
                                                                <line x1="12" y1="1" x2="12" y2="23"></line>
                                                                <path
                                                                    d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6">
                                                                </path>
                                                            </svg>
                                                            Procedi al Checkout
                                                        </button>

                                                        <% if (errormsg !=null) { %>
                                                            <div class="error-message">
                                                                <%= errormsg %>
                                                            </div>
                                                            <% } %>

                                                                <% } else { %>
                                                                    <div class="cart-login">
                                                                        <p>Si prega di effettuare l'accesso per
                                                                            completare l'ordine</p>
                                                                        <a href="login"
                                                                            class="btn btn-primary">Accedi</a>
                                                                        <a href="registration"
                                                                            class="btn btn-outline-secondary">Registrati</a>
                                                                    </div>
                                                                    <% } %>
                                                </div>
                                            </div>
                                            <% } %>
                                </div>
                            </main>

                            <%@ include file="footer.jsp" %>

                                <script>
                                    function updateQuantity(input, productID, prezzo) {
                                        const quantity = parseInt(input.value);
                                        updateItemTotal(productID, quantity, prezzo);
                                        recalculateTotals();
                                        sendUpdateRequest(productID, quantity);
                                    }

                                    function increaseQuantity(productID, prezzo) {
                                        const input = document.getElementById('quantity_' + productID);
                                        const currentValue = parseInt(input.value);
                                        const maxValue = parseInt(input.getAttribute('max'));

                                        if (currentValue < maxValue) {
                                            input.value = currentValue + 1;
                                            updateQuantity(input, productID, prezzo);
                                        }
                                    }

                                    function decreaseQuantity(productID, prezzo) {
                                        const input = document.getElementById('quantity_' + productID);
                                        const currentValue = parseInt(input.value);

                                        if (currentValue > 1) {
                                            input.value = currentValue - 1;
                                            updateQuantity(input, productID, prezzo);
                                        }
                                    }

                                    function updateItemTotal(productID, quantity, prezzo) {
                                        const totalElement = document.getElementById('total_' + productID);
                                        const totalPrice = quantity * prezzo;
                                        totalElement.textContent = '€' + totalPrice.toFixed(2);
                                    }

                                    function recalculateTotals() {
                                        let subtotale = 0;
                                        const cartItems = document.querySelectorAll('.cart-item');

                                        cartItems.forEach(item => {
                                            const priceText = item.querySelector('.cart-item-price span').textContent;
                                            const price = parseFloat(priceText.replace('€', '').replace(',', '.'));
                                            const quantityInput = item.querySelector('.quantity-value');
                                            const quantity = parseInt(quantityInput.value);

                                            subtotale += price * quantity;
                                        });

                                        const iva = subtotale * 0.22;
                                        const totale = subtotale + iva;

                                        document.getElementById('subtotale').textContent = '€' + subtotale.toFixed(2);
                                        document.getElementById('iva').textContent = '€' + iva.toFixed(2);
                                        document.getElementById('totale').textContent = '€' + totale.toFixed(2);
                                    }

                                    function sendUpdateRequest(productID, quantity) {
                                        const xhr = new XMLHttpRequest();
                                        xhr.open("POST", "cart", true);
                                        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                                        xhr.send("action=updateitem&ID=" + productID + "&quantita=" + quantity);
                                    }

                                    function updateCart() {
                                        document.getElementById('cartForm').submit();
                                    }
                                </script>
            </body>

            </html>