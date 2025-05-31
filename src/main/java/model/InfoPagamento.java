package model;

import java.util.Base64;

public class InfoPagamento {
    private String cardHolder;
    private String cardNumber; // Will be stored encrypted
    private String cardExpiry; // Will be stored encrypted  
    private String cardCvv;    // Will be stored encrypted
    private String paymentMethod;
    private String paymentStatus;

    // Default constructor
    public InfoPagamento() {
        this.paymentMethod = "card";
        this.paymentStatus = "pending";
    }

    // Constructor with all fields
    public InfoPagamento(String cardHolder, String cardNumber, String cardExpiry, String cardCvv) {
        this();
        this.cardHolder = cardHolder;
        this.cardNumber = encrypt(cardNumber);
        this.cardExpiry = encrypt(cardExpiry);
        this.cardCvv = encrypt(cardCvv);
    }

    // Getters
    public String getCardHolder() { return cardHolder; }
    public String getCardNumber() { return cardNumber; }
    public String getCardExpiry() { return cardExpiry; }
    public String getCardCvv() { return cardCvv; }
    public String getPaymentMethod() { return paymentMethod; }
    public String getPaymentStatus() { return paymentStatus; }

    // Setters
    public void setCardHolder(String cardHolder) { this.cardHolder = cardHolder; }
    public void setCardNumber(String cardNumber) { this.cardNumber = encrypt(cardNumber); }
    public void setCardExpiry(String cardExpiry) { this.cardExpiry = encrypt(cardExpiry); }
    public void setCardCvv(String cardCvv) { this.cardCvv = encrypt(cardCvv); }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    // Encrypted getters (for database storage)
    public String getEncryptedCardNumber() { return cardNumber; }
    public String getEncryptedCardExpiry() { return cardExpiry; }
    public String getEncryptedCardCvv() { return cardCvv; }

    // Decrypted getters (for display purposes)
    public String getDecryptedCardNumber() { return decrypt(cardNumber); }
    public String getDecryptedCardExpiry() { return decrypt(cardExpiry); }
    public String getDecryptedCardCvv() { return decrypt(cardCvv); }

    // Masked card number for display (shows only last 4 digits)
    public String getMaskedCardNumber() {
        String decrypted = getDecryptedCardNumber();
        if (decrypted == null || decrypted.length() < 4) {
            return "****";
        }
        return "**** **** **** " + decrypted.substring(decrypted.length() - 4);
    }

    // Payment validation methods
    public boolean isValidCard() {
        String decryptedNumber = getDecryptedCardNumber();
        return decryptedNumber != null && 
               decryptedNumber.matches("\\d{13,19}") && 
               isValidLuhn(decryptedNumber);
    }

    public boolean isTestCard() {
        String decryptedNumber = getDecryptedCardNumber();
        return "4242424242424242".equals(decryptedNumber);
    }

    public boolean isValidExpiry() {
        String decryptedExpiry = getDecryptedCardExpiry();
        return decryptedExpiry != null && decryptedExpiry.matches("(0[1-9]|1[0-2])/\\d{2}");
    }

    public boolean isValidCvv() {
        String decryptedCvv = getDecryptedCardCvv();
        return decryptedCvv != null && decryptedCvv.matches("\\d{3,4}");
    }

    public boolean isValid() {
        return cardHolder != null && !cardHolder.trim().isEmpty() &&
               isValidCard() && isValidExpiry() && isValidCvv();
    }

    // Simulated payment processing
    public boolean processPayment() {
        if (!isValid()) {
            setPaymentStatus("failed");
            return false;
        }

        // Only test card "4242424242424242" should succeed
        if (isTestCard()) {
            setPaymentStatus("completed");
            return true;
        } else {
            setPaymentStatus("failed");
            return false;
        }
    }

    // Simple encryption simulation (Base64 encoding)
    // NOTE: This is NOT secure encryption - only for educational purposes
    private String encrypt(String plainText) {
        if (plainText == null) return null;
        return Base64.getEncoder().encodeToString(plainText.getBytes());
    }

    private String decrypt(String encryptedText) {
        if (encryptedText == null) return null;
        try {
            return new String(Base64.getDecoder().decode(encryptedText));
        } catch (Exception e) {
            return null;
        }
    }

    // Luhn algorithm for credit card validation
    private boolean isValidLuhn(String cardNumber) {
        int sum = 0;
        boolean alternate = false;
        for (int i = cardNumber.length() - 1; i >= 0; i--) {
            int n = Integer.parseInt(cardNumber.substring(i, i + 1));
            if (alternate) {
                n *= 2;
                if (n > 9) {
                    n = (n % 10) + 1;
                }
            }
            sum += n;
            alternate = !alternate;
        }
        return (sum % 10 == 0);
    }

    @Override
    public String toString() {
        return "InfoPagamento{" +
               "cardHolder='" + cardHolder + '\'' +
               ", cardNumber='" + getMaskedCardNumber() + '\'' +
               ", paymentMethod='" + paymentMethod + '\'' +
               ", paymentStatus='" + paymentStatus + '\'' +
               '}';
    }
} 