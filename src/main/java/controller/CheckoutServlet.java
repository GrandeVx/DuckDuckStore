package controller;

import java.io.IOException;
import java.util.ArrayList;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String step = request.getParameter("step");
        HttpSession session = request.getSession();
        
        // Check if user is logged in
        Utente utenteLoggato = (Utente) session.getAttribute("Utente");
        if (utenteLoggato == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Check if cart has items
        Carrello cart = (Carrello) session.getAttribute("carrello");
        if (cart == null || cart.getProdotti().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/carrello");
            return;
        }

        // Handle different steps
        if ("back".equals(step)) {
            // Clear checkout session data and go back to address
            session.removeAttribute("checkoutAddress");
            session.removeAttribute("checkoutPayment");
            session.removeAttribute("indirizzoRiepilogo");
            handleAddressStep(request, response);
            return;
        }

        // Default: start with address step
        handleAddressStep(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String step = request.getParameter("step");
        
        if ("address".equals(step)) {
            handleAddressSubmission(request, response);
        } else if ("payment".equals(step)) {
            handlePaymentSubmission(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/checkout");
        }
    }

    private void handleAddressStep(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Utente utenteLoggato = (Utente) session.getAttribute("Utente");
        
        // Try to get last delivery address for convenience
        IndirizzoConsegna lastAddress = OrdineDAO.getLastDeliveryAddress(utenteLoggato.getID());
        // Only show last address if it has valid data
        if (lastAddress != null && lastAddress.hasValidData()) {
            request.setAttribute("lastAddress", lastAddress);
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/CheckoutAddress.jsp");
        dispatcher.forward(request, response);
    }

    private void handleAddressSubmission(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("DEBUG: handleAddressSubmission called");
        HttpSession session = request.getSession();
        
        // Debug: Print all request parameters
        System.out.println("DEBUG: Request parameters:");
        request.getParameterMap().forEach((key, values) -> {
            System.out.println("  " + key + " = " + String.join(", ", values));
        });
        
        // Check if using saved address
        boolean useSavedAddress = "true".equals(request.getParameter("useSavedAddress"));
        System.out.println("DEBUG: useSavedAddress = " + useSavedAddress);
        
        IndirizzoConsegna indirizzo;
        
        if (useSavedAddress) {
            System.out.println("DEBUG: Using saved address");
            // Use the last saved address
            Utente utenteLoggato = (Utente) session.getAttribute("Utente");
            indirizzo = OrdineDAO.getLastDeliveryAddress(utenteLoggato.getID());
            System.out.println("DEBUG: Retrieved saved address: " + indirizzo);
            
            if (indirizzo == null) {
                System.out.println("DEBUG: No saved address found, using form data");
                // Fallback to form data if no saved address found
                indirizzo = extractAddressFromRequest(request);
            }
        } else {
            System.out.println("DEBUG: Using form data");
            // Use form data
            indirizzo = extractAddressFromRequest(request);
        }

        System.out.println("DEBUG: Final address object: " + indirizzo);
        System.out.println("DEBUG: Address valid: " + indirizzo.isValid());
        System.out.println("DEBUG: Phone valid: " + indirizzo.isValidTelefono());

        // Validate address
        if (!indirizzo.isValid() || !indirizzo.isValidTelefono()) {
            System.out.println("DEBUG: Address validation failed, returning to address page");
            request.setAttribute("errore", "Dati indirizzo non validi");
            handleAddressStep(request, response);
            return;
        }

        System.out.println("DEBUG: Address validation passed, proceeding to payment");

        // Store address in session and continue to payment
        session.setAttribute("checkoutAddress", indirizzo);
        
        // Store cart total for payment page
        Carrello cart = (Carrello) session.getAttribute("carrello");
        session.setAttribute("totaleCarrello", cart.getPrezzoTotale());
        session.setAttribute("indirizzoRiepilogo", indirizzo.getIndirizzoCompleto());
        
        System.out.println("DEBUG: Forwarding to payment page");
        
        // Redirect to payment step
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/CheckoutPayment.jsp");
        dispatcher.forward(request, response);
    }

    private void handlePaymentSubmission(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("DEBUG: handlePaymentSubmission called");
        HttpSession session = request.getSession();
        
        // Debug: Print all request parameters
        System.out.println("DEBUG: Payment request parameters:");
        request.getParameterMap().forEach((key, values) -> {
            if (key.equals("cardNumber") || key.equals("cardCvv")) {
                System.out.println("  " + key + " = [MASKED]");
            } else {
                System.out.println("  " + key + " = " + String.join(", ", values));
            }
        });
        
        // Get address from session
        IndirizzoConsegna indirizzo = (IndirizzoConsegna) session.getAttribute("checkoutAddress");
        System.out.println("DEBUG: Retrieved address from session: " + (indirizzo != null ? "found" : "null"));
        if (indirizzo == null) {
            System.out.println("DEBUG: No address in session, redirecting to checkout");
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }

        // Extract payment info from request
        System.out.println("DEBUG: Extracting payment info from request");
        InfoPagamento pagamento = extractPaymentFromRequest(request);
        System.out.println("DEBUG: Payment object created: " + (pagamento != null ? "success" : "null"));

        // Validate payment information
        System.out.println("DEBUG: Validating payment information");
        boolean paymentValid = pagamento.isValid();
        System.out.println("DEBUG: Payment valid: " + paymentValid);
        
        if (!paymentValid) {
            System.out.println("DEBUG: Payment validation failed, returning to payment page");
            request.setAttribute("errore", "Dati pagamento non validi");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/CheckoutPayment.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Process payment
        System.out.println("DEBUG: Processing payment");
        boolean paymentSuccess = pagamento.processPayment();
        System.out.println("DEBUG: Payment processing result: " + paymentSuccess);
        
        if (!paymentSuccess) {
            System.out.println("DEBUG: Payment processing failed, returning to payment page");
            request.setAttribute("errore", "Pagamento rifiutato. Verifica i dati della carta.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/CheckoutPayment.jsp");
            dispatcher.forward(request, response);
            return;
        }

        System.out.println("DEBUG: Payment successful, completing order");
        // Payment successful - complete the order
        completeOrder(request, response, indirizzo, pagamento);
    }

    private void completeOrder(HttpServletRequest request, HttpServletResponse response, 
                              IndirizzoConsegna indirizzo, InfoPagamento pagamento) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Utente utenteLoggato = (Utente) session.getAttribute("Utente");
        Carrello cart = (Carrello) session.getAttribute("carrello");

        try {
            // Check for cart errors (stock, balance)
            int erroreCheckout = cart.checkoutErrors(utenteLoggato);
            if (erroreCheckout != 0) {
                String erroreMsg = erroreCheckout < 0 ? 
                    "Quantità prodotto non disponibile" : "Saldo insufficiente";
                request.setAttribute("errore", erroreMsg);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/CheckoutPayment.jsp");
                dispatcher.forward(request, response);
                return;
            }

            // Complete the checkout process with address and payment info
            cart.checkout(utenteLoggato, indirizzo, pagamento);

            // Clear cart and checkout session data
            session.setAttribute("carrello", new Carrello());
            session.removeAttribute("checkoutAddress");
            session.removeAttribute("checkoutPayment");
            session.removeAttribute("totaleCarrello");
            session.removeAttribute("indirizzoRiepilogo");

            // Redirect to order history
            response.sendRedirect(request.getContextPath() + "/order_history");

        } catch (Exception e) {
            request.setAttribute("errore", "Errore durante l'elaborazione dell'ordine: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/CheckoutPayment.jsp");
            dispatcher.forward(request, response);
        }
    }

    private IndirizzoConsegna extractAddressFromRequest(HttpServletRequest request) {
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String via = request.getParameter("via");
        String citta = request.getParameter("citta");
        String cap = request.getParameter("cap");
        String telefono = request.getParameter("telefono");
        String note = request.getParameter("note");

        return new IndirizzoConsegna(nome, cognome, via, citta, cap, telefono, note);
    }

    private InfoPagamento extractPaymentFromRequest(HttpServletRequest request) {
        String cardHolder = request.getParameter("cardHolder");
        String cardNumber = request.getParameter("cardNumber").replace(" ", ""); // Remove spaces
        String cardExpiry = request.getParameter("cardExpiry");
        String cardCvv = request.getParameter("cardCvv");

        return new InfoPagamento(cardHolder, cardNumber, cardExpiry, cardCvv);
    }
} 