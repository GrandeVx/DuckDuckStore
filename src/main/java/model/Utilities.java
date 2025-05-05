package model;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.nio.charset.StandardCharsets;
import java.util.List;

public class Utilities {

    public static List<Prodotto> scontrinoToProdotti(String json) {

        Gson gson = new Gson();
        Type productListType = new TypeToken<List<Prodotto>>() {
        }.getType();
        return gson.fromJson(json, productListType);
    }


    public static String prodottiToScontrino(List<Prodotto> prodotti) {

        Gson gson = new Gson();
        return gson.toJson(prodotti);

    }


    public static String toHash(String password) {
        String hashString = null;
        try {
            java.security.MessageDigest digest = java.security.MessageDigest.getInstance("SHA-512");
            byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
            hashString = "";
            for (int i = 0; i < hash.length; i++) {
                hashString += Integer.toHexString((hash[i] & 0xFF) | 0x100).substring(1, 3);
            }
        } catch (java.security.NoSuchAlgorithmException e) {
            System.out.println(e);
        }
        return hashString;
    }

}
