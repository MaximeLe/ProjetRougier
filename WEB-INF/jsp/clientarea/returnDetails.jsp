<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<tiles:insertDefinition name="templateMenu">
	<tiles:putAttribute name="title"><spring:message code="order.detailRetour"/></tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="order.detailRetour"/></tiles:putAttribute>
	
	<tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}${requestScope['javax.servlet.forward.servlet_path']}
	</tiles:putAttribute>
	
	<tiles:putAttribute name="breadcrumb">
		||&nbsp;<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt;<span class="lien_chemin"><a href="${contextPath}/myReturns.html"><spring:message code="clientAreaMenu.mesRetours"/></a></span>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="menu">
		<c:import url="clientAreaMenu.jsp"/>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<div id="clients" class="mes_retours">
			<div id="contenu_interieur">
				<div id="returnDetails">
					<div class="coordonnees">
						<div class="floatRight" style="padding: 10px;"><a class="deco" href="${contextPath}/login.html?logout"><spring:message code="customerAccount.deconnexion"/></a></div>
						<h2><spring:message code="order.monRetour"/><fmt:formatDate value="${returnDemand.dateDemand}" pattern="dd/MM/yyyy" /> </h2>
					</div>
					<div class="contenu_blanc">
						<table style="text-align: center; vertical-align: middle;">
								<tr>
									<th class="reference"><spring:message code="order.reference"/></th>
									<th class="libelle"><spring:message code="order.article"/></th>
									<th class="statut"><spring:message code="order.statut"/></th>
		 							<th class="quantité"><spring:message code="order.quantiteRet"/></th> 
									<th class="motifs"><spring:message code="order.motifs"/></th>
								</tr>
								<c:forEach items="${returnDemand.linesReturnDemand}" var="line">
									<tr>
										<td>${line.articleBiz}</td>
										<td>${line.wordingProduct}</td>
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
										<td>${line.quantityReturn}</td>
										<td>${line.returnCause.causeReturnWording}</td>
									</tr>
								</c:forEach>
						</table>
						<br/>
						<table>
							<tr>
								<td>
									<label for="motif"><span class="gras"><spring:message code="order.pourValider"/> <br></span></label>							
								</td>
								<td>
									<table>
										<tr>
											<td>
											<div class="imprimer" onclick="javascript:printReturnDemand(${returnDemand.returnDemandId})">
												<img src="${contextPath}/resources/${codeIsoLang}/img/clientArea/picto_imprimante.png" alt="<spring:message code="order.imprimer"/>" title="<spring:message code="order.imprimer"/>" />
											</div>
											</td>
										</tr>
										<tr>
											<td rowspan="2">
												<spring:message code="order.recapitulatifDemande"/>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>		
					</div>
				</div>
			</div>				
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="moreJS">
		<script src="${contextPath}/resources/js/clientArea/printReturnDemand.js" type="text/javascript"></script>
		<script>$("#menu .menu ul:eq(1) li:eq(1) a").attr("style","color:#FF7F00;font-weight:bold;");</script>
	</tiles:putAttribute>
</tiles:insertDefinition>