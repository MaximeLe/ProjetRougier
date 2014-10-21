<%@ page trimDirectiveWhitespaces="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="devise"><c:choose><c:when test="${storeId==2}">&#36;</c:when><c:otherwise>&euro;</c:otherwise></c:choose></c:set>


<tiles:insertDefinition name="templateHeaderSimplifie">
	<tiles:putAttribute name="title"><spring:message code="delivery.title"/></tiles:putAttribute>
	
	<tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}${contextPath}${requestScope['javax.servlet.forward.servlet_path']}
	</tiles:putAttribute>
	
	<tiles:putAttribute name="head">
		<link href="${contextPath}/resources/${codeIsoLang}/css/delivery.css" rel="stylesheet" type="text/css" />
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
	
	
		<div id="content" class="livraison">
				<div id="conteneur_ariane">
					<div id="etapes">
						<img id="filet1" class="filet" src="${contextPath}/resources/${codeIsoLang}/img/cart/panier_filet_1.png" width="95" height="20" alt="filet"/>
						<img class="onglet1" src="${contextPath}/resources/${codeIsoLang}/img/cart/panier_onglet_1.png" width="20" height="20" alt=""/>
						<span class="actif"><spring:message code="tunnel.ariane.panier"/></span>
						<div class="etapes_separations"></div>
						<img class="onglet2" src="${contextPath}/resources/${codeIsoLang}/img/cart/panier_onglet_2_actif.png" width="20" height="20" alt=""/>
						<span class="actif"><spring:message code="tunnel.ariane.livraison"/></span>
						<div class="etapes_separations"></div>
						<img class="onglet3" src="${contextPath}/resources/${codeIsoLang}/img/cart/panier_onglet_3.png" width="20" height="20" alt=""/>
						<span id="derniere_etape"><spring:message code="tunnel.ariane.paiement"/></span>
						<img class="filet" src="${contextPath}/resources/${codeIsoLang}/img/cart/panier_filet_1.png" width="95" height="20" alt="filet"/>
					</div>
				</div>
				<div id="conteneur_paiement">
					<div id="contenant_droit">				
					<div class="bordure">
						<!-- Partie gauche -->
						<div class="cadregris grand">
							<div class="barretitre"><span><spring:message code="delivery.monModeLivraison"/></span></div>
							<form:form method="post" id="formulaire" action="#">
								
								<c:forEach items="${serviceTransports}" var="stz"> 
											<c:set var="isChecked">
												<c:choose>
													<c:when test="${(stz.active)&&(stz.serviceTransportZoneId == serviceTransportIdSelected || serviceTransportIdSelected==null)}">true</c:when>
													<c:otherwise>false</c:otherwise>
												</c:choose>
											</c:set>
																		
											<div class="ligne">
												<div class="colonne_intitule <c:if test="${isChecked}">bold </c:if>" ><input type="radio" <c:if test="${isChecked}">checked="checked" </c:if>  name="modeDelivery" id="${stz.serviceTransportZoneId}" value="${stz.serviceTransportZoneId}" onclick="changeModeLivraison(${stz.serviceTransportZoneId},'${stz.codeService}')"><label for="${stz.serviceTransportZoneId}">${stz.serviceTransportDescription[langId]}</label></div>
												<div class="colonne_date "><spring:message code="delivery.Sous"/> &nbsp; ${stz.period} &nbsp; <spring:message code="delivery.jours" /></div>
												<div class="colonne_prix">												
												<c:choose>
													<c:when test="${stz.totalFrais > 0}">
														<fwk:priceFormater price="${stz.totalFrais}" format="$1${devise}$2"/>
													</c:when>
													<c:when test="${stz.totalFrais == 0}">
														<spring:message code="delivery.gratuit"/>
													</c:when>
													<c:otherwise>
														<spring:message code="delivery.gratuit"/>
													</c:otherwise>
												</c:choose>
													<br />
												</div>
											</div>								
								</c:forEach>
																
							</form:form>
						</div>
									
						<c:choose>
							<c:when test="${isModeLivraisonDomicile}">
							<div class="ligne">
								<c:choose>
									<c:when test="${isAddressLivraisonValid}">
										<div class="barretitre"><span><spring:message code="delivery.monAdresseLivraison"/>&nbsp;(${cart.addressDelivery.wording})</span></div>
										<div class="ligne addresse_perso">
											${cart.addressDelivery.firstName}&nbsp;${cart.addressDelivery.lastName} <br />
											<c:if test="${!empty cart.addressDelivery.addressLine1}">
											${cart.addressDelivery.addressLine1}<br />
											</c:if>
											<c:if test="${!empty cart.addressDelivery.addressLine2}">
											${cart.addressDelivery.addressLine2}<br />
											</c:if>
											<c:if test="${!empty cart.addressDelivery.addressLine3}">
											${cart.addressDelivery.addressLine3}<br />
											</c:if>
											<c:if test="${!empty cart.addressDelivery.addressLine4}">
											${cart.addressDelivery.addressLine4}<br />
											</c:if>
											<c:if test="${!empty cart.addressDelivery.complementInfo}">
											${cart.addressDelivery.complementInfo}<br />
											</c:if>
											${cart.addressDelivery.zipCode} - ${cart.addressDelivery.city}<br/>
											${cart.addressDelivery.country}
										</div>
										<div class="ligne">
											<a href="#" class="modifBillingAdress" id="modify_shippingAddress_button${cart.addressDelivery.addressId}" onClick="addOrModifyAddress('${cart.addressDelivery.addressId}','shipping');"><span>Modifier</span></a>
										</div>
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${(isAddressLivraisonValid && fn:length(listOfValidAddress)>1)}">
									<div class="barretitre blanc">
										<c:choose>
											<c:when test="${param.serviceTransportId == null}">
												<c:set var="serviceTId" value="${defaultServiceTransportId}"/>
											</c:when>
											<c:otherwise>
												<c:set var="serviceTId" value="${param.serviceTransportId}"/>
											</c:otherwise>	
										</c:choose>
										<select name="selectAdresseLivraison" id="addressLivraisonList" onchange="reloadModeLivraison(this.value,${serviceTId})">
											<option value="0">Selectionnez une adresse</option>
											<c:forEach items="${listOfValidAddress}" var="addr">
												<option value="${addr.addressId}">${addr.wording}</option>	
											</c:forEach>
										</select>
									</div>
									</c:when>
								</c:choose>
							<c:if test="${(!isAddressLivraisonValid && fn:length(listOfValidAddress)==0)}">
							<div class="message_erreur">
								<span class="error">Vous ne disposez pas d'adresse de livraison valide</span>
							</div>
									
							</c:if>
							<div class="validation">
								<c:set var="text"><spring:message code="address.boutonAjouterAdresse"/></c:set>
								<c:choose>
									<c:when test="${(!isAddressLivraisonValid && fn:length(listOfValidAddress)==0)}">
										<fwk:genericButton text="${text}" firstSpanClass="Org" btnId="add_new_address_button_active" onClick="addNewAddress()" />
									</c:when>
									<c:otherwise>
										<fwk:genericButton text="${text}" firstSpanClass="Org" btnId="add_new_address_button" onClick="addNewAddress()" />
									</c:otherwise>
								</c:choose>
							</div>
					</div>
							</c:when>
							<c:when test="${isModeLivraisonMagazin}">
								<c:import url="../tunnel/magasin.jsp"/>
							</c:when>
							<c:otherwise>
								<c:import url="../tunnel/deliveryRelay.jsp"/>
							</c:otherwise>
						</c:choose>

		</div>	
		
														
		<div id="deliveryType">
			<form onsubmit="return false;" id="shippingFormHome" name="addressDelivery" method="post" action="delivery.html">							
				<div id="bloc_home" style="display: block">
					<div class="boutonsbas">
						<p class="floatLeft">
							<a href="${contextPath}/cart.html" class="bt_retour"><spring:message code="delivery.retour"/></a>
						</p>
						<c:choose>
							<c:when test="${isModeLivraisonDomicile}">
								<c:choose>
									<c:when test="${(isAddressLivraisonValid && fn:length(listOfValidAddress)>0)}">
										<p class="floatRight_livraison zonebas">  
											<input type="submit" value="Etape suivante" class="bt_suivant_submit_delivery" />
										</p>
									</c:when>
									<c:otherwise>
										<p class="floatRight_livraison zonebas">  
											<input value="Etape suivante" class="bt_suivant_submit_delivery_off" disabled="disabled" />
										</p>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:when test="${isModeLivraisonMagazin}">
								<%-- Le bouton Etape Suivante n'est pas affiché, il est directement dans magasin.jsp --%>
