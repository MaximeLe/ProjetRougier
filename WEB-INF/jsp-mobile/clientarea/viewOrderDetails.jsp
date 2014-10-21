<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags"      prefix="spring" %>

<c:set var="devise"><c:choose><c:when test="${storeId==2}">&#36;</c:when><c:otherwise>€</c:otherwise></c:choose></c:set>

<tiles:insertDefinition name="templateMenu">
	<tiles:putAttribute name="title"><spring:message code="clientAreaMenu.visualiserCommandes"/></tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="clientAreaMenu.visualiserCommandes"/></tiles:putAttribute>
	
	<tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}${contextPath}${requestScope['javax.servlet.forward.servlet_path']}
	</tiles:putAttribute>
	
	<tiles:putAttribute name="breadcrumb">
		<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt;
		<span class="lien_chemin"><a href="${contextPath}/account.html"><spring:message code="clientAreaMenu.monCompte"/></a></span>&nbsp;&gt;
		<span class="lien_chemin"><a href="${contextPath}/viewOrders.html"><spring:message code="clientAreaMenu.visualiserCommandes"/></a></span>&nbsp;&gt;
		<span class="lien_chemin"><spring:message code="order.commandeNum"/>${order.numOrderBiz}</span>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="head"><link href="${contextPath}/resources/${codeIsoLang}/css/print.css" media="print" rel="stylesheet" type="text/css" /></tiles:putAttribute>
	
	<tiles:putAttribute name="ems">&nbsp;</tiles:putAttribute>
	
	<tiles:putAttribute name="menu">
		<c:import url="clientAreaMenu.jsp"/>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<div id="clients" class="visualiser_detail_commandes">
			<div class="contenu_interieur">
				<div class="coordonnees">
					<div class="emplacement_titre">
						<h2>
							<spring:message code="order.commandeNum"/>${order.numOrderBiz}&nbsp;<spring:message code="order.du"/>&nbsp;<fmt:formatDate value="${order.dateOrder}" pattern="dd/MM/yyyy 'à' HH:mm" />
						</h2>
					</div>
					<c:if test="${not empty colis}">
					<div class="liens_colis">
						<c:forEach items="${colis}" var="aColis" varStatus="status">
							<div class="liens"><spring:message code="order.suiviColis"/> <a href="${aColis.customFields}">${aColis.numPacket}</a></div>
						</c:forEach>
					</div>
					</c:if>
					<div class="boutons">						
						<c:set var="text"><spring:message code="order.boutonEffectuerRetour"/></c:set>
						<fwk:genericButton text="${text}" href="javascript:history.go(-1);" firstSpanClass="Black_small" />
					</div>
				</div>
				
				<div class="contenu_blanc">	
					<div class="ctn_tableau">
						<ul id="entete_tableau" class="tableau">
							<li class="colonne1"><span><spring:message code="order.reference"/></span></li>
							<li class="colonne2"><span><spring:message code="order.article"/></span></li>
							<li class="colonne3"><span><spring:message code="order.quantite"/></span></li>
							<li class="colonne4"><span><spring:message code="order.etat"/></span></li>
							<li class="colonne5"><span><spring:message code="order.discriminant"/></span></li>
							<li class="colonne6"><span><spring:message code="order.montant"/></span></li>
						</ul>
				
						<c:forEach items="${order.orderLines}" var="line">
							<ul class="tableau separation" >
								<li class="colonne1">${line.articleBiz}</li>
								<li class="colonne2">${line.wordingProduct}</li>
								<li class="colonne3">${line.quantity}</li>
								<li class="colonne4">${line.statusOrder.wordingFO}
									<c:if test="${not empty line.statusOrder.dateChange }">
										<br/><fmt:formatDate value="${line.statusOrder.dateChange}" pattern="dd/MM/yyyy" />
									</c:if>
								</li>
								<li class="colonne5">
									<c:if test="${not empty line.discriminant1}">
										${line.discriminant1}:${line.discriminant1Value}
									</c:if>
								</li>
								<c:forEach var="tva" items="${tauxTva}">
									<c:choose>
										<c:when test="${tva.value == line.taxPercent}">
								    		<li class="colonne6"><fmt:formatNumber value="${line.totalLine}" currencySymbol="${devise}" type="currency"></fmt:formatNumber>&nbsp;<sup style="vertical-align:5px; font-size:80%">${tva.key}</sup></li>										
										</c:when>
									</c:choose>
								</c:forEach>
							</ul>
						</c:forEach>
						
					<ul id="ligne_ss_total" class="separation border">
						<li class="vide"><span class="gras"><spring:message code="order.sousTotal"/></span></li>
						<li class="montant_tot"><span class="gras"><fmt:formatNumber value="${order.totalItems}" currencySymbol="${devise}" type="currency"></fmt:formatNumber></span></li>
					</ul>
					<ul id="ligne_frais_de_port" class="separation">
						<li class="vide"><spring:message code="order.fraisDePort"/></li>
						<li class="montant_tot">+<fmt:formatNumber value="${order.totalShippingFee}" currencySymbol="${devise}" type="currency"></fmt:formatNumber></li>
					</ul>
					<c:forEach items="${order.discountsForOrder}" var="discount"> 
							<c:if test="${discount.applyOnObjectTypeId == 1}">
								<ul id="ligne_remises_frais_port" class="separation" >
								<li class="vide"><spring:message code="order.RemiseFraisDePortmontant"/></li>
								<li class="montant_tot">-<fmt:formatNumber value="${discount.discountValue * discount.quantity}" currencySymbol="${devise}" type="currency"></fmt:formatNumber></li>
								</ul>
							</c:if>
					</c:forEach>
					<c:if test="${montantAutreRemise >0}">
									<ul id="ligne_remises_autres" class="separation" >
									<li class="vide"><spring:message code="order.RemiseAutremontant"/></li>
									<li class="montant_tot">-<fmt:formatNumber value="${montantAutreRemise}" currencySymbol="${devise}" type="currency"></fmt:formatNumber></li>
								</ul>
					</c:if>
					
					<ul id="ligne_total_commande" class="separation">
						<li class="paiement"><span class="gras"><spring:message code="order.totalCommandeHT"/></span></li>
						<li class="montant_tot_com"><span class="gras"><fmt:formatNumber value="${order.total - order.totalTaxAmount}" currencySymbol="${devise}" type="currency"></fmt:formatNumber></span></li>
					</ul>
					
					<ul id="ligne_total_commande" class="separation">
						<li class="paiement"><span class="gras"><spring:message code="order.totalCommandeTTC"/></span></li>
						<li class="montant_tot_com"><span class="gras"><fmt:formatNumber value="${order.total}" currencySymbol="${devise}" type="currency"></fmt:formatNumber></span></li>
					</ul>

						<c:forEach items="${order.transactions}" var="transaction" varStatus="num"  begin="0" end="0"> 
							<ul class="separation" >
								<li class="vide"><spring:message code="order.moyenPaiement"/></li>
								<li class="montant_tot">${transaction.libelleTypeTransaction}</li>
							</ul>
						</c:forEach>
				</div>
				
				<!-- Affichage des taux de TVA -->
				<div style="float:left; margin-top:10px; padding-top:5px; width:768px;">
					<div style="width:200px; float:left">
						<c:forEach var="tva" items="${tauxTva}">
							<c:forEach var="tvaValeur" items="${montantTotalTva}">
								<c:if test="${tva.key == tvaValeur.key}">
									<p style="float:left; width:100%; padding:0; margin:0px 0px 5px 10px"><sup style="vertical-align:4px; font-size:80%">${tva.key}</sup> : TVA à ${tva.value}% soit : <fmt:formatNumber value="${tvaValeur.value}" currencySymbol="${devise}" type="currency" /></p>	
								</c:if>
							</c:forEach>
						</c:forEach>
					</div>
				</div>
				
					<div>
						<div class="adresse_facturation">
							<span class="gras"><spring:message code="order.adresseFacturation"/></span><br/><br/>
							<span>
								${order.addressBilling.firstName}&nbsp;${order.addressBilling.lastName}
								<br/>
									${order.addressBilling.addressLine1}
									<c:if test="${not empty order.addressBilling.addressLine2 }">
										<br/>
										${order.addressBilling.addressLine2}
									</c:if>
									<c:if test="${not empty order.addressBilling.addressLine3}">
									<br/>
										${order.addressBilling.addressLine3}
									</c:if>
								<br/>
								${order.addressBilling.zipCode}&nbsp;${order.addressBilling.city}
							</span>
						</div>
						<div class="adresse_livraison">
						<span class="gras"><spring:message code="order.adresseLivraison"/></span><br/><br/>
							<span>
								<c:if test="${!isLivraisonMagasin}">${order.addressDelivery.firstName}&nbsp;</c:if>${order.addressDelivery.lastName}
								<br/>
									${order.addressDelivery.addressLine1}
									<c:if test="${not empty order.addressDelivery.addressLine2}"><br/>
										${order.addressDelivery.addressLine2}
									</c:if>
									<c:if test="${not empty order.addressDelivery.addressLine3}"><br/>
										${order.addressDelivery.addressLine3}
									</c:if>
									<br/>
								${order.addressDelivery.zipCode}&nbsp;${order.addressDelivery.city}
							</span>
						</div>
						<c:if test="${order.statusOrder.wordingMO == 'Expédié'}">
						<div class="imprimer" onClick="window.print();">
								<img src="${contextPath}/resources/${codeIsoLang}/img/clientArea/btn_imprimer.jpg" alt="<spring:message code="order.imprimer"/>" title="<spring:message code="order.imprimer"/>" width="79" height="28" />
						</div>
						</c:if>
						<a class="ttes_commandes" href="viewOrders.html"><spring:message code="order.voirToutesMesCommandes"/></a>
					</div>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="moreJS">
		<script>
			$("#menu .contenu_menu ul:eq(1) li:eq(0) a").attr("style","color:#000000;");
			$("#menu .contenu_menu ul:eq(1) li:eq(0) a").removeAttr("href");
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>