<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${contextPath}/resources/fr_FR/css/review.css"
	type="text/css" rel="stylesheet">
<title>StarterStore Avis des internautes</title>
</head>

<body>

<jsp:include page="header.jsp" />

<div id="corps"><br />
<h2>Simulation de Produits et de Stores qui font l'objet d'avis</h2>
<br />
<br />
<i>(Il n'y a aucun rapport entre les produits et les stores de cet
exemple. C'est juste pour montrer qu'il est possible de saisir des avis
sur autre chose que des produits.)</i> <br />
<br />

<table id="test">
	<thead>
		<tr>
			<th>classId</th>
			<td colspan="2"><b>Produits</b>(classId=1)</td>
			<td colspan="2"><b>Stores</b>(classId=2)</td>
		</tr>
	</thead>
	<thead>
		<tr>
			<th>subClassId</th>
			<td><b>Jeux</b>(subClassId=1)</td>
			<td><b>Ecrans</b>(subClassId=2)</td>
			<td><b>Boutique normale</b>(subClassId=1)</td>
			<td><b>Boutique de location</b>(subClassId=2)</td>
		</tr>
	</thead>
	<tr>
		<th rowspan="2">ObjectInstanceId</th>
		<td><a
			href="?action=displayReviews&classId=1&objectInstanceId=1&subClassId=1&langueId=1&finderType=radom">Call
		of Duty 4</a>(id=1)</td>
		<td><a
			href="?action=displayReviews&classId=1&objectInstanceId=1&subClassId=2&langueId=1&finderType=radom">Samsung
		SyncMaster P2770</a>(id=1)</td>
		<td><a
			href="?action=displayReviews&classId=2&objectInstanceId=1&subClassId=1&langueId=1&finderType=radom">www.boutique.com</a>(id=1)</td>
		<td><a
			href="?action=displayReviews&classId=2&objectInstanceId=1&subClassId=2&langueId=1&finderType=radom">www.location.com</a>(id=1)</td>
	</tr>
	<tr>
		<td><a
			href="?action=displayReviews&classId=1&objectInstanceId=2&subClassId=1&langueId=1&finderType=radom">Starcraft
		2 Wings of Liberty</a>(id=2)</td>
		<td><a
			href="?action=displayReviews&classId=1&objectInstanceId=2&subClassId=2&langueId=1&finderType=radom">HP
		2710m 27" LCD Full HD</a>(id=2)</td>
		<td><a
			href="?action=displayReviews&classId=2&objectInstanceId=2&subClassId=1&langueId=1&finderType=radom">www.boutique2.com</a>(id=2)</td>
		<td><a
			href="?action=displayReviews&classId=2&objectInstanceId=2&subClassId=2&langueId=1&finderType=radom">www.locations2.com</a>(id=2)</td>
	</tr>
</table>


<br />
<br />
<br />
<br />
<br />

<center><img
	src="${contextPath}/resources/fr_FR/img/review/logo_pictime.gif" /></center>
<br />
<br />
</div>
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

</body>
</html>





