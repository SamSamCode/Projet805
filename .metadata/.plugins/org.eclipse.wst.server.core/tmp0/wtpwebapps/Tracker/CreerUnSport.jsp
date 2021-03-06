<!DOCTYPE html>
<html>
<head>
<title>CreationSport</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" media="screen" type="text/css" title="mon style"
	href="MenuHorizontal2.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/main.css" />
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


	<link rel="stylesheet" href="leaflet/leaflet.css">
	<script src="leaflet/leaflet.js"></script>
	<link rel="stylesheet" href="src/Leaflet.GraphicScale.min.css">
	<link rel="stylesheet" href="src/stylesheet.css">

</head>
<body>
	<div id="page">
		<div id="banniere_image">
			<h1>Creation Tracker</h1>
		</div>
		<jsp:include page="header.jsp" />

		<form action="CreerSport" method="post">
			<div id="corps">
				<h3>Espace de creation</h3>
				<label for="nomSport"><strong>Nom du sport</strong></label> <input
					type="text" placeholder="Nom du sport" name="nomSport" required>
				<br /> <br />
				<button type="submit">Ajout</button>
			</div>
		</form>
		
		<div id="map"></div>

		<jsp:include page="footer.html" />
	</div>



	<script src="src/Leaflet.GraphicScale.min.js"></script>
	<script src="https://api.mapbox.com/mapbox.js/plugins/leaflet-omnivore/v0.2.0/leaflet-omnivore.min.js"></script>
	<script>
		function getUrlParameter(name) {
			name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
			var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
			var results = regex.exec(location.search);
			return (results === null) ? '' : decodeURIComponent(results[1]
					.replace(/\+/g, ' '));
		};

		function highlightFeature(e) {
			var layer = e.target;

			layer.setStyle({
				weight : 5,
				color : '#666',
				dashArray : '10 10',
				fillOpacity : 0.7
			});

			if (!L.Browser.ie && !L.Browser.opera && !L.Browser.edge) {
				layer.bringToFront();
			}
		}

		function resetHighlight(e) {
			customLayer.resetStyle(e.target);
		}

		var Marker = L.icon({
			iconUrl : 'Point.png',

			iconSize : [ 27, 32 ], // size of the icon
			iconAnchor : [ 13, 32 ], // point of the icon which will correspond to marker's location
			popupAnchor : [ 0, -30 ]
		// point from which the popup should open relative to the iconAnchor
		});
		var Lon = getUrlParameter('Lon')
		var Lat = getUrlParameter('Lat')
		var starts = new L.LayerGroup();
		L.marker([ Lat, Lon ], {
			icon : Marker
		}).bindPopup(Lat + '<br>' + Lon).addTo(starts);

		// ****************** change colors sequentially  *****************

		var colors = [ '#3388ff', '#800000', '#9a6324', '#808000', '#469990',
				'#000075', '#000000', '#e6194b', '#f58231', '#ffe119',
				'#bfef45', '#3cb44b', '#42d4f4', '#4363d8', '#911eb4',
				'#f032e6', '#a9a9a9',
				//'#fabed4',	Pink
				//'#ffd8b1',	Apricot
				//'#fffac8',	Beige
				//'#aaffc3',	Mint
				'#dcbeff',
		//'#ffffff'	White
		];

		var n = 0;
		var customLayer = L.geoJson(null, {
			style : function(feature) {
				if (!feature.properties.id) {
					feature.properties.id = n++;
				}
				var iColor = feature.properties.id % colors.length;
				return {
					color : colors[iColor]
				};
			},
			onEachFeature : function(feature, layer) {
				if (feature.properties.desc) {
					layer.bindPopup(feature.properties.desc);
				}
				layer.on({
					mouseover : highlightFeature,
					mouseout : resetHighlight
				});
			}

		});

		var map = new L.LayerGroup();
		var runLayer = omnivore.gpx("../" + getUrlParameter('map'), null,
				customLayer).on('ready', function() {
			map.fitBounds(runLayer.getBounds());
		}).addTo(map);

		var Time = "";
		var Lat = "";
		var Lon = "";
		var i = 0;
		while ((Dist = getUrlParameter("D" + i)) != "") {
			Time = getUrlParameter("T" + i);
			Time = Math.floor(Time / 60) + "h"
					+ (Time % 60).toString().padStart(2, "0");
			Lon = getUrlParameter("Lon" + i);
			Lat = getUrlParameter("Lat" + i)
			var marker = new L.marker([ Lat, Lon ], {
				opacity : 0
			});
			marker.bindTooltip(Dist + "km<br>" + Time, {
				permanent : true,
				offset : [ -15, 25 ]
			});
			marker.addTo(map);
			i++;
			Dist = getUrlParameter("D" + i);
		}

		var osmLink = '<a href="https://openstreetmap.org">OpenStreetMap</a>';
		var osmUrl = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', osmAttrib = '&copy; '
				+ osmLink + ' Contributors';
		var mbAttr = 'Map data &copy; <a href="https://openstreetmap.org">OpenStreetMap</a> contributors, '
				+ '<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, '
				+ 'Imagery ?? <a href="https://mapbox.com">Mapbox</a>', mbUrl = 'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiamFudXMwMDciLCJhIjoiY2l0azNvNjZlMDAzbTQ2bGk0dDFtaGhzcCJ9.8GAQYGpMFog62mRv17pGtA';

		var osmMap = L.tileLayer(osmUrl, {
			attribution : osmAttrib
		}), satellite = L.tileLayer(mbUrl, {
			id : 'mapbox.satellite',
			attribution : mbAttr
		});

		var Stamen_Terrain = L
				.tileLayer(
						'https://stamen-tiles-{s}.a.ssl.fastly.net/terrain/{z}/{x}/{y}.{ext}',
						{
							attribution : 'Map tiles by <a href="http://stamen.com">Stamen Design</a>, <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a> &mdash; Map data &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>',
							subdomains : 'abcd',
							ext : 'png'
						});
		var standard = L
				.tileLayer(
						'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png',
						{
							attribution : 'Map data: &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>, <a href="http://viewfinderpanoramas.org">SRTM</a> | Map style: &copy; <a href="https://opentopomap.org">OpenTopoMap</a> (<a href="https://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA</a>)',
							maxZoom : 18
						});

		var map = L.map('map', {
			layers : [ osmMap, starts, map ],
		}).setView([ 49.21, 4.2 ], 8);

		var baseLayers = {
			"OpenStreetMap" : osmMap,
			"OpenTopoMap" : standard,
			"3D map" : Stamen_Terrain,
			"satellite" : satellite,
		};

		L.control.layers(baseLayers).addTo(map);

		var graphicScale = L.control.graphicScale({
			position : 'bottomright',
			fill : 'hollow',
		}).addTo(map);
		
		
	</script>
	
	<script type="text/javascript">
/* 	var map = L.map('map').setView([51.505, -0.09], 13);

	L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
	    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
	}).addTo(map);

	L.marker([51.5, -0.09]).addTo(map)
	    .bindPopup('A pretty CSS3 popup.<br> Easily customizable.')
	    .openPopup(); */
	</script>

</body>
</html>