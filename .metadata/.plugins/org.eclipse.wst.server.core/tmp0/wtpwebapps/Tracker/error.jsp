
<%
HttpSession nsession = request.getSession(false);
if (nsession == null) {
	response.sendRedirect(request.getContextPath() + "/Connexion.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Performances</title>
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
			<h1>Performances</h1>
		</div>
	
	
		<jsp:include page="header.jsp" />
		
	
		<div id="corps">
			<h3>Une erreur est survenue</h3>
		</div>
		<jsp:include page="footer.html" /></div>
</body>
</html>