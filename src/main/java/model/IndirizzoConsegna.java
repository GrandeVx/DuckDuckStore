package model;

public class IndirizzoConsegna {
    private String nome;
    private String cognome;
    private String via;
    private String citta;
    private String cap;
    private String telefono;
    private String note;

    // Default constructor
    public IndirizzoConsegna() {}

    // Constructor with all fields
    public IndirizzoConsegna(String nome, String cognome, String via, String citta, String cap, String telefono, String note) {
        this.nome = nome;
        this.cognome = cognome;
        this.via = via;
        this.citta = citta;
        this.cap = cap;
        this.telefono = telefono;
        this.note = note;
    }

    // Constructor without optional fields
    public IndirizzoConsegna(String nome, String cognome, String via, String citta, String cap) {
        this(nome, cognome, via, citta, cap, null, null);
    }

    // Getters
    public String getNome() { return nome; }
    public String getCognome() { return cognome; }
    public String getVia() { return via; }
    public String getCitta() { return citta; }
    public String getCap() { return cap; }
    public String getTelefono() { return telefono; }
    public String getNote() { return note; }

    // Setters
    public void setNome(String nome) { this.nome = nome; }
    public void setCognome(String cognome) { this.cognome = cognome; }
    public void setVia(String via) { this.via = via; }
    public void setCitta(String citta) { this.citta = citta; }
    public void setCap(String cap) { this.cap = cap; }
    public void setTelefono(String telefono) { this.telefono = telefono; }
    public void setNote(String note) { this.note = note; }

    // Utility methods
    public String getIndirizzoCompleto() {
        // Handle null or empty values to avoid showing just commas
        if (via == null || via.trim().isEmpty() || 
            cap == null || cap.trim().isEmpty() || 
            citta == null || citta.trim().isEmpty()) {
            return "";
        }
        return via + ", " + cap + " " + citta;
    }

    public String getNomeCompleto() {
        // Handle null or empty values
        if (nome == null || nome.trim().isEmpty() || 
            cognome == null || cognome.trim().isEmpty()) {
            return "";
        }
        return nome + " " + cognome;
    }

    // Check if this address has meaningful data (not just empty fields)
    public boolean hasValidData() {
        return nome != null && !nome.trim().isEmpty() &&
               cognome != null && !cognome.trim().isEmpty() &&
               via != null && !via.trim().isEmpty() &&
               citta != null && !citta.trim().isEmpty() &&
               cap != null && !cap.trim().isEmpty();
    }

    // Validation methods
    public boolean isValid() {
        return nome != null && !nome.trim().isEmpty() &&
               cognome != null && !cognome.trim().isEmpty() &&
               via != null && !via.trim().isEmpty() &&
               citta != null && !citta.trim().isEmpty() &&
               cap != null && !cap.trim().isEmpty() && isValidCap(cap);
    }

    private boolean isValidCap(String cap) {
        return cap != null && cap.matches("\\d{5}");
    }

    public boolean isValidTelefono() {
        // Allow empty/null telefono (it's optional)
        if (telefono == null || telefono.trim().isEmpty()) {
            return true;
        }
        
        // Remove all spaces, dashes, and parentheses for validation
        String cleanedTelefono = telefono.replaceAll("[\\s\\-\\(\\)]", "");
        
        // Validate: optional +, followed by 8-15 digits
        // This supports formats like: +39 393 831 5665, +39-393-831-5665, +39(393)8315665, etc.
        return cleanedTelefono.matches("\\+?\\d{8,15}");
    }

    @Override
    public String toString() {
        return "IndirizzoConsegna{" +
               "nome='" + nome + '\'' +
               ", cognome='" + cognome + '\'' +
               ", via='" + via + '\'' +
               ", citta='" + citta + '\'' +
               ", cap='" + cap + '\'' +
               ", telefono='" + telefono + '\'' +
               ", note='" + note + '\'' +
               '}';
    }
} 