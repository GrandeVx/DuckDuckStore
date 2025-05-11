DROP DATABASE IF EXISTS DuckDuckStore;
CREATE DATABASE DuckDuckStore;
USE DuckDuckStore;

CREATE TABLE utente
(
    utente_ID      INT AUTO_INCREMENT PRIMARY KEY,
    nome           VARCHAR(25)    NOT NULL,
    cognome        VARCHAR(25)    NOT NULL,
    saldo          DECIMAL(10, 2) NOT NULL,
    email          VARCHAR(25)    NOT NULL,
    pass           VARCHAR(1000)  NOT NULL,
    amministratore BOOLEAN        NOT NULL
);

CREATE TABLE prodotto
(
    prodotto_ID     INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(100)   NOT NULL,
    descrizione     VARCHAR(300)   NOT NULL,
    prezzo          DECIMAL(10, 2) NOT NULL,
    quantita        int            NOT NULL,
    sconto          INT CHECK (sconto >= 0 AND sconto <= 100),
    categoria       ENUM('tavoli', 'racchette', 'palline', 'abbigliamento', 'altro') NOT NULL,
    img             VARCHAR(10000)  NOT NULL,
    numero_acquisti INT DEFAULT 0
);

CREATE TABLE ordine
(
    ordine_ID  INT AUTO_INCREMENT PRIMARY KEY,
    prezzo_tot DECIMAL(10, 2) NOT NULL,
    data       DATE           NOT NULL,
    scontrino  JSON,
    utente_ID  INT,
    FOREIGN KEY (utente_ID) REFERENCES utente (utente_ID)
);


INSERT INTO utente (nome, cognome, saldo, email, pass, amministratore)
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

