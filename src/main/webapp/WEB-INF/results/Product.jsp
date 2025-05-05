<%@ page import="model.ProdottoDAO" %>
<%@ page import="model.Prodotto" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pagina Prodotto</title>
    <link href="css/product.css" rel="stylesheet" type="text/css">
</head>
<body>
<%@include file="header.jsp" %>
<%@include file="nav.jsp" %>
<div class="product-page">
    <div class="infos">
        <p>${prodotto.categoria} / ${prodotto.nome}</p>
    </div>
    <div class="product-container">
        <div class="product-image">
            <img src="${prodotto.img}" alt="Immagine Prodotto">
        </div>
        <div class="product-details">
            <div class="product-nome">
                <h1 class="nome-prodotto">${prodotto.nome}</h1>
            </div>
            <div class="price">
                <c:choose>
                    <c:when test="${prodotto.sconto == 0}">
                        <span class="prezzo">$<fmt:formatNumber value="${prodotto.prezzo}" type="currency"
                                                                pattern="0.00"/></span>
                    </c:when>
                    <c:otherwise>
                        <p class="barred-prezzo">$<fmt:formatNumber value="${prodotto.prezzo}" type="currency"
                                                                    pattern="0.00"/></p>
                        <span class="prezzo">$<fmt:formatNumber
                                value="${prodotto.prezzo - (prodotto.prezzo / 100 * prodotto.sconto)}"
                                pattern="0.00"/></span>
                    </c:otherwise>
                </c:choose>
            </div>
            <c:choose>
                <c:when test="${prodotto.quantita > 0}">
                    <form action="cart" method="get">
                        <input type="hidden" name="action" value="additem">
                        <input type="hidden" name="ID" value="${prodotto.ID}">
                        <label for="quantity">Quantita'</label>
                        <input type="number" id="quantity" name="quantita" min="1" max="${prodotto.quantita}" value="1">
                        <br>
                        <button type="submit">Aggiungi al carrello</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <p class="non-disponibile">Prodotto non disponibile</p>
                </c:otherwise>
            </c:choose>
            <p class="descrizione">${prodotto.descrizione}</p>
        </div>
    </div>
</div>
<%@include file="footer.jsp" %>
</body>
</html>
