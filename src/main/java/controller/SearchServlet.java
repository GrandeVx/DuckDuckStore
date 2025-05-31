package controller;

import java.io.IOException;
import java.util.ArrayList;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Prodotto;
import model.ProdottoDAO;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String category = request.getParameter("category");
        String query = request.getParameter("query");
        String sort = request.getParameter("sort");

        ArrayList<Prodotto> prodotti = null;

        if (category == null || category.isEmpty()) {

            if (query == null || query.isEmpty() || "null".equalsIgnoreCase(query)) {
                //RESTITUISCE TUTTI I PRODOTTI
                prodotti = ProdottoDAO.doRetrieveProdotto();
                request.setAttribute("query", "Tutti i prodotti");
            } else {
                //RICERCA PER QUERY
                if (query.equals("offerte")) {
                    //RESTITUISCE I PRODOTTI SCONTATI
                    prodotti = ProdottoDAO.doRetrieveProdottoScontato();
                    request.setAttribute("query", "Offerte");
                } else {
                    //QUERY STANDARD
                    prodotti = ProdottoDAO.doRetrieveBySearch(query);
                    request.setAttribute("query", query);
                }
            }
        } else {
            //RICERCA PER CATEGORIA
            prodotti = ProdottoDAO.doRetrieveByCategory(category);
            request.setAttribute("query", category);
        }

        // Applica l'ordinamento se richiesto
        if (prodotti != null && sort != null && !sort.isEmpty()) {
            prodotti = ProdottoDAO.sortProducts(prodotti, sort);
        }

        request.setAttribute("listaProdotti", prodotti);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/Ricerca_Prodotti.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

}
