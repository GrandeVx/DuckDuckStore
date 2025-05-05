package model;

import java.sql.Date;
import java.util.GregorianCalendar;

public class Ordine {

    private int ordine_ID, utente_ID;
    private double prezzo_tot;
    private GregorianCalendar data;
    private String scontrino;

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
}
