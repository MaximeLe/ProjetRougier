<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
	<c:if test="${not empty param.avis }">
		<script>
		$(document).ready(function(){
			openModalAvisClient();
		});
		</script>
	</c:if>
<div class="zAvis">
	<ul class="titre">
		<li><h2>Avis clients</h2></li>
		<c:if test="${ceDisplay.realisationStickers != null && (not empty ceDisplay.realisationStickers)}">
			<li><h2>idées de réalisation</h2></li>
		</c:if>
	</ul>
	
	<ul class="contenu">
		<li>
			<c:choose>
			<%-- Si j'ai au moins 1 avis --%>
			<c:when test="${(!empty (ceDisplay.globalRating))}">
				<ul class="rating">
					<fmt:formatNumber maxFractionDigits="2" var="rating" value="${ceDisplay.globalRating}" scope="request" />
					<c:set var="betweenLi" value="true" scope="request"/>
					<c:set var="ratingInPageProduct" value="true" scope="request"/>
					<li class="txt"><span class="bold">Note des clients</span> (${ceDisplay.summaryCount} <spring:message code="catalogue.avis"/>)</li>
					<c:import url="showRatingFacet.jsp" />
				</ul>
				<div class="avis">
					<c:import url="showReview.jsp" />
					<a style="cursor: pointer;" onclick="openModalAvisClient();"><spring:message code="catalogue.donnerAvis"/></a>
				</div>
			</c:when>
			
			<%-- Si je n'ai aucun d'avis' --%>
			<c:otherwise>
				<div class="avis">
					<c:if test="${ceDisplay.realisationStickers != null && (not empty ceDisplay.realisationStickers)}">
						<input type="hidden" id="realisationStickers" value="TRUE"/>
					</c:if>
					<a style="cursor: pointer;" onclick="openModalAvisClient();"><spring:message code="catalogue.soyezLePremier"/></a>
				</div>
			</c:otherwise>
		</c:choose>
		</li>
		<c:if test="${ceDisplay.realisationStickers != null && (not empty ceDisplay.realisationStickers)}">
		<li>
				<c:forEach items="${ceDisplay.realisationStickers}" var="realisationSticker" varStatus="realisationStickerStatus">
				<div class="idee">
					<span class="bold">${realisationSticker.stickerDescriptions[langId].wording}</span>
					<c:choose>
						<c:when test="${not empty realisationSticker.stickerDescriptions[langId].picture1}">
							<div class="alignCenter"><img alt="${realisationSticker.stickerDescriptions[langId].wording}" src="${mediaPath}/${realisationSticker.stickerDescriptions[langId].picture1}"></div>
						</c:when>
						<c:otherwise>
							<br/>
						</c:otherwise>
					</c:choose>
					<span>${realisationSticker.stickerDescriptions[langId].text1}</span><br/><br/>
					<c:if test="${realisationSticker.stickerDescriptions[langId].text2 != null && realisationSticker.stickerDescriptions[langId].text2 != ''}">
						<a href="${realisationSticker.stickerDescriptions[langId].text2}" target="_blank"">En savoir +</a>
					</c:if>
				</div>
				</c:forEach>
		</li>
		</c:if>
	</ul>
</div>