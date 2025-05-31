<%@ page import="model.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DuckDuckStore | Storico Ordini</title>
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">
    <!-- Core styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/design-system.css">
    <!-- Component-specific styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        .order-history-page {
            background: var(--background-light);
            min-height: calc(100vh - var(--header-height) - var(--footer-height));
            padding: 2rem 0;
        }

        .orders-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }

        .page-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .page-subtitle {
            font-size: 1.1rem;
            color: var(--text-secondary);
            margin-bottom: 0;
        }

        .orders-list {
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }

        .order-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .order-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.15);
        }

        .order-header {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
            padding: 1.5rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .order-number {
            font-size: 1.2rem;
            font-weight: 600;
            margin: 0;
        }

        .order-status {
            background: rgba(255, 255, 255, 0.2);
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
        }

        .order-details {
            padding: 1.5rem 2rem;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            border-bottom: 1px solid var(--border-light);
        }

        .detail-item {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .detail-label {
            font-size: 0.9rem;
            font-weight: 500;
            color: var(--text-secondary);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .detail-value {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-primary);
            margin: 0;
        }

        .order-total {
            font-size: 1.3rem;
            color: var(--primary-color);
        }

        .order-date {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .order-products {
            padding: 1.5rem 2rem;
        }

        .products-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1rem;
        }

        .product-item {
            background: var(--background-light);
            border-radius: 8px;
            padding: 1rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: background-color 0.2s ease;
        }

        .product-item:hover {
            background: #f0f0f0;
        }

        .product-image {
            width: 60px;
            height: 60px;
            border-radius: 6px;
            object-fit: cover;
            flex-shrink: 0;
        }

        .product-info {
            flex: 1;
            min-width: 0;
        }

        .product-name {
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--text-primary);
            margin: 0 0 0.3rem 0;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .product-price {
            font-size: 0.9rem;
            color: var(--text-secondary);
            margin: 0;
        }

        .product-quantity {
            font-weight: 600;
            color: var(--primary-color);
        }

        /* New styles for delivery and payment info */
        .order-section {
            padding: 1.5rem 2rem;
            border-bottom: 1px solid var(--border-light);
        }

        .section-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .delivery-info, .payment-info {
            background: var(--background-light);
            border-radius: 8px;
            padding: 1rem;
        }

        .delivery-info p, .payment-info p {
            margin: 0.5rem 0;
            font-size: 0.95rem;
        }

        .delivery-note {
            font-style: italic;
            color: var(--text-secondary);
        }

        .payment-status {
            font-weight: 600;
            padding: 0.3rem 0.6rem;
            border-radius: 15px;
            font-size: 0.85rem;
        }

        .payment-status.completed {
            background: var(--success-light);
            color: var(--success-color);
        }

        .payment-status.failed {
            background: var(--danger-light);
            color: var(--danger-color);
        }

        .payment-status.pending {
            background: var(--warning-light);
            color: var(--warning-color);
        }

        .empty-state {
            text-align: center;
            padding: 4rem 1rem;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .empty-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 1.5rem;
            color: var(--text-muted);
        }

        .empty-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .empty-text {
            font-size: 1rem;
            color: var(--text-secondary);
            margin-bottom: 2rem;
        }

        .icon {
            width: 20px;
            height: 20px;
            stroke: currentColor;
            fill: none;
        }

        @media (max-width: 768px) {
            .page-title {
                font-size: 2rem;
            }

            .order-header {
                padding: 1rem 1.5rem;
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }

            .order-details,
            .order-products {
                padding: 1rem 1.5rem;
            }

            .order-details {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .products-grid {
                grid-template-columns: 1fr;
            }

            .product-item {
                padding: 0.8rem;
            }
        }

        @media (max-width: 480px) {
            .orders-container {
                padding: 0 0.5rem;
            }

            .page-header {
                margin-bottom: 2rem;
            }

            .orders-list {
                gap: 1.5rem;
            }
        }
    </style>
</head>

<body>
    <%@ include file="header.jsp" %>

    <main class="order-history-page">
        <div class="orders-container">
            <div class="page-header">
                <h1 class="page-title">Storico Ordini</h1>
                <p class="page-subtitle">Visualizza tutti i tuoi ordini passati</p>
            </div>

            <c:choose>
                <c:when test="${empty requestScope.listaOrdini}">
                    <div class="empty-state">
                        <div class="empty-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                                <path d="M16 3H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V8l-5-5z"/>
                                <path d="M15 3v5h5"/>
                                <path d="M8 12h8"/>
                                <path d="M8 16h8"/>
                            </svg>
                        </div>
                        <h2 class="empty-title">Nessun ordine trovato</h2>
                        <p class="empty-text">Non hai ancora effettuato nessun ordine. Inizia a fare shopping per vedere i tuoi ordini qui!</p>
                        <a href="home" class="btn btn-primary">Inizia lo Shopping</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="orders-list">
                        <c:forEach var="ordine" items="${requestScope.listaOrdini}">
                            <div class="order-card">
                                <div class="order-header">
                                    <h3 class="order-number">Ordine #${ordine.ordine_ID}</h3>
                                    <span class="order-status">Completato</span>
                                </div>

                                <div class="order-details">
                                    <div class="detail-item">
                                        <span class="detail-label">Data Ordine</span>
                                        <p class="detail-value order-date">
                                            <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                            </svg>
                                            <fmt:formatDate value="${ordine.data.time}" pattern="dd/MM/yyyy" />
                                        </p>
                                    </div>

                                    <div class="detail-item">
                                        <span class="detail-label">Totale Ordine</span>
                                        <p class="detail-value order-total">
                                            &euro;<fmt:formatNumber value="${ordine.prezzo_tot}" pattern="0.00" />
                                        </p>
                                    </div>

                                    <div class="detail-item">
                                        <span class="detail-label">Prodotti</span>
                                        <p class="detail-value">
                                            <c:set var="prodottiOrdine" value="${Utilities.scontrinoToProdotti(ordine.scontrino)}" />
                                            ${prodottiOrdine.size()} <c:choose><c:when test="${prodottiOrdine.size() == 1}">prodotto</c:when><c:otherwise>prodotti</c:otherwise></c:choose>
                                        </p>
                                    </div>
                                </div>

                                <!-- Delivery Information -->
                                <c:if test="${ordine.indirizzoConsegna != null}">
                                    <div class="order-section">
                                        <h4 class="section-title">
                                            📍 Indirizzo di Consegna
                                        </h4>
                                        <div class="delivery-info">
                                            <p><strong>${ordine.indirizzoConsegna.nomeCompleto}</strong></p>
                                            <p>${ordine.indirizzoConsegna.indirizzoCompleto}</p>
                                            <c:if test="${not empty ordine.indirizzoConsegna.telefono}">
                                                <p>📞 ${ordine.indirizzoConsegna.telefono}</p>
                                            </c:if>
                                            <c:if test="${not empty ordine.indirizzoConsegna.note}">
                                                <p class="delivery-note">📝 ${ordine.indirizzoConsegna.note}</p>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:if>

                                <!-- Payment Information -->
                                <c:if test="${ordine.infoPagamento != null}">
                                    <div class="order-section">
                                        <h4 class="section-title">
                                            💳 Informazioni di Pagamento
                                        </h4>
                                        <div class="payment-info">
                                            <p><strong>${ordine.infoPagamento.cardHolder}</strong></p>
                                            <p>${ordine.infoPagamento.maskedCardNumber}</p>
                                            <p class="payment-status ${ordine.infoPagamento.paymentStatus}">
                                                <c:choose>
                                                    <c:when test="${ordine.infoPagamento.paymentStatus == 'completed'}">
                                                        ✅ Pagamento Completato
                                                    </c:when>
                                                    <c:when test="${ordine.infoPagamento.paymentStatus == 'failed'}">
                                                        ❌ Pagamento Fallito
                                                    </c:when>
                                                    <c:otherwise>
                                                        ⏳ In Elaborazione
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </div>
                                </c:if>

                                <div class="order-products">
                                    <h4 class="products-title">
                                        <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                                        </svg>
                                        Prodotti Ordinati
                                    </h4>
                                    <div class="products-grid">
                                        <c:forEach var="prodotto" items="${prodottiOrdine}">
                                            <div class="product-item">
                                                <img src="${prodotto.img}" alt="${prodotto.nome}" class="product-image">
                                                <div class="product-info">
                                                    <h5 class="product-name">${prodotto.nome}</h5>
                                                    <p class="product-price">
                                                        <c:choose>
                                                            <c:when test="${prodotto.sconto == 0}">
                                                                &euro;<fmt:formatNumber value="${prodotto.prezzo}" pattern="0.00" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                &euro;<fmt:formatNumber value="${prodotto.prezzo - (prodotto.prezzo / 100 * prodotto.sconto)}" pattern="0.00" />
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <span class="product-quantity">× ${prodotto.quantita}</span>
                                                    </p>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <%@ include file="footer.jsp" %>
</body>

</html>