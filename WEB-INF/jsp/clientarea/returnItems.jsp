<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<tiles:insertDefinition name="templateMenu">
	<tiles:putAttribute name="title"><spring:message code="clientAreaMenu.effectuerRetour"/></tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="clientAreaMenu.effectuerRetour"/></tiles:putAttribute>
	
	<tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}${requestScope['javax.servlet.forward.servlet_path']}
	</tiles:putAttribute>
	
	<tiles:putAttribute name="breadcrumb">
		||&nbsp;<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt;<span class="lien_chemin"><a href="${contextPath}/viewOrders.html"><spring:message code="clientAreaMenu.visualiserCommandes"/></a>
			</span>&nbsp;&gt;<span class="lien_chemin"><a href="${contextPath}/viewOrdersDetails.html?orderId=${order.orderId}"><spring:message code="order.commandeNum"/>${order.numOrderBiz}</a></span>&nbsp;&gt;<span class="lien_chemin"><spring:message code="clientAreaMenu.effectuerRetour"/></span>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="menu">
		<c:import url="clientAreaMenu.jsp"/>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<div id="clients" class="effectuer_retour">
			<div id="contenu_interieur">
				<div class="coordonnees">
					<div class="floatRight" style="padding: 10px;"><a class="deco" href="${contextPath}/login.html?logout"><spring:message code="customerAccount.deconnexion"/></a></div>
					<h2><spring:message code="order.effectuerRetour"/>&nbsp;-&nbsp;<spring:message code="order.retourCommandeNum"/>${order.numOrderBiz}&nbsp;<spring:message code="order.du"/>&nbsp;<fmt:formatDate value="${order.dateOrder}" pattern="dd/MM/yyyy 'à' HH:mm" /></h2>
				</div>
				
				<div class="contenu_blanc">
					<c:if test="${error != null}">
						<div style="color:red">${error}</div>
					</c:if>
					<%-- <c:if test="${oder.isReturnDemandExist}"> --%>
					<form name="form_visualiser_commandes"  method="post">
						<div class="detail_commande">
							<label for="motif"><span class="gras"><spring:message code="order.retourMaCommandeNum"/>${order.numOrderBiz}&nbsp;<spring:message code="order.du"/>&nbsp;<fmt:formatDate value="${order.dateOrder}" pattern="dd/MM/yyyy 'à' HH:mm" /></span></label>
							<select name="returnCause" id="returnCause">
								<c:forEach items="${returnCauseList}" var="returnCause">
 									<option value="${returnCause.causeReturnId}" class="grise" >${returnCause.causeReturnWording}</option>
								</c:forEach>
							</select>
						</div>
						<table>
							<tr>
								<th><spring:message code="order.article"/></th>
								<th><spring:message code="order.motifRetour"/></th>
								<th><spring:message code="order.statut"/></th>
								<th><spring:message code="order.quantiteExp"/></th>
								<th><spring:message code="order.quantiteRet"/></th>
							</tr>
							<c:forEach items="${order.orderLines}" var="item" varStatus="status">
							<c:if test="${!item.isReturnDemandExist}">
								<tr>
									<td>
										${item.wordingProduct}
										<!-- si l'article a déja donné lieu à une demande de retour -->
											<spring:message code="order.retournerArticle"/>
											<input type="checkbox" value="${status.index}" name="returned" />
									</td>
									<td>
										<select name="returnCause${item.orderLineId}" id="returnCause${item.orderLineId}">
											<c:forEach items="${returnCauseList}" var="returnCause">
			 									<option value="${returnCause.causeReturnId}" class="grise" >${returnCause.causeReturnWording}</option>
											</c:forEach>
										</select>
									</td>
									<td><spring:message code="order.expedieLe"/>&nbsp;<fmt:formatDate value="${order.dateOrder}" pattern="dd/MM/yyyy 'à' HH:mm" /></td>
									<td>${item.quantity}</td>
									<td>
										<select name="quantity${item.orderLineId}" id="quantity${item.orderLineId}">
											<c:forEach begin="1" end="${item.quantity}" step="1" varStatus="status">
			 									<option value="${status.index}">${status.index}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
							</c:if>
							</c:forEach>
						</table> 
						<div class="boutons">
							<c:set var="text"><spring:message code="accessCode.boutonJeValide"/></c:set>
							<fwk:genericButton text="${text}" firstSpanClass="Org_small" buttonType="submit" />
						</div>
					</form>
					<%-- </c:if>
					<c:if test="${!oder.isReturnDemandExist}">
						vous avez déjà effectué le retour de cette commande
					</c:if> --%>
				</div>
				<div id="fond_blanc"></div>
			</div>				
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="moreJS">
		<script>$("#menu .menu ul:eq(1) li:eq(0) a").attr("style","color:#FF7F00;font-weight:bold;");</script>
	</tiles:putAttribute>
</tiles:insertDefinition>