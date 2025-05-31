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
import model.Utilities;

import java.io.IOException;

@WebServlet("/update-profilo")
public class UpdateProfilo extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        Utente u = (Utente) session.getAttribute("Utente");
        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String action = request.getParameter("action");

        if ("newsaldo".equals(action)) {
            UtenteDAO.updateSaldo(u, 1000);
            u.setSaldo(1000.0);
        } else {
            String nome = request.getParameter("firstName");
            String cognome = request.getParameter("lastName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (nome != null && !nome.isEmpty()) u.setNome(nome);
            if (cognome != null && !cognome.isEmpty()) u.setCognome(cognome);
            if (email != null && !email.isEmpty()) u.setEmail(email);
            if (password != null && !password.isEmpty())
                u.setPassword(Utilities.toHash(password));

            UtenteDAO.updateUser(u);
        }

        response.sendRedirect(request.getContextPath() + "/home");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

