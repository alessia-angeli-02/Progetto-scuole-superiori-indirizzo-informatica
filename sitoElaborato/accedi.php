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
	<title>ACCEDI</title>
	<link rel="stylesheet" href="stile_accedi.css?ts=<?=time()?>&quot">
	<script>
	function mostraPassword() {
		var x = document.getElementById("p3");
		var y = document.getElementById("hide1");
		var z = document.getElementById("hide2");
		if (x.type === "password") {
			x.type = "text";
			y.style.display="block";
			z.style.display="none";
		} else {
			x.type = "password";
			y.style.display="none";
			z.style.display="block";
		}
	}
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
<body>
	<?php
	if(isset($_POST['username'])&&isset($_POST['password'])){
		$errori="";
		if(empty($_POST['username'])){
			$errori=$errori."Manca lo username ";
		}
		if(empty($_POST['password'])){
			$errori=$errori." Manca la password";
		}
		if($errori!=""){
			echo "<script> alert('$errori');window.location='accedi.php';</script>";
		}else{
			require_once('database.php');
			$username=$_POST['username'];
			$query = "SELECT * FROM utenti WHERE username='$username'";
			$risultato = mysqli_query($connessione,$query);
			if(mysqli_num_rows($risultato)==0){
				$errori=$errori."Questo username non esiste<br>";
			}else{
				$t = $risultato->fetch_array(MYSQLI_ASSOC);
				if(!password_verify($_POST['password'],$t['password'])){
					$errori=$errori."Password errata";
				}
			}
			if($errori!=""){
				echo "<script> alert('$errori');window.location='accedi.php';</script>";
			}else{
				session_start();
				$_SESSION["username"] = $t['username'];
				header("Location: inserisci_risultati.php");
			}
		}
	}
	?>

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
				<form action="<?php echo $_SERVER['PHP_SELF']?>" method="POST">
					<div class="login-box">
						<h1>Login</h1>
						<div class="textbox">
							<i class="fas fa-user" aria-hidden="true"></i>
							<input type="text"placeholder="Username" name="username" pattern="[A-Za-z0-9]+">
						</div>
						<div class="textbox">
							<i class="fas fa-lock"></i>
							<input type="password"placeholder="Password"id="p3" name="password" pattern="[A-Za-z0-9]+">
							<span class="eye">
								<i id="hide1"class="fa fa-eye" onclick="mostraPassword()"> </i>
								<i id="hide2"class="fa fa-eye-slash" onclick="mostraPassword()"></i>
							</span>
						</div>
						<input  class="submit"type="submit"value="Accedi">
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
