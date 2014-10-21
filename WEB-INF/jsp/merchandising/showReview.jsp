<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:forEach items="${ceDisplay.reviews}" var="review">
<div itemprop="reviews" itemscope itemtype="http://schema.org/Review">
	<!-- Obsolete : <spring:message code="catalogue.commentaireDe"/> (${review.email})-->
	<h3 class="auteur" itemprop="author">${review.pseudonym}</h3>
	<ul class="rating" itemprop="reviewRating" itemscope itemtype="http://schema.org/Rating">
		<c:if test="${!empty review.generalRating.value}">
		<c:forEach begin="1" end="5" var="nb">
			<c:choose>
				<c:when test="${nb <= review.generalRating.value}">
					<li><img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/starF.png" width="12" height="11" border="0" alt=""/></li>
				</c:when>
				<c:otherwise>
					<li><img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/starE.png" width="12" height="11" border="0" alt=""/></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		</c:if>
		<li class="displayNone" itemprop="ratingValue"><!-- Inserer ici la note --></li>
	</ul>

	<div class="commentaire" itemprop="description">
		${review.generalComment.text}
<!-- 	Obsolete -->
<%-- 		<c:if test="${!empty review.ratingAndCommentCouple}"> --%>
<!-- 			<div class="avis_separation"> -->
<%-- 				<c:forEach items="${review.ratingAndCommentCouple}" var="r"> --%>
<%-- 					<p class="gauche2"><strong>${r.criterion.criterionDescription.text}</strong> : --%>
<%-- 						<c:if test="${!r.criterion.recoUsage && !empty r.rating.value}"> --%>
<%-- 							<c:forEach begin="1" end="5" var="nb"> --%>
<%-- 								<c:choose> --%>
<%-- 									<c:when test="${nb <= r.rating.value}"> --%>
<%-- 										<img src="${contextPath}/resources/${codeIsoLang}/img/StarterStore/Etoile_orange.png" width="13" alt="" /> --%>
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
<%-- 										<img src="${contextPath}/resources/${codeIsoLang}/img/StarterStore/Etoile_grise.png" width="13" alt="" /> --%>
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose> --%>
<%-- 							</c:forEach> --%>
<%-- 						</c:if> --%>
<%-- 						${r.comment.text} --%>
<!-- 					</p> -->
<%-- 				</c:forEach> --%>
<!-- 			</div> -->
<%-- 		</c:if> --%>
<%-- 		<span class="avis_titre2">${review.title}</span> --%>
<%-- 		<span class="gras"><spring:message code="catalogue.commentaireGeneral"/></span><br /> --%>
<%-- 		${review.generalComment.text}<br /><br /> --%>
<%-- 		<c:if test="${!empty review.recommendations}"> --%>
<!-- 			<span class="gras">Recommandations :</span><br /> -->
<%-- 			<c:forEach items="${review.recommendations}" var="reco"> --%>
<%-- 				${reco.criterion.criterionDescription.text} : <i>${reco.optionOrNoteDescription.text}</i><br/> --%>
<%-- 			</c:forEach> --%>
<%-- 		</c:if> --%>
	</div>
</div>
</c:forEach>
