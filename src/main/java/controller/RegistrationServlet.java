package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Utente;
import model.UtenteDAO;

import java.io.IOException;
@WebServlet("/registration")
public class RegistrationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nome = request.getParameter("Nome");
        String cognome = request.getParameter("Cognome");
        String email = request.getParameter("Email");
        String password = request.getParameter("Password");

        // Verifica se i parametri richiesti sono nulli o vuoti
        if (nome == null || nome.isEmpty() ||
                cognome == null || cognome.isEmpty() ||
                email == null || email.isEmpty() ||
                password == null || password.isEmpty()) {
            request.setAttribute("controllo", "Non ci possono essere campi vuoti.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/Registration.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Crea un nuovo oggetto Utente
        Utente u = new Utente();
        u.setNome(nome);
        u.setCognome(cognome);
        u.setSaldo(1000.00); // Imposta un saldo iniziale
        u.setEmail(email);
        u.setPassword(password);
        u.setAmministratore(false);

        // Verifica se l'email è già presente nel database
        if (!UtenteDAO.isNewEmail(u.getEmail())) {
            request.setAttribute("errore", "Email già presente.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/Registration.jsp");
            dispatcher.forward(request, response);
        } else {
            UtenteDAO.doRegistration(u);
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
