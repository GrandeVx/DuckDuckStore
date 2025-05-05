package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Prodotto;
import model.ProdottoDAO;

import java.io.IOException;
import java.security.ProtectionDomain;

@WebServlet("/admin/product-management")
public class GestioneProdottoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.isEmpty() || action.equals("add")) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/admin/CreaProdotto.jsp");
            dispatcher.forward(request, response);
        }

        if (action.equals("modify")) {
            int ID = Integer.parseInt(request.getParameter("ID"));
            Prodotto p = ProdottoDAO.findProduct(ID);
            request.setAttribute("prodotto", p);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/admin/ModificaProdotto.jsp");
            dispatcher.forward(request, response);
        }

        if (action.equals("delete")) {
            //CANCELLA PRODOTTO
            int ID = Integer.parseInt(request.getParameter("ID"));
            ProdottoDAO.deleteProdotto(ID);
            response.sendRedirect(request.getContextPath() + "/admin?action=prodotti");
        }


    }


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
