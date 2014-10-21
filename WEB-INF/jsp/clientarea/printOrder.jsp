<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags"      prefix="spring" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<fmt:bundle basename="i18n.Message_Client">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title><spring:message code="order.imprimerCommande"/></title>
	<link href="${contextPath}/resources/${codeIsoLang}/css/creation_compte.css" rel="stylesheet" type="text/css" />
	<script src="${contextPath}/resources/js/clientArea/printOrder.js" type="text/javascript"></script>
</head>
<body>
<c:set var="devise"><c:choose><c:when test="${storeId==2}">&#36;</c:when><c:otherwise>€</c:otherwise></c:choose></c:set>
	<div id="clients" class="visualiser_detail_commandes_print">
		<div class="contenu_interieur">
			<div class="coordonnees">
				<h2><spring:message code="order.commandeNum"/>${order.numOrderBiz}&nbsp;<spring:message code="order.du"/>&nbsp;<fmt:formatDate value="${order.dateOrder}" pattern="dd/MM/yyyy 'à' HH:mm" />
<%-- 					<a href="viewOrders.html"><input type="image" src="${contextPath}/resources/${codeIsoLang}/img/clientArea/retour.png"/></a>
 --%>				</h2>
			</div>
			
			<%-- <a href="printOrder.html?action=imprimer"><input type="image" src="${contextPath}/resources/${codeIsoLang}/img/clientArea/retour.png"/><spring:message code="order.imprimer"/></a> --%>
			
			<div class="ctn_print">		
				<table>
					<tr>
						<th class="reference"><spring:message code="order.reference"/></th>
						<th class="libelle"><spring:message code="order.article"/></th>
						<th class="quantite"><spring:message code="order.quantite"/></th>
						<th class="etat"><spring:message code="order.etat"/></th>
						<th class="montant"><spring:message code="order.prix"/></th>
						<th class="montant"><spring:message code="order.remise"/></th>
						<th class="montant"><spring:message code="order.montant"/></th>
					</tr>
					<c:forEach items="${order.orderLines}" var="line">
						<tr class="separation">
							<td class="reference">${line.articleBiz}</td>
							<td class="libelle">${line.wordingProduct}</td>
							<td class="quantite">${line.quantity}</td>
							<td class="etat">${line.statusOrder.wordingFO}</td>
							<td class="montant"><span class="prix_barre"><fmt:formatNumber value="${item.basePrice}" currencySymbol="${devise}" type="currency"/></span><fmt:formatNumber value="${line.basePrice}" currencySymbol="${devise}" type="currency"></fmt:formatNumber></td>
							<td class="montant"><fmt:formatNumber value="${remiseLigne.valueToApply}" currencySymbol="${devise}" type="currency"></fmt:formatNumber></td>
							<td class="montant_tot"><fmt:formatNumber value="${line.price}" currencySymbol="${devise}" type="currency"></fmt:formatNumber></td>
						</tr>
					</c:forEach>
				</table>
				<table>
					<tr class="separation border" >
						<td class="vide" style="text-align: right;"><spring:message code="order.sousTotal"/></td>
						<td  class="montant_tot"><fmt:formatNumber value="${order.totalItems}" currencySymbol="${devise}" type="currency"></fmt:formatNumber></td>
					</tr>
					<tr class="separation" >
					<c:forEach items="${order.discountsForOrder}" var="discount">
						<td class="vide" style="text-align: right;"><spring:message code="order.remise"/>&nbsp;: </td>
						<td class="montant_tot"><fmt:formatNumber value="${discount.valueToApply}" currencySymbol="${devise}" type="currency"></fmt:formatNumber> </td>
					</c:forEach>
					</tr>
					<tr class="separation" >
						<td class="vide" style="text-align: right;"><spring:message code="order.fraisDePort"/></td>
						<td class="montant_tot"><fmt:formatNumber value="${order.totalShippingFee}" currencySymbol="${devise}" type="currency"></fmt:formatNumber></td>
					</tr>
					<tr class="separation" >
						<td class="paiement" style="text-align: right;"><spring:message code="order.totalCommande"/></td>
						<td class="montant_tot_com"><fmt:formatNumber value="${order.total}" currencySymbol="${devise}" type="currency"></fmt:formatNumber></td>
					</tr>
					<c:forEach items="${order.transactions}" var="transaction" varStatus="num"  begin="0" end="0"> 
						<tr class="separation" >
							<td class="vide" style="text-align: right;"><spring:message code="order.moyenPaiement"/></td>
							<td class="montant_tot">${transaction.libelleTypeTransaction}</td>
						</tr>
					</c:forEach>
				</table>
			
				<div>
					<div class="adresse_facturation">
						<span class="gras"><spring:message code="order.adresseFacturation"/></span><br/><br/>
						<span>
							${order.addressBilling.firstName}&nbsp;${order.addressBilling.lastName}
							<br/>
								${order.addressBilling.addressLine1}
								<c:if test="${order.addressBilling.addressLine2 != null}">
									${order.addressBilling.addressLine2}
								</c:if>
								<c:if test="${order.addressBilling.addressLine3 != null}">
									${order.addressBilling.addressLine3}
								</c:if>
							<br/>
							${order.addressBilling.zipCode}&nbsp;${order.addressBilling.city}
						</span>
					</div>
					<div class="adresse_livraison">
					<span class="gras"><spring:message code="order.adresseLivraison"/></span><br/><br/>
						<span>
							${customer.firstName}&nbsp;${customer.lastName}
							<br/>
								${customer.addressLine1}
								<c:if test="${customer.addressLine2 != null}">
									${customer.addressLine2}
								</c:if>
								<c:if test="${customer.addressLine3 != null}">
									${customer.addressLine3}
								</c:if>
							<br/>
							${customer.zipCode}&nbsp;${customer.city}
						</span>
					</div>
				</div>
			</div>
			<div id="pi_facture_pop"><img title="<spring:message code="order.imprimer"/>" alt="<spring:message code="order.imprimer"/>" src="/StarterStore/resources/fr_FR/img/clientArea/picto_imprimante.png"></div>
		</div>
	</div>
</body>
</html>
</fmt:bundle>