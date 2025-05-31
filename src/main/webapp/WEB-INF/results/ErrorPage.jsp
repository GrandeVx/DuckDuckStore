<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="it">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DuckDuckStore | Error</title>
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
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                color: #333;
                text-align: center;
                margin: 0;
                padding: 0;
            }

            .container {
                margin: 8em auto;
                padding: 1.4em;
                background-color: #fff;
                border: 0.1em solid #ccc;
                border-radius: 0.3em;
                box-shadow: 0 0 0.6em rgba(0, 0, 0, 0.1);
            }

            h1 {
                font-size: 2em;
                margin-bottom: 1.5em;
            }

            p {
                font-size: 1.2em;
                line-height: 1.6em;
            }

            @media screen and (max-width: 980px) {
                .container {
                    margin: 6em auto;
                    padding: 1em;
                }

                h1 {
                    font-size: 1.8em;
                    margin-bottom: 1em;
                }

                p {
                    font-size: 1.1em;
                }
            }

            @media screen and (max-width: 750px) {
                .container {
                    margin: 4em auto;
                    padding: 0.8em;
                }

                h1 {
                    font-size: 1.5em;
                    margin-bottom: 0.8em;
                }

                p {
                    font-size: 1em;
                }
            }

            @media screen and (max-width: 540px) {
                .container {
                    margin: 3em auto;
                    padding: 0.6em;
                }

                h1 {
                    font-size: 1.2em;
                    margin-bottom: 0.6em;
                }

                p {
                    font-size: 0.9em;
                }
            }

            .error-container {
                max-width: 600px;
                margin: 100px auto;
                text-align: center;
                padding: 2rem;
                background-color: var(--color-white);
                border-radius: var(--radius-lg);
                box-shadow: var(--shadow-md);
            }

            .error-title {
                color: var(--color-primary);
                margin-bottom: 1rem;
            }

            .error-message {
                margin-bottom: 2rem;
                color: var(--color-gray-500);
            }

            .error-image {
                max-width: 200px;
                margin: 2rem auto;
            }
        </style>
    </head>

    <body>
        <%@ include file="header.jsp" %>
            <div class="container">
                <h1>Oops! Si e' verificato un errore.</h1>
                <p>La pagina che stavi cercando di raggiungere non e' disponibile al momento.</p>
                <p>Per favore, prova più tardi o ritorna alla <a href="/">pagina iniziale</a>.</p>
            </div>
    </body>

    </html>