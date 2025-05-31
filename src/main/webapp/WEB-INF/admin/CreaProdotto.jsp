<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>DuckDuckStore | Admin - Crea Prodotto</title>
            <!-- Core styles -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/design-system.css">
            <!-- Component-specific styles -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/crea_prodotto.css">
            <!-- Fonts -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">
            <c:url value="/css/product_crea_modifica.css" var="cssCreaProdotto" />
            <c:url value="/images/imageNA.png" var="imageNA" />
            <link href="${cssCreaProdotto}" type="text/css" rel="stylesheet">
        </head>

        <body>
            <%@ include file="../results/header.jsp" %>
                <button class="back" onclick="goBack()">Ritorna Indietro</button>
                <div class="tag">
                    <h2>PAGINA CREAZIONE PRODOTTO</h2>
                </div>
                <form method="post" action="new_product">
                    <div class="container">

                        <div class="summary">
                            <div class="row">
                                <div class="detail">
                                    <label for="nome">Nome Prodotto</label>
                                    <input type="text" placeholder="Nome Prodotto" name="Nome" id="nome" required>
                                </div>
                                <div class="detail">
                                    <label for="prezzo">Prezzo</label>
                                    <input type="number" placeholder="Prezzo &euro;" name="Prezzo" id="prezzo"
                                        step="0.01" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="detail">
                                    <label for="quantita">Quantita'</label>
                                    <input type="number" min="1" max="99" placeholder="Quantita'" name="Quantita"
                                        id="quantita" required>
                                </div>
                                <div class="detail">
                                    <label for="sconto">Sconto</label>
                                    <input type="number" min="0" max="100" placeholder="Sconto" name="Sconto"
                                        id="sconto" required>
                                </div>
                                <div class="detail">
                                    <label for="categoria">Categoria</label>
                                    <select placeholder="Categoria" name="Categoria" id="categoria" required>
                                        <option>spaventose</option>
                                        <option>natale</option>
                                        <option>fantasy</option>
                                        <option>professioni</option>
                                    </select>
                                </div>
                            </div>
                            <div class="detail">
                                <label for="descrizione">Descrizione</label>
                                <textarea cols="30" rows="5" placeholder="Descrizione" name="Descrizione"
                                    id="descrizione" required></textarea>
                            </div>
                            <div class="detail">
                                <button type="submit" id="submit" class="prod">Inserisci</button>
                            </div>
                        </div>
                        <div class="immagine">
                            <img src="${imageNA}" alt="Prodotto" id="previewImage">
                            <label for="imageSelect">Cambia Immagine</label>
                            <input type="text" id="imageSelect" value="${imageNA}" name="Img" required>
                        </div>
                    </div>
                </form>

                <script>

                    function goBack() {
                        window.history.back();
                    }

                    function updateImage() {
                        var imageUrl = document.getElementById('imageSelect').value;
                        var previewImage = document.getElementById('previewImage');

                        if (imageUrl.trim() === '') {
                            previewImage.src = '${imageNA}'; // Immagine predefinita
                            previewImage.alt = 'Inserisci un URL per visualizzare l\'immagine'; // Testo alternativo
                        } else {
                            previewImage.src = imageUrl;
                            previewImage.alt = 'Immagine del prodotto';
                        }
                    }

                    document.addEventListener('DOMContentLoaded', function () {
                        var imageSelect = document.getElementById('imageSelect');
                        var previewImage = document.getElementById('previewImage');

                        imageSelect.addEventListener('input', updateImage);

                        // Esegui updateImage() una volta all'inizio per impostare l'immagine iniziale
                        updateImage();
                    });
                </script>

        </body>

        </html>