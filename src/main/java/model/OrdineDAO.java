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
                Ordine ordine = extractOrdineFromResultSet(rs);
                o.add(ordine);
            }
            return o;
        } catch (SQLException e) {
            throw new RuntimeException("Errore durante il recupero degli ordini.", e);
        }
    }

    public static void addOrdine(Ordine ordine) {
        String sql = "INSERT INTO ordini (prezzo_tot, data, scontrino, utente_ID, " +
                    "delivery_nome, delivery_cognome, delivery_via, delivery_citta, delivery_cap, " +
                    "delivery_telefono, delivery_note, payment_card_holder, payment_card_number, " +
                    "payment_card_expiry, payment_card_cvv, payment_method, payment_status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDouble(1, ordine.getPrezzo_tot());
            GregorianCalendar data = ordine.getData();
            ps.setDate(2, new java.sql.Date(data.getTimeInMillis()));
            ps.setString(3, ordine.getScontrino());
            ps.setInt(4, ordine.getUtente_ID());
            
            // Delivery address fields
            IndirizzoConsegna indirizzo = ordine.getIndirizzoConsegna();
            ps.setString(5, indirizzo.getNome());
            ps.setString(6, indirizzo.getCognome());
            ps.setString(7, indirizzo.getVia());
            ps.setString(8, indirizzo.getCitta());
            ps.setString(9, indirizzo.getCap());
            ps.setString(10, indirizzo.getTelefono());
            ps.setString(11, indirizzo.getNote());
            
            // Payment information fields (encrypted)
            InfoPagamento pagamento = ordine.getInfoPagamento();
            ps.setString(12, pagamento.getCardHolder());
            ps.setString(13, pagamento.getEncryptedCardNumber());
            ps.setString(14, pagamento.getEncryptedCardExpiry());
            ps.setString(15, pagamento.getEncryptedCardCvv());
            ps.setString(16, pagamento.getPaymentMethod());
            ps.setString(17, pagamento.getPaymentStatus());
            
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
        query.append(" ORDER BY data DESC");
        
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(query.toString());
            int idx = 1;
            if (utenteId != null) ps.setInt(idx++, utenteId);
            if (from != null) ps.setDate(idx++, from);
            if (to != null) ps.setDate(idx++, to);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Ordine ordine = extractOrdineFromResultSet(rs);
                ordini.add(ordine);
            }
            return ordini;
        } catch (SQLException e) {
            throw new RuntimeException("Errore durante il recupero degli ordini.", e);
        }
    }

    // Helper method to extract Ordine object from ResultSet
    private static Ordine extractOrdineFromResultSet(ResultSet rs) throws SQLException {
        Ordine ordine = new Ordine();
        ordine.setOrdine_ID(rs.getInt("ordine_ID"));
        ordine.setPrezzo_tot(rs.getDouble("prezzo_tot"));
        Date sqlDate = rs.getDate("data");
        GregorianCalendar calendar = new GregorianCalendar();
        calendar.setTime(sqlDate);
        ordine.setData(calendar);
        ordine.setScontrino(rs.getString("scontrino"));
        ordine.setUtente_ID(rs.getInt("utente_ID"));
        
        // Extract delivery address
        IndirizzoConsegna indirizzo = new IndirizzoConsegna();
        indirizzo.setNome(rs.getString("delivery_nome"));
        indirizzo.setCognome(rs.getString("delivery_cognome"));
        indirizzo.setVia(rs.getString("delivery_via"));
        indirizzo.setCitta(rs.getString("delivery_citta"));
        indirizzo.setCap(rs.getString("delivery_cap"));
        indirizzo.setTelefono(rs.getString("delivery_telefono"));
        indirizzo.setNote(rs.getString("delivery_note"));
        ordine.setIndirizzoConsegna(indirizzo);
        
        // Extract payment information (encrypted data)
        InfoPagamento pagamento = new InfoPagamento();
        pagamento.setCardHolder(rs.getString("payment_card_holder"));
        // Set encrypted data directly (bypass encryption in setter)
        pagamento = new InfoPagamento();
        pagamento.setCardHolder(rs.getString("payment_card_holder"));
        pagamento.setPaymentMethod(rs.getString("payment_method"));
        pagamento.setPaymentStatus(rs.getString("payment_status"));
        // Set encrypted fields directly
        setEncryptedFields(pagamento, 
                         rs.getString("payment_card_number"),
                         rs.getString("payment_card_expiry"),
                         rs.getString("payment_card_cvv"));
        ordine.setInfoPagamento(pagamento);
        
        return ordine;
    }

    // Helper method to set encrypted fields without re-encryption
    private static void setEncryptedFields(InfoPagamento pagamento, String encCardNumber, 
                                         String encCardExpiry, String encCardCvv) {
        try {
            // Use reflection to set encrypted fields directly
            java.lang.reflect.Field cardNumberField = InfoPagamento.class.getDeclaredField("cardNumber");
            java.lang.reflect.Field cardExpiryField = InfoPagamento.class.getDeclaredField("cardExpiry");
            java.lang.reflect.Field cardCvvField = InfoPagamento.class.getDeclaredField("cardCvv");
            
            cardNumberField.setAccessible(true);
            cardExpiryField.setAccessible(true);
            cardCvvField.setAccessible(true);
            
            cardNumberField.set(pagamento, encCardNumber);
            cardExpiryField.set(pagamento, encCardExpiry);
            cardCvvField.set(pagamento, encCardCvv);
        } catch (Exception e) {
            throw new RuntimeException("Error setting encrypted fields", e);
        }
    }

    // Get the last saved address for a user (for convenience)
    public static IndirizzoConsegna getLastDeliveryAddress(int utenteId) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "SELECT delivery_nome, delivery_cognome, delivery_via, delivery_citta, " +
                "delivery_cap, delivery_telefono, delivery_note FROM ordini " +
                "WHERE utente_ID = ? ORDER BY data DESC LIMIT 1");
            ps.setInt(1, utenteId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return new IndirizzoConsegna(
                    rs.getString("delivery_nome"),
                    rs.getString("delivery_cognome"),
                    rs.getString("delivery_via"),
                    rs.getString("delivery_citta"),
                    rs.getString("delivery_cap"),
                    rs.getString("delivery_telefono"),
                    rs.getString("delivery_note")
                );
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving last delivery address", e);
        }
    }
}
