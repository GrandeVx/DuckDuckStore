<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Carrello + Futuro Nome Utente</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="css/carrello.css" rel="stylesheet" type="text/css">
</head>
<body>
<%@include file="header.jsp" %>
<%@include file="nav.jsp" %>
<%
    String errormsg = (String) request.getAttribute("errore");
    Carrello carrello = (Carrello) session.getAttribute("carrello");
    ArrayList<Prodotto> listaProdottiCarrello = (ArrayList<Prodotto>) carrello.getProdotti();

    double subtotale = 0.0;
    boolean isUtenteAutenticato = session.getAttribute("Utente") != null;
    double saldoUtente = isUtenteAutenticato ? ((Utente) session.getAttribute("Utente")).getSaldo() : 0.0;

    for (Prodotto p : listaProdottiCarrello) {
        double prezzo = p.getPrezzo();
        if (p.getSconto() != 0) {
            prezzo -= (prezzo / 100 * p.getSconto());
        }
        subtotale += prezzo * p.getQuantita();
    }

    double iva = subtotale * 0.22;
    double totale = subtotale + iva;
%>


<%
    if (listaProdottiCarrello.isEmpty()) {
%>
<div class="cart_vuoto">
    <h3>Il mio carrello</h3>
    <div class="cart_items_vuoto">
        <p>Carrello Vuoto</p>
        <a href="<%= request.getContextPath() %>">Continua la Navigazione</a>
    </div>
</div>
<%
} else {
%>
<form id="cartForm" action="cart" method="post">
    <div class="cart_pieno">
        <div class="cart_pieno_items">
            <h3>Il mio carrello</h3>
            <%
                for (Prodotto p : listaProdottiCarrello) {
                    double prezzo = p.getPrezzo();
                    if (p.getSconto() != 0) {
                        prezzo -= (prezzo / 100 * p.getSconto());
                    }
                    double prezzoTotale = prezzo * p.getQuantita();
            %>
            <div class="prodotto">
                <div class="img_details">
                    <img src="<%= p.getImg() %>" alt="Immagine Prodotto">
                    <div class="product-details">
                        <p class="nome"><%= p.getNome() %></p>
                        <p class="prezzo">$ <%= String.format("%.2f", prezzo) %></p>
                    </div>
                </div>

                <label for="quantity_<%= p.getID() %>" style="position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip: rect(0, 0, 0, 0); border: 0;">Quantità prodotto <%= p.getNome() %></label>
                <input class="quantita" type="number" id="quantity_<%= p.getID() %>" name="quantity_<%= p.getID() %>" min="1" max="99"
                       value="<%= p.getQuantita() %>" onchange="updateQuantity(this, <%= p.getID() %>, <%= prezzo %>)">
                <p class="prezzo_totale">$ <%= String.format("%.2f", prezzoTotale) %></p>

                <label for="delete_<%= p.getID() %>" style="position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip: rect(0, 0, 0, 0); border: 0;">Cancella prodotto <%= p.getNome() %></label>
                <button type="button" class="bidone" id="delete_<%= p.getID() %>" onclick="window.location.href ='cart?action=removeitem&ID=<%= p.getID() %>'">
                    <img src="images/bin-icon.webp" alt="">
                </button>
            </div>
            <%
                }
            %>
        </div>
        <div class="cart_pieno_check">
            <h3>Riepilogo ordine</h3>
            <div class="summary">
                <p>Subtotale <span id="subtotale">$ <%= String.format("%.2f", subtotale) %></span></p>
                <p>Iva <span id="iva">$ <%= String.format("%.2f", iva) %></span></p>
                <p>Totale <span id="totale">$ <%= String.format("%.2f", totale) %></span></p>
            </div>
            <%
                if (isUtenteAutenticato) {
            %>
            <div class="checkout-button">
                <button type="submit" name="action" value="checkout">Checkout</button>
            </div>
            <% if (errormsg != null) { %>
            <p id="errore"><%= errormsg %></p>
            <% } %>

            <%
            } else {
            %>
            <div class="accedi-button">
                <p class="accedi-p">Si prega di effettuare l'accesso per eseguire il pagamento</p>
                <button type="button" onclick="location.href='login';">Accedi</button>
            </div>
            <%
                }
            %>
        </div>
    </div>
</form>
<%
    }
%>


<script>
    function updateQuantity(input, productID, prezzo) {
        updatePriceDisplay(input, prezzo);
        recalculateTotals();
        updateCartIconCount(productID);
        sendUpdateRequest(productID, input.value);
    }

    function updatePriceDisplay(input, prezzo) {
        var quantita = parseInt(input.value, 10);
        var prezzoTotale = quantita * prezzo;
        var totalPriceElement = input.closest('.prodotto').querySelector('.prezzo_totale');
        totalPriceElement.textContent = '$ ' + prezzoTotale.toFixed(2);
    }

    function recalculateTotals() {
        var listaProdottiCarrello = document.querySelectorAll('.prodotto');
        var subtotale = 0.0;

        listaProdottiCarrello.forEach(function (item) {
            var prezzoUnitario = parseFloat(item.querySelector('.prezzo').textContent.replace('$ ', ''));
            var quantitaProdotto = parseInt(item.querySelector('.quantita').value, 10);
            var prezzoTotaleProdotto = prezzoUnitario * quantitaProdotto;
            subtotale += prezzoTotaleProdotto;
        });

        var iva = subtotale * 0.22;
        var totale = subtotale + iva;

        document.getElementById('subtotale').textContent = '$ ' + subtotale.toFixed(2);
        document.getElementById('iva').textContent = '$ ' + iva.toFixed(2);
        document.getElementById('totale').textContent = '$ ' + totale.toFixed(2);
    }

    function updateCartIconCount(productID) {
        var listaProdottiCarrello = document.querySelectorAll('.prodotto');
        var quantitaTotale = 0;

        listaProdottiCarrello.forEach(function (item) {
            quantitaTotale += parseInt(item.querySelector('.quantita').value, 10);
        });

        var cartIcon = document.querySelector('.cart-icon');
        cartIcon.setAttribute('data-item-count', quantitaTotale);
    }

    function sendUpdateRequest(productID, quantity) {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "cart", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.send("action=updateitem&ID=" + productID + "&quantita=" + quantity);
    }


</script>

</body>
</html>
