<%@ page import="model.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders</title>
    <link href="css/ordini.css" type="text/css" rel="stylesheet">
</head>
<body>
<%@ include file="header.jsp" %>
<%@ include file="nav.jsp" %>
<div class="container">
    <h3>Ordini</h3>
    <c:forEach var="ordine" items="${requestScope.listaOrdini}">
        <div class="ordine">
            <div class="ordine-header">
                <p>Codice Ordine : #${ordine.ordine_ID}</p>
            </div>
            <div class="dettagli-ordine">
                <div>
                    <p>Data Ordine</p>
                    <p><fmt:formatDate value="${ordine.data.time}" pattern="dd/MM/yyyy"/></p>
                </div>
                <div>
                    <p>Spesa Totale</p>
                    <p>$<fmt:formatNumber value="${ordine.prezzo_tot}" pattern="0.00"/></p>
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
                                <span>$<fmt:formatNumber value="${prodotto.prezzo}"
                                                         pattern="0.00"/> x ${prodotto.quantita}</span>
                            </c:when>
                            <c:otherwise>
                                <span>$<fmt:formatNumber
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