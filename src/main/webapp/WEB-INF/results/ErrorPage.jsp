<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="it">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DuckDuckStore | ${errorTitle != null ? errorTitle : 'Errore'}</title>
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
    <style>
        .error-page {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: calc(100vh - var(--header-height) - var(--footer-height));
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 1rem;
        }

        .error-container {
            background: white;
            border-radius: 20px;
            padding: 3rem 2rem;
            max-width: 600px;
            width: 100%;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
            text-align: center;
            animation: fadeInUp 0.8s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .error-icon {
            width: 120px;
            height: 120px;
            margin: 0 auto 2rem;
            background: linear-gradient(135deg, #ff6b6b, #ff8e8e);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
        }

        .error-icon svg {
            width: 60px;
            height: 60px;
            color: white;
        }

        .error-code {
            font-size: 4rem;
            font-weight: 800;
            color: #667eea;
            margin-bottom: 1rem;
            line-height: 1;
        }

        .error-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 1rem;
        }

        .error-message {
            font-size: 1.2rem;
            color: var(--text-secondary);
            margin-bottom: 1rem;
            line-height: 1.6;
        }

        .error-description {
            font-size: 1rem;
            color: var(--text-muted);
            margin-bottom: 2.5rem;
            line-height: 1.5;
        }

        .error-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .error-button {
            padding: 0.8rem 2rem;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 1rem;
        }

        .error-button.primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .error-button.primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
        }

        .error-button.secondary {
            background: #f8f9fa;
            color: var(--text-primary);
            border: 2px solid #e9ecef;
        }

        .error-button.secondary:hover {
            background: #e9ecef;
            transform: translateY(-1px);
        }

        @media (max-width: 768px) {
            .error-container {
                padding: 2rem 1.5rem;
                margin: 1rem;
            }

            .error-code {
                font-size: 3rem;
            }

            .error-title {
                font-size: 1.5rem;
            }

            .error-message {
                font-size: 1.1rem;
            }

            .error-actions {
                flex-direction: column;
                align-items: center;
            }

            .error-button {
                width: 100%;
                max-width: 250px;
            }
        }
    </style>
</head>

<body>
    <%@ include file="header.jsp" %>

    <main class="error-page">
        <div class="error-container">
            <div class="error-icon">
                <%
                    Integer errorCode = (Integer) request.getAttribute("errorCode");
                    if (errorCode != null && errorCode == 404) {
                %>
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="11" cy="11" r="8"></circle>
                    <path d="M21 21l-4.35-4.35"></path>
                    <line x1="11" y1="8" x2="11" y2="14"></line>
                    <line x1="8" y1="11" x2="14" y2="11"></line>
                </svg>
                <%
                    } else {
                %>
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="12" cy="12" r="10"></circle>
                    <line x1="15" y1="9" x2="9" y2="15"></line>
                    <line x1="9" y1="9" x2="15" y2="15"></line>
                </svg>
                <%
                    }
                %>
            </div>

            <% if (errorCode != null) { %>
                <div class="error-code"><%= errorCode %></div>
            <% } %>

            <h1 class="error-title">
                <%= request.getAttribute("errorTitle") != null ? request.getAttribute("errorTitle") : "Errore" %>
            </h1>

            <p class="error-message">
                <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "Si è verificato un errore imprevisto." %>
            </p>

            <% if (request.getAttribute("errorDescription") != null) { %>
                <p class="error-description">
                    <%= request.getAttribute("errorDescription") %>
                </p>
            <% } %>

            <div class="error-actions">
                <a href="${pageContext.request.contextPath}/home" class="error-button primary">
                    🏠 Torna alla Homepage
                </a>
            </div>
        </div>
    </main>

    <%@ include file="footer.jsp" %>
</body>

</html>