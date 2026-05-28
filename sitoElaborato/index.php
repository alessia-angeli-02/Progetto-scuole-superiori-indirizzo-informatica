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
		<title>PAGINA INIZIALE</title>
		<link rel="stylesheet" href="stile_index.css?ts=<?=time()?>&quot">
		<script>
		  function apriMenu(){
				document.getElementById('menu').style.width='250px';
				document.getElementById('content').style.marginLeft='250px';
			}
			function chiudiMenu(){
				document.getElementById('menu').style.width='0';
				document.getElementById('content').style.marginLeft='0';
			}
    let map;
	  const bermuda = { lat: 32.3191775, lng: -64.7670827 };
	  const newYork = { lat: 40.730610, lng: -73.935242 };
	  const auckland = { lat: -36.848461, lng: 174.763336 };
	  const sanFrancisco = { lat: 37.773972, lng: -122.431297 };
	  const wateimataHarbour = { lat: -35.688604, lng:  174.475964 };
	  const BOUNDS = {
			north: 42.60560282680911,
		  south: -47.706120342558364,
		  west: 118.75111800000002,
		  east: -16.248882000000005,
	  };
	  const immagine ="https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png";
      function initMap() {
        map = new google.maps.Map(document.getElementById("map"), {
          center: { lat: -3.617671, lng: -128.748882 },
          zoom: 2,
		  restriction: {
			  latLngBounds: BOUNDS,
			  strictBounds: false,
			},
		  mapTypeId: google.maps.MapTypeId.SATELLITE,
		  disableDefaultUI: true,
        });
		const marker1 = new google.maps.Marker({
		  animation: google.maps.Animation.BOUNCE,
          position: bermuda,
		  icon: immagine,
		  title: 'Bermuda',
          map: map,
        });
		const marker2 = new google.maps.Marker({
		  animation: google.maps.Animation.BOUNCE,
          position: newYork,
		  icon: immagine,
		  title: 'New Tork',
          map: map,
        });
		const marker3 = new google.maps.Marker({
		  animation: google.maps.Animation.BOUNCE,
          position: sanFrancisco,
		  icon: immagine,
		  title: 'San Francisco',
          map: map,
        });
		const marker4 = new google.maps.Marker({
		  animation: google.maps.Animation.BOUNCE,
          position: auckland,
		  icon: immagine,
		  title: 'Auckland',
          map: map,
        });
		const marker5 = new google.maps.Marker({
		  animation: google.maps.Animation.BOUNCE,
          position: wateimataHarbour,
		  icon: immagine,
		  title: 'Wateimata',
          map: map,
        });
		const infowindow1 = new google.maps.InfoWindow({
		  content: 'Bermuda',
		});
		marker1.addListener("click", () => {
		  infowindow1.open(map, marker1);
		});
		const infowindow2 = new google.maps.InfoWindow({
		  content: 'New York',
		});
		marker2.addListener("click", () => {
		  infowindow2.open(map, marker2);
		});
		const infowindow3 = new google.maps.InfoWindow({
		  content: 'San Francisco',
		});
		marker3.addListener("click", () => {
		  infowindow3.open(map, marker3);
		});
		const infowindow4 = new google.maps.InfoWindow({
		  content: 'Auckland',
		});
		marker4.addListener("click", () => {
		  infowindow4.open(map, marker4);
		});
		const infowindow5 = new google.maps.InfoWindow({
		  content: 'Wateimata Harbour',
		});
		marker4.addListener("click", () => {
		  infowindow5.open(map, marker5);
		});
      }
    </script>
	</head>
	<body>
		<div id="content">
			<span class="slide">
				<a href="#" onclick="apriMenu()">
					<i class="fas fa-bars"></i>
				</a>
			</span>
			<div id="menu"class="nav">
				<a href="#" class="close"onclick="chiudiMenu()">
					<i class="fas fa-times"></i>
				</a>
				<a href="index.php">Home</a>
				<a href="accedi.php">Accedi</a>
			</div>
			<div class="hero">
				<div class="hero__content">
					<p class="intro-text">Classifiche e location degli eventi</p>
					<h1 class="big-text">AMERICA'S CUP - HOME</h1>
				</div>
				<img src="barca.png" id="video-back">
			</div>
			<div class="poster mt-3">
				<div class="poster__content">
					<h3 class="big-text">RISULTATI DELLE ELIMINATORIE & MAPPA INTERATTIVA</h3>
					<?php
						include('database.php');
						$query = "SELECT b.Nazionalità AS Nazione, SUM(g.Punteggio) AS Punteggio_eliminatorie FROM barche b, regate r, gareggiano_in g WHERE b.ID_barca=g.id_barca AND r.ID_regata=g.id_regata AND r.Turno='Eliminatoria' GROUP BY b.Nazionalità ORDER BY Punteggio_eliminatorie ASC";
						$result = mysqli_query($connessione,$query);
						echo "<table><tr><th>POSIZIONE</th><th>NAZIONE</th><th>PUNTEGGIO</th><tr>";
						$posizione=1;
						foreach($result as $row){
							$nazione=$row['Nazione'];
							$punteggio=$row['Punteggio_eliminatorie'];
							echo "<tr><td>$posizione"."º</td><td>$nazione</td><td>$punteggio</td>";
							$posizione++;
						}
						echo "</table>";
					?>
					<div id="map"></div>
			    <script
			      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBjCVPl9nWZ8X-bLrg3bzqJKLypnaDTDAg&callback=initMap&libraries=&v=weekly"
			      async
			    ></script>
				</div>
			</div>
		</div>
	</body>
	</html>
