package controller;

import com.google.gson.Gson;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Prodotto;
import model.Utente;
import model.UtenteDAO;
import model.ProdottoDAO;
import model.Ordine;
import model.OrdineDAO;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/admin")
public class ListaAdminServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/results/HomePage.jsp");
            dispatcher.forward(request, response);
            return;
        }
        switch (action) {
            case "prodotti":
                if (request.getParameter("query") == null) {
                    // LISTA PRODOTTI GENERALE
                    ArrayList<Prodotto> listaProdotti = ProdottoDAO.doRetrieveProdotto();
                    request.setAttribute("listaProdotti", listaProdotti);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/admin/ListaProdotti.jsp");
                    dispatcher.forward(request, response);
                } else {
                    // LISTA PRODOTTI FILTRATA (AJAX)
                    String query = request.getParameter("query");
                    ArrayList<Prodotto> listaProdotti = ProdottoDAO.doRetrieveBySearch(query);
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    String json = new Gson().toJson(listaProdotti);
                    response.getWriter().write(json);
                }
                break;
            case "utenti":
                if (request.getParameter("ID") == null) {
                    // LISTA UTENTI
                    ArrayList<Utente> listaUtenti = UtenteDAO.doRetrieveUtente();
                    request.setAttribute("listaUtenti", listaUtenti);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/admin/ListaUtenti.jsp");
                    dispatcher.forward(request, response);
                } else {
                    // AJAX AGGIORNAMENTO STATUS
                    try {
                        int ID = Integer.parseInt(request.getParameter("ID"));
                        boolean status = Boolean.parseBoolean(request.getParameter("status"));
                        UtenteDAO.setNewStatus(ID, status);
                    } catch (NumberFormatException ignored) {}
                }
                break;
            case "ordini": {
                // Recupera parametri filtro
                String idUtenteStr = request.getParameter("utente_ID");
                String fromStr = request.getParameter("from");
                String toStr = request.getParameter("to");
                Integer idUtente = (idUtenteStr != null && !idUtenteStr.isEmpty()) ? Integer.parseInt(idUtenteStr) : null;
                java.sql.Date from = (fromStr != null && !fromStr.isEmpty()) ? java.sql.Date.valueOf(fromStr) : null;
                java.sql.Date to = (toStr != null && !toStr.isEmpty()) ? java.sql.Date.valueOf(toStr) : null;
                ArrayList<Ordine> listaOrdini = OrdineDAO.doRetrieveOrdini(idUtente, from, to);
                ArrayList<Utente> listaUtenti = UtenteDAO.doRetrieveUtente();
                request.setAttribute("listaOrdini", listaOrdini);
                request.setAttribute("listaUtenti", listaUtenti);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/admin/ListaOrdini.jsp");
                dispatcher.forward(request, response);
                break;
            }
            default:
                response.sendRedirect(request.getContextPath());
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}