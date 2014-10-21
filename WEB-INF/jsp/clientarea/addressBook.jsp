<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<tiles:insertDefinition name="templateMenu">
	<tiles:putAttribute name="title"><spring:message code="clientAreaMenu.monCarnetAdresses"/></tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="clientAreaMenu.monCarnetAdresses"/></tiles:putAttribute>
	
	<tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}${contextPath}${requestScope['javax.servlet.forward.servlet_path']}
	</tiles:putAttribute>
	
	<tiles:putAttribute name="breadcrumb">
		<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt;
		<span class="lien_chemin"><a href="${contextPath}/account.html"><spring:message code="clientAreaMenu.monCompte"/></a></span>&nbsp;&gt;
		<span class="lien_chemin"><spring:message code="clientAreaMenu.monCarnetAdresses"/></span>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="ems">&nbsp;</tiles:putAttribute>
	
	<tiles:putAttribute name="menu">
		<c:import url="clientAreaMenu.jsp"/>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<div id="clients" class="carnet_adresse">
			<div id="contenu_interieur">
						<div class="coordonnees">
							<h2>
								<spring:message code="clientAreaMenu.monCarnetAdresses"/>
								<c:if test="${customer.blackListed}">
									<span style="color: red;">&nbsp;<spring:message code="customerAccount.compteBlackliste"/></span>
								</c:if>
								<c:if test="${customer.disabled}">
									<span style="color: red;">&nbsp;<spring:message code="customerAccount.compteDesactive"/></span>
								</c:if>								
							</h2>
						</div>
						<div class="contenu_blanc">
							<div class="adresse_facturation">
								<h3><spring:message code="address.monAdresseFact"/></h3>
								<c:if test="${!empty bilingAddress}">
									<div class="contenu_adressse_facturation">
										${bilingAddress.firstName}&nbsp; ${bilingAddress.lastName}<br/>
										${bilingAddress.addressLine1}<br/>
										<c:if test="${!empty bilingAddress.addressLine2}">
											${bilingAddress.addressLine2}<br/>
										</c:if>
										<c:if test="${!empty bilingAddress.addressLine3}">
											${bilingAddress.addressLine3}<br/>
										</c:if>
										${bilingAddress.zipCode}&nbsp;${bilingAddress.city}
									</div>
									<div class="btn">
										<%--<c:set var="text"><spring:message code="address.boutonModifier"/></c:set>
										<fwk:genericButton text="${text}" firstSpanClass="Black_small" btnId="modify_billingAddress_button" onClick="addOrModifyAddress('${bilingAddress.addressId}','billing')"/> --%>
										<a href="#" onClick="addOrModifyAddress('${bilingAddress.addressId}','billing')"><img src="${contextPath}/resources/fr_FR/img/clientArea/btn_modifier.png" alt="modifier" width="78" height="28"></a>
									</div>
	 							</c:if>
								<c:if test="${empty bilingAddress}">
	 									<spring:message code="address.adresseFactNonCree"></spring:message>
	 							</c:if>
							</div>
							
							<div class="adresse_livraison">
								<h3><spring:message code="address.monAdresseLivr"/></h3>
								<div class="contenu_adressse_livraison_domicile">
									<c:if test="${!empty shippingAddressList}">
										<c:forEach items="${shippingAddressList}" var="shippingAddress" varStatus="shippingAddressStatus">
											<c:if test="${shippingAddress.isDefaultAddress==true}">
												<div class="block_address" id="firstBlock">
													<span class="gras">
														${shippingAddress.complementInfo}
													</span>
													<div class="ctn_infos">
														<span class="nom_adresse">${shippingAddress.wording}</span>
														<c:if test="${shippingAddress.isDefaultAddress==true}">
															(<spring:message code="address.parDefaut"/>)
														<br/>
														</c:if>
														${shippingAddress.firstName}&nbsp; ${shippingAddress.lastName}<br/>
														${shippingAddress.addressLine1}<br/>
														<c:if test="${!empty shippingAddress.addressLine2}">
															${shippingAddress.addressLine2}<br/>
														</c:if>
														<c:if test="${!empty shippingAddress.addressLine3}">
															${shippingAddress.addressLine3}<br/>
														</c:if>
														${shippingAddress.zipCode}&nbsp;${shippingAddress.city}<br/>
													</div>
												</div>
												<div class="ctn_btn">			 
													<a href="#" id="modify_shippingAddress_button${shippingAddress.addressId}" onClick="addOrModifyAddress('${shippingAddress.addressId}','shipping');"><img src="${contextPath}/resources/fr_FR/img/clientArea/btn_modifier.png" alt="modifier" width="78" height="28"></a>
												</div>
											 </c:if>
										</c:forEach>  <!-- Attention il a été déplacé -->
										<c:forEach items="${shippingAddressList}" var="shippingAddress" varStatus="shippingAddressStatus">
											<c:if test="${shippingAddress.isDefaultAddress==false}">
												<div class="block_address">
													<span class="gras">
														${shippingAddress.complementInfo}
													</span>
													<div class="ctn_infos">
														<span class="nom_adresse">${shippingAddress.wording}</span>
														${shippingAddress.firstName}&nbsp; ${shippingAddress.lastName}<br/>
														${shippingAddress.addressLine1}<br/>
														<c:if test="${!empty shippingAddress.addressLine2}">
															${shippingAddress.addressLine2}<br/>
														</c:if>
														<c:if test="${!empty shippingAddress.addressLine3}">
															${shippingAddress.addressLine3}<br/>
														</c:if>
														${shippingAddress.zipCode}&nbsp;${shippingAddress.city}<br/>
													</div>
												</div>
												<div class="ctn_btn">
													<a href="#" id="default_shippingAddress_button${shippingAddress.addressId}" onClick="defaultAddress('${shippingAddress.addressId}');"><img src="${contextPath}/resources/fr_FR/img/clientArea/par_defaut_rouge.png" alt="par défaut" width="82" height="28"></a>
													<a href="#" id="delete_shippingAddress_button${shippingAddress.addressId}" onClick="deleteAddress('${shippingAddress.addressId}');"><img src="${contextPath}/resources/fr_FR/img/clientArea/btn_supprimer.png" alt="supprimer" width="91" height="28"></a>
													<a href="#" id="modify_shippingAddress_button${shippingAddress.addressId}" onClick="addOrModifyAddress('${shippingAddress.addressId}','shipping');"><img src="${contextPath}/resources/fr_FR/img/clientArea/btn_modifier.png" alt="modifier" width="78" height="28"></a>
												</div>
											</c:if>	
										</c:forEach>
									</c:if>
								</div>

										

	 								
	 								<c:if test="${empty shippingAddressList}">
	 									<spring:message code="address.adresseLivrNonCree"></spring:message>
	 								</c:if>
								</div>
							</div>
							<div class="validation">
								<c:set var="text"><spring:message code="address.boutonAjouterAdresse"/></c:set>
								<fwk:genericButton text="${text}" firstSpanClass="Org" btnId="add_new_address_button" onClick="addNewAddress()" />
							</div>
						</div>
					</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="moreJS">
		<script>
			$("#menu .contenu_menu ul:eq(0) li:eq(3) a").attr("style","color:#000000;");
			$("#menu .contenu_menu ul:eq(0) li:eq(3) a").removeAttr("href");
		</script>
		<script src="${contextPath}/resources/js/clientArea/addressBook.js" type="text/javascript"></script>
		<script src="${contextPath}/resources/js/clientArea/ville.js" type="text/javascript"></script>		
	</tiles:putAttribute>
</tiles:insertDefinition>