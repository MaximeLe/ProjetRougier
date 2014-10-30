<%@ page trimDirectiveWhitespaces="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.pictime.com/tags/core"  prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!-- BANDE ORANGE -->
<c:if test="${(context.instanceType) == 'STORE_PREVIEW'}">
	<div id="bandeorange">
		<div class="floatLeft"><spring:message code="header.vousEtes"/>&nbsp;<span class="gras"><spring:message code="header.modePreview"/></span></div>
		<div class="date">
			<spring:message code="header.date"/>&nbsp;<span class="gras"><fmt:formatDate value="${context.date}" pattern="dd/MM/yyyy HH:mm"/></span>
			<c:if test="${((context.instanceType) == 'STORE_PREVIEW') && (context.siteEditMode)}">
				<span style="margin-left: 5px;">
					<a href="/StoreManager/secure/ADM/modifierParametreValeurs.htm?action=editer&parametreId=1" title="modifier la date preview" target="storeManager"><img src="${contextPath}/resources/${codeIsoLang}/img/common/modifyBlack.png" style="border: 0px;"/></a>
				</span>
			</c:if>
		</div>
		<c:set var="activer"><spring:message code="header.activer"/></c:set>
		<c:set var="desactiver"><spring:message code="header.desactiver"/></c:set>
		<div class="floatRight"><a href="#" onclick="onClickSiteEditMod()" class="lien_blanc">${(context.siteEditMode)? desactiver:activer}&nbsp;<spring:message code="header.modeEdition"/></a></div>
	</div>
</c:if>

<!-- Header -->
<div id="header">

	<div class="logo">
		<a href="${contextPath}">
			<div class="image1">
				<img
					src="${contextPath}/resources-mobile/${codeIsoLang}/img/common/logo.png"
					alt="Rougier &amp; Plé – Matériel de Beaux-Arts et Loisirs créatifs"
					border="0" />
			</div>
		</a>
	</div>
	<div class="comptec">
		<a href="${contextPath}/login.html?request=account.html">
			<div class="image2">
				<div class="imgCentreCompte">
					<img
						src="${contextPath}/resources-mobile/${codeIsoLang}/img/common/picto-compte.png"
						alt="Mon compte" border="0" />
				</div>
			</div>
		</a>
	</div>
	<div class="panier">
		<a href="${contextPath}/cart.html">
			<div class="image3">
				<div class="nbArticles"></div>
				<div class="imgCentrePanier">
					<%-- 						<img src="${contextPath}/resources-mobile/${codeIsoLang}/img/common/picto-panier.png"  alt="Mon panier" border="0"/> --%>
				</div>
			</div>
		</a>
	</div>
	<div class="blocRecherche">
		<div class="recherche">
			<c:set var="url">
				<fwk:rewrite url="/search.html?catalogId=2" />
			</c:set>
			<form:form action="${url}" method="get"
				onsubmit="return validsearch(this);">
				<input id="recherche" type="text"
					value="<spring:message code='header.rechercher' />" name="text"
					autocomplete="off" maxlength="255"
					onFocus="if($('#recherche').val() == '<spring:message code='header.rechercher' />'){$('#recherche').val('');}"
					onBlur="if($('#recherche').val().trim() == ''){$('#recherche').val('<spring:message code='header.rechercher' />');}" />
				<input type="submit"
					value="<spring:message code='header.boutonOK' />" />
			</form:form>
		</div>
	</div>

</div>

<!-- Test si la session est vide, alors on déconnecte le client (hormis le cas ou le paiement a été annulé) -->
<c:if test="${sessionScope.cart == null && orderId == null}">

	<script type="text/javascript">
		if(existsCookie("RougierAuthentificationCookie")){	
			updateAuthentificationCookieStatus("false");			
		}
	</script>
</c:if>

<!-- Fin Popin Newsletter -->