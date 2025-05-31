<%@ page import="model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DuckDuckStore | Checkout - Indirizzo di Consegna</title>
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">
    <!-- Core styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/design-system.css">
    <!-- Component-specific styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            /* Use existing design system colors */
            --primary-color: var(--color-primary);
            --primary-dark: #e57a80;
            --primary-light: #fce8ea;
            --secondary-color: var(--color-secondary);
            --accent-color: var(--color-accent);
            --success-color: #22c55e;
            --danger-color: #ef4444;
            --warning-color: #f59e0b;
            
            /* Text colors from design system */
            --text-primary: var(--color-black);
            --text-secondary: var(--color-gray-500);
            --text-muted: var(--color-gray-400);
            
            /* Background colors from design system */
            --bg-primary: var(--color-white);
            --bg-secondary: var(--color-gray-100);
            --bg-light: var(--color-gray-100);
            
            /* Border colors */
            --border-color: var(--color-gray-200);
            --border-light: var(--color-gray-200);
            
            /* Shadows from design system */
            --shadow-sm: var(--shadow-sm);
            --shadow-md: var(--shadow-md);
            --shadow-lg: var(--shadow-lg);
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }

        body {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            font-family: 'Inter', sans-serif;
            color: var(--text-primary);
            min-height: 100vh;
        }

        .checkout-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 2rem 1rem;
        }

        .checkout-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .checkout-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .checkout-subtitle {
            font-size: 1.125rem;
            color: var(--text-secondary);
            font-weight: 400;
        }

        .checkout-steps {
            display: flex;
            justify-content: center;
            margin-bottom: 3rem;
            gap: 1rem;
            position: relative;
        }

        .checkout-steps::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 2px;
            background: var(--border-color);
            z-index: 1;
        }

        .step {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 1rem;
            border-radius: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            background: var(--bg-primary);
            box-shadow: var(--shadow-md);
            z-index: 2;
            min-width: 160px;
        }

        .step.active {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            color: white;
            transform: translateY(-4px);
            box-shadow: var(--shadow-xl);
        }

        .step.inactive {
            background: var(--bg-primary);
            color: var(--text-secondary);
        }

        .step-number {
            background: white;
            color: var(--primary-color);
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.125rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            box-shadow: var(--shadow-sm);
        }

        .step.active .step-number {
            background: white;
            color: var(--primary-color);
        }

        .step.inactive .step-number {
            background: var(--bg-light);
            color: var(--text-muted);
        }

        .step-text {
            font-size: 0.875rem;
            text-align: center;
            line-height: 1.2;
        }

        .checkout-card {
            background: var(--bg-primary);
            border-radius: 20px;
            box-shadow: var(--shadow-xl);
            padding: 3rem;
            margin-bottom: 2rem;
            border: 1px solid var(--border-light);
        }

        .card-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }

        .card-title {
            font-size: 1.875rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .card-subtitle {
            font-size: 1rem;
            color: var(--text-secondary);
            font-weight: 400;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.75rem;
            font-weight: 600;
            color: var(--text-primary);
            font-size: 0.975rem;
        }

        .form-group label .required {
            color: var(--danger-color);
            margin-left: 0.25rem;
        }

        .input-wrapper {
            position: relative;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 1rem 1.25rem;
            border: 2px solid var(--border-color);
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 400;
            background: var(--bg-primary);
            transition: all 0.3s ease;
            box-shadow: var(--shadow-sm);
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: var(--shadow-md), 0 0 0 3px rgba(255, 107, 53, 0.1);
            transform: translateY(-1px);
        }

        .form-group input::placeholder,
        .form-group textarea::placeholder {
            color: var(--text-muted);
            font-weight: 400;
        }

        .form-group.error input,
        .form-group.error textarea {
            border-color: var(--danger-color);
            box-shadow: var(--shadow-md), 0 0 0 3px rgba(239, 68, 68, 0.1);
        }

        .error-message {
            color: var(--danger-color);
            font-size: 0.875rem;
            font-weight: 500;
            margin-top: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }

        .error-message::before {
            content: '⚠️';
            font-size: 0.75rem;
        }

        .saved-address {
            background: linear-gradient(135deg, var(--primary-light) 0%, #fff5f2 100%);
            border: 2px solid var(--primary-color);
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .saved-address::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color) 0%, var(--primary-dark) 100%);
        }

        .saved-address:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .saved-address.selected {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            color: white;
            box-shadow: var(--shadow-xl);
        }

        .saved-address h4 {
            font-size: 1.125rem;
            font-weight: 600;
            margin-bottom: 0.75rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .saved-address p {
            margin-bottom: 0.5rem;
            font-weight: 500;
        }

        .saved-address p:last-child {
            margin-bottom: 0;
        }

        .checkout-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 3rem;
            gap: 1rem;
        }

        .btn {
            padding: 1rem 2rem;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            text-align: center;
            justify-content: center;
            min-width: 160px;
        }

        .btn-back {
            background: var(--bg-secondary);
            color: var(--text-primary);
            border: 2px solid var(--border-color);
        }

        .btn-back:hover {
            background: var(--bg-light);
            border-color: var(--text-secondary);
            transform: translateY(-1px);
            box-shadow: var(--shadow-md);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            color: white;
            border: 2px solid var(--primary-color);
            box-shadow: var(--shadow-md);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-primary:active {
            transform: translateY(0);
        }

        @media (max-width: 768px) {
            .checkout-container {
                padding: 1rem;
            }

            .checkout-title {
                font-size: 2rem;
            }

            .checkout-card {
                padding: 2rem;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
            
            .checkout-steps {
                flex-direction: column;
                align-items: center;
                gap: 0.5rem;
            }

            .checkout-steps::before {
                display: none;
            }

            .step {
                min-width: auto;
                width: 200px;
            }
            
            .checkout-actions {
                flex-direction: column;
                gap: 1rem;
            }

            .btn {
                width: 100%;
            }
        }

        /* Loading animation for form submission */
        .btn-loading {
            position: relative;
            color: transparent;
        }

        .btn-loading::after {
            content: '';
            position: absolute;
            width: 20px;
            height: 20px;
            border: 2px solid white;
            border-top: 2px solid transparent;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        @keyframes spin {
            0% { transform: translate(-50%, -50%) rotate(0deg); }
            100% { transform: translate(-50%, -50%) rotate(360deg); }
        }

        /* Focus management for accessibility */
        .form-group input:focus-visible,
        .form-group textarea:focus-visible {
            outline: 2px solid var(--primary-color);
            outline-offset: 2px;
        }
    </style>
</head>

<body>
    <!-- Header -->
    <%@ include file="header.jsp" %>

    <main class="checkout-container">
        <!-- Header -->
        <div class="checkout-header">
            <h1 class="checkout-title">Checkout</h1>
            <p class="checkout-subtitle">Completa il tuo ordine in pochi semplici passaggi</p>
        </div>

        <!-- Checkout Steps -->
        <div class="checkout-steps">
            <div class="step active">
                <span class="step-number">1</span>
                <span class="step-text">Indirizzo di<br>Consegna</span>
            </div>
            <div class="step inactive">
                <span class="step-number">2</span>
                <span class="step-text">Metodo di<br>Pagamento</span>
            </div>
            <div class="step inactive">
                <span class="step-number">3</span>
                <span class="step-text">Conferma<br>Ordine</span>
            </div>
        </div>

        <div class="checkout-card">
            <div class="card-header">
                <h2 class="card-title">📍 Dove vuoi ricevere il tuo ordine?</h2>
                <p class="card-subtitle">Inserisci l'indirizzo di consegna per il tuo ordine</p>
            </div>

            <!-- Error message display -->
            <% String errore = (String) request.getAttribute("errore"); %>
            <% if (errore != null) { %>
                <div class="alert alert-error" style="background: linear-gradient(135deg, #ef4444, #dc2626); color: white; padding: 1rem; border-radius: 12px; margin-bottom: 2rem; font-weight: 500;">
                    ⚠️ <%= errore %>
                </div>
            <% } %>

            <!-- Saved Address (if available) -->
            <% IndirizzoConsegna lastAddress = (IndirizzoConsegna) request.getAttribute("lastAddress"); %>
            <% if (lastAddress != null) { %>
                <div class="saved-address" id="savedAddress" onclick="useSavedAddress()">
                    <h4>✨ Usa l'ultimo indirizzo utilizzato</h4>
                    <p><strong><%= lastAddress.getNomeCompleto() %></strong></p>
                    <p><%= lastAddress.getIndirizzoCompleto() %></p>
                    <% if (lastAddress.getTelefono() != null && !lastAddress.getTelefono().isEmpty()) { %>
                        <p>📞 <%= lastAddress.getTelefono() %></p>
                    <% } %>
                </div>
            <% } %>

            <form id="addressForm" action="checkout" method="post">
                <input type="hidden" name="step" value="address">
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="nome">Nome<span class="required">*</span></label>
                        <div class="input-wrapper">
                            <input type="text" id="nome" name="nome" value="<%= lastAddress != null && lastAddress.getNome() != null ? lastAddress.getNome() : "" %>" 
                                   placeholder="Inserisci il tuo nome" required>
                        </div>
                        <div class="error-message" id="nomeError"></div>
                    </div>
                    <div class="form-group">
                        <label for="cognome">Cognome<span class="required">*</span></label>
                        <div class="input-wrapper">
                            <input type="text" id="cognome" name="cognome" value="<%= lastAddress != null && lastAddress.getCognome() != null ? lastAddress.getCognome() : "" %>" 
                                   placeholder="Inserisci il tuo cognome" required>
                        </div>
                        <div class="error-message" id="cognomeError"></div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="via">Indirizzo<span class="required">*</span></label>
                    <div class="input-wrapper">
                        <input type="text" id="via" name="via" value="<%= lastAddress != null && lastAddress.getVia() != null ? lastAddress.getVia() : "" %>" 
                               placeholder="Via, Numero civico (es. Via Roma 123)" required>
                    </div>
                    <div class="error-message" id="viaError"></div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="citta">Città<span class="required">*</span></label>
                        <div class="input-wrapper">
                            <input type="text" id="citta" name="citta" value="<%= lastAddress != null && lastAddress.getCitta() != null ? lastAddress.getCitta() : "" %>" 
                                   placeholder="Inserisci la città" required>
                        </div>
                        <div class="error-message" id="cittaError"></div>
                    </div>
                    <div class="form-group">
                        <label for="cap">Codice Postale<span class="required">*</span></label>
                        <div class="input-wrapper">
                            <input type="text" id="cap" name="cap" value="<%= lastAddress != null && lastAddress.getCap() != null ? lastAddress.getCap() : "" %>" 
                                   pattern="[0-9]{5}" maxlength="5" placeholder="12345" required>
                        </div>
                        <div class="error-message" id="capError"></div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="telefono">Numero di Telefono</label>
                    <div class="input-wrapper">
                        <input type="tel" id="telefono" name="telefono" value="<%= lastAddress != null && lastAddress.getTelefono() != null ? lastAddress.getTelefono() : "" %>" 
                               placeholder="+39 123 456 7890">
                    </div>
                    <div class="error-message" id="telefonoError"></div>
                </div>

                <div class="form-group">
                    <label for="note">Note per la Consegna</label>
                    <div class="input-wrapper">
                        <textarea id="note" name="note" rows="4" 
                                  placeholder="Informazioni aggiuntive: scala, piano, citofono, orari preferiti..."><%= lastAddress != null && lastAddress.getNote() != null ? lastAddress.getNote() : "" %></textarea>
                    </div>
                </div>

                <div class="checkout-actions">
                    <a href="carrello" class="btn btn-back">
                        ← Torna al Carrello
                    </a>
                    <button type="submit" class="btn btn-primary" id="submitBtn">
                        Continua al Pagamento →
                    </button>
                </div>
            </form>
        </div>
    </main>

    <script>
        function useSavedAddress() {
            const savedAddress = document.getElementById('savedAddress');
            savedAddress.classList.toggle('selected');
            
            // If using saved address, disable form fields
            const formInputs = document.querySelectorAll('#addressForm input, #addressForm textarea');
            const isSelected = savedAddress.classList.contains('selected');
            
            formInputs.forEach(input => {
                if (input.type !== 'hidden') {
                    input.disabled = isSelected;
                    if (isSelected) {
                        input.style.opacity = '0.5';
                        input.style.pointerEvents = 'none';
                    } else {
                        input.style.opacity = '1';
                        input.style.pointerEvents = 'auto';
                    }
                }
            });

            // Add hidden input to indicate using saved address
            const hiddenInput = document.getElementById('useSavedAddress');
            if (isSelected) {
                if (!hiddenInput) {
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'useSavedAddress';
                    input.id = 'useSavedAddress';
                    input.value = 'true';
                    document.getElementById('addressForm').appendChild(input);
                }
            } else {
                if (hiddenInput) {
                    hiddenInput.remove();
                }
            }
        }

        // Form validation
        document.getElementById('addressForm').addEventListener('submit', function(e) {
            console.log('Form submission started');
            const submitBtn = document.getElementById('submitBtn');
            let isValid = true;

            // Clear previous errors
            document.querySelectorAll('.error-message').forEach(el => el.textContent = '');
            document.querySelectorAll('.form-group').forEach(el => el.classList.remove('error'));

            // Check if using saved address
            const savedAddressElement = document.getElementById('savedAddress');
            const isUsingSavedAddress = savedAddressElement && savedAddressElement.classList.contains('selected');
            
            console.log('Using saved address:', isUsingSavedAddress);

            // Skip validation if using saved address
            if (isUsingSavedAddress) {
                console.log('Skipping validation - using saved address');
                // Show loading state
                submitBtn.classList.add('btn-loading');
                submitBtn.textContent = 'Elaborazione...';
                return; // Allow form submission
            }

            console.log('Validating form fields...');

            // Validate required fields
            const requiredFields = ['nome', 'cognome', 'via', 'citta', 'cap'];
            requiredFields.forEach(field => {
                const input = document.getElementById(field);
                const value = input ? input.value.trim() : '';
                console.log(`Field ${field}:`, value);
                
                if (!value) {
                    console.log(`Error in field ${field}: empty`);
                    showError(field, 'Campo obbligatorio');
                    isValid = false;
                }
            });

            // Validate CAP
            const capInput = document.getElementById('cap');
            const cap = capInput ? capInput.value.trim() : '';
            if (cap && !cap.match(/^\d{5}$/)) {
                console.log('Error in CAP:', cap);
                showError('cap', 'Il codice postale deve essere di 5 cifre');
                isValid = false;
            }

            // Validate phone (if provided)
            const telefonoInput = document.getElementById('telefono');
            const telefono = telefonoInput ? telefonoInput.value.trim() : '';
            if (telefono && !telefono.match(/^[\+]?[\d\s\-\(\)]{8,15}$/)) {
                console.log('Error in telefono:', telefono);
                showError('telefono', 'Formato telefono non valido');
                isValid = false;
            }

            console.log('Form validation result:', isValid);

            if (!isValid) {
                console.log('Preventing form submission due to validation errors');
                e.preventDefault();
                // Scroll to first error
                const firstError = document.querySelector('.form-group.error');
                if (firstError) {
                    firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            } else {
                console.log('Form is valid, submitting...');
                // Show loading state
                submitBtn.classList.add('btn-loading');
                submitBtn.textContent = 'Elaborazione...';
            }
        });

        function showError(fieldId, message) {
            const field = document.getElementById(fieldId);
            const error = document.getElementById(fieldId + 'Error');
            field.parentElement.parentElement.classList.add('error');
            error.textContent = message;
        }

        // Auto-format CAP
        document.getElementById('cap').addEventListener('input', function(e) {
            e.target.value = e.target.value.replace(/\D/g, '').substring(0, 5);
        });

        // Auto-format phone number
        document.getElementById('telefono').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.startsWith('39')) {
                value = '+39 ' + value.substring(2);
            } else if (value.length > 0 && !value.startsWith('+')) {
                if (value.startsWith('3')) {
                    value = '+39 ' + value;
                }
            }
            
            // Format the number with spaces
            if (value.startsWith('+39 ')) {
                const number = value.substring(4);
                if (number.length > 3) {
                    value = '+39 ' + number.substring(0, 3) + ' ' + number.substring(3, 6) + ' ' + number.substring(6);
                }
            }
            
            e.target.value = value;
        });

        // Add smooth animations on input focus
        document.querySelectorAll('.form-group input, .form-group textarea').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.parentElement.style.transform = 'translateY(-2px)';
            });
            
            input.addEventListener('blur', function() {
                this.parentElement.parentElement.style.transform = 'translateY(0)';
            });
        });
    </script>
</body>
</html> 