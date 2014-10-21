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

	<tiles:putAttribute name="title"><spring:message code="acknowledgment.title"/></tiles:putAttribute>

	<tiles:putAttribute name="head">
		<tiles:putAttribute name="googleAnalytics">
			<script type="text/javascript">    
		
				var _gaq = _gaq || [];
				_gaq.push(['_setAccount', '${codeAnalytics}']);
				_gaq.push(['_trackPageview']);
				_gaq.push(['_addTrans',     
				           '${order.orderId}',            			// ID de commande – requis
				           'Rougier',  								// nom du magasin
				           '${order.total-order.totalTaxAmount-order.totalShippingFee}',          				// total - requis
				           '${order.totalTaxAmount}',     			// taxe
				           '${order.totalShippingFee}',   			// frais de livraison
				           '${order.addressDelivery.city}',       	// ville
				           '${order.addressDelivery.zipCode}',    	// région
				           '${order.addressDelivery.country}'      	// pays
				           ]);     
				
				     // add item might be called for every item in the shopping cart    
				     // where your ecommerce engine loops through each item in the cart and    
				     // prints out _addItem for each   
					<c:forEach items="${order.orderLines}" var="orderLine">
					_gaq.push([
						'_addItem',
					   '${order.orderId}',          				// ID de commande - requis
					   '${orderLine.articleId}',           			// code SKU - requis
					   '${wordingReplace[orderLine.articleId]}',   	// nom du produit
					   '${categories[orderLine.articleId]}',   		// catégorie
					   '${orderLine.price}',          				// prix à l’unité - requis
					   '${orderLine.quantity}'               		// quantité - requis
					]);
					</c:forEach>
					   
				 _gaq.push(['_trackTrans']); //submits transaction to the Analytics servers    
				  _gaq.push(['_trackPageLoadTime']);
				 (function() {     
					 var ga = document.createElement('script'); 
					 ga.type = 'text/javascript'; ga.async = true;
					 ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
					 var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);   
				  })();  
			
			</script>
		</tiles:putAttribute>
	</tiles:putAttribute>
	
<%-- 	<tiles:putAttribute name="head">
		<link href="${contextPath}/resources/${codeIsoLang}/css/creation_compte.css" rel="stylesheet" type="text/css" />
	</tiles:putAttribute>
 --%>	<tiles:putAttribute name="description">Remerciement :</tiles:putAttribute>
 
	 <tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}${contextPath}${requestScope['javax.servlet.forward.servlet_path']}
	</tiles:putAttribute>

	<tiles:putAttribute name="content">
		<div id="content" class="confirmation">
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
							<div id="contenu_interieur">
								<div class="coordonnees">
									<c:choose>
										<c:when test="${not isServiceClient }">
										<h2>Votre commande a &eacute;t&eacute; enregistr&eacute; sous le N&deg;${order.numOrderBiz} le <fmt:formatDate value="${order.dateOrder}" pattern="dd/MM/yyyy 'à' HH:mm" /> pour un montant de <fmt:formatNumber value="${order.total}" currencySymbol="${devise}" type="currency"></fmt:formatNumber></h2>
										</c:when>
										<c:when test="${isServiceClient }">
										<h2><spring:message code="acknowledgement.messageServiceClient"/></h2>
										</c:when>
										<c:otherwise></c:otherwise>										
									</c:choose>
								</div>
							</div>
						</div>
						<div class="ems_mot">${animationBody }</div>
					</div>
				</div>
		</div>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="ems">
		${animationBody}
	</tiles:putAttribute>
	
	<tiles:putAttribute name="moreJS">
		<!-- Début Tag de Conversion Adwords --> 
		<script type="text/javascript"> 
		/* <![CDATA[ */ 
		var google_conversion_id = 1018644718; 
		var google_conversion_language = "fr"; 
		var google_conversion_format = "3"; 
		var google_conversion_color = "ffffff"; 
		var google_conversion_label = "6AYMCNrCowIQ7pHd5QM"; 
		if (${totalOrder}) { 
		   var google_conversion_value = ${totalOrder};
		} 
		/* ]]> */ 
		</script> 
		<script type="text/javascript"   
		src="http://www.googleadservices.com/pagead/conversion.js"> 
		</script> 
		
		<script type="text/javascript">
			$(document).ready(function(){
				if($.cookie('reloadable') == 'true'){
					$.cookie('reloadable', 'false', { expires: 30, path: '/'});
					
				}
			});
		</script>
		
		<noscript> 
		<div style="display:inline;"> 
		<img height="1" width="1" style="border-style:none;" alt=""   
		src="http://www.googleadservices.com/pagead/conversion/1018644718/?value=${order.total}&amp;label=6AYMCNrCowIQ7pHd5QM&amp;guid=ON&amp;script=0"/> 
		</div>
		</noscript> 
		<!-- Fin Tag de Conversion Adwords -->
		<c:if test="${isTagMetafiliationActivated }">
			<script type="text/javascript" src="http://img.metaffiliation.com/u/11/p33385.js?zone=fincommande&montant=${order.total}&listeids=${articleIds}&idtransaction=${order.orderId}"></script>
		</c:if>
	</tiles:putAttribute>
	
</tiles:insertDefinition>