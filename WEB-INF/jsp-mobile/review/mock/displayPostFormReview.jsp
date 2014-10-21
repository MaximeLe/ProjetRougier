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
<div id="corps">
<br/><br/>
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
<br />

<table>
	<tr>
		<td colspan="3" align="center">
		<h4><i>"${review.title}"</i></h4>
		</td>
	</tr>

	<tr id="form">
		<td BGCOLOR="#C6E8FF">Commentaire de :<br />
		<b>${review.pseudonym}</b><br />
		<i>(${review.email})</i></td>
		<td colspan="2" align="center"><img
			src="${contextPath}/resources/fr_FR/img/review/${review.generalRating.value}.bmp"
			width="200" height="50" /><br />
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
			${reco.criterion.criterionDescription.text} : <i>${reco.optionOrNoteDescription.text}</i><br/>
			</c:forEach></td>
		</tr>
	</c:if>
	<tr>
</table>

<br />
<center><img
	src="${contextPath}/resources/fr_FR/img/review/logo_pictime.gif" /></center><br/><br/>
	</div>
	</body>
</html>






