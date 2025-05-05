<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="css/login.css">
    <title>Utente</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<%@ include file="header.jsp" %>
<%@ include file="nav.jsp" %>
<div class="login-page">
<% String errormsg = (String) request.getAttribute("errore"); %>
    <div class="form">
        <form method="POST" class="login-form" onsubmit="return verifyLogin()" action="login">
            <input type="hidden" name="flag" id="flag" value="true">
            <label for="email">Indirizzo email</label><br>
            <input type="email" placeholder="Inserisci l'email" name="Email" id="email" required><br>
            <label for="password">Password</label><br>
            <input type="password" placeholder="Inserisci la password" name="Password" id="password" required><br>
            <button type="submit" id="submit" class="cart">Login</button>
            <p class="message">Non registrato? <a href="registration">Crea un account</a></p>


            <% if (errormsg != null) { %>
            <p id="error"><%= errormsg %></p>
            <% } %>
        </form>
    </div>
</div>
<%@include file="footer.jsp" %>
<script>
    function verifyLogin() {
        var email = document.getElementById('email').value;
        var password = document.getElementById('password').value;

        // Validazione degli input lato client
        var emailRGX = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        var passwordRGX = /^[a-zA-Z0-9!@#$%^&*]*$/;

        var errorMessage = "";

        if (!emailRGX.test(email)) {
            errorMessage = "Formato email non corretto.<br>";
        }

        if (!passwordRGX.test(password)) {
            errorMessage = "Il campo password contiene caratteri non consentiti.<br>";
        }

        if (email.trim() === "" || password.trim() === "") {
            errorMessage = "Non ci possono essere campi vuoti.<br>";
        }

        if (errorMessage !== "") {
            document.getElementById("error").innerHTML = errorMessage;
            document.getElementById("error").style.display = "block";
            return false;
        }

        return true;
    }
</script>
</body>
</html>
