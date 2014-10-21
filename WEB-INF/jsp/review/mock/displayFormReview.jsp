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

<div id="corps"><a
	href="?action=displayReviews&classId=${classId}&objectInstanceId=${objectInstanceId}&subClassId=${subClassId}&langueId=${langueId}&finderType=random">
Retour à la page d'affichage des avis</a>
<center><img
	src="${contextPath}/resources/fr_FR/img/review/class=${classId}subClass=${subClassId}objectInstance=${objectInstanceId}.jpg"
	height=350 /></center>

<br />
<form name="formReview" action="?action=displayPostFormReview"
	method="post" ACCEPT-CHARSET="ISO-8859-1"><input type="hidden"
	name="objectInstanceId" value="${objectInstanceId }" /> <input
	type="hidden" name="classId" value="${classId }" /> <input
	type="hidden" name="subClassId" value="${subClassId }" /> <input
	type="hidden" name="langueId" value="${langueId }" /> <input
	type="hidden" name="generalCommentCriterionId"
	value="${generalCommentCriterion.id }" />
<h4>Informations générales</h4>
<table id="civilite">
	<tr id="form">
		<td>Titre de la review</td>
		<td><input type="text" name="title" /></td>
	</tr>
	<tr id="form">
		<td>Pseudonym</td>
		<td><input type="text" name="pseudonym" /></td>
	</tr>
	<tr id="form">
		<td>Adresse email</td>
		<td><input type="text" name="email" /> <br />
		</td>
	</tr>
</table>

<br />

<h4>Notation générale</h4>


<table id="generalRating">
	<tr id="form">
		<td>Note générale du produit</td>
		<td><select name="generalRating">
			<option value="null" selected>Je ne répond pas</option>
			<c:forEach items="${generalRatingCriterions.optionOrNotes}" var="grc">
				<option value="${grc.id}">${grc.optionOrNoteDescription.text
				}</option>
			</c:forEach>
		</select></td>
	</tr>
</table>
<br />
<h4>Commentaire general</h4>
<table id="generalComment">
	<tr id="form">
		<td>Commentaire général</td>
		<td><textarea name="comment" rows="10" cols="50"></textarea></td>
	</tr>
</table>
<br />




<h4>Commentaires et Notations sur critères</h4>
<table id="commentCriterion">
	<thead>
		<tr>
			<td>Critère</td>
			<td>Commentaire</td>
			<td>Notation</td>
		</tr>
	</thead>
	<c:forEach items="${ratingOrCommentCriterions}" var="criterion">
		<tr id="form">
			<td>${criterion.criterionDescription.text}</td>
			<td><c:if test="${criterion.hasComment==true}">
				<input type="hidden" name="commentCriterion" value="${criterion.id}" />
				<textarea name="commentCriterions${criterion.id}" rows="2" cols="40"></textarea>
			</c:if></td>
			<td><c:if test="${criterion.hasRating==true}">
				<c:if test="${!empty criterion.optionOrNotes}">
					<select name="rating">
						<option value="null" selected>Je ne répond pas</option>
						<c:forEach items="${criterion.optionOrNotes}" var="optionOrNote">
							<option value="${optionOrNote.id}">${optionOrNote.optionOrNoteDescription.text}</option>
						</c:forEach>
					</select>
				</c:if>
			</c:if></td>


		</tr>
	</c:forEach>
</table>
<br />
<h4>Recommandations sur critères</h4>
<table id="recommendations">
	<c:forEach items="${recoCriterions}" var="recoCriterion">
		<tr id="form">
			<td>${recoCriterion.criterionDescription.text}<input
				type="hidden" name="recoCriterions" value="${recoCriterion.id}" /></td>
			<td><c:forEach items="${recoCriterion.optionOrNotes}"
				var="optionOrNote">
				<input type="checkbox" name="recommendation"
					value="${optionOrNote.id}" />${optionOrNote.optionOrNoteDescription.text}<br />
			</c:forEach><br />
			<b>Autre...</b><br />
			<input type="text" name="userRecommendation${recoCriterion.id }"></input>
			<br />

			</td>
		</tr>
	</c:forEach>
</table>
<br />
<br />
<table>
	<tr id="form">
		<td><input type="submit" /></td>
	</tr>
</table>


</form>

<br />
<center><img
	src="${contextPath}/resources/fr_FR/img/review/logo_pictime.gif" /></center>
<br />
<br />
</div>
</body>
</html>






