<%@ page import="java.util.ArrayList" %>
    <%@ page import="model.Utente" %>
        <%@ page import="model.Carrello" %>
            <%@ page import="model.Prodotto" %>
                <%@ page language="java" %>

                    <% Carrello carrelloHeader=(Carrello) request.getSession().getAttribute("carrello");
                        ArrayList<Prodotto> listaProdottiCarrelloHeader = (ArrayList<Prodotto>)
                            carrelloHeader.getProdotti();
                            int countProdotti = carrelloHeader.getSizeCarrello();
                            %>

                            <header class="header">
                                <div class="container">
                                    <div class="header-content">
                                        <div class="logo">
                                            <a href="/">
                                                <h1 class="logo-text">DuckDuckStore</h1>
                                            </a>
                                        </div>

                                        <button class="mobile-menu-toggle" aria-label="Menu">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <line x1="3" y1="12" x2="21" y2="12"></line>
                                                <line x1="3" y1="6" x2="21" y2="6"></line>
                                                <line x1="3" y1="18" x2="21" y2="18"></line>
                                            </svg>
                                        </button>

                                        <nav class="main-nav">
                                            <ul class="nav-list">
                                                <li class="nav-item"><a href="/" class="nav-link">Home</a></li>
                                                <li class="nav-item"><a href="search"
                                                        class="nav-link">Store</a></li>
                                                <li class="nav-item"><a href="search?category=spaventose"
                                                        class="nav-link">Spooky</a></li>
                                                <li class="nav-item"><a href="search?category=fantasy"
                                                        class="nav-link">Fantasy</a></li>
                                                <li class="nav-item"><a href="search?category=professioni"
                                                    class="nav-link">Profession</a></li>
                                                <li class="nav-item"><a href="search?category=natale"
                                                    class="nav-link">Christmas</a></li>
                                            </ul>
                                        </nav>

                                        <div class="header-actions">
                                            <div class="search-bar">
                                                <form method="get" action="search" class="search-form">
                                                    <input type="text" id="query" name="query"
                                                        placeholder="Cerca prodotti" class="search-input" required>
                                                    <button type="submit" class="search-button">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                                            viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                            stroke-width="2" stroke-linecap="round"
                                                            stroke-linejoin="round">
                                                            <circle cx="11" cy="11" r="8"></circle>
                                                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                                                        </svg>
                                                    </button>
                                                </form>
                                            </div>

                                            <button class="search-toggle" aria-label="Toggle Search">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <circle cx="11" cy="11" r="8"></circle>
                                                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                                                </svg>
                                            </button>

                                            <div class="user-actions">
                                                <% Utente utente=(Utente) request.getSession().getAttribute("Utente");
                                                    if (utente !=null) { %>
                                                    <div class="user-dropdown">
                                                        <button class="user-button">
                                                            <div class="user-info">
                                                                <span class="user-name">
                                                                    <%= utente.getNome() %>
                                                                </span>
                                                                <span class="user-balance">&euro;
                                                                    <%=String.format("%.2f", utente.getSaldo())%>
                                                                </span>
                                                            </div>
                                                            <div class="user-avatar">
                                                                <svg xmlns="http://www.w3.org/2000/svg" width="24"
                                                                    height="24" viewBox="0 0 24 24" fill="none"
                                                                    stroke="currentColor" stroke-width="2"
                                                                    stroke-linecap="round" stroke-linejoin="round">
                                                                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2">
                                                                    </path>
                                                                    <circle cx="12" cy="7" r="4"></circle>
                                                                </svg>
                                                            </div>
                                                        </button>
                                                        <div class="dropdown-menu">
                                                            <a href="profilo" class="dropdown-item">Profilo</a>
                                                            <a href="order_history" class="dropdown-item">I tuoi ordini</a>
                                                            <% if (session !=null && session.getAttribute("isAdmin")
                                                                !=null) { %>
                                                                <a href="admin?action=prodotti"
                                                                    class="dropdown-item">Gestione Prodotti</a>
                                                                <a href="admin?action=utenti"
                                                                    class="dropdown-item">Gestione Utenti</a>
                                                                <a href="admin?action=ordini"
                                                                    class="dropdown-item">Gestione Ordini</a>
                                                                <% } %>
                                                                    <a href="login?action=logout"
                                                                        class="dropdown-item">Logout</a>
                                                        </div>
                                                    </div>
                                                    <% } else { %>
                                                        <a href="login" class="login-button">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="24"
                                                                height="24" viewBox="0 0 24 24" fill="none"
                                                                stroke="currentColor" stroke-width="2"
                                                                stroke-linecap="round" stroke-linejoin="round">
                                                                <path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4">
                                                                </path>
                                                                <polyline points="10 17 15 12 10 7"></polyline>
                                                                <line x1="15" y1="12" x2="3" y2="12"></line>
                                                            </svg>
                                                            <span>Accedi</span>
                                                        </a>
                                                        <% } %>

                                                            <a href="carrello" class="cart-button">
                                                                <div class="cart-icon">
                                                                    <svg xmlns="http://www.w3.org/2000/svg" width="24"
                                                                        height="24" viewBox="0 0 24 24" fill="none"
                                                                        stroke="currentColor" stroke-width="2"
                                                                        stroke-linecap="round" stroke-linejoin="round">
                                                                        <circle cx="9" cy="21" r="1"></circle>
                                                                        <circle cx="20" cy="21" r="1"></circle>
                                                                        <path
                                                                            d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6">
                                                                        </path>
                                                                    </svg>
                                                                    <% if (countProdotti> 0) { %>
                                                                        <span class="cart-count">
                                                                            <%=countProdotti%>
                                                                        </span>
                                                                        <% } %>
                                                                </div>
                                                            </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </header>

                            <script>
                                document.addEventListener('DOMContentLoaded', function () {
                                    const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
                                    const mainNav = document.querySelector('.main-nav');
                                    const searchToggle = document.querySelector('.search-toggle');
                                    const searchBar = document.querySelector('.search-bar');

                                    if (mobileMenuToggle) {
                                        mobileMenuToggle.addEventListener('click', function () {
                                            this.classList.toggle('active');
                                            mainNav.classList.toggle('active');
                                            document.body.classList.toggle('mobile-menu-open');
                                        });
                                    }

                                    if (searchToggle) {
                                        searchToggle.addEventListener('click', function () {
                                            searchBar.classList.toggle('active');
                                            this.classList.toggle('active');
                                        });
                                    }

                                    // Close mobile menu when clicking outside
                                    document.addEventListener('click', function (event) {
                                        if (mainNav.classList.contains('active') &&
                                            !mainNav.contains(event.target) &&
                                            !mobileMenuToggle.contains(event.target)) {
                                            mobileMenuToggle.classList.remove('active');
                                            mainNav.classList.remove('active');
                                            document.body.classList.remove('mobile-menu-open');
                                        }

                                        // Close search bar when clicking outside
                                        if (searchBar.classList.contains('active') &&
                                            !searchBar.contains(event.target) &&
                                            !searchToggle.contains(event.target)) {
                                            searchBar.classList.remove('active');
                                            searchToggle.classList.remove('active');
                                        }
                                    });
                                });
                            </script>