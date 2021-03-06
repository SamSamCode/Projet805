<!DOCTYPE html>
<html>
<head>
<title>Accueil</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" media="screen" type="text/css" title="mon style"
	href="MenuHorizontal2.css">
<style>
body {
	margin-left: 0;
	margin-right: 0;
}

#page {
	min-height: 100%;
	width: 750px;
	margin-left: auto;
	margin-right: auto;
	padding: 1.5em;
	font-family: Calibri, Times New Roman, Arial, Verdana, Times, sans-serif;
	font-size: 1.1em;
	border-style: ridge;
	border-width: 5px;
	border-color: #FAAC58;
	background-color: rgb(200, 120, 25);
}

#footer {
	color: #FAAC58;
	text-align: center;
	font-family: Calibri, Times New Roman, Bookman Old Style, sans-serif;
	padding-top: 2px;
	padding-bottom: 2px;
	height: 20px;
}

#blocmenu {
	/* height: 36px; */
	font-size: 1.0em;
	font-family: Calibri, Times New Roman, Bookman Old Style, sans-serif;
	background-color: #585858;
	padding-left: 120px;
	display: flex;
	flex-wrap: wrap;
}

#menu {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
}

#menu li {
	float: left;
	list-style-type: none;
}

#menu li a, #menu li a:visited {
	padding: 10px;
	line-height: 35px;
	font-size: 18px;
	text-decoration: none;
	color: #FAAC58;
}

#menu li a:hover {
	background-color: #FAAC58;
	color: white;
}

#corps {
	padding: 1.0em;
	margin-top: 10px;
	padding-top: 2px;
	overflow: hidden;
	text-align: center;
	color: white;
}

#corps h2 {
	padding: 1.1em;
	margin-top: 10px;
	padding-top: 2px;
	overflow: hidden;
	text-align: center;
	font-size: 18px;
}

ul {
	list-style-type: none;
}

li {
	list-style-type: none;
}
</style>
</head>
<body>
	<div id="page">
		<div id="banniere_image">
			<h1>Accueil Tracker</h1>
		</div>

		<jsp:include page="header.jsp" />

		<div id="corps">
			<h3>Localisation</h3>
	
			<div id="map" style="height: 500px;"></div>
			
			<input type="submit" onclick="AddMarker(49.251329, 4.039696)" name="button" title="Ajouter un point GPS" value="Ajouter un point GPS d&eacute;placable" />
		</div>
		<jsp:include page="footer.html" />
	</div>


	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB41DRUbKWJHPxaFjMAwdrzWzbVKartNGg&callback=initMap&v=weekly"
		defer>
	</script>
	
	<script type="text/javascript">
 	let map;
	function initMap(latitude, longitude) {
	 if(latitude != null && longitude != null) {
		 latLng = {lat: latitude, lng:longitude}; 
	 } else {
		 latLng = { lat: 49.258329, lng: 4.031696 };
	 } 
		
	 map = new google.maps.Map(document.getElementById("map"), {
	   zoom: 13,
	   center: latLng,
	 });

	  new google.maps.Marker({
	    position: latLng,
	    map,
		draggable: true,
	    title: " ",
	  });
	}

	window.initMap = initMap;
	
	function AddMarker(latitude, longitude) {   
		let latLng;
		if(latitude != null && longitude != null) {
			 latLng = {lat: latitude, lng:longitude}; 
		 } else {
			 latLng = { lat: 49.958329, lng: 4.931696 };
		 } 

         let marker = new google.maps.Marker({
             position: latLng,
             map: map,
             draggable: true,
         });
     }
	</script>
</body>
</html>