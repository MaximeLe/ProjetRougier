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
<div id="corps"><a href="?action=displayMenu">Retour au menu
général</a>

<center><img
	src="${contextPath}/resources/fr_FR/img/review/class=${classId}subClass=${subClassId}objectInstance=${objectInstanceId}.jpg"
	height=350 /></center>
<br />

<table align="center">
	<tr>
		<td colspan="2">
		<h3>Statistiques globales</h3>
		</td>
	</tr>
	<tr>
		<td><b>Moyenne des notes générales</b></td>
		<td>${generalAvg}/5</td>
	</tr>
	<tr>
		<td><b>Nombre d'avis</b></td>
		<td>${count}</td>
	</tr>
</table>

<br />
<br />
<br />
</div>
<br />
<div id="corps2">
<ul id="tabnav">
	<li><a
		href="?action=displayReviews&classId=${classId}&objectInstanceId=${objectInstanceId}&subClassId=${subClassId}&langueId=${langueId}&finderType=random">Affichage
	complet des avis</a></li>
	<li class="active"><a href="#">Affichage des recommendations</a></li>
	<li><a
		href="?action=displayReviews&classId=${classId}&objectInstanceId=${objectInstanceId}&subClassId=${subClassId}&langueId=${langueId}&finderType=random&view=commentAndRating">Affichage
	des commentaires et notes</a></li>

</ul>
<br />
<br />

<table>
	<thead>
		<tr>
			<td colspan="2"><b>Tris</b></td>
		</tr>
	</thead>
	<tr>
		<td><a
			href="?action=displayReviews&classId=${classId}&objectInstanceId=${objectInstanceId}&subClassId=${subClassId}&langueId=${langueId}&finderType=random">
		5 Avis aléatoires</a></td>
		<td><a
			href="?action=displayReviews&classId=${classId}&objectInstanceId=${objectInstanceId}&subClassId=${subClassId}&langueId=${langueId}&finderType=date">
		Tri par date</a><br />
		</td>
	</tr>
</table>
<br />
<a
	href="?action=displayFormReview&classId=${classId}&objectInstanceId=${objectInstanceId}&subClassId=${subClassId}&langueId=${langueId}">
<img src="${contextPath}/resources/fr_FR/img/review/addReviewButton.JPG" />
</a> <br />
<br />
<br />
<br />
<center><c:forEach items="${reviews}" var="review">
	<c:if test="${!empty review.recommendations}">
		<table>
			<thead>
				<tr>
					<td colspan="3" align="center">
					<center><b>"${review.title}"</b></center>
					</td>
				</tr>
			</thead>
			<tr id="form">
				<td BGCOLOR="#C6E8FF">Les recommandations de :<br />
				<b>${review.pseudonym}</b><br />
				<i>(${review.email})</i></td>
				<td colspan="2" align="center"><c:forEach
					items="${review.recommendations}" var="reco">
			${reco.criterion.criterionDescription.text} : <i>${reco.optionOrNoteDescription.text}</i><br/>
				</c:forEach></td>

			</tr>



			<tr>
		</table>
		<br />
		<br />
	</c:if>
</c:forEach></center>
<a
	href="?action=displayFormReview&classId=${classId}&objectInstanceId=${objectInstanceId}&subClassId=${subClassId}&langueId=${langueId}">
<img src="${contextPath}/resources/fr_FR/img/review/addReviewButton.JPG" />
</a> <br />
<center><img
	src="${contextPath}/resources/fr_FR/img/review/logo_pictime.gif" /></center>
<br />
<br />
</div>
</body>
</html>






