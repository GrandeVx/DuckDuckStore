<%@ page import="model.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestione Ordini</title>
    <link href="css/ordini.css" type="text/css" rel="stylesheet">
</head>
<body>
<%@ include file="/WEB-INF/results/header.jsp" %>
<%@ include file="/WEB-INF/results/nav.jsp" %>
<div class="container">
    <h2>Gestione Ordini</h2>
    <form method="get" action="admin">
        <input type="hidden" name="action" value="ordini" />
        <label for="utente_ID">Cliente:</label>
        <select name="utente_ID" id="utente_ID">
            <option value="">Tutti</option>
            <c:forEach var="utente" items="${listaUtenti}">
                <option value="${utente.ID}" ${param.utente_ID == utente.ID ? 'selected' : ''}>
                    ${utente.nome} ${utente.cognome} (${utente.email})
                </option>
            </c:forEach>
        </select>
        <label for="from">Dal:</label>
        <input type="date" name="from" id="from" value="${param.from}" />
        <label for="to">Al:</label>
        <input type="date" name="to" id="to" value="${param.to}" />
        <button type="submit">Filtra</button>
    </form>
    <hr/>
    <c:if test="${empty listaOrdini}">
        <p>Nessun ordine trovato.</p>
    </c:if>
    <c:forEach var="ordine" items="${listaOrdini}">
        <div class="ordine">
            <div class="ordine-header">
                <p>Codice Ordine : #${ordine.ordine_ID}</p>
                <p>Cliente: <c:forEach var="utente" items="${listaUtenti}">
                    <c:if test="${utente.ID == ordine.utente_ID}">
                        ${utente.nome} ${utente.cognome} (${utente.email})
                    </c:if>
                </c:forEach></p>
            </div>
            <div class="dettagli-ordine">
                <div>
                    <p>Data Ordine</p>
                    <p><fmt:formatDate value="${ordine.data.time}" pattern="dd/MM/yyyy"/></p>
                </div>
                <div>
                    <p>Spesa Totale</p>
                    <p>&euro;<fmt:formatNumber value="${ordine.prezzo_tot}" pattern="0.00"/></p>
                </div>
            </div>
            <div class="lista-prodotti">
                <c:set var="prodottiOrdine" value="${Utilities.scontrinoToProdotti(ordine.scontrino)}"/>
                <c:forEach var="prodotto" items="${prodottiOrdine}">
                    <div class="prodotto">
                        <img src="${prodotto.img}" alt="Prod">
                        <p>${prodotto.nome}</p>
                        <c:choose>
                            <c:when test="${prodotto.sconto == 0}">
                                <span>&euro;<fmt:formatNumber value="${prodotto.prezzo}"
                                                         pattern="0.00"/> x ${prodotto.quantita}</span>
                            </c:when>
                            <c:otherwise>
                                <span>&euro;<fmt:formatNumber
                                        value="${prodotto.prezzo - (prodotto.prezzo / 100 * prodotto.sconto)}"
                                        pattern="0.00"/> x ${prodotto.quantita}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:forEach>
</div>
</body>
</html>
