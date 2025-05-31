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

@WebServlet("/product")
public class VisualizzaProdottoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int ID = Integer.parseInt(request.getParameter("ID"));
            Prodotto p = ProdottoDAO.findProduct(ID);
            if (p == null) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            request.setAttribute("prodotto", p);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/Product.jsp");
            dispatcher.forward(request, response);
        } catch (NumberFormatException | NullPointerException e) {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
