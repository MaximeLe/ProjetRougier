<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags"      prefix="spring" %>

<c:set var="devise"><c:choose><c:when test="${storeId==2}">&#36;</c:when><c:otherwise>&euro;</c:otherwise></c:choose></c:set>

<tiles:insertDefinition name="templateMenu">
	<tiles:putAttribute name="title"><spring:message code="clientAreaMenu.monEspaceCarte"/></tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="clientAreaMenu.monEspaceCarte"/></tiles:putAttribute>
	
	<tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}${requestScope['javax.servlet.forward.servlet_path']}
	</tiles:putAttribute>
	
	<tiles:putAttribute name="breadcrumb">
		||&nbsp;<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt;<span class="lien_chemin"><spring:message code="clientAreaMenu.monEspaceCarte"/></span>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="menu">
		<c:import url="clientAreaMenu.jsp"/>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<div id="clients" class="espace_carte">
			<div id="contenu_interieur">
				<div class="coordonnees">
					<div class="floatRight" style="padding: 10px;"><a class="deco" href="${contextPath}/login.html?logout"><spring:message code="customerAccount.deconnexion"/></a></div>
					<h2>
						<spring:message code="clientAreaMenu.monEspaceCarte"/>
						<c:if test="${customer.blackListed}">
							<span style="color: red;">&nbsp;<spring:message code="customerAccount.compteBlackliste"/></span>
						</c:if>
						<c:if test="${customer.disabled}">
							<span style="color: red;">&nbsp;<spring:message code="customerAccount.compteDesactive"/></span>
						</c:if>
					</h2>
				</div>
				<div class="contenu_blanc">
					<c:if test="${!empty fidelityCard}" >	
						<div class="titre">
							<span><spring:message code="customerAccount.numeroDeCarte"/>${fidelityCard.numCardBiz}</span>
						</div>
						<div class="solde">
							<div class="solde_points">
								<span><spring:message code="customerAccount.soldePoints"/> <fmt:formatDate value="${fidelityCard.dateUpdate}" pattern="dd/MM/yyyy" /></span>
								<span class="gras">${fidelityCard.balancePoints}&nbsp;<spring:message code="customerAccount.points"/></span>
							</div>
							<span>
								<spring:message code="customer.plusQue"> </spring:message>&nbsp;${fidelityCard.nbPointsLess}&nbsp; <spring:message code="customerAccount.points"/>&nbsp;
								<spring:message code="customer.pourBeneficier"></spring:message>${fidelityCard.amountCheck} &nbsp; ${devise}&nbsp;
								<spring:message code="customer.deRemise"></spring:message>
							</span>
						</div>
					</c:if>
					<c:if test="${empty fidelityCard}">
						<span><spring:message code="customerAccount.noCarte"/></span>
					</c:if>	
					
						<div class="EMS_avantages">
							<img src="${contextPath}/resources/${codeIsoLang}/img/clientArea/EMS_2.gif" alt="EMS"/>
							<div class="mes_avantages">
								<c:if test="${!empty couponList}">
								<span class="gras"><spring:message code="customer.mesAvantages"/></span>
									<c:forEach items="${couponList}" var="coupon">
										<div class="codes">
											${coupon.operation.libelleMetier}
				 						</div>
									</c:forEach>
								</c:if>
							</div>
						</div>
				</div>
				<div id="fond_blanc"></div>
			</div>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="moreJS">
		<script>$("#menu .menu ul:eq(2) li:eq(0) a").attr("style","color:#FF7F00;font-weight:bold;");</script>
	</tiles:putAttribute>
</tiles:insertDefinition>