<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>DuckDuckStore | Admin - Prodotti</title>
            <!-- Core styles -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/design-system.css">
            <!-- Component-specific styles -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
            <!-- Fonts -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">
        </head>

        <body>
            <%@ include file="../results/header.jsp" %>
                <div class="admin-container">
                    <div class="admin-content">
                        <%@ include file="admin_nav.jsp" %>

                            <div class="admin-header">
                                <h1 class="admin-title">Gestione Prodotti</h1>
                                <div class="admin-actions">
                                    <a href="admin/product-management" class="admin-btn admin-btn-primary">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                            stroke-linecap="round" stroke-linejoin="round">
                                            <line x1="12" y1="5" x2="12" y2="19"></line>
                                            <line x1="5" y1="12" x2="19" y2="12"></line>
                                        </svg>
                                        Aggiungi Prodotto
                                    </a>
                                </div>
                            </div>

                            <div class="admin-filters">
                                <div class="admin-search">
                                    <input type="text" id="query" placeholder="Cerca prodotti..."
                                        class="admin-search-input">
                                    <button onclick="filterProducts(document.getElementById('query').value)"
                                        class="admin-btn admin-btn-primary">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                            stroke-linecap="round" stroke-linejoin="round">
                                            <circle cx="11" cy="11" r="8"></circle>
                                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                                        </svg>
                                        Cerca
                                    </button>
                                </div>
                                <button type="button" onclick="filterProducts('')"
                                    class="admin-btn admin-btn-secondary">Mostra tutti</button>
                            </div>

                            <div id="productList" class="admin-grid">
                                <c:forEach var="p" items="${listaProdotti}">
                                    <div class="admin-product-card">
                                        <img src="${p.img}" alt="${p.nome}" class="admin-product-image">
                                        <div class="admin-product-content">
                                            <h3 class="admin-product-title">${p.nome}</h3>
                                            <div class="admin-product-meta">
                                                <span>Quantità: ${p.quantita}</span>
                                                <span>&euro; ${p.prezzo}</span>
                                            </div>
                                            <c:if test="${p.sconto > 0}">
                                                <div class="admin-badge admin-badge-primary"
                                                    style="margin-bottom: 1rem;">
                                                    Sconto: ${p.sconto}%
                                                </div>
                                            </c:if>
                                            <div class="admin-product-actions">
                                                <button onclick="modifyProduct(${p.ID})"
                                                    class="admin-btn admin-btn-primary admin-btn-sm">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                        viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                        <path
                                                            d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7">
                                                        </path>
                                                        <path
                                                            d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z">
                                                        </path>
                                                    </svg>
                                                    Modifica
                                                </button>
                                                <button onclick="deleteProduct(${p.ID})"
                                                    class="admin-btn admin-btn-danger admin-btn-sm">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                        viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                        <polyline points="3 6 5 6 21 6"></polyline>
                                                        <path
                                                            d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2">
                                                        </path>
                                                        <line x1="10" y1="11" x2="10" y2="17"></line>
                                                        <line x1="14" y1="11" x2="14" y2="17"></line>
                                                    </svg>
                                                    Elimina
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                    </div>
                </div>

                <script>
                    document.getElementById('query').addEventListener('keypress', function (event) {
                        if (event.key === 'Enter') {
                            event.preventDefault();
                            filterProducts(this.value);
                        }
                    });

                    function filterProducts(query) {
                        fetch("admin?action=prodotti", {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/x-www-form-urlencoded",
                                "X-Requested-With": "XMLHttpRequest"
                            },
                            body: new URLSearchParams({ query: query })
                        })
                            .then(response => {
                                if (!response.ok) {
                                    throw new Error(`HTTP error! Status: ` + response.status);
                                }
                                return response.json();
                            })
                            .then(products => {
                                updateProductList(products);
                            })
                            .catch(error => {
                                console.error("Error fetching products:", error);
                            });
                    }

                    function updateProductList(products) {
                        var productList = document.getElementById("productList");
                        productList.innerHTML = "";
                        products.forEach(function (item) {
                            var productCard = document.createElement("div");
                            productCard.className = "admin-product-card";

                            var discountBadge = '';
                            if (item.sconto > 0) {
                                discountBadge = `<div class="admin-badge admin-badge-primary" style="margin-bottom: 1rem;">
                                    Sconto: ${item.sconto}%
                                </div>`;
                            }

                            productCard.innerHTML = `
                                <img src="${item.img}" alt="${item.nome}" class="admin-product-image">
                                <div class="admin-product-content">
                                    <h3 class="admin-product-title">${item.nome}</h3>
                                    <div class="admin-product-meta">
                                        <span>Quantità: ${item.quantita}</span>
                                        <span>&euro; ${item.prezzo}</span>
                                    </div>
                                    ${discountBadge}
                                    <div class="admin-product-actions">
                                        <button onclick="modifyProduct(${item.ID})" class="admin-btn admin-btn-primary admin-btn-sm">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                                                <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                                            </svg>
                                            Modifica
                                        </button>
                                        <button onclick="deleteProduct(${item.ID})" class="admin-btn admin-btn-danger admin-btn-sm">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <polyline points="3 6 5 6 21 6"></polyline>
                                                <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                                <line x1="10" y1="11" x2="10" y2="17"></line>
                                                <line x1="14" y1="11" x2="14" y2="17"></line>
                                            </svg>
                                            Elimina
                                        </button>
                                    </div>
                                </div>
                            `;
                            productList.appendChild(productCard);
                        });
                    }

                    function deleteProduct(id) {
                        if (confirm('Sei sicuro di voler eliminare questo prodotto?')) {
                            var url = 'admin/product-management?action=delete&ID=' + encodeURIComponent(id);
                            window.location.href = url;
                        }
                    }

                    function modifyProduct(id) {
                        var url = 'admin/product-management?action=modify&ID=' + encodeURIComponent(id);
                        window.location.href = url;
                    }
                </script>
        </body>

        </html>