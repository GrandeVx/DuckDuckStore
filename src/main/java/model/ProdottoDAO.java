package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ProdottoDAO {

    public static ArrayList<Prodotto> doRetrieveProdotto() {
        ArrayList<Prodotto> p = new ArrayList<Prodotto>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotti");
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

    public static ArrayList<Prodotto> doRetrieveProdottoScontato() {
        ArrayList<Prodotto> p = new ArrayList<Prodotto>();
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotti WHERE sconto != 0 ORDER BY sconto DESC");
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
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotti WHERE categoria = ?");
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
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotti WHERE nome LIKE ? OR descrizione LIKE ?");
            search = "%" + search + "%";
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
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotti ORDER BY numero_acquisti DESC");
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
            PreparedStatement ps = con.prepareStatement("SELECT * FROM prodotti WHERE prodotto_ID = ?");
            ps.setInt(1, ID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Prodotto prodotto = new Prodotto();
                prodotto.setID(rs.getInt(1));
                prodotto.setNome(rs.getString(2));
                prodotto.setDescrizione(rs.getString(3));
                prodotto.setPrezzo(rs.getDouble(4));
                prodotto.setQuantita(rs.getInt(5));
                prodotto.setSconto(rs.getInt(6));
                prodotto.setCategoria(rs.getString(7));
                prodotto.setImg(rs.getString(8));
                return prodotto;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException("Errore durante la ricerca del prodotto con ID: " + ID, e);
        }
    }

    public static void addProdotto(Prodotto prodotto) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO prodotti (nome, descrizione, prezzo, quantita, sconto, categoria, img) VALUES (?, ?, ?, ?, ?, ?, ?)");
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
            PreparedStatement ps = con.prepareStatement("DELETE FROM prodotti WHERE prodotto_ID = ?");
            ps.setInt(1, prodotto_ID);
            int righeRimosse = ps.executeUpdate();

            if (righeRimosse == 0) {
                throw new RuntimeException("Errore nella rimozione del prodotto con ID: " + prodotto_ID + ". Prodotto non trovato.");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public static void modifyProdotto(Prodotto prodotto) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("UPDATE prodotti SET nome = ?, descrizione = ?, prezzo = ?, quantita = ?, sconto = ?, categoria =?, img = ? WHERE prodotto_ID = ?");
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
                throw new RuntimeException("Errore nella modifica del prodotto con ID: " + prodotto.getID() + ". Prodotto non trovato.");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public static void updateQuantitaDisponibile(Prodotto p, int nuovaQuantita) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("UPDATE prodotti SET quantita = ? WHERE prodotto_ID = ?");
            ps.setInt(1, nuovaQuantita);
            ps.setInt(2, p.getID());
            int righe = ps.executeUpdate();

            if (righe == 0) {
                throw new RuntimeException("Impossibile aggiornare la quantità");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static void updateAcquisti(int ID) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("UPDATE prodotti SET numero_acquisti = numero_acquisti+1 WHERE prodotto_ID = ?");
            ps.setInt(1, ID);
            int rows = ps.executeUpdate();

            if (rows == 0) {
                throw new RuntimeException("Errore nella modifica del prodotto con ID: " + ID + ". Prodotto non trovato.");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Ordina una lista di prodotti in base al criterio specificato
     *
     * @param products Lista di prodotti da ordinare
     * @param sortCriteria Criterio di ordinamento (relevance, price-asc,
     * price-desc, newest)
     * @return Lista ordinata di prodotti
     */
    public static ArrayList<Prodotto> sortProducts(ArrayList<Prodotto> products, String sortCriteria) {
        if (sortCriteria == null || sortCriteria.isEmpty() || sortCriteria.equals("relevance")) {
            // Se il criterio è rilevanza (default) o non specificato, restituisci la lista così com'è
            return products;
        }

        switch (sortCriteria) {
            case "price-asc":
                // Ordina per prezzo crescente
                products.sort((p1, p2) -> {
                    return Double.compare(p1.getPrezzoScontato(), p2.getPrezzoScontato());
                });
                break;

            case "price-desc":
                // Ordina per prezzo decrescente
                products.sort((p1, p2) -> {
                    return Double.compare(p2.getPrezzoScontato(), p1.getPrezzoScontato());
                });
                break;

            case "newest":
                // Assumendo che gli ID più alti siano i prodotti più recenti
                products.sort((p1, p2) -> Integer.compare(p2.getID(), p1.getID()));
                break;
        }

        return products;
    }
}
