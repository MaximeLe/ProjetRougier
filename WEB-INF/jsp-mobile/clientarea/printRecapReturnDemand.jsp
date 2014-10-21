<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags"      prefix="spring" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title><spring:message code="order.recapitulatifDemande"/></title>
	<link href="${contextPath}/resources/${codeIsoLang}/css/creation_compte.css" rel="stylesheet" type="text/css" />
	<script src="${contextPath}/resources/js/clientArea/printReturnDemand.js" type="text/javascript"></script>
	<script src="${contextPath}/resources/js/clientArea/printOrder.js" type="text/javascript"></script>
</head>
<body>
<c:set var="devise"><c:choose><c:when test="${storeId==2}">&#36;</c:when><c:otherwise>€</c:otherwise></c:choose></c:set>
		
		<div id="clients" class="effectuer_retour_print">
			<div class="info_client">
				<span>${customer.firstName}&nbsp;${customer.lastName}</span><br/>
				<span>${customer.addressLine1}<br/>
						<c:if test="${!empty customer.addressLine2}">
							<span>${customer.addressLine2}</span><br/>
						</c:if>
						<c:if test="${!empty customer.addressLine3}">
							<span>${customer.addressLine3}</span><br/>
						</c:if>
				</span>
				<span>${customer.zipCode}&nbsp;${customer.city}</span><br/>
				<span>${customer.phone}</span><br/>
				<span><spring:message code="order.numClient"/>&nbsp;: ${customer.customerId}</span><br/>
				<span><spring:message code="order.numCommande"/>&nbsp;:&nbsp;${order.numOrderBiz}</span>
			</div>
			<div class="logistique">
				<div class="info">
					<span><spring:message code="order.logistiqueCommercant"/></span><br/>
					<span><spring:message code="signUp.adresse"/>&nbsp;: </span><br/>
					<span><spring:message code="order.telephone"/>&nbsp;:</span><br/>
				</div>
				<div class="date">
					<span><spring:message code="order.date"/>&nbsp;:&nbsp;<fmt:formatDate value="${returnDemand.dateDemand}" pattern="dd/MM/yyyy 'à' HH:mm" /></span>
				</div>
			</div>
			<div class="clear"></div>
			<div class="objet">
				<span><spring:message code="order.objectDemande"/>${returnDemand.returnDemandId}</span>
			</div>
			<div class="motif">
				<span><spring:message code="order.motifRetour"/>&nbsp;:&nbsp;${returnDemand.returnDemandCause.causeReturnWording}</span>
			</div>
			<div class="table_recap">
				<table cellpadding="0" cellspacing="0">
					<tr>
						<th><spring:message code="order.reference"/></th>
						<th><spring:message code="order.article"/></th>	
						<th><spring:message code="order.quantite"/></th>	
						<th><spring:message code="order.motif"/></th>						
					</tr>
					<c:forEach items="${returnDemand.linesReturnDemand}" var="item" varStatus="status">
					<tr>
						<td>${item.articleBiz}</td>
						<td>${item.wordingProduct}</td>
						<td>${item.quantityReturn}</td>
						<td>${item.returnCause.causeReturnWording}</td>
					</tr>
					</c:forEach>
				</table>
			</div>
			<div id="pi_facture_pop"><img title="<spring:message code="order.imprimer"/>" alt="<spring:message code="order.imprimer"/>" src="/StarterStore/resources/fr_FR/img/clientArea/picto_imprimante.png"></div>
		</div>
</body>
</html>
