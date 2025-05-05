package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Prodotto;
import model.ProdottoDAO;

import java.io.IOException;

@WebServlet("/admin/mod_product")
public class ModificaProdottoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int ID = Integer.parseInt(request.getParameter("ID"));
        String nome = request.getParameter("Nome");
        String descrizione = request.getParameter("Descrizione");
        int quantita = Integer.parseInt(request.getParameter("Quantita"));
        double prezzo = Double.parseDouble(request.getParameter("Prezzo"));
        int sconto = Integer.parseInt(request.getParameter("Sconto"));
        String categoria = request.getParameter("Categoria");
        String img = request.getParameter("Img");

        Prodotto p = new Prodotto();
        p.setID(ID);
        p.setNome(nome);
        p.setPrezzo(prezzo);
        p.setQuantita(quantita);
        p.setDescrizione(descrizione);
        p.setSconto(sconto);
        p.setCategoria(categoria);
        p.setImg(img);

        ProdottoDAO.modifyProdotto(p);

        // Redirect alla pagina dei prodotti dopo l'aggiunta
        response.sendRedirect(request.getContextPath() + "/admin?action=prodotti");

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }


}
