<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="carac">
<ul>
	<c:forEach items="${ceDisplay.catalogEntry.schemaBiz.schemaNodes}" var="schemaNode">
		<c:if test="${schemaNode.wording == 'Descriptif'}">
			<c:forEach items="${schemaNode.schemaAttributeNodes}" var="schemaAttributeNode">
	<li><span class="bold">${schemaAttributeNode.attribute.attributeDescriptions[langId].description} :</span>&nbsp;
				<c:forEach items="${ceDisplay.attributesKeys}" var="key">
						<c:if test="${schemaAttributeNode.attribute.attributeBiz == ceDisplay.attributes[key].attributeBiz}">
							<c:forEach items="${ceDisplay.attributes[key].attributeValues}" var="attributesValue" varStatus="status">
								<c:choose>
									<c:when test="${not status.last}">
										${attributesValue.attributeValueDescriptions[langId].description},&nbsp;
									</c:when>
									<c:otherwise>
										${attributesValue.attributeValueDescriptions[langId].description}.
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:if>
				</c:forEach>
	</li>
			</c:forEach>
		</c:if>
	</c:forEach>
</ul>
<div class="colis">
		<p class="infoColis"> Informations relatives au colis.</p>
		<c:set var="first" value="true"></c:set>
		<c:set var="index" value="0"></c:set>
		<c:forEach items="${infosColis}" var="info">
			<c:choose>
				<c:when test="${info.libelle == ''}">
				 	<c:if test="${first}">
				 	<div class="colisTab">
				 		<table width="100%">
				 			<tr>
				 				<th width="50%">Code Article</th><th width="50%">Poids</th>
				 			</tr>
				 		<c:set var="first" value="false"></c:set>
					</c:if>
						<tr>
			 				<td>${info.ceBiz}</td><td>${info.weight} g</td>
			 			</tr>
				</c:when>
				<c:otherwise>
					<c:if test="${first}">
						<div class="colisTab">
				 		<table width="100%">
				 			<tr>
				 				<th width="30%">Code Article</th><th width="30%">Variante</th><th width="30%">Poids</th>
				 			</tr>
				 		<c:set var="first" value="false"></c:set>
					</c:if>
					<c:if test="${index lt 6}">
						<tr>
			 				<td>${info.ceBiz}</td><td>${info.libelle}</td><td>${info.weight} g</td>
			 			</tr>
			 			<c:set var="index" value="${index+ 1}"></c:set>
			 		</c:if>
			 		<c:if test="${index gt 6}">
				 		<tr>
			 				<td width="30%">${info.ceBiz}</td><td width="30%">${info.libelle}</td><td width="30%">${info.weight} g</td>
			 			</tr>
			 			 <c:set var="index" value="${index+ 1}"></c:set>
			 		</c:if>
			 		<c:if test="${index eq 6}">
			 			</table>
			 			</div>
			 			<div class="arrow">Voir la suite <img src="/library/css/img/arrow.png" alt="" width="5" height="7" onclick="toggle('fullTable')"/></div>
			 			<div class="colisTab" id="fullTable" style="display:none;">
			 			<table width="100%">
			 			 <c:set var="index" value="${index+ 1}"></c:set>
			 		</c:if>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		</table>
		</div>
</div>