package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.*;

import java.io.IOException;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        Carrello cart = (Carrello) request.getSession().getAttribute("carrello");
        if (cart == null) {
            cart = new Carrello();
            request.getSession().setAttribute("carrello", cart);
        }

        if (action == null || action.isEmpty()) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/Carrello.jsp");
            dispatcher.forward(request, response);
            return;
        }

        switch (action) {
            case "checkout": {
                HttpSession session = request.getSession();
                Utente utenteLoggato = (Utente) session.getAttribute("Utente");
                if (utenteLoggato == null) {
                    response.sendRedirect(request.getContextPath() + "/login");
                    return;
                }
                int erroreCheckout = cart.checkoutErrors(utenteLoggato);
                if (erroreCheckout == 0) {
                    cart.checkout(utenteLoggato);
                    session.setAttribute("carrello", new Carrello());
                    response.sendRedirect("order_history");
                } else {
                    if (erroreCheckout < 0) {
                        request.setAttribute("errore", "Quantità prodotto non disponibile");
                    } else {
                        request.setAttribute("errore", "Saldo insufficiente");
                    }
                    RequestDispatcher rs = request.getRequestDispatcher("/WEB-INF/results/Carrello.jsp");
                    rs.forward(request, response);
                }
                break;
            }
            case "additem": {
                try {
                    int ID = Integer.parseInt(request.getParameter("ID"));
                    int quantita = Integer.parseInt(request.getParameter("quantita"));
                    Prodotto prodotto = ProdottoDAO.findProduct(ID);
                    if (prodotto != null) {
                        prodotto.setQuantita(quantita);
                        cart.addProdotto(prodotto);
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("errore", "Parametro non valido");
                }
                response.sendRedirect(request.getContextPath() + "/cart");
                break;
            }
            case "removeitem": {
                try {
                    int ID = Integer.parseInt(request.getParameter("ID"));
                    cart.removeProdotto(ID);
                } catch (NumberFormatException e) {
                    request.setAttribute("errore", "Parametro non valido");
                }
                response.sendRedirect(request.getContextPath() + "/cart");
                break;
            }
            case "updateitem": {
                try {
                    int ID = Integer.parseInt(request.getParameter("ID"));
                    int quantita = Integer.parseInt(request.getParameter("quantita"));
                    cart.setNumOrdered(ID, quantita);
                } catch (NumberFormatException ignored) {}
                break;
            }
            default:
                response.sendRedirect(request.getContextPath() + "/cart");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}