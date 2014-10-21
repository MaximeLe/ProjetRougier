<%@ page trimDirectiveWhitespaces="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"   prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="devise"><c:choose><c:when test="${storeId==2}">&#36;</c:when><c:otherwise>€</c:otherwise></c:choose></c:set>

<tiles:insertDefinition name="templateHeaderSimplifie">
	<tiles:putAttribute name="title"><spring:message code="payment.title"/></tiles:putAttribute>
	
	<tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}${contextPath}${requestScope['javax.servlet.forward.servlet_path']}
	</tiles:putAttribute>

	<tiles:putAttribute name="head">
		<link href="${contextPath}/resources/${codeIsoLang}/css/delivery.css" rel="stylesheet" type="text/css" />
	</tiles:putAttribute>

	<tiles:putAttribute name="content">
		<div id="content" class="paiement">
				<div id="conteneur_ariane">
					<div id="etapes">
						<img id="filet1" class="filet" src="${contextPath}/resources/${codeIsoLang}/img/cart/panier_filet_1.png" width="95" height="20" alt="filet"/>
						<img class="onglet1" src="${contextPath}/resources/${codeIsoLang}/img/cart/panier_onglet_1.png" width="20" height="20" alt=""/>
						<span class="actif"><spring:message code="tunnel.ariane.panier"/></span>
						<div class="etapes_separations"></div>
						<img class="onglet2" src="${contextPath}/resources/${codeIsoLang}/img/cart/panier_onglet_2_actif.png" width="20" height="20" alt=""/>
						<span class="actif"><spring:message code="tunnel.ariane.livraison"/></span>
						<div class="etapes_separations"></div>
						<img class="onglet3" src="${contextPath}/resources/${codeIsoLang}/img/cart/panier_onglet_3_actif.png" width="20" height="20" alt=""/>
						<span class="actif" id="derniere_etape"><spring:message code="tunnel.ariane.paiement"/></span>
						<img class="filet" src="${contextPath}/resources/${codeIsoLang}/img/cart/panier_filet_1.png" width="95" height="20" alt="filet"/>
					</div>
				</div>
				
				<div id="conteneur_paiement">
					<div id="contenant_droit" class="clear hidden">
					<c:if test="${not empty deliveryMode && not empty deliveryAddress}">
						<div class="infos_livraison">
							<div class="barretitre"><span> Mon mode de livraison : </span></div>
							<div id="texte_infos_livraison">${deliveryMode}<br />
								<c:if test="${!empty deliveryAddress.firstName}">${deliveryAddress.firstName}&nbsp;</c:if>
								<c:if test="${!empty deliveryAddress.lastName}">${deliveryAddress.lastName}</c:if>
								<br/>
								<c:if test="${!empty deliveryAddress.addressLine1}">
								${deliveryAddress.addressLine1}<br />
								</c:if>
								<c:if test="${!empty deliveryAddress.addressLine2}">
								${deliveryAddress.addressLine2}<br />
								</c:if>
								<c:if test="${!empty deliveryAddress.addressLine3}">
								${deliveryAddress.addressLine3}<br />
								</c:if>
								<c:if test="${!empty deliveryAddress.addressLine4}">
								${deliveryAddress.addressLine4}<br />
								</c:if>
								<c:if test="${!empty deliveryAddress.complementInfo}">
								${deliveryAddress.complementInfo}<br />
								</c:if>
								${deliveryAddress.zipCode} - ${deliveryAddress.city}<br/>
								${deliveryAddress.country}
							</div>
						</div>
					</c:if>
					<div class="bordure">
					<!-- Partie droite -->

						<c:if test="${!empty message}">
							<div class="cadregris grand">
								<div class="barretitre"><span>${message}</span></div>
							</div>
						</c:if>
						<div class="cadregris grand">
							<div class="barretitre"><span>Mon paiement</span></div>
							
							<div id="texte_facilite_paiement">
								<spring:message code="payment.problemePaiement"/><spring:message code="payment.appelez"/><span class="gras"><spring:message code="payment.numero"/></span><spring:message code="payment.coutTelephone"/><br /><spring:message code="payment.autrePossibilites"/>
							</div>
							
							<form id="formulaire" action="#" onSubmit="return false">
								<div class="ligne titre">S&eacute;lectionnez le mode de paiement de votre commande</div>
								<div class="ligne">
									
									<c:forEach items="${instancesPayments}" var="paymentInstance">					
										<div class="clear">
											<c:set var="payType" value="typeCB${paymentInstance.paymentInstanceId}"></c:set>
											<div class="colonne_intitule"><input type="radio" name="paymentType" id="${paymentInstance.codePaymentBiz}" value="${payType}"  <c:if test="${paymentType == payType}">checked="checked"</c:if>/><label for="${paymentInstance.codePaymentBiz}">Paiement ${paymentInstance.descriptions[langId]}</label></div>
										</div>																		
									</c:forEach>
									
									
									<c:forEach items="${instancesPaymentsExterne}" var="paymentInstance">					
										<div class="clear">
											<c:set var="payType" value="typePayExterne${paymentInstance.paymentInstanceId}"></c:set>
											<div class="colonne_intitule"><input type="radio" name="paymentType" id="${paymentInstance.codePaymentBiz}" value="${payType}"  <c:if test="${paymentType == payType}">checked="checked"</c:if>/><label for="${paymentInstance.codePaymentBiz}">Paiement ${paymentInstance.descriptions[langId]}</label></div>
										</div>																		
									</c:forEach>
									
									<c:if test="${empty annulationPaiement}">
									<div class="clear">
										<div class="colonne_intitule"><input type="radio" name="paymentType" id="express"  value="typeCheck" /><label for="express">Autre moyen de paiement (chèque, virement, carte cadeau ...)</label></div>
									</div>
									</c:if>
								</div>
								<!-- <input type="submit" id="submitCheckboxType"/>-->
							</form>

							<div id="layers">
							
								<c:forEach items="${formPaymentExterne}" var="formPayment">																								
									<div id="typePaymentExterne${formPayment.key}">
										<div class="separation"></div>
							
										<!-- <div class="ligne titre">Je r&egrave;gle ma commande par Carte Bancaire</div> -->
										<div class="ligne">
											<div class="floatLeft">
											
												<div class="bloc">
													 ${formPayment.value.formHtml} 
												</div>
											</div>
										</div>
											<!-- Boutons -->
										<div class="boutonsbas">
											 <!-- 
											 <p class="floatLeft"><input type="checkbox" name="acceptCondition" id="acceptCondition${formPayment.value.formHtmlId}" value="" /></p>
											<p class="floatLeft"><label for="acceptCondition1">J'ai pris connaissance des <a href="#" class="lien_noir">conditions générales de vente.</a></label></p>
											 -->
											<p class="floatLeft zonebas">
												<!--<a href="#" class="bt_retour">Retour</a>-->												
												<input type="button" id="validPaymentExterne${formPayment.value.formHtmlId}" onclick="validPaymentExterne('${formPayment.value.formHtmlId}', ${formPayment.value.paymentInstanceId}, '${formPayment.value.transactionBiz}'  )" value="" class="bt_suivant_submit" />
											</p>
										</div>
									</div>
								</c:forEach>
								
								<input type="hidden" name="action" value="typeCB" id="hiddenAction"/>
								<input type="hidden" name="instancePaymentId" value="" id="hiddenInstancePayment"/>
								
								<!--  EN CAS DE REGLEMENT PAR Service Client -->
								<div id="typeCheck">
									<form:form id="paymentFormcheck">
										<input type="hidden" name="action" value="typeCheck" id="hiddenAction"/>
										<div class="separation"></div>
										
										<!-- Boutons -->
										<div class="boutonsbas">
											<p class="floatLeft zonebas">
												<input type="submit" value="Etape suivante" class="bt_suivant_submit" />
											</p>
										</div>
									</form:form>
								</div>
								
							</div>
						</div>
						
					</div>
					<div class="ems_mot">${animationBody }</div>
				
				</div>
				<div class="colonne_gauche">
					<!-- Partie droite -->
					<c:import url="../cart/receipt.jsp"/>
				</div>
						
			</div>
		</div>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="moreJS">
		<script src="${contextPath}/resources/js/clientArea/ville.js" type="text/javascript"></script>	
		<script src="${contextPath}/resources/js/tunnel/payment.js" type="text/javascript"></script>
		<script src="${contextPath}/resources/js/tunnel/delivery.js" type="text/javascript"></script>
		<script src="${contextPath}/resources/js/ejs_production.js" type="text/javascript"></script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				
				if($.cookie('reloadable') == 'true'){
					//Si le cookie est à reloadable true on recharge et on passe à false
					$.cookie('reloadable', 'false', { expires: 30, path: '/'});
					window.location.reload();
					
				}else{
					//Crée le cookie à reloadable => true
					$.cookie('reloadable', 'true', { expires: 30, path: '/'});
				}
				
				var annulationPaiement = '${annulationPaiement}';
				if(annulationPaiement != null && annulationPaiement){
					showModalAnnulationPaiement();
				}
			});
		</script>
		
	</tiles:putAttribute>
</tiles:insertDefinition>

	