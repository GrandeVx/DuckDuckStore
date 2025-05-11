package model;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

public class OrdineDAO {

    public static ArrayList<Ordine> doRetrieveOrdine(int ID_utente) {
        ArrayList<Ordine> o = new ArrayList<>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM ordini WHERE utente_ID = ?");
            ps.setInt(1, ID_utente);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Ordine ordine = new Ordine();
                ordine.setOrdine_ID(rs.getInt(1));
                ordine.setPrezzo_tot(rs.getDouble(2));
                Date sqlDate = rs.getDate(3);
                GregorianCalendar calendar = new GregorianCalendar();
                calendar.setTime(sqlDate);
                ordine.setData(calendar);
                ordine.setScontrino(rs.getString(4));
                ordine.setUtente_ID(rs.getInt(5));
                o.add(ordine);
            }
            return o;
        } catch (SQLException e) {
            throw new RuntimeException("Errore durante il recupero degli ordini.", e);
        }
    }

    public static void addOrdine(Ordine ordine) {

        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO ordini (prezzo_tot, data, scontrino, utente_ID) VALUES (?, ?, ?, ?)");
            ps.setDouble(1, ordine.getPrezzo_tot());
            GregorianCalendar data = ordine.getData();
            ps.setDate(2, new java.sql.Date(data.getTimeInMillis()));
            ps.setString(3, ordine.getScontrino());
            ps.setInt(4, ordine.getUtente_ID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public static ArrayList<Ordine> doRetrieveOrdini(Integer utenteId, java.sql.Date from, java.sql.Date to) {
        ArrayList<Ordine> ordini = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM ordini WHERE 1=1");
        if (utenteId != null) query.append(" AND utente_ID = ?");
        if (from != null) query.append(" AND data >= ?");
        if (to != null) query.append(" AND data <= ?");
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(query.toString());
            int idx = 1;
            if (utenteId != null) ps.setInt(idx++, utenteId);
            if (from != null) ps.setDate(idx++, from);
            if (to != null) ps.setDate(idx++, to);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Ordine ordine = new Ordine();
                ordine.setOrdine_ID(rs.getInt(1));
                ordine.setPrezzo_tot(rs.getDouble(2));
                java.util.Date sqlDate = rs.getDate(3);
                java.util.GregorianCalendar calendar = new java.util.GregorianCalendar();
                calendar.setTime(sqlDate);
                ordine.setData(calendar);
                ordine.setScontrino(rs.getString(4));
                ordine.setUtente_ID(rs.getInt(5));
                ordini.add(ordine);
            }
            return ordini;
        } catch (SQLException e) {
            throw new RuntimeException("Errore durante il recupero degli ordini.", e);
        }
    }

}
