<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	    <!--reset del css-->
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css" integrity="sha512-NmLkDIU1C/C88wi324HBc+S2kLhi08PN5GDeUVVVC/BVt/9Izdsc9SVeVfA1UZbY3sHUlDSyRXhCzHfr6hmPPw==" crossorigin="anonymous" />
	    <!--stili di testo-->
	    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;700;900&display=swap" rel="stylesheet">
		<script src="https://kit.fontawesome.com/0b3c862c21.js" crossorigin="anonymous>"></script>
		<title>INSERISCI RISULTATI</title>
		<link rel="stylesheet" href="stile_inserisci_risultati.css?ts=<?=time()?>&quot">
		<script>
			function apriMenu(){
			  document.getElementById('menu').style.width='250px';
			  document.getElementById('content').style.marginLeft='250px';
			}
			function chiudiMenu(){
			  document.getElementById('menu').style.width='0';
			  document.getElementById('content').style.marginLeft='0';
			}
		</script>
	</head>
<?php
	session_start();
    include("database.php");
	if($_SESSION["username"]!=null){
    $query = "SELECT * FROM regate";
  	$result = $connessione->query($query);
    $query2 = "SELECT * FROM barche";
  	$result2 = $connessione->query($query2);
		  echo "
			<div id='content'>
				<span class='slide'>
					<a href='#' onclick='apriMenu()'>
						<i class='fas fa-bars'></i>
					</a>
				</span>
				<div id='menu'class='nav'>
					<a href='#' class='close'onclick='chiudiMenu()'>
						<i class='fas fa-times'></i>
					</a>
					<a href='index.php'>Home</a>
					<a href='accedi.php'>Accedi</a>
				</div>
			</div>
			<div class='hero'>
				<div class='hero__content'>
					<form action='aggiornamento.php' method='POST'>
						<div class='docente-box'>
							<h2>INSERISCI UN NUOVO RISULTATO</h2>
							<div class='select'>
								<label>Regata:</label>
									<select name='regata'>";
										foreach($result as $row){
										  echo "<option value=".$row['ID_regata'].">".$row['Turno']." - ".$row['Luogo']."</option>";
										}
									echo " </select>
							</div>
							<div class='select'>
  							  <label>Barca:</label>
								<select name='barca'>";
								  foreach($result2 as $row){
									echo "<option value=".$row['ID_barca'].">".$row['Nazionalità']." - ".$row['Modello']."</option>";
								  }
								echo "</select>
							</div>
							<div class='textarea'>
								<label>Punteggio:</label>
								<input type='number' step='1' name='punteggio' value='0' min='0'><br></div><div class='textarea'>
								<input class='submit' type='submit' value='INSERISCI PUNTEGGIO'>
							</div>
						</div>
					</form>
				</div>
			</div>";
    }else{
		echo "<script> alert('Non possiedi i permessi necessari');window.location='accedi.php';</script>";
  }
?>
