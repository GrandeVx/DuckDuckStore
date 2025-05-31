<%@ page import="model.ProdottoDAO" %>
    <%@ page import="model.Prodotto" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
                <!DOCTYPE html>
                <html lang="it">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>DuckDuckStore | <%= ((Prodotto)request.getAttribute("prodotto")).getNome() %>
                    </title>
                    <!-- Core styles -->
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/design-system.css">
                    <!-- Component-specific styles -->
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product.css">
                    <!-- Fonts -->
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                        rel="stylesheet">
                </head>

                <body>
                    <%@ include file="header.jsp" %>

                        <% Prodotto prodotto=(Prodotto) request.getAttribute("prodotto"); %>

                            <main class="main">
                                <div class="container">
                                    <div class="product-breadcrumb">
                                        <a href="home" class="breadcrumb-link">Home</a>
                                        <span class="breadcrumb-separator">/</span>
                                        <a href="search?category=<%= prodotto.getCategoria() %>"
                                            class="breadcrumb-link">
                                            <%= prodotto.getCategoria() %>
                                        </a>
                                        <span class="breadcrumb-separator">/</span>
                                        <span class="breadcrumb-current">
                                            <%= prodotto.getNome() %>
                                        </span>
                                    </div>

                                    <div class="product-container">
                                        <div class="product-gallery">
                                            <div class="product-main-image">
                                                <img src="<%= prodotto.getImg() %>" alt="<%= prodotto.getNome() %>"
                                                    class="product-img">
                                            </div>
                                            <div class="product-thumbnails">
                                                <div class="product-thumbnail active">
                                                    <img src="<%= prodotto.getImg() %>" alt="<%= prodotto.getNome() %>"
                                                        class="thumbnail-img">
                                                </div>
                                                <!-- Additional thumbnails would go here -->
                                            </div>
                                        </div>

                                        <div class="product-details">
                                            <h1 class="product-title">
                                                <%= prodotto.getNome() %>
                                            </h1>

                                            <div class="product-price-container">
                                                <span class="product-price">
                                                    <%= String.format("%.2f", prodotto.getPrezzo()) %> &#8364
                                                </span>

                                                <% if (prodotto.getSconto()> 0) {
                                                    double originalPrice = prodotto.getPrezzo() / (1 -
                                                    prodotto.getSconto() / 100.0);
                                                    %>
                                                    <div class="product-price-discount">
                                                        <span class="product-price-original">
                                                            <%= String.format("%.2f", originalPrice) %> &#8364
                                                        </span>
                                                        <span class="product-discount badge badge-primary">
                                                            <%= prodotto.getSconto() %> %
                                                        </span>
                                                    </div>
                                                    <% } %>
                                            </div>

                                            <div class="product-description">
                                                <p>
                                                    <%= prodotto.getDescrizione() %>
                                                </p>
                                            </div>

                                            <div class="product-meta">
                                                <div class="product-meta-item">
                                                    <span class="meta-label">Categoria:</span>
                                                    <span class="meta-value">
                                                        <%= prodotto.getCategoria() %>
                                                    </span>
                                                </div>
                                                <div class="product-meta-item">
                                                    <span class="meta-label">ID Prodotto:</span>
                                                    <span class="meta-value">
                                                        <%= prodotto.getID() %>
                                                    </span>
                                                </div>
                                                <div class="product-meta-item">
                                                    <span class="meta-label">Disponibilita:</span>
                                                    <% if (prodotto.getQuantita()> 0) { %>
                                                        <span class="meta-value in-stock">In Stock (<%=
                                                                prodotto.getQuantita() %> disponibilita)</span>
                                                        <% } else { %>
                                                            <span class="meta-value out-of-stock">Out of Stock</span>
                                                            <% } %>
                                                </div>
                                            </div>

                                            <div class="product-actions">
                                                <form action="carrello" method="post" class="add-to-cart-form">
                                                    <div class="quantity-input">
                                                        <button type="button" class="quantity-btn quantity-decrease"
                                                            onclick="decreaseQuantity()">-</button>
                                                        <input type="number" name="quantita" value="1" min="1"
                                                            max="<%= prodotto.getQuantita() %>" class="quantity-value"
                                                            id="quantity">
                                                        <button type="button" class="quantity-btn quantity-increase"
                                                            onclick="increaseQuantity()">+</button>
                                                    </div>

                                                    <input type="hidden" name="ID" value="<%= prodotto.getID() %>">
                                                    <input type="hidden" name="action" value="additem">

                                                    <% if (prodotto.getQuantita()> 0) { %>
                                                        <button type="submit" class="btn btn-primary add-to-cart-btn">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="20"
                                                                height="20" viewBox="0 0 24 24" fill="none"
                                                                stroke="currentColor" stroke-width="2"
                                                                stroke-linecap="round" stroke-linejoin="round">
                                                                <circle cx="9" cy="21" r="1"></circle>
                                                                <circle cx="20" cy="21" r="1"></circle>
                                                                <path
                                                                    d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6">
                                                                </path>
                                                            </svg>
                                                            Aggiungi al Carrello
                                                        </button>
                                                        <% } else { %>
                                                            <button type="button"
                                                                class="btn btn-secondary out-of-stock-btn" disabled>
                                                                Non Disponibile
                                                            </button>
                                                            <% } %>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="product-tabs">
                                        <div class="tab-headers">
                                            <button class="tab-header active"
                                                data-tab="description">Descrizione</button>
                                            <button class="tab-header" data-tab="details">Dettagli</button>
                                            <button class="tab-header" data-tab="shipping">Spedizione</button>
                                        </div>

                                        <div class="tab-content active" id="description">
                                            <p>
                                                <%= prodotto.getDescrizione() %>
                                            </p>
                                        </div>

                                        <div class="tab-content" id="details">
                                            <ul class="details-list">
                                                <li><strong>Categoria:</strong>
                                                    <%= prodotto.getCategoria() %>
                                                </li>
                                                <li><strong>ID Prodotto:</strong>
                                                    <%= prodotto.getID() %>
                                                </li>
                                                <li><strong>Materiale:</strong> Premium Rubber</li>
                                                <li><strong>Dimensioni:</strong> 10 x 8 x 8 cm</li>
                                                <li><strong>Peso:</strong> 100g</li>
                                            </ul>
                                        </div>

                                        <div class="tab-content" id="shipping">
                                            <div class="shipping-info">
                                                <div class="shipping-item">
                                                    <div class="shipping-icon">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                            viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                            stroke-width="2" stroke-linecap="round"
                                                            stroke-linejoin="round">
                                                            <rect x="1" y="3" width="15" height="13"></rect>
                                                            <polygon points="16 8 20 8 23 11 23 16 16 16 16 8">
                                                            </polygon>
                                                            <circle cx="5.5" cy="18.5" r="2.5"></circle>
                                                            <circle cx="18.5" cy="18.5" r="2.5"></circle>
                                                        </svg>
                                                    </div>
                                                    <div class="shipping-content">
                                                        <h4>Spedizione Standard</h4>
                                                        <p>3-5 giorni lavorativi</p>
                                                        <p>4.99 &#8364</p>
                                                    </div>
                                                </div>

                                                <div class="shipping-item">
                                                    <div class="shipping-icon">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                            viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                            stroke-width="2" stroke-linecap="round"
                                                            stroke-linejoin="round">
                                                            <path d="M5 12.55a11 11 0 0 1 14.08 0"></path>
                                                            <path d="M1.42 9a16 16 0 0 1 21.16 0"></path>
                                                            <path d="M8.53 16.11a6 6 0 0 1 6.95 0"></path>
                                                            <line x1="12" y1="20" x2="12.01" y2="20"></line>
                                                        </svg>
                                                    </div>
                                                    <div class="shipping-content">
                                                        <h4>Spedizione Express</h4>
                                                        <p>1-2 giorni lavorativi</p>
                                                        <p>9.99 &#8364</p>
                                                    </div>
                                                </div>

                                                <div class="shipping-item">
                                                    <div class="shipping-icon">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                            viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                            stroke-width="2" stroke-linecap="round"
                                                            stroke-linejoin="round">
                                                            <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z">
                                                            </path>
                                                        </svg>
                                                    </div>
                                                    <div class="shipping-content">
                                                        <h4>Politica di Reso</h4>
                                                        <p>Restituzione gratuita entro 30 giorni</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Related Products Section -->
                                    <section class="related-products">
                                        <div class="section-header">
                                            <h2 class="section-title">Prodotti Correlati</h2>
                                        </div>

                                        <div class="products-grid">
                                            <!-- Related products would be dynamically generated here -->
                                        </div>
                                    </section>
                                </div>
                            </main>

                            <%@ include file="footer.jsp" %>

                                <script>
                                    // Tab functionality
                                    const tabHeaders = document.querySelectorAll('.tab-header');
                                    const tabContents = document.querySelectorAll('.tab-content');

                                    tabHeaders.forEach(header => {
                                        header.addEventListener('click', () => {
                                            // Remove active class from all headers and contents
                                            tabHeaders.forEach(h => h.classList.remove('active'));
                                            tabContents.forEach(c => c.classList.remove('active'));

                                            // Add active class to clicked header
                                            header.classList.add('active');

                                            // Show corresponding content
                                            const tabId = header.getAttribute('data-tab');
                                            document.getElementById(tabId).classList.add('active');
                                        });
                                    });

                                    // Quantity input functionality
                                    function increaseQuantity() {
                                        const quantityInput = document.getElementById('quantity');
                                        const currentValue = parseInt(quantityInput.value);
                                        const maxValue = parseInt(quantityInput.getAttribute('max'));

                                        if (currentValue < maxValue) {
                                            quantityInput.value = currentValue + 1;
                                        }
                                    }

                                    function decreaseQuantity() {
                                        const quantityInput = document.getElementById('quantity');
                                        const currentValue = parseInt(quantityInput.value);

                                        if (currentValue > 1) {
                                            quantityInput.value = currentValue - 1;
                                        }
                                    }

                                    // Initialize event listeners when DOM is loaded
                                    document.addEventListener('DOMContentLoaded', function () {
                                        // Add event listeners for quantity buttons as a fallback
                                        const decreaseBtn = document.querySelector('.quantity-decrease');
                                        const increaseBtn = document.querySelector('.quantity-increase');

                                        if (decreaseBtn) {
                                            decreaseBtn.addEventListener('click', decreaseQuantity);
                                        }

                                        if (increaseBtn) {
                                            increaseBtn.addEventListener('click', increaseQuantity);
                                        }

                                        // Prevent form submission on enter in quantity input
                                        const quantityInput = document.getElementById('quantity');
                                        if (quantityInput) {
                                            quantityInput.addEventListener('keydown', function (e) {
                                                if (e.key === 'Enter') {
                                                    e.preventDefault();
                                                    return false;
                                                }
                                            });
                                        }
                                    });
                                </script>

                                <script>
                                    // Debug layout issues
                                    document.addEventListener('DOMContentLoaded', function () {
                                        console.log('Debugging layout issues');

                                        // Check if all styles are loaded
                                        const stylesheets = document.styleSheets;
                                        for (let i = 0; i < stylesheets.length; i++) {
                                            try {
                                                const sheet = stylesheets[i];
                                                console.log(`Stylesheet ${i}: ${sheet.href || 'inline'}`);
                                            } catch (e) {
                                                console.error(`Error accessing stylesheet ${i}:`, e);
                                            }
                                        }

                                        // Check container widths
                                        const container = document.querySelector('.container');
                                        if (container) {
                                            console.log('Container width:', container.offsetWidth);
                                            console.log('Container computed style:', getComputedStyle(container).width);
                                        }

                                        // Check product container
                                        const productContainer = document.querySelector('.product-container');
                                        if (productContainer) {
                                            console.log('Product container width:', productContainer.offsetWidth);
                                            console.log('Product container computed style:', getComputedStyle(productContainer).width);
                                        }
                                    });
                                </script>
                </body>

                </html>