<?php
	session_start();
  include("database.php");
	if($_SESSION["username"]!=null){
    $barca=$_POST['barca'];
    $regata=$_POST['regata'];
    $punteggio=$_POST['punteggio'];
    $query = "INSERT INTO `gareggiano_in`(`id_barca`, `id_regata`, `Punteggio`) VALUES ('$barca','$regata','$punteggio')";
    if (!$connessione -> query($query)) {
      echo("Errore: " . $connessione -> error);
    }
    echo "<script> alert('Inserimento avvenuto con successo!');window.location='inserisci_risultati.php';</script>";
    }else{
			echo "<script> alert('Non possiedi i permessi necessari');window.location='accedi.php';</script>";
  }
?>
