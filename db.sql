DROP DATABASE IF EXISTS DuckDuckStore;
CREATE DATABASE DuckDuckStore;
USE DuckDuckStore;

CREATE TABLE utenti
(
    utente_ID      INT AUTO_INCREMENT PRIMARY KEY,
    nome           VARCHAR(25)    NOT NULL,
    cognome        VARCHAR(25)    NOT NULL,
    saldo          DECIMAL(10, 2) NOT NULL,
    email          VARCHAR(25)    NOT NULL,
    pass           VARCHAR(1000)  NOT NULL,
    amministratore BOOLEAN        NOT NULL
);

CREATE TABLE prodotti
(
    prodotto_ID     INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(100)   NOT NULL,
    descrizione     VARCHAR(300)   NOT NULL,
    prezzo          DECIMAL(10, 2) NOT NULL,
    quantita        int            NOT NULL,
    sconto          INT CHECK (sconto >= 0 AND sconto <= 100),
    categoria       ENUM('spaventose', 'natale', 'fantasy', 'professioni') NOT NULL,
    img             VARCHAR(10000)  NOT NULL,
    numero_acquisti INT DEFAULT 0
);

CREATE TABLE ordini
(
    ordine_ID  INT AUTO_INCREMENT PRIMARY KEY,
    prezzo_tot DECIMAL(10, 2) NOT NULL,
    data       DATE           NOT NULL,
    scontrino  JSON,
    utente_ID  INT,
    FOREIGN KEY (utente_ID) REFERENCES utenti (utente_ID)
);


INSERT INTO utenti (nome, cognome, saldo, email, pass, amministratore)
-- le password sono il solo nome il minuscolo, esempio: per Vito la password e' "vito"
VALUES  ('Vito', 'Altieri', 10000, 'vito@gmail.com',
        '9b592838e90a2adb1358c5496934792b0246de9dc230ab553d2622117884f3031c440a78ba579716401b862a27d6e5144b81208b15e829ea6aebe6d7c422a2e8',
        TRUE),
        ('Vittorio', "D'Alfonso", 10000, 'vittorio@gmail.com',
        'e0098f8bd8ade0638c23fb2f3ff534bca3ac87b9fa6367f5040ac77451d7fd75cf925ff1a799b0da9478ae9883f65fdf28638da94e02af542326c24789631229',
        TRUE),
        ('Matteo Ferdinando', 'Emolo', 10000, 'matteo@gmail.com',
        'c2ed182680410c5bf65559f2d005bf3262bddcffd8b1f3d69c20263af677f9be3eee013a8905d3f96245d177c1c1a5929d0c607cf2bf6e8eb5bbfa16bd0a4c3e',
        TRUE);


INSERT INTO prodotti (nome, descrizione, prezzo, quantita, sconto, categoria, img)
VALUES  ('Cyber Duck', 'Cyber Rubber Duck. Compra il malvagio imperatore del Milan Duck Store. Dirige Cyber, il centro del lato oscuro. Che la forza sia con noi...', 12, 50, 0, 'spaventose',
        'https://milanduckstore.com/wp-content/uploads/2019/04/cyber-360x360.png'),
        ('Albero di Natale', "Christmas tree. Sicuramente non avetemai avuto un albero di Natale cosi' carino. Un regalo da mettere sotto l'albero o una semplice decorazione", 15, 50, 5, 'natale',
        'https://milanduckstore.com/wp-content/uploads/2019/12/image0-360x360.png'),
        ('Biancaneve', "Snow White Rubber Duck. Acquista la bella ragazza addormentata delle fiabe di DuckDuckStore. Con la sua tipica acconciatura, il cerchietto rosso ed il vestito blu da principessa, e' il regalo perfetto per gli amanti delle fiabe della buona notte.", 12, 50, 0, 'fantasy',
        'https://milanduckstore.com/wp-content/uploads/2019/05/snow-white-360x360.png'),
        ('Fotografo', 'La paperella amante dei primi piani e del grandangolo, sempre alla ricerca dello scatto perfetto!', 12, 50, 0, 'professioni',
        'https://milanduckstore.com/wp-content/uploads/2020/02/image0-360x360.png');
