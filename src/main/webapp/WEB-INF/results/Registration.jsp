<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="css/registrazione.css">
    <title>Registrazione</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<%@ include file="header.jsp" %>
<%@ include file="nav.jsp" %>
<% String errormsg = (String) request.getAttribute("errore"); %>
<div class="registration-page">

    <div class="form">
        <% String stringa = (String) request.getAttribute("controllo"); %>
        <form class="registration-form" onsubmit="return verifyRegistration()" method="post" action="registration">
            <label for="nome">Nome</label><br>
            <input type="text" placeholder="Inserisci il nome" name="Nome" id="nome" required><br>
            <label for="cognome">Cognome</label><br>
            <input type="text" placeholder="Inserisci il cognome" name="Cognome" id="cognome" required><br>
            <label for="email">Email</label><br>
            <input type="email" placeholder="Inserisci l'email" name="Email" id="email" required><br>
            <label for="password">Password</label><br>
            <input type="password" placeholder="Inserisci la password" name="Password" id="password" required><br>
            <button type="submit" id="submit" class="cart">Registrati</button>
            <p class="message">Già registrato? <a href="login">Accedi</a></p>
            <% if (errormsg != null) { %>
            <p id="error"><%= errormsg %></p>
            <% } %>
            <p id="error"></p>
        </form>
    </div>
</div>
<%@include file="footer.jsp" %>
<script>
    function verifyRegistration() {
        var nome = document.getElementById('nome').value;
        var cognome = document.getElementById('cognome').value;
        var email = document.getElementById('email').value;
        var password = document.getElementById('password').value;

        // Validazione degli input lato client
        var emailRGX = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        var passwordRGX = /^[a-zA-Z0-9!@#$%^&*]*$/;
        var nameRGX = /^[a-zA-Z]+$/;

        var errorMessage = "";

        if (!nameRGX.test(nome)) {
            errorMessage = "Il campo nome può contenere solo lettere.<br>";
        }

        if (!nameRGX.test(cognome)) {
            errorMessage = "Il campo cognome può contenere solo lettere.<br>";
        }

        if (!emailRGX.test(email)) {
            errorMessage = "Formato email non corretto.<br>";
        }

        if (!passwordRGX.test(password)) {
            errorMessage = "Il campo password contiene caratteri non consentiti.<br>";
        }

        if (password.length < 8) {
            errorMessage = "La password deve contenere almeno 8 caratteri.<br>";
        }

        if (nome.trim() === "" || cognome.trim() === "" || email.trim() === "" || password.trim() === "") {
            errorMessage = "Non ci possono essere campi vuoti.<br>";
        }

        if (errorMessage !== "") {
            document.getElementById("error").innerHTML = errorMessage;
            return false;
        }

        return true;
    }
</script>
</body>
</html>