INSERT INTO prodotto (nome, descrizione, prezzo, quantita, sconto, categoria, img)
VALUES  ('Pongori Palline', 'Set di palline silenziose', 5, 50, 0, 'palline',
        'https://contents.mediadecathlon.com/p2485695/k$5ad2fa81fd31dedc99118c03fce1e2a2/sq/8790388.jpg?format=auto&f=320x320'),
        ('Racchetta Stiga', 'racchetta professionale', 45, 10, 5, 'racchette',
        'https://contents.mediadecathlon.com/m11584230/k$6b52acd5b11e268f37e4d7ce7dcd5361/sq/2406b9e2-371d-4965-8a59-a4b8d02909d7_c1.jpg?format=auto&f=320x320'),
        ('Borsa da tennis table', 'borsa capiente e resistente', 60, 7, 10, 'altro',
        'https://contents.mediadecathlon.com/p1818463/k$baa228586f5fbb6b704d1cd0bd249caf/sq/8558317.jpg?format=auto&f=320x320'),
        ('Pongori Palline', 'set di 6 palline', 12, 30, 0, 'palline',
        'https://contents.mediadecathlon.com/p1939222/k$46844f70283cf97e46b4087306b4dcca/sq/8648795.jpg?format=auto&f=320x320'),
        ('Dione Tavolo', 'tavolo di alta qualità', 300, 5, 15, 'tavoli',
        'https://contents.mediadecathlon.com/p2157213/k$790b47c39f847109d8a832acb1f21ea7/sq/8352846.jpg?format=auto&f=320x320'),
        ('Pongori Rete','Rete portabile per uso domestico',10,10,20,'altro',
        'https://contents.mediadecathlon.com/p1902468/k$61a8c75d6156e0f89a273a30d4dc3d6a/sq/8501506.jpg?format=auto&f=320x320'),
        ('Tibhar Sacco','Sacca da table tennis',12,20,0,'altro',
        'https://contents.mediadecathlon.com/p1339332/k$6a926f90f8ae295d849569470c46c4e0/sq/8406140.jpg?format=auto&f=320x320'),
        ('Artengo Calze','Calze medie junior',6,30,25,'abbigliamento',
        'https://contents.mediadecathlon.com/p1539710/k$e4003fc7b6c1f1f3719ca59439922c1d/sq/8523833.jpg?format=auto&f=320x320'),
        ('Artengo Calze','Calze medie bambini',6,40,25,'abbigliamento',
        'https://contents.mediadecathlon.com/p1968790/k$1df75906c64038555a01a96eb4cece75/sq/8615813.jpg?format=auto&f=320x320'),
        ('Artengo Bandana','Bandana da ping pong bianca',20,30,50,'abbigliamento',
        'https://contents.mediadecathlon.com/p1538336/k$0634495986a1aa1c32ea7d0f121af98b/sq/8505905.jpg?format=auto&f=320x320'),
        ('FoodSpring Crema Proteica','Crema spalmabbile proteica alle nocciole',6,5,0,'altro',
        'https://contents.mediadecathlon.com/p2335076/k$c7e3661d279fd472b160e633b5cd49f2/sq/8793882.jpg?format=auto&f=320x320'),
        ('Corniulle Tavolo','Tavolo Professionale Ping Pong 510 grigio',800,3,5,'tavoli',
        'https://contents.mediadecathlon.com/p2157213/k$790b47c39f847109d8a832acb1f21ea7/sq/8352846.jpg?format=auto&f=320x320'),
        ('Kettler Tavolo','Tavolo Professionale Ping Pong Kettler K10',600,10,0,'tavoli',
        'https://contents.mediadecathlon.com/m15963116/k$a10638b3305c5b7aead47de468f3edc2/sq/d87df883-9d3a-4f26-9d5b-b2a0d3293673_c3c5c4.jpg?format=auto&f=320x320'),
        ('Joola Tavolo','Tavolo Professionale Ping Pong Interno J15',700,5,10,'tavoli',
        'https://contents.mediadecathlon.com/m5940123/k$9a41e517aed7149e2044de0e45c659db/sq/cd181445-d186-41fd-83e6-f5ffc3e31b33_c5.jpg?format=auto&f=320x320'),
        ('Stiga Racchetta','Racchetta Ping Pong Riassemblata in fibra di carbonio',300,10,0,'racchette',
        'https://contents.mediadecathlon.com/m14161207/k$731020a8ecd0c7eae71678df47c2c960/sq/c12488a6-3bd4-4278-9c00-b4772742bff2_c14.jpg?format=auto&f=320x320'),
        ('Garmin Smartwatch','Smartwatch GPS Garmin Forerunner grigio',280,21,10,'abbigliamento',
        'https://contents.mediadecathlon.com/p2680703/k$535268da3cbe50ed02de18068e2c6f84/sq/8916517.jpg?format=auto&f=320x320'),
        ('Tibhar Robot','Robot lancia palline ping pong',280,3,0,'altro','https://contents.mediadecathlon.com/p346816/k$0d44e85256f704f8aaa35b359e133efa/sq/8319180.jpg?format=auto&f=320x320'),
        ('Stiga Legno','Racchetta table tennis di legno',120,12,20,'racchette','https://contents.mediadecathlon.com/m12308652/k$88d6c376e3527193667cac8ff84a7bb4/sq/bcfddbf6-d030-4730-a194-689047ed7c4e_c1.jpg?format=auto&f=320x320'),
        ('Pongori','Tavolo da tennis table blu',210,10,0,'tavoli','https://contents.mediadecathlon.com/p2467191/k$ef5900dde64bfc7a6cfa7866c6cd07e5/sq/8804772.jpg?format=auto&f=320x320'),
        ('Pongori','Tavolo da tennis table nero',210,7,0,'tavoli','https://contents.mediadecathlon.com/p2467199/k$221499e00a01abd3e03a902ddeb99b8f/sq/8733511.jpg?format=auto&f=320x320'),
        ('Pongori','Tavolo da tennis table grigio',210,6,0,'tavoli','https://contents.mediadecathlon.com/p1729644/k$6c880a920ca169be050d8de167042bc3/sq/8572240.jpg?format=auto&f=320x320'),
        ('Pongori','Tavolo da tennis table baby',180,10,0,'tavoli','https://contents.mediadecathlon.com/p2166731/k$79e99566c123ff4b159c8da6cbdd851c/sq/8736742.jpg?format=auto&f=320x320'),
        ('Stiga Legno','Racchetta table tennis di legno',190,5,30,'racchette','https://contents.mediadecathlon.com/m14168824/k$030fd2992617b33f0d23011a143a8618/sq/5340d8b0-39fe-4542-9704-c27f5373d6fb_c27.jpg?format=auto&f=320x320'),
        ('Stiga Carbonio','Racchetta table tennis in fibra di carbonio',160,7,10,'racchette','https://contents.mediadecathlon.com/m11584135/k$8ae94864baec6ae9ef112fd158c65267/sq/0afb8027-7a1e-4f8c-a6a4-b9a4a87ee78e_c1.jpg?format=auto&f=320x320'),
        ('Yonex Scarpe','Scarpe maschili in gomma antiaderenti',90,12,0,'abbigliamento','https://contents.mediadecathlon.com/p2434424/k$f1a4922d19f8c66977f696ca2bc25b3c/sq/8815539.jpg?format=auto&f=320x320'),
        ('Stiga Cover','Copertura per racchette',40,29,0,'altro','https://contents.mediadecathlon.com/m14159717/k$d8357a9b1bf72a2cfff967b499c43464/sq/7d4905ea-ace0-455b-a337-851b53294410_c14.jpg?format=auto&f=320x320'),
        ('FZ Forza','Scarpe maschili in gomma antiaderenti',120,20,20,'abbigliamento','https://contents.mediadecathlon.com/m10768028/k$3d24551d59c0c12597228c4438b683f4/sq/c07466ce-24d5-4183-8b29-8551bd3942a4_c4c4c4.jpg?format=auto&f=320x320'),
        ('Cornilleau','Racchetta ergonomica',50,7,0,'racchette','https://contents.mediadecathlon.com/m9508686/k$0a266f0a23d6b909c6bf4401c8674272/sq/24ca2776-98a2-4ef3-be29-0e29e9541ecf_c1c1.jpg?format=auto&f=320x320'),
        ('Joola','Racchetta table tennis nera',100,2,10,'racchette','https://contents.mediadecathlon.com/m14602869/k$e2f05d690f14b9392f8b243e5e92b767/sq/483b9104-33b7-44ed-b108-fb57df43d533_c255.jpg?format=auto&f=320x320'),
        ('Joola','Racchetta table tennis blu',100,12,15,'racchette','https://contents.mediadecathlon.com/m16212372/k$677112447d7c6903c61a2146016ed831/sq/7dbfcbc2-6c0a-4066-9eea-4ee715bc99aa_c6.jpg?format=auto&f=320x320');
