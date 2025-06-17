package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/errore")
public class ErrorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processError(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processError(request, response);
    }

    private void processError(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Recupera informazioni sull'errore dai request attributes
        Integer statusCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");

        // Se non ci sono informazioni di errore dai request attributes, 
        // potrebbe essere una chiamata diretta al servlet
        if (statusCode == null) {
            statusCode = response.getStatus();
            if (statusCode == 200) {
                statusCode = 500; // Default per errori generici
            }
        }
        
        // Prepara informazioni per la pagina di errore
        String errorTitle = getErrorTitle(statusCode);
        String errorMessage = getErrorMessage(statusCode);
        String errorDescription = getErrorDescription(statusCode);
        
        // Imposta gli attributi per la JSP
        request.setAttribute("errorCode", statusCode);
        request.setAttribute("errorTitle", errorTitle);
        request.setAttribute("errorMessage", errorMessage);
        request.setAttribute("errorDescription", errorDescription);
        
        // Imposta il status code corretto nella response
        response.setStatus(statusCode);
        
        // Forward alla pagina di errore
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/ErrorPage.jsp");
        dispatcher.forward(request, response);
    }
    
    private String getErrorTitle(int statusCode) {
        switch (statusCode) {
            case 400: return "Richiesta Non Valida";
            case 401: return "Non Autorizzato";
            case 403: return "Accesso Negato";
            case 404: return "Pagina Non Trovata";
            case 405: return "Metodo Non Consentito";
            case 500: return "Errore Interno del Server";
            case 502: return "Gateway Non Valido";
            case 503: return "Servizio Non Disponibile";
            default: return "Errore " + statusCode;
        }
    }
    
    private String getErrorMessage(int statusCode) {
        switch (statusCode) {
            case 400: return "La richiesta inviata non è valida o contiene errori.";
            case 401: return "È necessario effettuare l'accesso per visualizzare questa pagina.";
            case 403: return "Non hai i permessi necessari per accedere a questa risorsa.";
            case 404: return "La pagina che stai cercando non esiste o è stata spostata.";
            case 405: return "Il metodo HTTP utilizzato non è supportato per questa risorsa.";
            case 500: return "Si è verificato un errore interno. Il nostro team è stato notificato.";
            case 502: return "Il server ha ricevuto una risposta non valida.";
            case 503: return "Il servizio è temporaneamente non disponibile. Riprova più tardi.";
            default: return "Si è verificato un errore imprevisto.";
        }
    }
    
    private String getErrorDescription(int statusCode) {
        switch (statusCode) {
            case 400: return "Controlla che tutti i dati inseriti siano corretti e riprova.";
            case 401: return "Effettua il login o registrati per continuare.";
            case 403: return "Se pensi che questo sia un errore, contatta l'amministratore.";
            case 404: return "Controlla l'URL o torna alla homepage per navigare verso il contenuto desiderato.";
            case 405: return "Assicurati di utilizzare il metodo HTTP corretto per questa richiesta.";
            case 500: return "Stiamo lavorando per risolvere il problema. Riprova tra qualche minuto.";
            case 502: return "Il problema potrebbe essere temporaneo. Riprova tra qualche momento.";
            case 503: return "Il server è in manutenzione o sovraccarico. Riprova più tardi.";
            default: return "Se il problema persiste, contatta il supporto tecnico.";
        }
    }
}
