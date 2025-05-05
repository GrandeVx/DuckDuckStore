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

        //cart.validazioneProdotti();   //Funzione per capire se i prodotti presenti nel carrello sono presenti nel db

        if (action == null || action.isEmpty()) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/Carrello.jsp");
            dispatcher.forward(request, response);
        } else {
            if (action.equals("checkout")) {

                HttpSession session = request.getSession();
                Utente utenteLoggato = (Utente) session.getAttribute("Utente");
                int erroreCheckout = cart.checkoutErrors(utenteLoggato);

                if (erroreCheckout==0) {
                    cart.checkout(utenteLoggato);
                    session.setAttribute("carrello", new Carrello());
                    response.sendRedirect("order_history");
                } else {
                    if(erroreCheckout<0){
                        request.setAttribute("errore", "Quantità prodotto non disponibile");
                    }
                    else{
                        request.setAttribute("errore", "Saldo insufficiente");
                    }
                    RequestDispatcher rs = request.getRequestDispatcher("/WEB-INF/results/Carrello.jsp");
                    rs.forward(request, response);
                }
            }

            if (action.equals("additem")) {
                //Dall'ID del prodotto prendo il prodotto e lo aggiungo al carrello
                int ID = Integer.parseInt(request.getParameter("ID"));
                Prodotto prodotto = ProdottoDAO.findProduct(ID);
                prodotto.setQuantita(Integer.parseInt(request.getParameter("quantita")));
                cart.addProdotto(prodotto);
                response.sendRedirect(request.getContextPath() + "/cart");
            }

            if (action.equals("removeitem")) {
                int ID = Integer.parseInt(request.getParameter("ID"));
                cart.removeProdotto(ID);
                response.sendRedirect(request.getContextPath() + "/cart");
            }

            if (action.equals("updateitem")) {

                //GESTISCE LA RICHIESTA AJAX DA CARRELLO.jsp
                int ID = Integer.parseInt(request.getParameter("ID"));
                int quantita = Integer.parseInt(request.getParameter("quantita"));
                cart.setNumOrdered(ID, quantita);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}