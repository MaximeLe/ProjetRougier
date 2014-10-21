<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="menu" class="menu_clients">
	<div class="menu">
		<div class="titre"><spring:message code="clientAreaMenu.title"/></div>
	</div>
	<div class="contenu_menu">
		<div class="groupement">
			<span><spring:message code="clientAreaMenu.mesInformations"/></span>
			<ul>
				<li><a href="${contextPath}/account.html"><spring:message code="clientAreaMenu.monCompte"/></a></li>
				<li><a href="${contextPath}/accessCode.html"><spring:message code="clientAreaMenu.mesCodesAcces"/></a></li>
				<li><a href="${contextPath}/addressInformation.html"><spring:message code="clientAreaMenu.mesCoordonnees"/></a></li>
				<li><a href="${contextPath}/addressBook.html"><spring:message code="clientAreaMenu.monCarnetAdresses"/></a></li>
				<li><a href="${contextPath}/favoriteShop.html"><spring:message code="clientAreaMenu.monMagasinPrefere"/></a></li>
				<li><a href="${contextPath}/wishList.html"><spring:message code="clientAreaMenu.mesListesSouhaits"/></a></li>
			</ul>
		</div>
		<div class="groupement">
			<span><spring:message code="clientAreaMenu.mesCommandes"/></span>
			<ul>
				<li><a href="${contextPath}/viewFiveLastOrders.html"><spring:message code="clientAreaMenu.visualiserCommandes"/></a></li>
			</ul>
		</div>
	</div>
	<div id="menu_bas">
	</div>
</div>