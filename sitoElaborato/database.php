<?php
	//mi connetto al server specificando: nome_host, username, password e nome_database
	$connessione=mysqli_connect("localhost","root","","americas_cup");

	if (mysqli_connect_errno()) { //se c'è un errore lo segnalo
	  echo "CONNESSIONE AL SERVER FALLITA: " . mysqli_connect_error();
	  exit();
	}
