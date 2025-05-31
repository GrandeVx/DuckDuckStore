package model;

import java.sql.Date;
import java.util.GregorianCalendar;

public class Ordine {

    private int ordine_ID, utente_ID;
    private double prezzo_tot;
    private GregorianCalendar data;
    private String scontrino;
    
    // New fields for delivery and payment
    private IndirizzoConsegna indirizzoConsegna;
    private InfoPagamento infoPagamento;

    // Default constructor
    public Ordine() {
        this.indirizzoConsegna = new IndirizzoConsegna();
        this.infoPagamento = new InfoPagamento();
    }

    // Constructor with delivery and payment info
    public Ordine(int utente_ID, double prezzo_tot, String scontrino, 
                  IndirizzoConsegna indirizzoConsegna, InfoPagamento infoPagamento) {
        this();
        this.utente_ID = utente_ID;
        this.prezzo_tot = prezzo_tot;
        this.scontrino = scontrino;
        this.data = new GregorianCalendar();
        this.indirizzoConsegna = indirizzoConsegna;
        this.infoPagamento = infoPagamento;
    }

    public int getOrdine_ID() {
        return ordine_ID;
    }

    public void setOrdine_ID(int ordine_ID) {
        this.ordine_ID = ordine_ID;
    }

    public int getUtente_ID() {
        return utente_ID;
    }

    public void setUtente_ID(int utente_ID) {
        this.utente_ID = utente_ID;
    }

    public double getPrezzo_tot() {
        return prezzo_tot;
    }

    public void setPrezzo_tot(double prezzo_tot) {
        this.prezzo_tot = prezzo_tot;
    }

    public GregorianCalendar getData() {
        return data;
    }

    public void setData(GregorianCalendar data) {
        this.data = data;
    }

    public String getScontrino() {
        return scontrino;
    }

    public void setScontrino(String scontrino) {
        this.scontrino = scontrino;
    }

    // New getters and setters for delivery and payment
    public IndirizzoConsegna getIndirizzoConsegna() {
        return indirizzoConsegna;
    }

    public void setIndirizzoConsegna(IndirizzoConsegna indirizzoConsegna) {
        this.indirizzoConsegna = indirizzoConsegna;
    }

    public InfoPagamento getInfoPagamento() {
        return infoPagamento;
    }

    public void setInfoPagamento(InfoPagamento infoPagamento) {
        this.infoPagamento = infoPagamento;
    }

    // Validation method
    public boolean isValidForCheckout() {
        return indirizzoConsegna != null && indirizzoConsegna.isValid() &&
               infoPagamento != null && infoPagamento.isValid();
    }

    // Process the complete order
    public boolean processOrder() {
        if (!isValidForCheckout()) {
            return false;
        }
        
        // Process payment
        boolean paymentSuccess = infoPagamento.processPayment();
        
        if (paymentSuccess) {
            // Set order date to now
            this.data = new GregorianCalendar();
        }
        
        return paymentSuccess;
    }

    @Override
    public String toString() {
        return "Ordine{" +
               "ordine_ID=" + ordine_ID +
               ", utente_ID=" + utente_ID +
               ", prezzo_tot=" + prezzo_tot +
               ", data=" + data +
               ", scontrino='" + scontrino + '\'' +
               ", indirizzoConsegna=" + indirizzoConsegna +
               ", infoPagamento=" + infoPagamento +
               '}';
    }
}
