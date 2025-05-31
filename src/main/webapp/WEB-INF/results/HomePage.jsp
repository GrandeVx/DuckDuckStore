<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>DuckDuckStore | Home</title>
                <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">
                <!-- Core styles -->
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/design-system.css">
                <!-- Component-specific styles -->
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homepage.css">
                <!-- Fonts -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">
            </head>

            <body>
                <%@ include file="header.jsp" %>

                    <main class="main">
                        <!-- Hero Section -->
                        <section class="hero-section">
                            <div class="container">
                                <div class="hero-content">
                                    <div class="hero-text">
                                        <h1 class="hero-title">Discover the perfect <span class="accent">rubber
                                                duck</span> for you</h1>
                                        <p class="hero-description">Explore our collection of unique and fun rubber
                                            ducks. From spooky to fantasy, we have the perfect companion for your bath
                                            time adventures!</p>
                                        <div class="hero-cta">
                                            <a href="search" class="btn btn-primary">Shop Now</a>
                                        </div>
                                    </div>
                                    <div class="hero-image">
                                        <img src="images/homeImg1.png" alt="Featured Rubber Ducks"
                                            id="hero-img">
                                        <div class="hero-controls">
                                            <button onclick="changeHeroImage('prev')" class="hero-control-btn"
                                                aria-label="Previous image">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M15 18l-6-6 6-6" />
                                                </svg>
                                            </button>
                                            <button onclick="changeHeroImage('next')" class="hero-control-btn"
                                                aria-label="Next image">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M9 18l6-6-6-6" />
                                                </svg>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <!-- Categories Section -->
                        <section class="categories-section">
                            <div class="container">
                                <h2 class="section-title">Shop by Category</h2>

                                <div class="bento-grid categories-grid">
                                    <a href="search?category=spaventose" class="bento-item category-item">
                                        <div class="category-image">
                                            <img src="images/design/category1.jpg" alt="Spooky Ducks">
                                        </div>
                                        <div class="category-content">
                                            <h3 class="category-title">Spooky</h3>
                                            <p class="category-description">Add some mischief to your collection with
                                                our spooky themed rubber ducks.</p>
                                            <div class="category-link">
                                                <span>Explore category</span>
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M5 12h14" />
                                                    <path d="M12 5l7 7-7 7" />
                                                </svg>
                                            </div>
                                        </div>
                                    </a>

                                    <a href="search?category=fantasy" class="bento-item category-item">
                                        <div class="category-image">
                                            <img src="images/design/category2.png" alt="Fantasy Ducks">
                                        </div>
                                        <div class="category-content">
                                            <h3 class="category-title">Fantasy</h3>
                                            <p class="category-description">Dive into imagination with our fantasy
                                                themed rubber ducks.</p>
                                            <div class="category-link">
                                                <span>Explore category</span>
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M5 12h14" />
                                                    <path d="M12 5l7 7-7 7" />
                                                </svg>
                                            </div>
                                        </div>
                                    </a>

                                    <a href="search?category=professioni" class="bento-item category-item">
                                        <div class="category-content">
                                            <h3 class="category-title">Professions</h3>
                                            <p class="category-description">Find your career match with our profession
                                                themed rubber ducks.</p>
                                            <div class="category-link">
                                                <span>Explore category</span>
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M5 12h14" />
                                                    <path d="M12 5l7 7-7 7" />
                                                </svg>
                                            </div>
                                        </div>
                                    </a>

                                    <a href="search?category=natale" class="bento-item category-item">
                                        <div class="category-content">
                                            <h3 class="category-title">Christmas</h3>
                                            <p class="category-description">Celebrate the holidays with our festive
                                                rubber ducks.</p>
                                            <div class="category-link">
                                                <span>Explore category</span>
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M5 12h14" />
                                                    <path d="M12 5l7 7-7 7" />
                                                </svg>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </section>

                        <!-- Featured Products Section -->
                        <section class="featured-section">
                            <div class="container">
                                <div class="section-header">
                                    <h2 class="section-title">Most Popular</h2>
                                    <a href="search" class="view-all-link">
                                        <span>Browse all products</span>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                            stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M5 12h14" />
                                            <path d="M12 5l7 7-7 7" />
                                        </svg>
                                    </a>
                                </div>

                                <div class="products-grid">
                                    <c:forEach var="prodotto" items="${listaProdottiVenduti}" varStatus="status">
                                        <c:if test="${status.index < 4}">
                                            <div class="product-card">
                                                <a href="product?ID=${prodotto.ID}" class="product-img-container">
                                                    <img src="${prodotto.img}" alt="${prodotto.nome}"
                                                        class="product-img">
                                                </a>
                                                <div class="product-content">
                                                    <a href="product?ID=${prodotto.ID}"
                                                        class="product-name">${prodotto.nome}</a>
                                                    <p class="product-description">${prodotto.descrizione.length() > 60
                                                        ? prodotto.descrizione.substring(0, 60).concat('...') :
                                                        prodotto.descrizione}</p>
                                                    <div class="product-price-container">
                                                        <c:choose>
                                                            <c:when test="${prodotto.sconto == 0}">
                                                                <p class="product-price">&euro;
                                                                    <fmt:formatNumber value="${prodotto.prezzo}"
                                                                        pattern="0.00" />
                                                                </p>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="product-price-discount">
                                                                    <p class="product-price-original">&euro;
                                                                        <fmt:formatNumber value="${prodotto.prezzo}"
                                                                            pattern="0.00" />
                                                                    </p>
                                                                    <p class="product-price">&euro;
                                                                        <fmt:formatNumber
                                                                            value="${prodotto.prezzo - (prodotto.prezzo / 100 * prodotto.sconto)}"
                                                                            pattern="0.00" />
                                                                    </p>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <button
                                                        onclick="window.location.href='carrello?action=additem&quantita=1&ID=${prodotto.ID}'"
                                                        class="add-to-cart-btn">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                                            viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                            stroke-width="2" stroke-linecap="round"
                                                            stroke-linejoin="round">
                                                            <circle cx="9" cy="21" r="1"></circle>
                                                            <circle cx="20" cy="21" r="1"></circle>
                                                            <path
                                                                d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6">
                                                            </path>
                                                        </svg>
                                                        Add to Cart
                                                    </button>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </section>

                        <!-- Special Offers Section -->
                        <section class="special-offers-section">
                            <div class="container">
                                <div class="section-header">
                                    <h2 class="section-title">Special Offers</h2>
                                    <a href="search?onSale=true" class="view-all-link">
                                        <span>View all discounts</span>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                            stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M5 12h14" />
                                            <path d="M12 5l7 7-7 7" />
                                        </svg>
                                    </a>
                                </div>

                                <div class="products-grid">
                                    <c:forEach var="prodotto" items="${listaProdottiScontati}" varStatus="status">
                                        <c:if test="${status.index < 4}">
                                            <div class="product-card">
                                                <div class="product-badge">
                                                    <span class="badge badge-accent">-${prodotto.sconto}%</span>
                                                </div>
                                                <a href="product?ID=${prodotto.ID}" class="product-img-container">
                                                    <img src="${prodotto.img}" alt="${prodotto.nome}"
                                                        class="product-img">
                                                </a>
                                                <div class="product-content">
                                                    <a href="product?ID=${prodotto.ID}"
                                                        class="product-name">${prodotto.nome}</a>
                                                    <p class="product-description">${prodotto.descrizione.length() > 60
                                                        ? prodotto.descrizione.substring(0, 60).concat('...') :
                                                        prodotto.descrizione}</p>
                                                    <div class="product-price-container">
                                                        <div class="product-price-discount">
                                                            <p class="product-price-original">&euro;
                                                                <fmt:formatNumber value="${prodotto.prezzo}"
                                                                    pattern="0.00" />
                                                            </p>
                                                            <p class="product-price">&euro;
                                                                <fmt:formatNumber
                                                                    value="${prodotto.prezzo - (prodotto.prezzo / 100 * prodotto.sconto)}"
                                                                    pattern="0.00" />
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <button
                                                        onclick="window.location.href='carrello?action=additem&quantita=1&ID=${prodotto.ID}'"
                                                        class="add-to-cart-btn">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                                            viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                            stroke-width="2" stroke-linecap="round"
                                                            stroke-linejoin="round">
                                                            <circle cx="9" cy="21" r="1"></circle>
                                                            <circle cx="20" cy="21" r="1"></circle>
                                                            <path
                                                                d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6">
                                                            </path>
                                                        </svg>
                                                        Add to Cart
                                                    </button>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </section>

                        <!-- Features Section -->
                        <section class="features-section">
                            <div class="container">
                                <div class="features-grid">
                                    <div class="feature-item">
                                        <div class="feature-icon">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                                                <circle cx="12" cy="10" r="3"></circle>
                                            </svg>
                                        </div>
                                        <div class="feature-content">
                                            <h3 class="feature-title">Free Shipping</h3>
                                            <p class="feature-description">On orders over €29.00</p>
                                        </div>
                                    </div>

                                    <div class="feature-item">
                                        <div class="feature-icon">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <rect x="1" y="4" width="22" height="16" rx="2" ry="2"></rect>
                                                <line x1="1" y1="10" x2="23" y2="10"></line>
                                            </svg>
                                        </div>
                                        <div class="feature-content">
                                            <h3 class="feature-title">Secure Payments</h3>
                                            <p class="feature-description">With multiple payment options</p>
                                        </div>
                                    </div>

                                    <div class="feature-item">
                                        <div class="feature-icon">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <path
                                                    d="M12.74 2.32a1 1 0 0 0-1.48 0l-2 2.72-3.14.35a1 1 0 0 0-.59 1.8L9.5 9.56l-1.32 4.3a1 1 0 0 0 1.45 1.05L12 12.98l3.38 1.93a1 1 0 0 0 1.45-1.05l-1.32-4.3 3.97-2.37a1 1 0 0 0-.59-1.8l-3.14-.35-2.01-2.72z">
                                                </path>
                                            </svg>
                                        </div>
                                        <div class="feature-content">
                                            <h3 class="feature-title">30 days free return</h3>
                                            <p class="feature-description">No questions asked</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <!-- Newsletter Section -->
                        <section class="newsletter-section">
                            <div class="container">
                                <div class="newsletter-content">
                                    <div class="newsletter-text">
                                        <h2 class="newsletter-title">Subscribe to our email newsletter and get 10% off
                                        </h2>
                                        <p class="newsletter-description">Stay updated with our latest arrivals, special
                                            offers and exclusive deals.</p>
                                    </div>
                                    <form class="newsletter-form">
                                        <div class="newsletter-form-group">
                                            <input type="email" placeholder="Email Address" class="newsletter-input"
                                                required>
                                            <button type="submit"
                                                class="btn btn-secondary newsletter-btn">Subscribe</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </section>
                    </main>

                    <%@ include file="footer.jsp" %>

                        <script>
                            const heroImages = [
                                'images/homeImg1.png', 
                                'images/homeImg2.jpg',
                            ];
                            let currentImageIndex = 0;
                            let inTransition = false;

                            function changeHeroImage(direction) {
                                if (inTransition) return;
                                inTransition = true;

                                const heroImg = document.getElementById('hero-img');
                                heroImg.style.opacity = 0;

                                setTimeout(() => {
                                    if (direction === 'next') {
                                        currentImageIndex = (currentImageIndex + 1) % heroImages.length;
                                    } else {
                                        currentImageIndex = (currentImageIndex - 1 + heroImages.length) % heroImages.length;
                                    }

                                    heroImg.src = heroImages[currentImageIndex];
                                    heroImg.style.opacity = 1;
                                    inTransition = false;
                                }, 500);
                            }

                            // Auto-change image every 5 seconds
                            setInterval(() => changeHeroImage('next'), 5000);
                        </script>
            </body>

            </html>