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
		<span class="lien_chemin"><spring:message code="clientAreaMenu.visualiserCommandes"/></span>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="ems">&nbsp;</tiles:putAttribute>
	
	<tiles:putAttribute name="menu">
		<c:import url="clientAreaMenu.jsp"/>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<div id="clients" class="visualiser_commandes">
			<div id="contenu_interieur">
				<div class="coordonnees">
					<h2>
						<spring:message code="clientAreaMenu.visualiserCommandes"/>
						<c:if test="${customer.blackListed}">
							<span style="color: red;">&nbsp;<spring:message code="customerAccount.compteBlackliste"/></span>
						</c:if>
						<c:if test="${customer.disabled}">
							<span style="color: red;">&nbsp;<spring:message code="customerAccount.compteDesactive"/></span>
						</c:if>						
					</h2>
				</div>
				<div class="contenu_blanc">
					<c:if test="${empty orderList}">
						<div class="aucune">
							<spring:message code="order.aucuneCommande"></spring:message>
						</div>
					</c:if>
					<c:if test="${!empty orderList}">
						<div class="ctn_tableau">
						
						<ul id="entete_tableau" class="tableau">
							<li class="colonne1"><span><spring:message code="order.numCommande"/></span></li>
							<li class="colonne2"><span><spring:message code="order.date"/></span></li>
							<li class="colonne3"><span><spring:message code="order.etat"/></span></li>
							<li class="colonne4"><span><spring:message code="order.montant"/></span></li>
							<li class="colonne5"><span><spring:message code="order.details"/></span></li>
							<li class="colonne6"><span>&nbsp;</span></li>
						</ul>

						<c:forEach items="${orderList}" var="order" varStatus="status">
								<ul class="tableau separation" onclick="window.location = 'viewOrderDetails.html?orderId=' + ${order.orderId};">
									<li class="colonne1">${order.numOrderBiz}</li>
									<li class="colonne2"><fmt:formatDate value="${order.dateOrder}" pattern="dd/MM/yyyy" /></li>
									<li class="colonne3">${order.statusOrder.wordingFO}
										<c:if test="${not empty line.statusOrder.dateChange }">
											<br/><fmt:formatDate value="${line.statusOrder.dateChange}" pattern="dd/MM/yyyy" />
										</c:if>
									</li>
									<li class="colonne4">
										<fmt:formatNumber value="${order.total}" currencySymbol="${devise}" type="currency"></fmt:formatNumber>
									</li>
									<li class="colonne5"><a href="viewOrderDetails.html?orderId=${order.orderId}">Voir le détail</a></li>
									<c:choose>
										<c:when test="${colis[order.orderId] !=null && fn:length(colis[order.orderId]) == 1}">
											<c:forEach items="${colis[order.orderId]}" var="aPack" varStatus="status">
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
								<c:if test="${colis[order.orderId] !=null && fn:length(colis[order.orderId])>1}">
									<!-- Le cas avec suivi de colis -->
									<c:forEach items="${colis[order.orderId]}" var="aPack" varStatus="status">
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

						</div>
						<!-- voir mes 5 dernieres commandes -->
						<a class="ttes_commandes" href="viewFiveLastOrders.html"><spring:message code="order.voirMesCinqDernieresCommandes"/></a>
					</c:if>
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