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
	<tiles:putAttribute name="title"><spring:message code="clientAreaMenu.mesRetours"/></tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="clientAreaMenu.mesRetours"/></tiles:putAttribute>
	
	<tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}${requestScope['javax.servlet.forward.servlet_path']}
	</tiles:putAttribute>
	
	<tiles:putAttribute name="breadcrumb">
		||&nbsp;<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt;<span class="lien_chemin"><spring:message code="clientAreaMenu.mesRetours"/></span>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="ems">&nbsp;</tiles:putAttribute>
	
	<tiles:putAttribute name="menu">
		<c:import url="clientAreaMenu.jsp"/>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<div id="clients" class="mes_retours">
			<div id="contenu_interieur">
				<div id="retour">
					<div class="coordonnees">
						<div class="floatRight" style="padding: 10px;"><a class="deco" href="${contextPath}/login.html?logout"><spring:message code="customerAccount.deconnexion"/></a></div>
						<h2>
							<spring:message code="clientAreaMenu.mesRetours"/>
							<c:if test="${customer.blackListed}">
								<span style="color: red;">&nbsp;<spring:message code="customerAccount.compteBlackliste"/></span>
							</c:if>
							<c:if test="${customer.disabled}">
								<span style="color: red;">&nbsp;<spring:message code="customerAccount.compteDesactive"/></span>
							</c:if>
						</h2>
					</div>
					<div class="contenu_blanc">
						<c:if test="${!empty returnDemandList}">
						<table style="text-align: center; vertical-align: middle;">
							<tr>
								<th class="date_dmd"><spring:message code="order.dateDemande"/></th>
								<th class="motifs"><spring:message code="order.motifs"/></th>
								<th class="nbr_art"><spring:message code="order.nbArticlesRetournes"/></th>
	 							<th class="statut"><spring:message code="order.statut"/></th> 
								<th class="montant"><spring:message code="order.montant"/></th>
								<th class="date_rbt"><spring:message code="order.dateRemboursement"/></th>
							</tr>
							
							<c:forEach items="${returnDemandList}" var="returnDemand">
								<tr onclick="window.location = 'returnDetails.html?returnDemandId=${returnDemand.returnDemandId}'">
									<td><fmt:formatDate value="${returnDemand.dateDemand}" pattern="dd/MM/yyyy 'à' HH:mm" /></td>
									<td>${returnDemand.returnDemandCause.causeReturnWording}</td>
									<td>${returnDemand.nbLineReturnDemand}</td>
 									<td>
										<c:choose>
										<c:when test="${returnDemand.return == null}" >
											<spring:message code="order.enCours"/>
										</c:when>
										<c:otherwise>
											<spring:message code="order.valide"/>
										</c:otherwise>
										</c:choose>
									</td>
									<td><fmt:formatNumber value="${returnDemand.return.repayment.amount}" currencySymbol="${devise}" type="currency"></fmt:formatNumber></td>
									<td class="rbt"><fmt:formatDate value="${returnDemand.return.repayment.dateRepayment}" pattern="dd/MM/yyyy 'à' HH:mm" /></td>
								</tr>
							</c:forEach>
							
							
						</table>
						</c:if>
						<c:if test="${empty returnDemandList}">
							<spring:message code="order.noReturn"/>
						</c:if>
					</div>
				</div>
				<div id="fond_blanc"></div>
			</div>				
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="moreJS">
		<script>$("#menu .menu ul:eq(1) li:eq(1) a").attr("style","color:#FF7F00;font-weight:bold;");</script>
	</tiles:putAttribute>
</tiles:insertDefinition>