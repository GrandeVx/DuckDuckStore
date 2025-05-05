package model;

import jakarta.servlet.annotation.WebServlet;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet(name = "ProdottoDAO", value = "/ProdottoDAO")
public class ProdottoDAO {

    public static ArrayList<Prodotto> doRetriveProdotto() {
        ArrayList<Prodotto> p = new ArrayList<Prodotto>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotto");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Prodotto prodotto = new Prodotto();
                prodotto.setID(rs.getInt(1));
                prodotto.setNome(rs.getString(2));
                prodotto.setDescrizione(rs.getString(3));
                prodotto.setPrezzo(rs.getDouble(4));
                prodotto.setQuantita(rs.getInt(5));
                prodotto.setSconto(rs.getInt(6));
                prodotto.setCategoria(rs.getString(7));
                prodotto.setImg(rs.getString(8));
                p.add(prodotto);
            }
            return p;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static ArrayList<Prodotto> doRetriveProdottoScontato() {
        ArrayList<Prodotto> p = new ArrayList<Prodotto>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotto WHERE sconto != 0 ORDER BY sconto desc");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Prodotto prodotto = new Prodotto();
                prodotto.setID(rs.getInt(1));
                prodotto.setNome(rs.getString(2));
                prodotto.setDescrizione(rs.getString(3));
                prodotto.setPrezzo(rs.getDouble(4));
                prodotto.setQuantita(rs.getInt(5));
                prodotto.setSconto(rs.getInt(6));
                prodotto.setCategoria(rs.getString(7));
                prodotto.setImg(rs.getString(8));
                p.add(prodotto);
            }
            return p;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public static ArrayList<Prodotto> doRetrieveByCategory(String category) {

        ArrayList<Prodotto> p = new ArrayList<Prodotto>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotto WHERE categoria = ?");
            ps.setString(1, category);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Prodotto prodotto = new Prodotto();
                prodotto.setID(rs.getInt(1));
                prodotto.setNome(rs.getString(2));
                prodotto.setDescrizione(rs.getString(3));
                prodotto.setPrezzo(rs.getDouble(4));
                prodotto.setQuantita(rs.getInt(5));
                prodotto.setSconto(rs.getInt(6));
                prodotto.setCategoria(rs.getString(7));
                prodotto.setImg(rs.getString(8));
                p.add(prodotto);
            }
            return p;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public static ArrayList<Prodotto> doRetrieveBySearch(String search) {

        ArrayList<Prodotto> p = new ArrayList<Prodotto>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotto WHERE nome LIKE ? OR descrizione LIKE ?");
            search = "%" + search + "%"; // Aggiungi i caratteri jolly
            ps.setString(1, search);
            ps.setString(2, search);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Prodotto prodotto = new Prodotto();
                prodotto.setID(rs.getInt(1));
                prodotto.setNome(rs.getString(2));
                prodotto.setDescrizione(rs.getString(3));
                prodotto.setPrezzo(rs.getDouble(4));
                prodotto.setQuantita(rs.getInt(5));
                prodotto.setSconto(rs.getInt(6));
                prodotto.setCategoria(rs.getString(7));
                prodotto.setImg(rs.getString(8));
                p.add(prodotto);
            }
            return p;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public static ArrayList<Prodotto> doRetrieveOrderByAcquisti() {

        ArrayList<Prodotto> p = new ArrayList<Prodotto>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotto ORDER BY numero_acquisti desc");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Prodotto prodotto = new Prodotto();
                prodotto.setID(rs.getInt(1));
                prodotto.setNome(rs.getString(2));
                prodotto.setDescrizione(rs.getString(3));
                prodotto.setPrezzo(rs.getDouble(4));
                prodotto.setQuantita(rs.getInt(5));
                prodotto.setSconto(rs.getInt(6));
                prodotto.setCategoria(rs.getString(7));
                prodotto.setImg(rs.getString(8));
                p.add(prodotto);
            }
            return p;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }


    public static Prodotto findProduct(int ID) {

        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotto WHERE prodotto_ID = ?");
            ps.setString(1, String.valueOf(ID));

            ResultSet rs = ps.executeQuery();

            Prodotto prodotto = new Prodotto();
            while (rs.next()) {
                prodotto.setID(rs.getInt(1));
                prodotto.setNome(rs.getString(2));
                prodotto.setDescrizione(rs.getString(3));
                prodotto.setPrezzo(rs.getDouble(4));
                prodotto.setQuantita(rs.getInt(5));
                prodotto.setSconto(rs.getInt(6));
                prodotto.setCategoria(rs.getString(7));
                prodotto.setImg(rs.getString(8));
            }
            return prodotto;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public static void addProdotto(Prodotto prodotto) {

        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO prodotto (nome, descrizione, prezzo, quantita, sconto, categoria, img) VALUES (?, ?, ?, ?, ?, ?, ?)");
            ps.setString(1, prodotto.getNome());
            ps.setString(2, prodotto.getDescrizione());
            ps.setDouble(3, prodotto.getPrezzo());
            ps.setInt(4, prodotto.getQuantita());
            ps.setInt(5, prodotto.getSconto());
            ps.setString(6, prodotto.getCategoria());
            ps.setString(7, prodotto.getImg());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public static void deleteProdotto(int prodotto_ID) {

        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM prodotto WHERE prodotto_ID = ?");
            ps.setInt(1, prodotto_ID);
            int rowsDeleted = ps.executeUpdate();

            if (rowsDeleted == 0) {
                throw new RuntimeException("Failed to delete product with ID: " + prodotto_ID + ". Product not found.");
            }

            //con.commit(); // Nel caso in cui non è impostato l'autocommit

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public static void modifyProdotto(Prodotto prodotto) {

        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("UPDATE prodotto SET nome = ?, descrizione = ?, prezzo = ?, quantita = ?, sconto = ?, categoria =?, img = ? WHERE prodotto_ID = ?");
            ps.setString(1, prodotto.getNome());
            ps.setString(2, prodotto.getDescrizione());
            ps.setDouble(3, prodotto.getPrezzo());
            ps.setInt(4, prodotto.getQuantita());
            ps.setInt(5, prodotto.getSconto());
            ps.setString(6, prodotto.getCategoria());
            ps.setString(7, prodotto.getImg());
            ps.setInt(8, prodotto.getID());
            int rows = ps.executeUpdate();

            if (rows == 0) {
                throw new RuntimeException("Failed to update product with ID: " + prodotto.getID() + ". Product not found.");
            }

            //con.commit(); // Nel caso in cui non è impostato l'autocommit

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public static void updateQuantitaDisponibile(Prodotto p, int nuovaQuantita) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("UPDATE prodotto SET quantita = ? WHERE prodotto_ID = ?");
            ps.setInt(1, nuovaQuantita);
            ps.setInt(2, p.getID());
            int rows = ps.executeUpdate();

            if (rows == 0) {
                throw new RuntimeException("Impossibile aggiornare la quantità");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static void updateAcquisti(int ID) {

        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("UPDATE prodotto SET numero_acquisti = numero_acquisti+1 WHERE prodotto_ID = ?");
            ps.setInt(1, ID);
            int rows = ps.executeUpdate();

            if (rows == 0) {
                throw new RuntimeException("Failed to update product with ID: " + ID + ". Product not found.");
            }

            //con.commit(); // Nel caso in cui non è impostato l'autocommit

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

}
