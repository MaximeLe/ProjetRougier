<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${contextPath}/resources/fr_FR/css/review.css"
	type="text/css" rel="stylesheet">
<title>${productName } - StarterStore Avis des internautes</title>
</head>
<body>
<jsp:include page="header.jsp" />
<div id="corps"><a href="?action=displayMenu">Retour au menu
général</a>

<center><img
	src="${contextPath}/resources/fr_FR/img/review/class=${classId}subClass=${subClassId}objectInstance=${objectInstanceId}.jpg"
	height=350 /></center>
<br />
<div xmlns:v="http://rdf.data-vocabulary.org/#"
	typeof="v:Review-aggregate"><span property="v:itemreviewed">${productName
} </span>


<table align="center">
	<tr>
		<td colspan="2">
		<h3>Statistiques globales</h3>
		</td>
	</tr>
	<tr>
		<td><b>Moyenne des notes générales</b></td>
		<td><span rel="v:Rating"><span property="v:average">${generalAvg}</span>/<span
			property="v:best">5</span></span></td>
	</tr>
	<tr>
		<td><b>Nombre d'avis</b></td>
		<td><span property="v:votes">${count}</span><span
			property="v:count" style="display: none">${count}</span></td>
	</tr>
</table>
</div>
<br />
<br />
<br />
</div>
<br />
<div id="corps2">
<ul id="tabnav">
	<li class="active"><a href="#">Affichage complet des avis</a></li>
	<li><a
		href="?action=displayReviews&classId=${classId}&objectInstanceId=${objectInstanceId}&subClassId=${subClassId}&langueId=${langueId}&finderType=random&view=reco">Affichage
	des recommendations</a></li>
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



<c:if test="${!empty nbPages}">
Page <c:forEach var="i" begin="1" end="${nbPages}">
		<a
			href="?action=displayReviews&classId=${classId}&objectInstanceId=${objectInstanceId}&subClassId=${subClassId}&langueId=${langueId}&finderType=date&page=${i}">${i}</a>
	</c:forEach>
</c:if>
<br /><br />



<center><c:forEach items="${reviews}" var="review">


	<table>
		<thead>
			<tr>
				<td colspan="3" align="center">
				<center><b>"${review.title}"</b></center>
				</td>
			</tr>
		</thead>
		<tr id="form">
			<td BGCOLOR="#C6E8FF">Commentaire de :<br />
			<b>${review.pseudonym}</b><br />
			<i>(${review.email})</i></td>
			<td colspan="2" align="center"><img
				src="${contextPath}/resources/fr_FR/img/review/${review.generalRating.value}.bmp"
				width="200" height="50" /><br />
			<div style="display: none">${review.generalRating.value }</div>
			Moyenne des notations sur critères : ${review.averageCriterionRating }
			</td>

		</tr>

		<c:if test="${!empty review.ratingAndCommentCouple}">

			<tr>
				<td colspan="3"><c:forEach
					items="${review.ratingAndCommentCouple}" var="r">
					<b>${r.criterion.criterionDescription.text} : </b>

					<c:if test="${!empty r.rating.value}">
						<img
							src="${contextPath}/resources/fr_FR/img/review/${r.rating.value}.bmp" />
					</c:if>
						
						${r.comment.text }
					<br />
				</c:forEach></td>
			</tr>
		</c:if>
		<c:if test="${!empty review.generalComment.text}">
			<tr>
				<td colspan="3" id="form"><b>Commentaire général de
				${review.pseudonym} : </b><br />
				${review.generalComment.text }</td>
			</tr>
		</c:if>
		<c:if test="${!empty review.recommendations}">
			<tr>
				<td colspan="3"><b>Les recommandations de
				${review.pseudonym}</b><br />
				<c:forEach items="${review.recommendations}" var="reco">
			${reco.criterion.criterionDescription.text} : <i>${reco.optionOrNoteDescription.text}</i>
					<br />
				</c:forEach></td>
			</tr>
		</c:if>
		<tr>
	</table>

	<br />
	<br />
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






