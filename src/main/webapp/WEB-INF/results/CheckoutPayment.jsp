<%@ page import="model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DuckDuckStore | Checkout - Pagamento</title>
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
            max-width: 1200px;
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

        .step.completed {
            background: linear-gradient(135deg, var(--success-color) 0%, #059669 100%);
            color: white;
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

        .step.completed .step-number {
            background: white;
            color: var(--success-color);
        }

        .step.completed .step-number::before {
            content: '✓';
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

        .checkout-content {
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 2rem;
        }

        .payment-section {
            background: var(--bg-primary);
            border-radius: 20px;
            box-shadow: var(--shadow-xl);
            padding: 3rem;
            border: 1px solid var(--border-light);
        }

        .summary-section {
            background: var(--bg-primary);
            border-radius: 20px;
            box-shadow: var(--shadow-xl);
            padding: 2rem;
            border: 1px solid var(--border-light);
            height: fit-content;
            position: sticky;
            top: 2rem;
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

        .payment-method-info {
            background: linear-gradient(135deg, var(--primary-light) 0%, #fff5f2 100%);
            border: 2px solid var(--primary-color);
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            text-align: center;
        }

        .credit-card-preview {
            background: linear-gradient(135deg, #1f2937 0%, #374151 100%);
            border-radius: 16px;
            padding: 2rem;
            color: white;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
            min-height: 200px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .credit-card-preview::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 300px;
            height: 300px;
            background: radial-gradient(circle, rgba(255, 107, 53, 0.3) 0%, transparent 70%);
            border-radius: 50%;
        }

        .card-chip {
            width: 50px;
            height: 40px;
            background: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%);
            border-radius: 8px;
            margin-bottom: 1rem;
        }

        .card-number {
            font-size: 1.5rem;
            font-weight: 600;
            letter-spacing: 0.2em;
            margin-bottom: 1rem;
            font-family: 'Courier New', monospace;
        }

        .card-details {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
        }

        .card-holder {
            font-size: 0.875rem;
            font-weight: 500;
            text-transform: uppercase;
        }

        .card-expiry {
            font-size: 0.875rem;
            font-weight: 500;
            font-family: 'Courier New', monospace;
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

        .form-group input {
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

        .form-group input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: var(--shadow-md), 0 0 0 3px rgba(255, 107, 53, 0.1);
            transform: translateY(-1px);
        }

        .form-group input::placeholder {
            color: var(--text-muted);
            font-weight: 400;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 120px;
            gap: 1rem;
        }

        .form-group.error input {
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

        .summary-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid var(--border-light);
        }

        .summary-row:last-child {
            border-bottom: none;
            font-weight: 600;
            font-size: 1.125rem;
            color: var(--primary-color);
        }

        .summary-label {
            font-weight: 500;
            color: var(--text-secondary);
        }

        .summary-value {
            font-weight: 600;
            color: var(--text-primary);
        }

        .delivery-info {
            background: var(--bg-light);
            border-radius: 12px;
            padding: 1rem;
            margin-bottom: 1rem;
            font-size: 0.875rem;
        }

        .delivery-info h4 {
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--text-primary);
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

        .processing-animation {
            display: none;
            text-align: center;
            padding: 2rem;
        }

        .processing-animation.active {
            display: block;
        }

        .spinner {
            width: 60px;
            height: 60px;
            border: 4px solid var(--border-light);
            border-top: 4px solid var(--primary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto 1rem;
        }

        @media (max-width: 768px) {
            .checkout-container {
                padding: 1rem;
            }

            .checkout-title {
                font-size: 2rem;
            }

            .checkout-content {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .payment-section,
            .summary-section {
                padding: 2rem;
            }

            .summary-section {
                position: static;
            }

            .form-row {
                grid-template-columns: 1fr;
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

        /* Focus management for accessibility */
        .form-group input:focus-visible {
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
            <div class="step completed">
                <span class="step-number"></span>
                <span class="step-text">Indirizzo di<br>Consegna</span>
            </div>
            <div class="step active">
                <span class="step-number">2</span>
                <span class="step-text">Metodo di<br>Pagamento</span>
            </div>
            <div class="step inactive">
                <span class="step-number">3</span>
                <span class="step-text">Conferma<br>Ordine</span>
            </div>
        </div>

        <div class="checkout-content">
            <!-- Payment Section -->
            <div class="payment-section">
                <div class="card-header">
                    <h2 class="card-title">💳 Metodo di Pagamento</h2>
                    <p class="card-subtitle">Inserisci i dati della tua carta di credito</p>
                </div>

                <!-- Error message display -->
                <% String errore = (String) request.getAttribute("errore"); %>
                <% if (errore != null) { %>
                    <div class="alert alert-error" style="background: linear-gradient(135deg, #ef4444, #dc2626); color: white; padding: 1rem; border-radius: 12px; margin-bottom: 2rem; font-weight: 500;">
                        ⚠️ <%= errore %>
                    </div>
                <% } %>

                <!-- Payment Method Info -->
                <div class="payment-method-info">
                    <h4>🔒 Pagamento Sicuro</h4>
                    <p><strong>Per il test, usa la carta:</strong> 4242 4242 4242 4242</p>
                    <p><small>Qualsiasi data futura e CVV a 3 cifre</small></p>
                </div>

                <!-- Credit Card Preview -->
                <div class="credit-card-preview">
                    <div>
                        <div class="card-chip"></div>
                        <div class="card-number" id="cardPreviewNumber">**** **** **** ****</div>
                    </div>
                    <div class="card-details">
                        <div>
                            <div style="font-size: 0.75rem; opacity: 0.8;">CARD HOLDER</div>
                            <div class="card-holder" id="cardPreviewHolder">NOME COGNOME</div>
                        </div>
                        <div>
                            <div style="font-size: 0.75rem; opacity: 0.8;">EXPIRES</div>
                            <div class="card-expiry" id="cardPreviewExpiry">MM/YY</div>
                        </div>
                    </div>
                </div>

                <form id="paymentForm" action="checkout" method="post">
                    <input type="hidden" name="step" value="payment">
                    
                    <div class="form-group">
                        <label for="cardHolder">Nome del Titolare<span class="required">*</span></label>
                        <div class="input-wrapper">
                            <input type="text" id="cardHolder" name="cardHolder" 
                                   placeholder="Nome e Cognome come sulla carta" required>
                        </div>
                        <div class="error-message" id="cardHolderError"></div>
                    </div>

                    <div class="form-group">
                        <label for="cardNumber">Numero della Carta<span class="required">*</span></label>
                        <div class="input-wrapper">
                            <input type="text" id="cardNumber" name="cardNumber" 
                                   placeholder="1234 5678 9012 3456" maxlength="19" required>
                        </div>
                        <div class="error-message" id="cardNumberError"></div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="cardExpiry">Scadenza<span class="required">*</span></label>
                            <div class="input-wrapper">
                                <input type="text" id="cardExpiry" name="cardExpiry" 
                                       placeholder="MM/AA" maxlength="5" required>
                            </div>
                            <div class="error-message" id="cardExpiryError"></div>
                        </div>
                        <div class="form-group">
                            <label for="cardCvv">CVV<span class="required">*</span></label>
                            <div class="input-wrapper">
                                <input type="text" id="cardCvv" name="cardCvv" 
                                       placeholder="123" maxlength="3" required>
                            </div>
                            <div class="error-message" id="cardCvvError"></div>
                        </div>
                    </div>

                    <div class="checkout-actions">
                        <a href="checkout" class="btn btn-back">
                            ← Indirizzo
                        </a>
                        <button type="submit" class="btn btn-primary" id="submitBtn">
                            <span id="btnText">Completa Ordine</span>
                        </button>
                    </div>
                </form>

                <!-- Processing Animation -->
                <div class="processing-animation" id="processingAnimation">
                    <div class="spinner"></div>
                    <h3>Elaborazione pagamento...</h3>
                    <p>Non chiudere questa pagina</p>
                </div>
            </div>

            <!-- Summary Section -->
            <div class="summary-section">
                <h3 class="summary-title">�� Riepilogo Ordine</h3>

                <!-- Delivery Info -->
                <div class="delivery-info">
                    <h4>📍 Indirizzo di Consegna</h4>
                    <p>${indirizzoRiepilogo}</p>
                </div>

                <div class="summary-row">
                    <span class="summary-label">Subtotale</span>
                    <span class="summary-value">€${totaleCarrello}</span>
                </div>

                <div class="summary-row">
                    <span class="summary-label">IVA (22%)</span>
                    <span class="summary-value">€${String.format("%.2f", totaleCarrello * 0.22)}</span>
                </div>

                <div class="summary-row">
                    <span class="summary-label">Spedizione</span>
                    <span class="summary-value">Gratuita</span>
                </div>

                <div class="summary-row">
                    <span class="summary-label">Totale</span>
                    <span class="summary-value">€${String.format("%.2f", totaleCarrello * 1.22)}</span>
                </div>
            </div>
        </div>
    </main>

    <script>
        // Update credit card preview
        function updateCardPreview() {
            const cardNumber = document.getElementById('cardNumber').value;
            const cardHolder = document.getElementById('cardHolder').value;
            const cardExpiry = document.getElementById('cardExpiry').value;

            // Update card number preview
            let formattedNumber = cardNumber.replace(/\s/g, '');
            if (formattedNumber.length > 0) {
                formattedNumber = formattedNumber.replace(/(.{4})/g, '$1 ').trim();
                // Mask all but last 4 digits
                if (formattedNumber.length > 8) {
                    const lastFour = formattedNumber.slice(-4);
                    const masked = '**** **** **** ' + lastFour;
                    document.getElementById('cardPreviewNumber').textContent = masked;
                } else {
                    document.getElementById('cardPreviewNumber').textContent = formattedNumber || '**** **** **** ****';
                }
            } else {
                document.getElementById('cardPreviewNumber').textContent = '**** **** **** ****';
            }

            // Update card holder preview
            document.getElementById('cardPreviewHolder').textContent = 
                cardHolder.toUpperCase() || 'NOME COGNOME';

            // Update expiry preview
            document.getElementById('cardPreviewExpiry').textContent = 
                cardExpiry || 'MM/YY';
        }

        // Format card number input
        document.getElementById('cardNumber').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\s/g, '');
            let formattedValue = value.replace(/(.{4})/g, '$1 ');
            if (formattedValue.endsWith(' ')) {
                formattedValue = formattedValue.slice(0, -1);
            }
            e.target.value = formattedValue;
            updateCardPreview();
        });

        // Format expiry input
        document.getElementById('cardExpiry').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length >= 2) {
                value = value.substring(0, 2) + '/' + value.substring(2, 4);
            }
            e.target.value = value;
            updateCardPreview();
        });

        // Format CVV input
        document.getElementById('cardCvv').addEventListener('input', function(e) {
            e.target.value = e.target.value.replace(/\D/g, '');
        });

        // Update card holder preview
        document.getElementById('cardHolder').addEventListener('input', updateCardPreview);

        // Form validation
        document.getElementById('paymentForm').addEventListener('submit', function(e) {
            console.log('Payment form submission started');
            const submitBtn = document.getElementById('submitBtn');
            const btnText = document.getElementById('btnText');
            let isValid = true;

            // Clear previous errors
            document.querySelectorAll('.error-message').forEach(el => el.textContent = '');
            document.querySelectorAll('.form-group').forEach(el => el.classList.remove('error'));

            // Validate card holder
            const cardHolder = document.getElementById('cardHolder').value.trim();
            console.log('Card holder:', cardHolder);
            if (!cardHolder || cardHolder.length < 2) {
                console.log('Error: Card holder invalid');
                showError('cardHolder', 'Nome del titolare richiesto');
                isValid = false;
            }

            // Validate card number
            const cardNumber = document.getElementById('cardNumber').value.replace(/\s/g, '');
            console.log('Card number:', cardNumber);
            if (!cardNumber || cardNumber.length !== 16 || !isValidCardNumber(cardNumber)) {
                console.log('Error: Card number invalid, length:', cardNumber.length, 'valid:', isValidCardNumber(cardNumber));
                showError('cardNumber', 'Numero carta non valido');
                isValid = false;
            }

            // Validate expiry
            const cardExpiry = document.getElementById('cardExpiry').value;
            console.log('Card expiry:', cardExpiry);
            if (!cardExpiry || !isValidExpiry(cardExpiry)) {
                console.log('Error: Card expiry invalid');
                showError('cardExpiry', 'Data di scadenza non valida');
                isValid = false;
            }

            // Validate CVV
            const cardCvv = document.getElementById('cardCvv').value;
            console.log('Card CVV:', cardCvv);
            if (!cardCvv || cardCvv.length !== 3) {
                console.log('Error: CVV invalid, length:', cardCvv.length);
                showError('cardCvv', 'CVV deve essere di 3 cifre');
                isValid = false;
            }

            console.log('Payment validation result:', isValid);

            if (!isValid) {
                console.log('Preventing payment form submission due to validation errors');
                e.preventDefault();
                // Scroll to first error
                const firstError = document.querySelector('.form-group.error');
                if (firstError) {
                    firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            } else {
                console.log('Payment form is valid, submitting...');
                // Show processing animation
                submitBtn.classList.add('btn-loading');
                btnText.textContent = 'Elaborazione...';
                
                // Remove the setTimeout that prevents submission
                // setTimeout(() => {
                //     document.querySelector('.payment-section').style.display = 'none';
                //     document.getElementById('processingAnimation').classList.add('active');
                // }, 500);
            }
        });

        function showError(fieldId, message) {
            const field = document.getElementById(fieldId);
            const error = document.getElementById(fieldId + 'Error');
            field.parentElement.parentElement.classList.add('error');
            error.textContent = message;
        }

        function isValidCardNumber(number) {
            // Basic Luhn algorithm check
            let sum = 0;
            let alternate = false;
            for (let i = number.length - 1; i >= 0; i--) {
                let n = parseInt(number.charAt(i), 10);
                if (alternate) {
                    n *= 2;
                    if (n > 9) {
                        n = (n % 10) + 1;
                    }
                }
                sum += n;
                alternate = !alternate;
            }
            return (sum % 10 === 0);
        }

        function isValidExpiry(expiry) {
            if (!/^\d{2}\/\d{2}$/.test(expiry)) return false;
            
            const [month, year] = expiry.split('/').map(Number);
            const now = new Date();
            const currentYear = now.getFullYear() % 100;
            const currentMonth = now.getMonth() + 1;
            
            if (month < 1 || month > 12) return false;
            if (year < currentYear || (year === currentYear && month < currentMonth)) return false;
            
            return true;
        }

        // Add smooth animations on input focus
        document.querySelectorAll('.form-group input').forEach(input => {
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