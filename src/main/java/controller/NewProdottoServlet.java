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


@WebServlet("/admin/new_product")
public class NewProdottoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //CREAZIONE NUOVO PRODOTTO
        String nome = request.getParameter("Nome");
        String descrizione = request.getParameter("Descrizione");
        int quantita = Integer.parseInt(request.getParameter("Quantita"));
        double prezzo = Double.parseDouble(request.getParameter("Prezzo"));
        int sconto = Integer.parseInt(request.getParameter("Sconto"));
        String categoria = request.getParameter("Categoria");
        String img = request.getParameter("Img");

        Prodotto p = new Prodotto();
        p.setNome(nome);
        p.setPrezzo(prezzo);
        p.setQuantita(quantita);
        p.setDescrizione(descrizione);
        p.setSconto(sconto);
        p.setCategoria(categoria);
        p.setImg(img);

        ProdottoDAO.addProdotto(p);

        // Redirect alla pagina dei prodotti dopo l'aggiunta
        response.sendRedirect(request.getContextPath() + "/admin?action=prodotti");


    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }


}
