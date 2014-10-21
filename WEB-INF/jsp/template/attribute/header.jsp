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
${EMS_HP_BANDEAU_TOP}
<div id="header">
	<div class="header2">
		<div class="logo" itemscope itemtype="http://schema.org/Organization"><a itemprop="url" href="${baseURLhttp}"><img itemprop="logo" src="${contextPath}/resources/${codeIsoLang}/img/common/logo.png" width="310" height="94" alt="Rougier &amp; Plé – Matériel de Beaux-Arts et Loisirs créatifs" border="0"/></a></div>
	<%-- 	<c:if test="${tunnel == false}"> --%>
<!-- 		<div class="newsletter"> -->
<%-- 			<form:form action="${contextPath}/newsletter.html" method="get" commandName="newsletter"> --%>
<%-- 				 <form:input path="email" onfocus="if($(this).val()=='votre adresse mail'){$(this).val('');}" onblur="if($(this).val()==''){$(this).val('votre adresse mail');}" maxlength="255"/> --%>
<%-- 				<input type="image" src="${contextPath}/resources/${codeIsoLang}/img/common/btnNewsOk.png" value="<spring:message code="header.boutonOK"/>"/> --%>
<%-- 			</form:form> --%>
<!-- 		</div> -->
<%-- 	</c:if> --%>
		<div class="recherche">	
			<c:set var="url">
				<fwk:rewrite url="/search.html?catalogId=2" />
			</c:set>
			<form:form action="${url}" method="get" onsubmit="return validsearch(this);">
				<input id="recherche" type="text" value="<spring:message code='header.rechercher' />" name="text" autocomplete="off" maxlength="255" onFocus="if($('#recherche').val() == '<spring:message code='header.rechercher' />'){$('#recherche').val('');}" onBlur="if($('#recherche').val().trim() == ''){$('#recherche').val('<spring:message code='header.rechercher' />');}"/>
				<input type="submit" value="<spring:message code='header.boutonOK' />" />
			</form:form>
			${EMS_HEADER_SOUS_RECHERCHE}
		</div>
		<div class="headerdroit">
			<div class="compte"></div>
			<div class="comptec">
				<div class="content" onclick="window.location='${contextPath}/login.html?request=account.html'">
					<div class="name"><spring:message code="header.monCompte" /></div>
					<span id="urlcompte"><a href="${contextPath}/login.html?request=account.html"><spring:message code="header.seConnecter" /></a></span>
				</div>
			</div>
			<div class="panier">
				<a href="${contextPath}/cart.html"><div class="image nbArticles"></div></a>
				<div class="content">
					<div class="name"><a href="${contextPath}/cart.html"><spring:message code="header.monPanier"/></a></div>
					<!-- <div class="infos">
						<span class="bold uppercase"></span><br/>
						<span class="art uppercase"><spring:message code="header.articles"/></span><br/>
						<span class="total"></span>
					</div> -->
				</div>
			</div>
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

<!-- Début Popin Newsletter -->
<script type="text/javascript">
	var popinNewsletterActivated = ${popinNewsletterActivated};
	var currentUrl = "${fn:toLowerCase(requestScope['javax.servlet.forward.servlet_path'])}";
	var urlsPopinNewsletter = "${fn:toLowerCase(urlsPopinNewsletter)}";
	var isAuthentified = (existsCookie("RougierAuthentificationCookie") && isCustomerAuthentificated() == "true");

	if(	popinNewsletterActivated && 
		!isAuthentified && 
		(urlsPopinNewsletter.indexOf(currentUrl) != -1 ||  (currentUrl == '' && urlsPopinNewsletter.indexOf("/VAD/") != -1)) &&
		!existsCookie("popinNewsletterCookie")
	){
		showPopinNewsletter();
	}
</script>
<!-- Fin Popin Newsletter -->