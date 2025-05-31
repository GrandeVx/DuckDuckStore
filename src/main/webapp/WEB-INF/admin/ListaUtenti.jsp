<%@ page import="java.util.ArrayList" %>
    <%@ page import="model.Utente" %>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>DuckDuckStore | Admin - Utenti</title>
                <!-- Core styles -->
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/design-system.css">
                <!-- Component-specific styles -->
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
                <!-- Fonts -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">
            </head>
            <% ArrayList<Utente> listaUtenti = (ArrayList<Utente>) request.getAttribute("listaUtenti");
                    Utente utenteLoggato = (Utente) request.getSession().getAttribute("Utente");
                    %>

                    <body>
                        <%@ include file="../results/header.jsp" %>
                            <div class="admin-container">
                                <div class="admin-content">
                                    <%@ include file="admin_nav.jsp" %>

                                        <div class="admin-header">
                                            <h1 class="admin-title">Gestione Utenti</h1>
                                        </div>

                                        <div class="admin-card">
                                            <div class="admin-table-responsive">
                                                <table class="admin-table">
                                                    <thead>
                                                        <tr>
                                                            <th>Nome</th>
                                                            <th>Cognome</th>
                                                            <th>Email</th>
                                                            <th>Saldo</th>
                                                            <th>Amministratore</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <% for (Utente ut : listaUtenti) { %>
                                                            <tr>
                                                                <td>
                                                                    <%= ut.getNome() %>
                                                                </td>
                                                                <td>
                                                                    <%= ut.getCognome() %>
                                                                </td>
                                                                <td>
                                                                    <%= ut.getEmail() %>
                                                                </td>
                                                                <td>
                                                                    &euro; <%= String.format("%.2f", ut.getSaldo()) %>
                                                                </td>
                                                                <td>
                                                                    <button
                                                                        class="admin-btn <%= ut.isAmministratore() ? "admin-btn-success" : "admin-btn-secondary" %> admin-btn-sm"
                                                                        <% if (utenteLoggato.getID() != ut.getID()) {%>
                                                                            onclick="toggleAdminStatus(this, '<%= ut.getID() %>')"
                                                                        <%}%>>
                                                                        <%= ut.isAmministratore() ? "Si" : "No" %>
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                            <%}%>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                </div>
                            </div>

                            <script>
                                function toggleAdminStatus(button, ID) {
                                    const isAdmin = button.classList.contains('admin-btn-secondary');

                                    // AJAX per aggiornare lo status dell'utente
                                    var xhr = new XMLHttpRequest();
                                    xhr.open("POST", "admin", true);
                                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                                    xhr.send("action=utenti&ID=" + ID + "&status=" + isAdmin);
                                    /////////////////////////////////////////

                                    if (isAdmin) {
                                        button.classList.remove('admin-btn-secondary');
                                        button.classList.add('admin-btn-success');
                                        button.textContent = 'Si';
                                    } else {
                                        button.classList.remove('admin-btn-success');
                                        button.classList.add('admin-btn-secondary');
                                        button.textContent = 'No';
                                    }
                                }
                            </script>
                    </body>

            </html>