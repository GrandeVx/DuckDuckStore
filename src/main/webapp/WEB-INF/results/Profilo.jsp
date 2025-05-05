<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profilo Utente</title>
    <link href="css/profilo.css" rel="stylesheet" type="text/css">

</head>
<body>
<%@ include file="header.jsp" %>

<% Utente user = (Utente) request.getSession().getAttribute("Utente");
%>
<div class="container">
    <div class="header">
        <h2>Informazioni Personali</h2>
    </div>
    <form method="post" id="formProfilo" action="update-profilo" onsubmit="return verifyProfile()">
        <div class="gruppo-form">
            <label for="firstName">Nome</label>
            <input type="text" id="firstName" name="firstName" value="<%= user.getNome()%>"  required>
        </div>
        <div class="gruppo-form">
            <label for="lastName">Cognome</label>
            <input type="text" id="lastName" name="lastName" value="<%= user.getCognome()%>" required>
        </div>
        <div class="gruppo-form">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" value="<%= user.getEmail()%>" required>
        </div>
        <div class="gruppo-form">
            <label for="password">Nuova Password</label>
            <input type="password" id="password" name="password">
        </div>
        <button type="button" class="saldo" onclick="window.location.href ='update-profilo?action=newsaldo'">RICARICA
            SALDO
        </button>
        <div class="bottoni">
            <button type="button" class="cancella" onclick="window.location.href='<%=request.getContextPath()%>';">
                Annulla
            </button>
            <button class="salva" type="submit">Salva</button>
        </div>
    </form>
    <p id="error"></p>
</div>
</body>
</html>

<script>
    function verifyProfile() {

        var nome = document.getElementById('firstName').value;
        var cognome = document.getElementById('lastName').value;
        var email = document.getElementById('email').value;
        var password = document.getElementById('password').value;

        // Validazione degli input lato client
        var emailRGX = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        var passwordRGX = /^[a-zA-Z0-9!@#$%^&*]*$/;
        var nameRGX = /^[a-zA-Z]+$/;

        var errorMessage = "";

        if (!nameRGX.test(nome)) {
            errorMessage = "Il campo nome puo' contenere solo lettere<br>";
        }

        if (!nameRGX.test(cognome)) {
            errorMessage = "Il campo cognome puo' contenere solo lettere<br>";
        }

        if (!emailRGX.test(email)) {
            errorMessage = "Formato email non corretto.<br>";
        }

        if (!passwordRGX.test(password)) {
            errorMessage = "Il campo password contiene caratteri non consentiti.<br>";
        }

        if (password.length > 0 && password.length < 8) {
            errorMessage = "La password deve contenere almeno 8 caratteri.<br>";
        }

        if(password.trim() == "" || email.trim() == "" || cognome.trim() == "" || nome.trim() ==""){
            errorMessage = "Non ci possono essere campi vuoti.<br>"
        }

        if (errorMessage !== "") {
            document.getElementById("error").innerHTML = errorMessage;
            document.getElementById("error").style.display = "block";
            return false;
        } else
            return true
    }

</script>