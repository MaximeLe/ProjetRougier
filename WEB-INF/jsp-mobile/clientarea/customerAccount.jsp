<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="devise"><c:choose><c:when test="${storeId==2}">&#36;</c:when><c:otherwise>&euro;</c:otherwise></c:choose></c:set>

<tiles:insertDefinition name="templateMenu">
	<tiles:putAttribute name="title"><spring:message code="customerAccount.title"/></tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="customerAccount.affichageMonCompte"/></tiles:putAttribute>
	
	<tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}${contextPath}${requestScope['javax.servlet.forward.servlet_path']}
	</tiles:putAttribute>
	
	<tiles:putAttribute name="head">
		<style>
		</style>
	</tiles:putAttribute>
	<tiles:putAttribute name="breadcrumb">
		<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt;&nbsp;<span class="lien_chemin"><spring:message code="clientAreaMenu.monCompte"/></span>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="ems">&nbsp;</tiles:putAttribute>
	
	<tiles:putAttribute name="menu">
		<c:import url="clientAreaMenu.jsp"/>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<div id="clients" class="accueil">
			<div id="contenu_interieur">
				<div class="coordonnees">
					<c:choose>
						<c:when test="${customer.civility == 2}"><c:set var="civilityTitle"><spring:message code="signUp.madame"/></c:set></c:when>
						<c:when test="${customer.civility == 3}"><c:set var="civilityTitle"><spring:message code="signUp.mademoiselle"/></c:set></c:when>
						<c:otherwise>
							<c:set var="civilityTitle"><spring:message code="signUp.monsieur"/></c:set>
						</c:otherwise>
					</c:choose>
					<span><spring:message code="customerAccount.bonjour"/>&nbsp;${civilityTitle}&nbsp;${customer.lastName}&nbsp;${customer.firstName}.&nbsp;<spring:message code="customerAccount.bienvenue"/>
						<c:if test="${customer.blackListed}">
							<span style="color: red;">&nbsp;<spring:message code="customerAccount.compteBlackliste"/></span>
						</c:if>
						<c:if test="${customer.disabled}">
							<span style="color: red;">&nbsp;<spring:message code="customerAccount.compteDesactive"/></span>
						</c:if> 
					</span>
				</div>
				<c:if test="${empty couponList && empty commandes}">
					<div class="ems full">
						${animation}
					</div>
				
				</c:if>
				<c:if test="${!empty couponList || !empty commandes}">
				<div class="contenu_blanc">					
					<div class="mes_coupons">
						<div class="titre">
							<span><spring:message code="customerAccount.mesCoupons"/></span>
						</div>
						<div class="contenu_coupons">
							<c:if test="${!empty couponList}">
								<c:forEach items="${couponList}" var="coupon">
									<div class="codes">
										<span>${coupon.code}&nbsp;:&nbsp;<%-- ${coupon.operation.libelleMetier}--%></span>
			 						</div>
									<div class="valables">
										<span><spring:message code="customerAccount.valable"/><fmt:formatDate value="${coupon.dateEnd}" pattern="dd/MM/yyyy" /></span>
									</div>
								</c:forEach>
							</c:if>
							<c:if test="${empty couponList}">
								<span><spring:message code="customerAccount.aucunCoupon"></spring:message></span>
							</c:if>
						</div>
					</div>
					<div class="mes_commandes">
						<div class="titre">
							<span class="gras"><spring:message code="customerAccount.mesCommandes"/></span>
						</div>
						<div class="commandes">

					<c:if test="${!empty commandes}">
						<ul id="entete_tableau" class="tableau">
							<li class="colonne1"><span><spring:message code="order.numCommande"/></span></li>
							<li class="colonne2"><span><spring:message code="order.date"/></span></li>
							<li class="colonne3"><span><spring:message code="order.etat"/></span></li>
							<li class="colonne4"><span><spring:message code="order.montant"/></span></li>
							<li class="colonne5"><span><spring:message code="order.details"/></span></li>
							<li class="colonne6"><span>&nbsp;</span></li>
						</ul>

						<c:forEach items="${commandes}" var="commande" begin="0" end="4">
							<ul class="tableau">		
								<li class="colonne1"><span>${commande.numOrderBiz}</span></li>
								<li class="colonne2"><span><fmt:formatDate value="${commande.dateOrder}" pattern="dd/MM/yyyy"/></span></li>
								<li class="colonne3"><span>${commande.statusOrder.wordingFO}</span></li>
								<li class="colonne4"><span><fmt:formatNumber value="${commande.total}" currencySymbol="${devise}" type="currency"></fmt:formatNumber></span></li>
								<li class="colonne5"><a href="viewOrderDetails.html?orderId=${commande.orderId}">Voir le détail</a></li>
								<c:choose>
										<c:when test="${colis[commande.orderId] !=null && fn:length(colis[commande.orderId]) == 1}">
											<c:forEach items="${colis[commande.orderId]}" var="aPack" varStatus="status">
											    <c:if test="${aPack.customFields!=null}">
													<li class="colonne6"><a href="${aPack.customFields}"target="_blank">Suivi colis</a></li>
												</c:if>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<li class="colonne6"><span>&nbsp;</span></li>
										</c:otherwise>
									</c:choose>
								</ul>
								<c:if test="${colis[commande.orderId] !=null && fn:length(colis[commande.orderId])>1}">
									<!-- Le cas avec suivi de colis -->
									<c:forEach items="${colis[commande.orderId]}" var="aPack" varStatus="status">
										<c:if test="${aPack.customFields!=null}">
											<ul class="tableau ouvert">		
												<li class="colonne1"><span>Colis ${aPack.numPacket}</span></li>
												<li class="colonne2"><span>-</span></li>
												<li class="colonne3"><span>-</span></li>
												<li class="colonne4"><span>-</span></li>
												<li class="colonne5"><span>-</span></li>
												<li class="colonne6"><a href="${aPack.customFields}"target="_blank">Suivi colis</a></li>
											</ul>
										</c:if>
									</c:forEach>
								<!--  fin le cas avec suivi de colis -->
							</c:if>
						</c:forEach>
						
						<ul class="separation">
							<li><img src="${contextPath}/resources/${codeIsoLang}/img/clientArea/client_separation_commandes.jpg" width="768" height="1" alt="separation" /></li>
						</ul>
						
						<c:if test="${fn:length(commandes)>5}">
							<ul class="toutes_commandes">
							<li><a href="viewOrders.html"><spring:message code="customerAccount.toutesCommandes"></spring:message></a></li>
						</ul>
						</c:if>
							</c:if>
							<c:if test="${empty commandes}">
								<div class="aucune_commande">
									<span><spring:message code="customerAccount.aucuneCommande"></spring:message></span>
								</div>
							</c:if>	
							</div>
						</div>
					</div>
						<div class="ems">
							${animation}
						</div>
					</c:if>

				</div>
			</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="moreJS">
		<script>
			$("#menu .contenu_menu ul:eq(0) li:eq(0) a").attr("style","color:#000000;");
			$("#menu .contenu_menu ul:eq(0) li:eq(0) a").removeAttr("href");
			<c:if test="${not empty retrieveCart}">
				Box.open({
					modal: true,
					urldata : "action=addToCartNuanceProduct&source=persistancePanier&nuancesChain="+${retrieveCart},
					url : contextPath+"/cart.html",
					cache: false,
					
					afterShow:function(){
						majPanier();				
					}
				});
			</c:if>
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>