<%-- 								<c:choose> --%>
<%-- 									<c:when test="${not empty shop}"> --%>
<!-- 										<p class="floatRight zonebas">   -->
<!-- 											<input type="submit" value="Etape suivante" id="validation" class="bt_suivant_submit_delivery" /> -->
<!-- 										</p> -->
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
<!-- 										<p class="floatRight zonebas">   -->
<!-- 											<input value="Etape suivante" class="bt_suivant_submit_delivery_off" disabled="disabled" /> -->
<!-- 										</p> -->
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose> --%>
							</c:when>
							<c:otherwise>
								<p class="floatRight_livraison zonebas">  
									<input type="submit" value="Etape suivante" class="bt_suivant_submit_delivery" />
								</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>	
					
				<input type="hidden" name="serviceTransportId" id="serviceTransportId" value="${serviceTransportIdSelected}"  />
			</form>
			<div class="ems_mot">${animationBody }</div>
		</div>

	</div>
	
					<div class="colonne_gauche">
						<c:import url="../cart/receipt.jsp"/>
					</div>
	</div>
</div>
</tiles:putAttribute>
	

	<tiles:putAttribute name="moreJS">
		<script src="${contextPath}/resources/js/tunnel/delivery.js" type="text/javascript"></script>
		<script src="${contextPath}/resources/js/dictionary/dictionary_fr_FR.js" type="text/javascript"></script>
		<script src="${contextPath}/resources/js/ejs_production.js" type="text/javascript"></script>
		<script src="${contextPath}/resources/js/clientArea/ville.js" type="text/javascript"></script>	
		<script>$("#menu .contenu_menu ul:eq(0) li:eq(4) a").attr("style","color:#000000;");</script>
		<script type="text/javascript" src="${contextPath}/resources/js/common/swfobject2.js"></script>		
		<script type="text/javascript" src="${contextPath}/resources/js/clientArea/favoriteShop.js"></script>	
		<script type="text/javascript">
			$(document).ready(function(){
				var defaultZipCode = '${defaultZipCode}';
				$("#zipCode").val(defaultZipCode);
			});
		</script>
		<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
		<script>
			var shopListForGoogleMaps =$.parseJSON('${googleShop}');
			var originLatitude = "${searchShop.latitude}";
			var originLongitude = "${searchShop.longitude}";
			</script>
	</tiles:putAttribute>
</tiles:insertDefinition>