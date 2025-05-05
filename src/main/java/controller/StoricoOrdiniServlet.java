package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Ordine;
import model.OrdineDAO;
import model.Utente;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/order_history")
public class StoricoOrdiniServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente utenteAttuale = (Utente) session.getAttribute("Utente");
        if (utenteAttuale != null) {
            ArrayList<Ordine> ordini = OrdineDAO.doRetriveOrdine(utenteAttuale.getID());
            request.setAttribute("listaOrdini", ordini);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/StoricoOrdini.jsp");
            dispatcher.forward(request, response);
        } else
            response.sendRedirect(request.getContextPath());

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
