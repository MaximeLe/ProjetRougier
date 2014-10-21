<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="atLeastOneElementCaracteristique" value="false"></c:set><c:forEach items="${ceDisplay.catalogEntry.schemaBiz.schemaNodes}" var="schemaNode"><c:if test="${schemaNode.wording == 'Descriptif'}"><c:forEach items="${schemaNode.schemaAttributeNodes}" var="schemaAttributeNode"><c:forEach items="${ceDisplay.attributesKeys}" var="key"><c:if test="${schemaAttributeNode.attribute.attributeBiz == ceDisplay.attributes[key].attributeBiz}"><c:forEach items="${ceDisplay.attributes[key].attributeValues}" var="attributesValue" varStatus="status"><c:if test="${attributesValue.attributeValueDescriptions[langId].description != null && attributesValue.attributeValueDescriptions[langId].description != ''}"><c:set var="atLeastOneElementCaracteristique" value="true"></c:set></c:if></c:forEach></c:if></c:forEach></c:forEach></c:if></c:forEach>

<div class="onglets">
	
	<c:set var="precaution"><c:import url="importPrecaution.jsp"/></c:set>

	<ul class="titre">
		<c:if test="${	(not empty ceDisplay.catalogEntryDescription.description && ceDisplay.catalogEntryDescription.description!='' && ceDisplay.catalogEntryDescription.description!=' ') || 
						(not empty ceDisplay.catalogEntryDescription.attachment && ceDisplay.catalogEntryDescription.attachment!='')}">
			<li><h2>Description</h2></li>
		</c:if>
		<c:if test="${atLeastOneElementCaracteristique == true}">
			<li><h2>Caractéristiques</h2></li>
		</c:if>	
		<c:if test="${not empty foireTechnique}">
			<li><h2>Conseil d’expert</h2></li>
		</c:if>
		<c:if test="${not empty fn:trim(precaution) }">
			<li><h2>Précautions</h2></li>
		</c:if>
	</ul>
	
	<ul class="contenu">
		<c:if test="${	(not empty ceDisplay.catalogEntryDescription.description && ceDisplay.catalogEntryDescription.description!='' && ceDisplay.catalogEntryDescription.description!=' ') || 
						(not empty ceDisplay.catalogEntryDescription.attachment && ceDisplay.catalogEntryDescription.attachment!='')}">	
			<li itemprop="description">
				<c:if  test="${	(not empty ceDisplay.catalogEntryDescription.description && ceDisplay.catalogEntryDescription.description!='' && ceDisplay.catalogEntryDescription.description!=' ')}">
					${ceDisplay.catalogEntryDescription.description}<br/><br/>
				</c:if>
				<c:if test="${not empty ceDisplay.catalogEntryDescription.description || not empty ceDisplay.catalogEntryDescription.attachment}">
					<c:if test="${ceDisplay.catalogEntryDescription.attachment != null && ceDisplay.catalogEntryDescription.attachment != ''}">
						<a href="${mediaPath}${ceDisplay.catalogEntryDescription.attachment}" target="_blank">Téléchargez la fiche technique</a>
					</c:if>
				</c:if>		
				<c:set var="showDescription" value="true"/>		
			</li>	
		</c:if>
		<c:if test="${atLeastOneElementCaracteristique == true}">
			<li class="carac"><c:import url="importCaracteristiques.jsp"/>
			</li>
		</c:if>
		<c:if test="${not empty foireTechnique}">
			<li><c:import url="importFoireTechnique.jsp"/>
			</li>
		</c:if>
		<c:if test="${not empty fn:trim(precaution) }">
			<li><table cellpadding="0" cellspacing="0" border="0" class="precaution">${precaution}</table>
			</li>
		</c:if>
	</ul>
</div>
<c:import url="importPictoSociaux.jsp"/>