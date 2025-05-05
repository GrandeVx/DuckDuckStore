<%@ page import="model.Prodotto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%=request.getAttribute("query")%>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="css/ricerca_prodotti.css" rel="stylesheet" type="text/css">
</head>
<% ArrayList<Prodotto> listaProdotti = (ArrayList<Prodotto>) request.getAttribute("listaProdotti");%>
<body>
<%@include file="header.jsp" %>
<%@include file="nav.jsp" %>
<div class="container">
    <div class="nome_ricerca">
        <p>
                <% if(listaProdotti.size() == 0) {%>
        <p>Nessun risultato per: <%=request.getAttribute("query")%>
        </p>
        <%} else {%>
        <p><%=request.getAttribute("query")%>
        </p>
        <%}%>
    </div>
    <!-- ciclo for per ciascun item che ha un riscontro questo scritto sotto sono solo esempi -->
    <% for (Prodotto p : listaProdotti) { %>
    <div class="product-search">
        <a href="product?ID=<%=p.getID()%>">
            <img src="<%=p.getImg()%>" alt="Immagine Prodotto"><br>
        </a>
        <p class="nome"><%=p.getNome()%>
        </p>
        <% if (p.getSconto() == 0) {%>
        <p class="prezzo">$<%=String.format("%.2f", p.getPrezzo())%>
        </p>
        <%} else {%>
        <p class="barred-prezzo">$<%=String.format("%.2f", p.getPrezzo())%>
        </p>
        <p class="prezzo">$<%=String.format("%.2f", p.getPrezzo() - (p.getPrezzo() / 100 * p.getSconto()))%>
        </p>
        <%}%>
    </div>
    <%}%>
</div>
<%@include file="footer.jsp" %>
</body>
</html>