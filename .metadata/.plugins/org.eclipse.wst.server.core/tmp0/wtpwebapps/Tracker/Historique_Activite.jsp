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

	<!-- Source: https://wiki.openstreetmap.org/wiki/Openlayers_Track_example -->
	<title>Simple OSM GPX Track</title>
	<!-- bring in the OpenLayers javascript library
		 (here we bring it from the remote site, but you could
		 easily serve up this javascript yourself) -->
	<script src="http://www.openlayers.org/api/OpenLayers.js"></script>
	<!-- bring in the OpenStreetMap OpenLayers layers.
		 Using this hosted file will make sure we are kept up
		 to date with any necessary changes -->
	<script src="https://www.openstreetmap.org/openlayers/OpenStreetMap.js"></script>

	<script type="text/javascript">

		var map; //complex object of type OpenLayers.Map

		function init() {
			map = new OpenLayers.Map ("map", {
				controls:[
					new OpenLayers.Control.Navigation(),
					new OpenLayers.Control.PanZoomBar(),
					new OpenLayers.Control.LayerSwitcher(),
					new OpenLayers.Control.Attribution()],
				maxExtent: new OpenLayers.Bounds(-20037508.34,-20037508.34,20037508.34,20037508.34),
				maxResolution: 156543.0399,
				numZoomLevels: 19,
				units: 'm',
				projection: new OpenLayers.Projection("EPSG:900913"),
				displayProjection: new OpenLayers.Projection("EPSG:4326")
			} );

			// Define the map layer
			// Here we use a predefined layer that will be kept up to date with URL changes
			layerMapnik = new OpenLayers.Layer.OSM.Mapnik("Mapnik");
			map.addLayer(layerMapnik);
			layerCycleMap = new OpenLayers.Layer.OSM.CycleMap("CycleMap");
			map.addLayer(layerCycleMap);
			layerMarkers = new OpenLayers.Layer.Markers("Markers");
			map.addLayer(layerMarkers);

			// Add the Layer with the GPX Track
			var lgpx = new OpenLayers.Layer.Vector("Lakeside cycle ride", {
				strategies: [new OpenLayers.Strategy.Fixed()],
				protocol: new OpenLayers.Protocol.HTTP({
					url: "220604V.gpx",
					format: new OpenLayers.Format.GPX()
				}),
				style: {strokeColor: "green", strokeWidth: 5, strokeOpacity: 0.5},
				projection: new OpenLayers.Projection("EPSG:4326")
			});
			map.addLayer(lgpx);
			/* const vectorLayer = new VectorLayer({
			  background: '#1a2b39',
			  source: new VectorSource({
			    url: '220604V.gpx',
			    format: new OpenLayers.Format.GPX(),
			  }),
			  style: function (feature) {
			    const color = feature.get('COLOR') || '#eeeeee';
			    style.getFill().setColor(color);
			    return style;
			  },
			});
		map.addLayer(vectorLayer); */

			// Add a Layer with Marker
			var size = new OpenLayers.Size(21, 25);
			var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
			var icon = new OpenLayers.Icon('https://www.openstreetmap.org/openlayers/img/marker.png',size,offset);
			layerMarkers.addMarker(new OpenLayers.Marker(lonLat,icon));

			// Start position for the map (hardcoded here for simplicity,
			// but maybe you want to get this from the URL params)
			var lat=47.496792;
			var lon=7.571726;
			var zoom=13;
			var lonLat = new OpenLayers.LonLat(lon, lat).transform(new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject());
			map.setCenter(lonLat, zoom);
		}
	</script>

</head>
<!-- body.onload is called once the page is loaded (call the 'init' function) -->
<body onload="init();">
	<!-- define a DIV into which the map will appear. Make it take up the whole window -->
	

	<div id="page">
		<div id="banniere_image">
			<h1>Accueil Tracker</h1>
		</div>

		<jsp:include page="header.jsp" />

		<div id="corps">
			<h3>Historique</h3>

	
			<div id="map" style="height: 500px;width:700px;"></div>
			
			<input type="submit" onclick="AddMarker(49.251329, 4.039696)" name="button" title="Ajouter un point GPS" value="Ajouter un point GPS d&eacute;placable" />
		</div>
		<jsp:include page="footer.html" />
	</div>



</body>
</html>
