package model;

import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.List;

public class Carrello {


    private final List<Prodotto> prodottiCarrello = new ArrayList<>();
    private double prezzoTotale;

    public List<Prodotto> getProdotti() {
        return prodottiCarrello;
    }

    public void updatePrezzoTotale() {
        this.prezzoTotale = 0;
        for (Prodotto prodotto : prodottiCarrello) {
            if (prodotto.getSconto() == 0)
                this.prezzoTotale += prodotto.getPrezzo() * prodotto.getQuantita();
            else {
                double prezzoScontato = prodotto.getPrezzo() - (prodotto.getPrezzo() / 100 * prodotto.getSconto());
                this.prezzoTotale += prezzoScontato * prodotto.getQuantita();
            }
        }

    }

    public double getPrezzoTotale() {
        return prezzoTotale;
    }

    public void setPrezzoTotale(double prezzoTotale) {
        this.prezzoTotale = prezzoTotale;
    }

    public void addProdotto(Prodotto prodottoNuovo) {
        for (Prodotto prodotto : prodottiCarrello) {
            if (prodotto.getID() == prodottoNuovo.getID()) {
                prodotto.setQuantita(prodotto.getQuantita() + prodottoNuovo.getQuantita());
                updatePrezzoTotale();
                return;
            }
        }
        prodottiCarrello.add(prodottoNuovo);
        updatePrezzoTotale();
    }

    public void removeProdotto(int ID) {
        prodottiCarrello.removeIf(prodotto -> prodotto.getID() == ID);
        updatePrezzoTotale();
    }

    public void setNumOrdered(int ID, int n) {
        for (Prodotto prodotto : prodottiCarrello) {
            if (prodotto.getID() == ID) {
                prodotto.setQuantita(n);
                updatePrezzoTotale();
                return;
            }
        }
    }

    public int getSizeCarrello() {
        int count = 0;

        for (Prodotto p : prodottiCarrello) {
            count += p.getQuantita();
        }
        return count;
    }

    public void checkout(Utente utenteLoggato){

        for (Prodotto prodotto : this.prodottiCarrello) {
            int quantitaDisponibile = ProdottoDAO.findProduct(prodotto.getID()).getQuantita();
            if (prodotto.getQuantita() <= quantitaDisponibile) {
                int nuovaQuantita = quantitaDisponibile - prodotto.getQuantita();
                ProdottoDAO.updateQuantitaDisponibile(prodotto, nuovaQuantita);
            }
        }

        double prezzoTotCarrello = this.getPrezzoTotale();
        double prezzoTot = prezzoTotCarrello + (prezzoTotCarrello * 0.22);   //aggiungo l'IVA al prezzo totale del carrello

        Ordine ordine = new Ordine();
        String scontrino = Utilities.prodottiToScontrino(this.getProdotti());
        ordine.setScontrino(scontrino);
        ordine.setUtente_ID(utenteLoggato.getID());


        utenteLoggato.setSaldo(utenteLoggato.getSaldo() - prezzoTot);
        UtenteDAO.updateSaldo(utenteLoggato, utenteLoggato.getSaldo());
        ordine.setPrezzo_tot(prezzoTot);
        ordine.setData(new GregorianCalendar());

        this.updateStatisticheProdotti();
        OrdineDAO.addOrdine(ordine);

    }

    public int checkoutErrors(Utente utenteLoggato) {

        for (Prodotto prodotto : this.prodottiCarrello) {
            int quantitaDisponibile = ProdottoDAO.findProduct(prodotto.getID()).getQuantita();
            if (prodotto.getQuantita() > quantitaDisponibile)
                return -1; //CASO ERRORE 1 (quantità non disponibile)
        }

        double prezzoTotCarrello = this.getPrezzoTotale();
        double prezzoTot = prezzoTotCarrello + (prezzoTotCarrello * 0.22);   //aggiungo l'IVA al prezzo totale del carrello

        if (utenteLoggato.getSaldo() < prezzoTot)
            return 1; //CASO ERRORE 2 (saldo non sufficiente)

        return 0; //Caso nessun errore
    }

    public void updateStatisticheProdotti() {

        for (Prodotto p : prodottiCarrello) {
            ProdottoDAO.updateAcquisti(p.getID());
        }

    }


}
