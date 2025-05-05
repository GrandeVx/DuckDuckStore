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

        HttpSession session = request.getSession();
        Utente u = (Utente) session.getAttribute("Utente");
        String action = request.getParameter("action");

        if (action != null && action.equals("newsaldo")) {
            UtenteDAO.updateSaldo(u, 1000);
            u.setSaldo(1000.0);
        } else {

            u.setNome(request.getParameter("firstName"));
            u.setCognome(request.getParameter("lastName"));
            u.setEmail(request.getParameter("email"));
            if (request.getParameter("password") != null && !request.getParameter("password").isEmpty())
                u.setPassword(Utilities.toHash(request.getParameter("password")));

            UtenteDAO.updateUser(u);
        }


        response.sendRedirect(request.getContextPath());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

