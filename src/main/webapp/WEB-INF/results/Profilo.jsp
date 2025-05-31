<%@ page import="model.Utente" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DuckDuckStore | Profilo Utente</title>
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">
    <!-- Core styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/design-system.css">
    <!-- Component-specific styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">
</head>

<body>
    <%@ include file="header.jsp" %>
    
    <% Utente user = (Utente) request.getSession().getAttribute("Utente"); %>
    
    <main class="main">
        <div class="container">
            <div class="profile-page">
                <div class="profile-header">
                    <h1 class="profile-title">Il Mio Profilo</h1>
                    <p class="profile-subtitle">Gestisci le tue informazioni personali e account</p>
                </div>

                <div class="profile-content">
                    <!-- Account Info Card -->
                    <div class="profile-card">
                        <div class="card-header">
                            <h2 class="card-title">Informazioni Account</h2>
                            <div class="account-balance">
                                <span class="balance-label">Saldo disponibile:</span>
                                <span class="balance-amount">&euro; <%= String.format("%.2f", user.getSaldo()) %></span>
                            </div>
                        </div>
                        
                        <div class="balance-actions">
                            <button type="button" class="btn btn-secondary" 
                                onclick="window.location.href='update-profilo?action=newsaldo'">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" 
                                    fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" 
                                    stroke-linejoin="round">
                                    <path d="M12 2v20M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
                                </svg>
                                Ricarica Saldo (+€1000)
                            </button>
                        </div>
                    </div>

                    <!-- Personal Information Card -->
                    <div class="profile-card">
                        <div class="card-header">
                            <h2 class="card-title">Informazioni Personali</h2>
                            <p class="card-description">Aggiorna i tuoi dati personali</p>
                        </div>
                        
                        <form method="post" id="formProfilo" action="update-profilo" onsubmit="return verifyProfile()" class="profile-form">
                            <div class="form-grid">
                                <div class="form-group">
                                    <label for="firstName" class="form-label">Nome</label>
                                    <input type="text" id="firstName" name="firstName" 
                                        value="<%= user.getNome() %>" 
                                        class="form-input" required>
                                </div>
                                
                                <div class="form-group">
                                    <label for="lastName" class="form-label">Cognome</label>
                                    <input type="text" id="lastName" name="lastName" 
                                        value="<%= user.getCognome() %>" 
                                        class="form-input" required>
                                </div>
                                
                                <div class="form-group full-width">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" id="email" name="email" 
                                        value="<%= user.getEmail() %>" 
                                        class="form-input" required>
                                </div>
                                
                                <div class="form-group full-width">
                                    <label for="password" class="form-label">Nuova Password</label>
                                    <input type="password" id="password" name="password" 
                                        class="form-input" placeholder="Lascia vuoto per non modificare">
                                    <small class="form-help">Minimo 8 caratteri. Lascia vuoto se non vuoi modificarla.</small>
                                </div>
                            </div>
                            
                            <div class="form-actions">
                                <button type="button" class="btn btn-outline" 
                                    onclick="window.location.href='${pageContext.request.contextPath}/home'">
                                    Annulla
                                </button>
                                <button type="submit" class="btn btn-primary">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" 
                                        fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" 
                                        stroke-linejoin="round">
                                        <path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path>
                                        <polyline points="17,21 17,13 7,13 7,21"></polyline>
                                        <polyline points="7,3 7,8 15,8"></polyline>
                                    </svg>
                                    Salva Modifiche
                                </button>
                            </div>
                            
                            <div id="error" class="error-message" style="display: none;"></div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <%@ include file="footer.jsp" %>

    <script>
        function verifyProfile() {
            var nome = document.getElementById('firstName').value;
            var cognome = document.getElementById('lastName').value;
            var email = document.getElementById('email').value;
            var password = document.getElementById('password').value;

            // Validazione degli input lato client
            var emailRGX = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            var passwordRGX = /^[a-zA-Z0-9!@#$%^&*]*$/;
            var nameRGX = /^[a-zA-Z\s'àèìòùáéíóúâêîôûäëïöüñç-]+$/i;

            var errorMessage = "";

            if (nome.trim() === "") {
                errorMessage += "Il nome è obbligatorio.<br>";
            } else if (!nameRGX.test(nome)) {
                errorMessage += "Il nome contiene caratteri non validi.<br>";
            }

            if (cognome.trim() === "") {
                errorMessage += "Il cognome è obbligatorio.<br>";
            } else if (!nameRGX.test(cognome)) {
                errorMessage += "Il cognome contiene caratteri non validi.<br>";
            }

            if (email.trim() === "") {
                errorMessage += "L'email è obbligatoria.<br>";
            } else if (!emailRGX.test(email)) {
                errorMessage += "Formato email non corretto.<br>";
            }

            if (password.trim() !== "") {
                if (password.length < 8) {
                    errorMessage += "La password deve contenere almeno 8 caratteri.<br>";
                } else if (!passwordRGX.test(password)) {
                    errorMessage += "La password contiene caratteri non consentiti.<br>";
                }
            }

            if (errorMessage !== "") {
                document.getElementById("error").innerHTML = errorMessage;
                document.getElementById("error").style.display = "block";
                return false;
            }
            
            return true;
        }
    </script>

    <style>
        .profile-page {
            min-height: 70vh;
            padding: 2rem 0;
        }

        .profile-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .profile-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--color-text-primary);
            margin-bottom: 0.5rem;
        }

        .profile-subtitle {
            font-size: 1.1rem;
            color: var(--color-text-secondary);
            margin: 0;
        }

        .profile-content {
            max-width: 800px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }

        .profile-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            overflow: hidden;
        }

        .card-header {
            padding: 2rem 2rem 1rem;
            border-bottom: 1px solid var(--color-border);
        }

        .card-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--color-text-primary);
            margin-bottom: 0.5rem;
        }

        .card-description {
            color: var(--color-text-secondary);
            margin: 0;
        }

        .account-balance {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 1rem;
        }

        .balance-label {
            color: var(--color-text-secondary);
            font-weight: 500;
        }

        .balance-amount {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--color-success);
        }

        .balance-actions {
            padding: 1rem 2rem 2rem;
        }

        .profile-form {
            padding: 0 2rem 2rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        .form-label {
            font-weight: 500;
            color: var(--color-text-primary);
            margin-bottom: 0.5rem;
        }

        .form-input {
            padding: 0.75rem;
            border: 1px solid var(--color-border);
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--color-primary);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .form-help {
            margin-top: 0.25rem;
            font-size: 0.875rem;
            color: var(--color-text-secondary);
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
        }

        .error-message {
            background: #FEF2F2;
            border: 1px solid #FECACA;
            color: #DC2626;
            padding: 1rem;
            border-radius: 8px;
            margin-top: 1rem;
            font-size: 0.875rem;
        }

        @media (max-width: 768px) {
            .profile-title {
                font-size: 2rem;
            }

            .form-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .form-group.full-width {
                grid-column: span 1;
            }

            .form-actions {
                flex-direction: column;
            }

            .profile-card {
                margin: 0 1rem;
            }

            .card-header,
            .balance-actions,
            .profile-form {
                padding-left: 1rem;
                padding-right: 1rem;
            }
        }
    </style>
</body>

</html>