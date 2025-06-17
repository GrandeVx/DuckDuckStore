<%@ page import="model.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                    <!-- jsPDF Libraries -->
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.31/jspdf.plugin.autotable.min.js"></script>
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
                                                <div style="display: flex; gap: 1rem; align-items: center;">
                                                    <span class="admin-badge admin-badge-primary">
                                                        <fmt:formatDate value="${ordine.data.time}"
                                                            pattern="dd/MM/yyyy" />
                                                    </span>
                                                    <c:set var="scontrinoEscaped" value="${fn:escapeXml(ordine.scontrino)}" />
                                                    
                                                    <!-- Hidden JSON data for invoice generation -->
                                                    <script type="application/json" id="orderData-${ordine.ordine_ID}">
                                                    {
                                                        "orderId": "${ordine.ordine_ID}",
                                                        "orderDate": "<fmt:formatDate value="${ordine.data.time}" pattern="yyyy-MM-dd"/>",
                                                        "total": ${ordine.prezzo_tot},
                                                        "scontrino": "${scontrinoEscaped}",
                                                        "customer": {
                                                            <c:forEach var="utente" items="${listaUtenti}">
                                                                <c:if test="${utente.ID == ordine.utente_ID}">
                                                                "nome": "${utente.nome}",
                                                                "cognome": "${utente.cognome}",
                                                                "email": "${utente.email}",
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:if test="${ordine.indirizzoConsegna != null}">
                                                            "indirizzo": "${ordine.indirizzoConsegna.indirizzoCompleto}",
                                                            "nomeCompleto": "${ordine.indirizzoConsegna.nomeCompleto}",
                                                            "telefono": "${ordine.indirizzoConsegna.telefono}",
                                                            "via": "${ordine.indirizzoConsegna.via}",
                                                            "citta": "${ordine.indirizzoConsegna.citta}",
                                                            "cap": "${ordine.indirizzoConsegna.cap}"
                                                            </c:if>
                                                        },
                                                        "delivery": <c:choose>
                                                            <c:when test="${ordine.indirizzoConsegna != null}">
                                                            {
                                                                "nome": "${ordine.indirizzoConsegna.nome}",
                                                                "cognome": "${ordine.indirizzoConsegna.cognome}",
                                                                "via": "${ordine.indirizzoConsegna.via}",
                                                                "citta": "${ordine.indirizzoConsegna.citta}",
                                                                "cap": "${ordine.indirizzoConsegna.cap}",
                                                                "telefono": "${ordine.indirizzoConsegna.telefono}",
                                                                "note": "${ordine.indirizzoConsegna.note}"
                                                            }
                                                            </c:when>
                                                            <c:otherwise>null</c:otherwise>
                                                        </c:choose>,
                                                        "payment": <c:choose>
                                                            <c:when test="${ordine.infoPagamento != null}">
                                                            {
                                                                "cardHolder": "${ordine.infoPagamento.cardHolder}",
                                                                "maskedCardNumber": "${ordine.infoPagamento.maskedCardNumber}",
                                                                "paymentStatus": "${ordine.infoPagamento.paymentStatus}"
                                                            }
                                                            </c:when>
                                                            <c:otherwise>null</c:otherwise>
                                                        </c:choose>
                                                    }
                                                    </script>
                                                    
                                                    <button onclick="generateInvoicePDFFromOrderData('${ordine.ordine_ID}')" 
                                                            class="admin-btn admin-btn-secondary admin-btn-sm">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                                                            <polyline points="14,2 14,8 20,8"></polyline>
                                                            <line x1="16" y1="13" x2="8" y2="13"></line>
                                                            <line x1="16" y1="17" x2="8" y2="17"></line>
                                                            <polyline points="10,9 9,9 8,9"></polyline>
                                                        </svg>
                                                        Fattura PDF
                                                    </button>
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
                
                <script src="${pageContext.request.contextPath}/js/invoice-generator.js"></script>
                </body>

                </html>