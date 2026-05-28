-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 23, 2021 alle 12:29
-- Versione del server: 10.4.14-MariaDB
-- Versione PHP: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `americas_cup`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `barche`
--

CREATE TABLE `barche` (
  `ID_barca` int(11) NOT NULL,
  `Nazionalità` varchar(20) NOT NULL,
  `Lunghezza` int(11) DEFAULT NULL CHECK (`Lunghezza` > 0),
  `Stazza` int(11) DEFAULT NULL CHECK (`Stazza` > 0),
  `Modello` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `barche`
--

INSERT INTO `barche` (`ID_barca`, `Nazionalità`, `Lunghezza`, `Stazza`, `Modello`) VALUES
(1, 'Italia', 12, 80, 'Neo 400'),
(2, 'USA', 15, 100, 'Viko 3OS'),
(3, 'Regno Unito', 13, 90, 'Visimara 40 IMS'),
(4, 'Germania', 20, 150, 'Bavaria B/one'),
(5, 'Francia', 17, 120, 'Cookson Boats TP 52'),
(6, 'Spagna', 16, 110, 'Janneu Sun Fast 3300');

-- --------------------------------------------------------

--
-- Struttura della tabella `finanziate_da_azienda`
--

CREATE TABLE `finanziate_da_azienda` (
  `id_barca` int(11) NOT NULL,
  `id_sponsor_azienda` int(11) NOT NULL,
  `Importo` int(11) NOT NULL CHECK (`Importo` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `finanziate_da_azienda`
--

INSERT INTO `finanziate_da_azienda` (`id_barca`, `id_sponsor_azienda`, `Importo`) VALUES
(1, 3, 200000),
(3, 3, 120000),
(4, 2, 300000),
(5, 1, 400000);

-- --------------------------------------------------------

--
-- Struttura della tabella `finanziate_da_privato`
--

CREATE TABLE `finanziate_da_privato` (
  `id_barca` int(11) NOT NULL,
  `id_sponsor_privato` int(11) NOT NULL,
  `Importo` int(11) NOT NULL CHECK (`Importo` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `finanziate_da_privato`
--

INSERT INTO `finanziate_da_privato` (`id_barca`, `id_sponsor_privato`, `Importo`) VALUES
(2, 1, 240000),
(2, 2, 150000),
(6, 3, 170000);

-- --------------------------------------------------------

--
-- Struttura della tabella `gareggiano_in`
--

CREATE TABLE `gareggiano_in` (
  `id_barca` int(11) NOT NULL,
  `id_regata` int(11) NOT NULL,
  `Punteggio` int(11) NOT NULL CHECK (`Punteggio` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `gareggiano_in`
--

INSERT INTO `gareggiano_in` (`id_barca`, `id_regata`, `Punteggio`) VALUES
(1, 1, 0),
(1, 2, 1),
(1, 3, 3),
(1, 5, 0),
(2, 1, 4),
(2, 2, 2),
(3, 1, 2),
(3, 2, 4),
(4, 1, 1),
(4, 2, 1),
(4, 3, 0),
(4, 5, 0),
(5, 1, 3),
(5, 2, 0),
(5, 4, 1),
(5, 5, 1),
(6, 1, 2),
(6, 2, 3),
(6, 4, 2);

-- --------------------------------------------------------

--
-- Struttura della tabella `membri_equipaggio`
--

CREATE TABLE `membri_equipaggio` (
  `ID_membro_equipaggio` int(11) NOT NULL,
  `Nome` varchar(20) NOT NULL,
  `Cognome` varchar(20) NOT NULL,
  `Data_nascita` date DEFAULT NULL,
  `Ruolo` varchar(10) NOT NULL CHECK (`Ruolo` in ('Bowman','Sewer','Mastman','Pitman','Tailer','Skipper','Tattico','Navigatore','Ospite','Riserva')),
  `id_barca` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `membri_equipaggio`
--

INSERT INTO `membri_equipaggio` (`ID_membro_equipaggio`, `Nome`, `Cognome`, `Data_nascita`, `Ruolo`, `id_barca`) VALUES
(1, 'Giovanni', 'Verdi', '1980-02-16', 'Bowman', 1),
(2, 'Antonio', 'Verdi', '1994-04-20', 'Bowman', 1),
(3, 'Lucia', 'Rossi', '1990-01-10', 'Sewer', 1),
(4, 'Carlo', 'Franchi', '1991-01-18', 'Sewer', 1),
(5, 'Alessandra', 'Gialli', '1989-12-26', 'Mastman', 1),
(6, 'Carmine', 'Bianchi', '1999-10-03', 'Tailer', 1),
(7, 'Giacomo', 'Neri', '1994-07-15', 'Tailer', 1),
(8, 'Andrea', 'Marrone', '1987-09-30', 'Skipper', 1),
(9, 'Luca', 'Violi', '1999-02-06', 'Tattico', 1),
(10, 'Maria', 'Aranci', '1992-05-19', 'Navigatore', 1),
(11, 'Francesca', 'Mele', '1994-02-19', 'Ospite', 1),
(12, 'Silvia', 'Pere', '1991-12-12', 'Ospite', 1),
(13, 'Natalia', 'Ferri', '1999-03-15', 'Riserva', 1),
(14, 'Alex', 'Argenti', '1989-08-02', 'Riserva', 1),
(15, 'Matteo', 'Oro', '1999-09-03', 'Riserva', 1),
(16, 'Fabio', 'Cromo', '1998-11-07', 'Riserva', 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `regate`
--

CREATE TABLE `regate` (
  `ID_regata` int(11) NOT NULL,
  `Turno` varchar(12) NOT NULL CHECK (`Turno` in ('Eliminatoria','Semi-finale','Finale')),
  `Luogo` varchar(30) NOT NULL,
  `Data_ora` datetime NOT NULL,
  `Caratteristiche_percorso` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `regate`
--

INSERT INTO `regate` (`ID_regata`, `Turno`, `Luogo`, `Data_ora`, `Caratteristiche_percorso`) VALUES
(1, 'Eliminatoria', 'Wateimata Harbour, New Zeland', '2021-05-05 14:00:00', 'The harbour is a drowned valley system that was carved through Miocene marine sediments of the Waitemata Group. Recent volcanism in the Auckland volcanic field has also shaped the coast, most obviously at Devonport and the Meola Reef (a lava flow which almost spans the harbour), but also in the explosion craters of Orakei Basin and in western Shoal Bay. In periods of low sea level, a tributary ran from Milford into the Shoal Bay stream. This valley provided the harbour with a second entrance when sea levels rose, until the Lake Pupuke volcano plugged this gap. The current shore is strongly influenced by tidal rivers, particularly in the west and north of the harbour. Mudflats covered by mangroves flourish in these conditions, and salt marshes are also typical.'),
(2, 'Eliminatoria', 'Great Sound, Bermuda', '2021-05-10 14:00:00', 'The Great Sound dominates the southwest of the island chain and forms a natural harbour. It is surrounded on all sides by islands, except for the northeast, where it is open to the Atlantic Ocean. To the south, two small peninsulas jut into the sound separating it from the smaller Little Sound. In the east, the Great Sound narrows to form Hamilton Harbour. Bermuda\'s capital, Hamilton, is on the northern shore of this harbour. Numerous islands lie within the Great Sound, most of them on the southeastern side of it, including Darrell\'s Island, Hawkins Island, Hinson\'s Island, Long Island, Marshall\'s Island, and Watling Island.'),
(3, 'Semi-finale', 'San Francisco, California', '2021-05-15 14:00:00', 'San Francisco has a warm-summer Mediterranean climate characteristic of California\'s coast, with moist mild winters and dry summers. San Francisco\'s weather is strongly influenced by the cool currents of the Pacific Ocean on the west side of the city, and the water of San Francisco Bay to the north and east. This moderates temperature swings and produces a remarkably mild year-round climate with little seasonal temperature variation. Because of its sharp topography and maritime influences, San Francisco exhibits a multitude of distinct microclimates. The high hills in the geographic center of the city are responsible for a 20% variance in annual rainfall between different parts of the city. San Francisco is sunnier, with an average of 260 clear days, and only 105 cloudy days per year.'),
(4, 'Semi-finale', 'Auckland, New Zeland', '2021-05-20 14:00:00', 'Auckland lies on and around an isthmus, less than two kilometres wide at its narrowest point, between Mangere Inlet and the Tamaki River. There are two harbours surrounding this isthmus: Waitematā Harbour to the north, which opens east to the Hauraki Gulf and thence to the Pacific Ocean, and Manukau Harbour to the south, which opens west to the Tasman Sea. The total coastline of Auckland is 3,702 kilometres (2,300 mi) long. Bridges span parts of both harbours, notably the Auckland Harbour Bridge crossing the Waitematā Harbour west of the central business district. The Mangere Bridge and the Upper Harbour Bridge span the upper reaches of the Manukau and Waitematā Harbours, respectively. In earlier times, portage paths crossed the narrowest sections of the isthmus.'),
(5, 'Finale', 'Lower New York Bay, New York', '2021-05-25 14:00:00', 'Since before the time of the Lenape, the Native American inhabitants of the area, the Lower Bay has sustained a rich marine ecosystem with multiple fish species and molluscs, especially oyster, clam and mussel beds. In the 20th century, due to increased population and industrial pollution, the water quality of the bay and its ability to support marine life was severely diminished. The water quality of the bay began to improve with the passage of the 1972 Clean Water Act. The main shipping channel through Lower New York Bay is the Ambrose Channel, 2,000 feet wide and dredged to a depth of 40 feet. The channel is navigable by ships with up to a 37-foot draft at low tide. The entrance to the Ambrose Channel was marked for many years by the Lightship Ambrose, which was superseded by the Ambrose Light. The bay contains popular beaches at Brighton Beach and Coney Island in Brooklyn. There are also beaches on Staten Island. Just outside the bay, facing the Atlantic, are the beaches of Sandy Hook and the Rockaways.');

-- --------------------------------------------------------

--
-- Struttura della tabella `sponsor_aziende`
--

CREATE TABLE `sponsor_aziende` (
  `ID_sponsor_azienda` int(11) NOT NULL,
  `Ragione_sociale` varchar(30) NOT NULL,
  `Partita_IVA` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `sponsor_aziende`
--

INSERT INTO `sponsor_aziende` (`ID_sponsor_azienda`, `Ragione_sociale`, `Partita_IVA`) VALUES
(1, 'Ferrero International SA', '03629090048'),
(2, 'Yamaha Motor', '12363410155'),
(3, 'The Coca-Cola Company', '12333410190');

-- --------------------------------------------------------

--
-- Struttura della tabella `sponsor_privati`
--

CREATE TABLE `sponsor_privati` (
  `ID_sponsor_privato` int(11) NOT NULL,
  `Nome` varchar(20) NOT NULL,
  `Cognome` varchar(20) NOT NULL,
  `Data_nascita` date DEFAULT NULL,
  `Codice_fiscale` char(16) NOT NULL,
  `Indirizzo` varchar(30) DEFAULT NULL,
  `Città` varchar(20) DEFAULT NULL,
  `Nazione` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `sponsor_privati`
--

INSERT INTO `sponsor_privati` (`ID_sponsor_privato`, `Nome`, `Cognome`, `Data_nascita`, `Codice_fiscale`, `Indirizzo`, `Città`, `Nazione`) VALUES
(1, 'Marco', 'Rodi', '1980-09-13', 'RDOMRC80P13D969V', 'Via Marconi 6', 'Genova', 'Italy'),
(2, 'Mohammed', 'Abualkheir', '1995-07-20', 'BLKMMM95L20Z215C', 'Nad al Hammar', 'Dubai', 'United Arab Emirates'),
(3, 'Jessica', 'Miller', '1960-02-01', 'MLLJSC60B41Z114G', '48 KingFisher Way', 'London', 'United Kingdom');

-- --------------------------------------------------------

--
-- Struttura della tabella `utenti`
--

CREATE TABLE `utenti` (
  `ID_utente` int(11) NOT NULL,
  `username` varchar(10) NOT NULL,
  `password` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `utenti`
--

INSERT INTO `utenti` (`ID_utente`, `username`, `password`) VALUES
(1, 'giudice1', '$2y$10$xGNvH8Oo/5QXBTzhWX6zz.pjjf/MZ73atsvkZl1nKfJWXZo2lSEEC'),
(2, 'giudice2', '$2y$10$EYdQEscnhoZLYd481WIxIOlfnPRXpJsL8MZgBUnohvdO.De2NKY72'),
(3, 'giudice3', '$2y$10$MqPOr8oz6mz8r2P.notNWe6d8JPgMPOmJj27RNFMOZeSPJz06Kzvi'),
(4, 'giudice4', '$2y$10$5eiH9/5XEh0GQuqfOwLl9eF8yFfuDka.13INO6MYuf55Mn3BAvkJO');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `barche`
--
ALTER TABLE `barche`
  ADD PRIMARY KEY (`ID_barca`);

--
-- Indici per le tabelle `finanziate_da_azienda`
--
ALTER TABLE `finanziate_da_azienda`
  ADD PRIMARY KEY (`id_barca`,`id_sponsor_azienda`),
  ADD KEY `id_sponsor_azienda` (`id_sponsor_azienda`);

--
-- Indici per le tabelle `finanziate_da_privato`
--
ALTER TABLE `finanziate_da_privato`
  ADD PRIMARY KEY (`id_barca`,`id_sponsor_privato`),
  ADD KEY `id_sponsor_privato` (`id_sponsor_privato`);

--
-- Indici per le tabelle `gareggiano_in`
--
ALTER TABLE `gareggiano_in`
  ADD PRIMARY KEY (`id_barca`,`id_regata`),
  ADD KEY `id_regata` (`id_regata`);

--
-- Indici per le tabelle `membri_equipaggio`
--
ALTER TABLE `membri_equipaggio`
  ADD PRIMARY KEY (`ID_membro_equipaggio`),
  ADD KEY `id_barca` (`id_barca`);

--
-- Indici per le tabelle `regate`
--
ALTER TABLE `regate`
  ADD PRIMARY KEY (`ID_regata`);

--
-- Indici per le tabelle `sponsor_aziende`
--
ALTER TABLE `sponsor_aziende`
  ADD PRIMARY KEY (`ID_sponsor_azienda`);

--
-- Indici per le tabelle `sponsor_privati`
--
ALTER TABLE `sponsor_privati`
  ADD PRIMARY KEY (`ID_sponsor_privato`),
  ADD UNIQUE KEY `Codice_fiscale` (`Codice_fiscale`);

--
-- Indici per le tabelle `utenti`
--
ALTER TABLE `utenti`
  ADD PRIMARY KEY (`ID_utente`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `barche`
--
ALTER TABLE `barche`
  MODIFY `ID_barca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT per la tabella `membri_equipaggio`
--
ALTER TABLE `membri_equipaggio`
  MODIFY `ID_membro_equipaggio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT per la tabella `regate`
--
ALTER TABLE `regate`
  MODIFY `ID_regata` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT per la tabella `sponsor_aziende`
--
ALTER TABLE `sponsor_aziende`
  MODIFY `ID_sponsor_azienda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la tabella `sponsor_privati`
--
ALTER TABLE `sponsor_privati`
  MODIFY `ID_sponsor_privato` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la tabella `utenti`
--
ALTER TABLE `utenti`
  MODIFY `ID_utente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `finanziate_da_azienda`
--
ALTER TABLE `finanziate_da_azienda`
  ADD CONSTRAINT `finanziate_da_azienda_ibfk_1` FOREIGN KEY (`id_barca`) REFERENCES `barche` (`ID_barca`),
  ADD CONSTRAINT `finanziate_da_azienda_ibfk_2` FOREIGN KEY (`id_sponsor_azienda`) REFERENCES `sponsor_aziende` (`ID_sponsor_azienda`);

--
-- Limiti per la tabella `finanziate_da_privato`
--
ALTER TABLE `finanziate_da_privato`
  ADD CONSTRAINT `finanziate_da_privato_ibfk_1` FOREIGN KEY (`id_barca`) REFERENCES `barche` (`ID_barca`),
  ADD CONSTRAINT `finanziate_da_privato_ibfk_2` FOREIGN KEY (`id_sponsor_privato`) REFERENCES `sponsor_privati` (`ID_sponsor_privato`);

--
-- Limiti per la tabella `gareggiano_in`
--
ALTER TABLE `gareggiano_in`
  ADD CONSTRAINT `gareggiano_in_ibfk_1` FOREIGN KEY (`id_barca`) REFERENCES `barche` (`ID_barca`),
  ADD CONSTRAINT `gareggiano_in_ibfk_2` FOREIGN KEY (`id_regata`) REFERENCES `regate` (`ID_regata`);

--
-- Limiti per la tabella `membri_equipaggio`
--
ALTER TABLE `membri_equipaggio`
  ADD CONSTRAINT `membri_equipaggio_ibfk_1` FOREIGN KEY (`id_barca`) REFERENCES `barche` (`ID_barca`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
