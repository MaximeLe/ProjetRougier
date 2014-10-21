<%@ page trimDirectiveWhitespaces="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"   prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<tiles:insertDefinition name="templateHeaderSimplifie">

	<tiles:putAttribute name="title"><spring:message code="customerservice.title"/></tiles:putAttribute>
 	<tiles:putAttribute name="description"><spring:message code="customerservice.description"/></tiles:putAttribute>
 	
 	<tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}${contextPath}${requestScope['javax.servlet.forward.servlet_path']}
	</tiles:putAttribute>
 	
	<tiles:putAttribute name="head">
		<link href="${contextPath}/resources/${codeIsoLang}/css/delivery.css" rel="stylesheet" type="text/css" />
	</tiles:putAttribute>
 	 	
	<tiles:putAttribute name="content">
		
		<div id="content" class="paiement">
				
			<!-- Début du content -->
			<div class="contentStart"></div>
				
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
					<span id="derniere_etape" class="actif"><spring:message code="tunnel.ariane.paiement"/></span>
					<img class="filet" src="${contextPath}/resources/${codeIsoLang}/img/cart/panier_filet_1.png" width="95" height="20" alt="filet"/>
				</div>
			</div>
						
			<div id="conteneur_paiement">
				<div id="contenant_droit" class="clear hidden">
					<div class="bordure">
						<div class="cadregris grand">
				
							<div>
								${emsServiceClient}
							</div>
							
							<div id="validCheck">
								<form:form id="validFormcheck">
									<input type="hidden" name="action" value="validCheck" id="hiddenAction"/>
									<div class="separation"></div>
																					
									<!-- Boutons -->
									<div class="boutonsbas">
										<p class="floatLeft">
											<a href="${contextPath}/tunnel/payment.html" class="bt_retour">
											<spring:message code="customerservice.boutonAnnuler"/>
											</a>
										</p>
										<p class="floatRight">
											<input type="submit" value="Valider" class="bt_suivant_submit" />
										</p>
									</div>
								</form:form>
							</div>
						</div>
					</div>
					<div class="ems_mot">${animationBody }</div>
				</div>
				<div class="colonne_gauche">
					<c:import url="../cart/receipt.jsp"/>
				</div>
			</div>
			
			<!-- Fin du content -->
			<div class="contentEnd"></div>
		</div>
	
	</tiles:putAttribute>

</tiles:insertDefinition>