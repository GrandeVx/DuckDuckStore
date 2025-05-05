<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Utente" %>
<%@ page import="model.Carrello" %>
<%@ page import="model.Prodotto" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Prodotto" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
    <link rel="icon" href="images/favicon.ico" type="image/x-icon">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TT Saturn</title>
    <link rel="stylesheet" href="css\header.css">
</head>
<%
    Carrello carrelloHeader = (Carrello) request.getSession().getAttribute("carrello");
    ArrayList<Prodotto> listaProdottiCarrelloHeader = (ArrayList<Prodotto>) carrelloHeader.getProdotti();
    int countProdotti = carrelloHeader.getSizeCarrello();
%>
<body>
<div class="header">
    <div class="logo">
        <a href="<%=request.getContextPath()%>">
            <img src="images/logo.png" alt="TT Saturn Logo">
        </a>
    </div>
    <div class="search-bar-infos">
        <div class="search-bar">
            <form method="get" action="search">
                <input type="text" id="query" name="query" placeholder="Cerca prodotti" onsubmit="window.location.href ='search';"
                       required>
                <label for="query" style="position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip: rect(0, 0, 0, 0); border: 0;">Barra di ricerca prodotti</label>
            </form>
        </div>
        <div class="user-options">
            <%
                Utente utente = (Utente) request.getSession().getAttribute("Utente");
                if (utente != null) {
            %>
            <div class="dropdown">
                <a class="login-dropdown">
                    <img src="images/user-icon2.png" alt="Utente">
                    <div class="utente-info">
                        <span class="utente-nome"><%= utente.getNome() + " " + utente.getCognome()%></span>
                        <span class="utente-saldo">$ <%=String.format("%.2f", utente.getSaldo())%></span>
                    </div>
                </a>
                <div class="dropdown-content">
                    <a href="profilo">Profilo</a>
                    <a href="order_history">Ordini</a>
                    <% if (session != null && session.getAttribute("isAdmin") != null) {%>
                    <a href="admin?action=prodotti">Gestione Prodotti</a>
                    <a href="admin?action=utenti">Gestione Utenti</a>
                    <%}%>
                    <a href="login?action=logout">Logout</a>
                </div>
            </div>
            <% } else { %>
            <a class="login-access" href="login">
                <img src="images/user-icon2.png" alt="Login">
                <span>Accedi</span>
            </a>
            <% } %>
            <div class="cart-icon" data-item-count="<%=countProdotti%>">
                <a class="cart-access" href="cart">
                    <img src="images\cart.png" alt="Carrello">
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
