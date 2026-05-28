# America's Cup – Database & Web App
**Elaborato di Esame di Stato 2020/2021**
Angeli Alessia – 5° INFO A, ISISS Valle Seriana

---

## Descrizione del progetto

Applicazione web per la gestione delle regate dell'America's Cup, con database centralizzato in Italia (Bergamo) e utenti collegati dall'America tramite rete intercontinentale.

---

## Struttura del progetto

```
americas-cup/
├── index.php                   # Home page con classifica eliminatorie e mappa interattiva
├── stile_index.css
├── accedi.php                  # Pagina di login
├── stile_accedi.css
├── inserisci_risultati.php     # Form per inserire nuovi punteggi (accesso autenticato)
├── stile_inserisci_risultati.css
├── aggiornamento.php           # Gestione INSERT nella tabella gareggiano_in
└── database.php                # Connessione al database MySQL
```

---

## Infrastruttura di rete

- **Server/Database**: Bergamo, Italia (`192.168.0.1`)
- **Utenti**: America, collegamento wireless tramite router (`16.0.0.1`)
- **Collegamento intercontinentale**: linea telefonica con 2 modem DSL
- **ISP europeo**: instradamento del traffico fino alla rete locale italiana
- **Software usato**: Cisco Packet Tracer

| Dispositivo               | Indirizzo IP  | Subnet Mask   |
|---------------------------|---------------|---------------|
| Wireless Router – America | 16.0.0.0      | 255.255.255.0 |
| ServerISP                 | 127.16.0.1    | 255.255.0.0   |
| MioServer                 | 192.168.0.1   | 255.255.255.0 |

---

## Database

**Nome database**: `americas_cup`
**DBMS**: MySQL

### Tabelle

| Tabella                | Descrizione                                              |
|------------------------|----------------------------------------------------------|
| `barche`               | Imbarcazioni partecipanti                                |
| `membri_equipaggio`    | Membri dell'equipaggio di ogni barca                     |
| `sponsor_privati`      | Privati che sponsorizzano le barche                      |
| `sponsor_aziende`      | Aziende sponsor                                          |
| `finanziate_da_privato`| Relazione barca–sponsor privato con importo              |
| `finanziate_da_azienda`| Relazione barca–sponsor azienda con importo              |
| `regate`               | Regate dell'America's Cup (eliminatorie, semifinali, finale) |
| `gareggiano_in`        | Risultati (punteggi) per ogni barca in ogni regata       |

### Schema logico

```
BARCA (ID_barca, Nazionalità, Lunghezza, Stazza, Modello)
MEMBRO_EQUIPAGGIO (ID_membro_equipaggio, Nome, Cognome, Data_nascita, Ruolo, ID_barca*)
SPONSOR_PRIVATO (ID_sponsor_privato, Nome, Cognome, Data_nascita, Codice_fiscale, Indirizzo, Città, Nazione)
FINANZIATA_DA_PRIVATO (ID_barca*, ID_sponsor_privato*, Importo)
SPONSOR_AZIENDA (ID_sponsor_azienda, Ragione_sociale, Partita_IVA)
FINANZIATA_DA_AZIENDA (ID_barca*, ID_sponsor_azienda*, Importo)
REGATA (ID_regata, Turno, Luogo, Data_ora, Caratteristiche_percorso)
GAREGGIA_IN (ID_barca*, ID_regata*, Punteggio)
```

---

## Query SQL principali

**1. Barche con lunghezza e stazza superiori alla media**
```sql
SELECT b.Modello, b.Lunghezza, b.Stazza
FROM barche b
WHERE b.Lunghezza >= (SELECT AVG(b.Lunghezza) FROM barche b)
  AND b.Stazza >= (SELECT AVG(b.Stazza) FROM barche b)
```

**2. Classifica nazioni dopo le eliminatorie**
```sql
SELECT b.Nazionalità AS Nazione, SUM(g.Punteggio) AS Punteggio_eliminatorie
FROM barche b, regate r, gareggiano_in g
WHERE b.ID_barca = g.id_barca
  AND r.ID_regata = g.id_regata
  AND r.Turno = 'Eliminatoria'
GROUP BY b.Nazionalità
ORDER BY Punteggio_eliminatorie ASC
```

**3. Nazioni finanziate da aziende con importo superiore a qualsiasi sponsor privato**
```sql
SELECT b.Nazionalità AS Nazione, SUM(f.Importo) AS Importo
FROM barche b, sponsor_aziende s, finanziate_da_azienda f
WHERE b.ID_barca = f.id_barca
  AND s.ID_sponsor_azienda = f.id_sponsor_azienda
GROUP BY b.Nazionalità
HAVING Importo > ALL (
    SELECT SUM(f.Importo)
    FROM barche b, sponsor_privati s, finanziate_da_privato f
    WHERE b.ID_barca = f.id_barca
      AND s.ID_sponsor_privato = f.id_sponsor_privato
    GROUP BY b.Nazionalità
)
```

---

## Funzionalità del sito web

- **Home page**: classifica eliminatorie estratta dal DB + mappa Google Maps interattiva con le location delle regate
- **Login**: autenticazione utente con sessioni PHP; le password sono salvate in hash bcrypt
- **Inserimento risultati**: form accessibile solo agli utenti autenticati per aggiungere punteggi di nuove regate

---

## Sicurezza – SQL Injection

Il progetto analizza la vulnerabilità da SQL injection e adotta le seguenti contromisure:

- `input type="select"` per barca e regata (valori predefiniti, nessun testo libero)
- `input type="number"` per il punteggio
- Attributo `pattern="[A-Za-z0-9]+"` sugli input di testo nel form di login
- Possibile estensione con `htmlspecialchars()` per la sanitizzazione lato server

---

## Requisiti

- PHP 7+
- MySQL / MariaDB
- Web server (es. Apache con XAMPP/MAMP)
- Connessione internet per Google Maps API e font esterni

## Avvio in locale

1. Importare il database con i comandi SQL forniti nell'elaborato
2. Configurare `database.php` con le credenziali locali
3. Avviare il server Apache e aprire `index.php` nel browser
