<%@ page import="model.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ page contentType="text/html;charset=UTF-8" language="java" %>
                <!DOCTYPE html>
                <html lang="it">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>DuckDuckStore | Admin - Ordini</title>
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
                    <%@ include file="/WEB-INF/results/header.jsp" %>
                        <div class="admin-container">
                            <div class="admin-content">
                                <%@ include file="admin_nav.jsp" %>

                                    <div class="admin-header">
                                        <h1 class="admin-title">Gestione Ordini</h1>
                                    </div>

                                    <div class="admin-filters">
                                        <form method="get" action="admin" class="admin-filter-form">
                                            <input type="hidden" name="action" value="ordini" />

                                            <div class="admin-filter-group">
                                                <label for="utente_ID" class="admin-filter-label">Cliente:</label>
                                                <select name="utente_ID" id="utente_ID" class="admin-select">
                                                    <option value="">Tutti</option>
                                                    <c:forEach var="utente" items="${listaUtenti}">
                                                        <option value="${utente.ID}" ${param.utente_ID==utente.ID
                                                            ? 'selected' : '' }>
                                                            ${utente.nome} ${utente.cognome} (${utente.email})
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="admin-filter-group">
                                                <label for="from" class="admin-filter-label">Dal:</label>
                                                <input type="date" name="from" id="from" value="${param.from}"
                                                    class="admin-input" />
                                            </div>

                                            <div class="admin-filter-group">
                                                <label for="to" class="admin-filter-label">Al:</label>
                                                <input type="date" name="to" id="to" value="${param.to}"
                                                    class="admin-input" />
                                            </div>

                                            <div class="admin-filter-group" style="align-self: flex-end;">
                                                <button type="submit" class="admin-btn admin-btn-primary">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                                        viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                        <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3">
                                                        </polygon>
                                                    </svg>
                                                    Filtra
                                                </button>
                                            </div>
                                        </form>
                                    </div>

                                    <c:if test="${empty listaOrdini}">
                                        <div class="admin-card" style="text-align: center; padding: 2rem;">
                                            <p>Nessun ordine trovato.</p>
                                        </div>
                                    </c:if>

                                    <c:forEach var="ordine" items="${listaOrdini}">
                                        <div class="admin-card">
                                            <div class="admin-card-header">
                                                <h3 class="admin-card-title">
                                                    Ordine #${ordine.ordine_ID}
                                                </h3>
                                                <div>
                                                    <span class="admin-badge admin-badge-primary">
                                                        <fmt:formatDate value="${ordine.data.time}"
                                                            pattern="dd/MM/yyyy" />
                                                    </span>
                                                </div>
                                            </div>

                                            <div style="margin-bottom: 1rem;">
                                                <strong>Cliente:</strong>
                                                <c:forEach var="utente" items="${listaUtenti}">
                                                    <c:if test="${utente.ID == ordine.utente_ID}">
                                                        ${utente.nome} ${utente.cognome} (${utente.email})
                                                    </c:if>
                                                </c:forEach>
                                            </div>

                                            <div style="margin-bottom: 1.5rem;">
                                                <strong>Totale:</strong>
                                                &euro;
                                                <fmt:formatNumber value="${ordine.prezzo_tot}" pattern="0.00" />
                                            </div>

                                            <h4
                                                style="margin-bottom: 1rem; border-bottom: 1px solid var(--admin-border); padding-bottom: 0.5rem;">
                                                Prodotti
                                            </h4>

                                            <div class="admin-table-responsive">
                                                <table class="admin-table">
                                                    <thead>
                                                        <tr>
                                                            <th style="width: 80px">Foto</th>
                                                            <th>Prodotto</th>
                                                            <th>Prezzo</th>
                                                            <th>Quantità</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:set var="prodottiOrdine"
                                                            value="${Utilities.scontrinoToProdotti(ordine.scontrino)}" />
                                                        <c:forEach var="prodotto" items="${prodottiOrdine}">
                                                            <tr>
                                                                <td>
                                                                    <img src="${prodotto.img}" alt="${prodotto.nome}"
                                                                        style="width: 60px; height: 60px; object-fit: cover; border-radius: var(--admin-radius)">
                                                                </td>
                                                                <td>
                                                                    ${prodotto.nome}
                                                                </td>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when test="${prodotto.sconto == 0}">
                                                                            &euro;
                                                                            <fmt:formatNumber value="${prodotto.prezzo}"
                                                                                pattern="0.00" />
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            &euro;
                                                                            <fmt:formatNumber
                                                                                value="${prodotto.prezzo - (prodotto.prezzo / 100 * prodotto.sconto)}"
                                                                                pattern="0.00" />
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td>
                                                                    ${prodotto.quantita}
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </c:forEach>
                            </div>
                        </div>
                </body>

                </html>