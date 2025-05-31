# DuckDuckStore

## Esecuzione con Docker

### Avvio dell'applicazione
1. Clona il repository
2. Naviga nella directory del progetto
3. Esegui il comando:
```
docker-compose up --build
oppure
docker-compose -f docker-compose.dev.yml up
per avviare l'applicazione in modalità sviluppo
```
4. L'applicazione sarà disponibile all'indirizzo: http://localhost:8080

### Configurazione del database
Il database MySQL viene automaticamente inizializzato con lo script `db.sql` presente nella root del progetto.

### Variabili d'ambiente
È possibile configurare le seguenti variabili d'ambiente nel file `docker-compose.yml`:
- `MYSQL_HOST`: Host del database MySQL (default: mysql)
- `MYSQL_PORT`: Porta del database MySQL (default: 3306)
- `MYSQL_DB`: Nome del database (default: DuckDuckStore)
- `MYSQL_USER`: Utente MySQL (default: root)
- `MYSQL_PASSWORD`: Password MySQL (default: root)

## Struttura dell'applicazione
- Applicazione web Java basata su Tomcat
- Utilizza JDBC per la connessione al database MySQL
- Model-View-Controller (MVC) pattern
