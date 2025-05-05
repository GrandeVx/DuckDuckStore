<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prodotti Database</title>
    <link href="css/product_list.css" type="text/css" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class="header">
        <h1>Prodotti</h1>
        <div class="bottoni">
            <button onclick="window.location.href ='admin/product-management'">Aggiungi Prodotto</button>
            <button onclick="window.location.href ='<%=request.getContextPath()%>'">Home Page</button>
        </div>
    </div>
        <div class="filtro">
            <div class="bottoni">
                <button type="button" onclick="filterProducts('')">Tutti</button>
            </div>
            <input type="text" name="query" id="query" placeholder="Nome Prodotti" required>
            <label for="query" style="position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip: rect(0, 0, 0, 0); border: 0;">Barra di ricerca prodotti</label>
        </div>
    <div id="productList" class="prodotto-list">
        <c:forEach var="p" items="${listaProdotti}">
            <div class="prodotto">
                <img src="${p.img}" alt="Product">
                <div class="info-prodotto">
                    <p class="nome-prodotto">${p.nome}</p>
                    <p class="stock">Quantita' : ${p.quantita}</p>
                </div>
                <div class="prezzo-sconto">
                    <p class="prezzo">Prezzo: $<c:out value="${p.prezzo}"/></p>
                    <p class="sconto">Sconto: ${p.sconto}%</p>
                </div>
                <div class="delete-modify">
                    <button onclick="modifyProduct(${p.ID})" class="modifica">Modifica</button>
                    <button onclick="deleteProduct(${p.ID})" class="cancella">Cancella</button>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script>

    document.getElementById('query').addEventListener('keypress', function(event) {
        if (event.key === 'Enter') {
            event.preventDefault();  // Previeni l'invio del modulo
            filterProducts(this.value);  // Chiama la funzione con il valore del campo
        }
    });

    function filterProducts(query) {
        fetch("admin?action=prodotti", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                "X-Requested-With": "XMLHttpRequest"
            },
            body: new URLSearchParams({ query: query })
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: `+response.status);
                }
                return response.json();
            })
            .then(products => {
                updateProductList(products);
            })
            .catch(error => {
                console.error("Error fetching products:", error);
            });
    }


    function updateProductList(products) {
        var productList = document.getElementById("productList");
        productList.innerHTML = "";
        products.forEach(function(item) {
            var productDiv = document.createElement("div");
            productDiv.className = "prodotto";
            productDiv.innerHTML = `
                <img src=`+item.img+`" alt="Product">
                <div class="info-prodotto">
                    <p class="nome-prodotto">`+item.nome+`</p>
                    <p class="stock">Quantita' : `+item.quantita+`</p>
                </div>
                <div class="prezzo-sconto">
                    <p class="prezzo">Prezzo: $`+item.prezzo+`</p>
                    <p class="sconto">Sconto: `+item.sconto+`%</p>
                </div>
                <div class="delete-modify">
                    <button onclick="modifyProduct(`+item.ID+`)" class="modifica">Modifica</button>
                    <button onclick="deleteProduct(`+item.ID+`)" class="cancella">Cancella</button>
                </div>
            `;
            productList.appendChild(productDiv);
        });
    }

    function deleteProduct(id) {
        var url = 'admin/product-management?action=delete&ID=' + encodeURIComponent(id);
        window.location.href = url;
    }

    function modifyProduct(id) {
        var url = 'admin/product-management?action=modify&ID=' + encodeURIComponent(id);
        window.location.href = url;
    }
</script>
</body>
</html>
