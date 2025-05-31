<%@ page import="model.Prodotto" %>
    <%@ page import="java.util.ArrayList" %>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>DuckDuckStore | <%=request.getAttribute("query")%>
                </title>
                <!-- Core styles -->
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/design-system.css">
                <!-- Component-specific styles -->
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/search.css">
                <!-- Fonts -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">
            </head>

            <body>
                <%@ include file="header.jsp" %>
                    <% ArrayList<Prodotto> listaProdotti = (ArrayList<Prodotto>)
                            request.getAttribute("listaProdotti");%>

                            <main class="main">
                                <div class="container">
                                    <div class="search-header">
                                        <% if(listaProdotti.size()==0) { %>
                                            <h1 class="search-title">Nessun risultato per: <span class="search-query">
                                                    <%=request.getAttribute("query")%>
                                                </span></h1>
                                            <p class="search-subtitle">Prova con termini diversi o esplora le nostre
                                                categorie.</p>
                                            <% } else { %>
                                                <h1 class="search-title">Risultati per: <span class="search-query">
                                                        <%=request.getAttribute("query")%>
                                                    </span></h1>
                                                <p class="search-subtitle">
                                                    <%=listaProdotti.size()%> prodotti trovati
                                                </p>
                                                <% } %>
                                    </div>

                                    <% if(listaProdotti.size()==0) { %>
                                        <div class="no-results">
                                            <div class="no-results-icon">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64"
                                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                    stroke-width="1" stroke-linecap="round" stroke-linejoin="round">
                                                    <circle cx="11" cy="11" r="8"></circle>
                                                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                                                    <line x1="8" y1="11" x2="14" y2="11"></line>
                                                </svg>
                                            </div>
                                            <p class="no-results-text">Ci dispiace, non abbiamo trovato prodotti
                                                corrispondenti alla tua ricerca.</p>
                                            <a href="home" class="btn btn-primary">Torna alla home</a>
                                        </div>
                                        <% } else { %>
                                            <div class="search-filters">
                                                <div class="search-sort">
                                                    <label for="sort">Ordina per:</label>
                                                    <form id="sortForm" action="" method="get">
                                                        <input type="hidden" name="query"
                                                            value="<%=request.getAttribute(" query")%>">
                                                        <select id="sort" name="sort" class="form-control"
                                                            onchange="document.getElementById('sortForm').submit();">
                                                            <option value="relevance"
                                                                <%=request.getParameter("sort")==null || "relevance"
                                                                .equals(request.getParameter("sort")) ? "selected" : ""
                                                                %>>Rilevanza</option>
                                                            <option value="price-asc" <%="price-asc"
                                                                .equals(request.getParameter("sort")) ? "selected" : ""
                                                                %>>Prezzo: basso - alto</option>
                                                            <option value="price-desc" <%="price-desc"
                                                                .equals(request.getParameter("sort")) ? "selected" : ""
                                                                %>>Prezzo: alto - basso</option>
                                                            <option value="newest" <%="newest"
                                                                .equals(request.getParameter("sort")) ? "selected" : ""
                                                                %>>Più recenti</option>
                                                        </select>
                                                    </form>
                                                </div>
                                            </div>

                                            <div class="products-grid">
                                                <% for (Prodotto p : listaProdotti) { %>
                                                    <div class="product-card">
                                                        <% if (p.getSconto()> 0) { %>
                                                            <div class="product-badge">
                                                                <span class="badge badge-primary">-<%=p.getSconto()%>
                                                                        %</span>
                                                            </div>
                                                            <% } %>

                                                                <a href="product?ID=<%=p.getID()%>"
                                                                    class="product-img-container">
                                                                    <img src="<%=p.getImg()%>" alt="<%=p.getNome()%>"
                                                                        class="product-img">
                                                                </a>

                                                                <div class="product-content">
                                                                    <a href="product?ID=<%=p.getID()%>"
                                                                        class="product-name">
                                                                        <%=p.getNome()%>
                                                                    </a>

                                                                    <p class="product-description">
                                                                        <%=p.getDescrizione()%>
                                                                    </p>

                                                                    <div class="product-price-container">
                                                                        <% if (p.getSconto()==0) { %>
                                                                            <span class="product-price">&euro;
                                                                                <%=String.format("%.2f",
                                                                                    p.getPrezzo())%>
                                                                            </span>
                                                                            <% } else { double
                                                                                discountedPrice=p.getPrezzo() -
                                                                                (p.getPrezzo() / 100 * p.getSconto());
                                                                                %>
                                                                                <div class="product-price-discount">
                                                                                    <span class="product-price">&euro;
                                                                                        <%=String.format("%.2f",
                                                                                            discountedPrice)%>
                                                                                    </span>
                                                                                    <span
                                                                                        class="product-price-original">&euro;
                                                                                        <%=String.format("%.2f",
                                                                                            p.getPrezzo())%>
                                                                                    </span>
                                                                                </div>
                                                                                <% } %>
                                                                    </div>

                                                                    <form action="carrello" method="post">
                                                                        <input type="hidden" name="ID"
                                                                            value="<%=p.getID()%>">
                                                                        <input type="hidden" name="quantita" value="1">
                                                                        <input type="hidden" name="action"
                                                                            value="additem">
                                                                        <button type="submit" class="add-to-cart-btn">
                                                                            <svg xmlns="http://www.w3.org/2000/svg"
                                                                                width="16" height="16"
                                                                                viewBox="0 0 24 24" fill="none"
                                                                                stroke="currentColor" stroke-width="2"
                                                                                stroke-linecap="round"
                                                                                stroke-linejoin="round">
                                                                                <circle cx="9" cy="21" r="1"></circle>
                                                                                <circle cx="20" cy="21" r="1"></circle>
                                                                                <path
                                                                                    d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6">
                                                                                </path>
                                                                            </svg>
                                                                            Aggiungi al carrello
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                    </div>
                                                    <% } %>
                                            </div>
                                            <% } %>
                                </div>
                            </main>

                            <%@ include file="footer.jsp" %>
            </body>

            </html>