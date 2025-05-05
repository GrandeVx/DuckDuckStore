<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Utente" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="css/lista_utenti.css" rel="stylesheet" type="text/css">
    <title>Riepilogo utenti</title>

</head>
<%
    ArrayList<Utente> listaUtenti = (ArrayList<Utente>) request.getAttribute("listaUtenti");
    Utente utenteLoggato = (Utente) request.getSession().getAttribute("Utente");
%>
<body>
<div class="container">
    <button onclick="window.location.href ='<%=request.getContextPath()%>'">Home Page</button>
    <table class="utenti">
        <tr>
            <th>Nome</th>
            <th>Cognome</th>
            <th>Email</th>
            <th>Amministratore</th>
        </tr>
        <% for (Utente ut : listaUtenti) { %>
        <tr>
            <td><%= ut.getNome() %>
            </td>
            <td><%= ut.getCognome() %>
            </td>
            <td><%= ut.getEmail() %>
            <td>
                <div class="admin-buttons">
                    <button class="toggle <%= ut.isAmministratore() ? "non-admin" : "admin" %>"
                            <% if (utenteLoggato.getID() != ut.getID()) {%>
                            onclick="toggleAdminStatus(this, '<%= ut.getID() %>')"
                            <%}%>>
                        <%= ut.isAmministratore() ? "Si" : "No" %>
                    </button>
                </div>
            </td>
        </tr>
        <%}%>
    </table>
</div>

<script>
    function toggleAdminStatus(button, ID) {
        const isAdmin = button.classList.contains('admin');

        //AJAX per aggiornare lo status dell'utente
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "admin", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.send("action=utenti&ID=" + ID + "&status=" + isAdmin);
        /////////////////////////////////////////

        if (isAdmin) {
            button.classList.remove('admin');
            button.classList.add('non-admin');
            button.textContent = 'Si';
        } else {
            button.classList.remove('non-admin');
            button.classList.add('admin');
            button.textContent = 'No';
        }
    }
</script>
</body>
</html>
