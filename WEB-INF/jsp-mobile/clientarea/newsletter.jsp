<%@ page trimDirectiveWhitespaces="true" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>

	
<tiles:insertDefinition name="template">
	<tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}<fwk:rewrite url="/newsletter.html" />
	</tiles:putAttribute>
	<tiles:putAttribute name="title"><spring:message code="newsletter.title"/></tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="newsletter.description"/></tiles:putAttribute>

	<tiles:putAttribute name="breadcrumb">
		<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt; <span class="lien_chemin"><spring:message code="newsletter.title"/></span>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">

<!--  EMS -->
		<style type="text/css">
		#emsNewsletter {width:990px;height:80px;background:url("${contextPath}/resources/${codeIsoLang}/img/clientArea/emsNewsletter_bg.jpg") no-repeat;margin-bottom:30px;}
		#emsNewsletter h1 {float:left;width:138px;margin:24px 0 0 43px;font-size:34px;color:#fff;text-align:center;line-height:26px;}
		#emsNewsletter p {float:left;width:400px;margin:14px 0 0 133px;font-size:14px;line-height:17px;color:#777777;}
		</style>
	
			${NL_BANIERE}
	
<!--  fin EMS -->
	
	<div class="formulaire_newsletter">
		<h2><spring:message code="newsletter.titre"/></h2>
		<form:form id="newsletterSelect" commandName="newsletter" method="post" action="${contextPath}/newsletter.html?newsLetter">
			<div class="email_nom_prenom">	
				<div id="inscriptionReussie1">
					<c:if test="${isMailOk}"><span id="champs_obligatoires" class="rouge" style="color: red"><spring:message code="newsLetter.preSent"/></span></c:if>		
				</div>
				<div class="ligne">
					<div class="label">
						<label for="email"><spring:message code="newsletter.email"/>&nbsp;*:</label>
					</div>
					<div class="input required">
						<form:input path="email" onchange="hideMessage()"/>
					</div>
					<div id="inscriptionReussie2">
						<c:if test="${send}"><span id="champs_obligatoires" class="rouge" style="color: red"><spring:message code="newsLetter.sent"/></span></c:if>
					</div>
				</div>
				<c:if test="${!isMailOk && !send}">			
					<div id="mailMalForme">
						<span><spring:message code="newsletter.emailMalForme"/></span>
					</div>
				</c:if>
				<div id="info_nom" class="ligne">
					<div class="label">
						<label for="nom"><spring:message code="newsletter.nom"/></label>
					</div>
					<div class="input">
						<form:input path="nom" maxlength="32"/>
						<form:errors path="nom" cssClass="errorPicture rouge" />
					</div>
				</div>
				<div id="info_prenom" class="ligne">
					<div class="label">
						<label for="prenom"><spring:message code="newsletter.prenom"/></label>
					</div>
					<div class="input">
						<form:input path="prenom"  maxlength="32"/>
						<form:errors path="prenom" cssClass="errorPicture rouge" />
						
					</div>
				</div>
			</div>
			<div id="bloc_activite" class="bloc">
				<div class="titre">
					<h2><span><spring:message code="newsletter.loisir"/></span></h2>
				</div>
				<div class="conteneur">
					<div class="activite"><form:checkboxes items="${customer.activiteList}" path="activites" itemValue="wording" itemLabel="wording"/></div>
				</div>
			</div>
			<div id="bloc_loisir" class="bloc">
				<div class="titre">
					<h2><span><spring:message code="newsletter.vousEtes"/></span></h2>
				</div>
				<div class="conteneur">
					<form:radiobuttons items="${customer.typesClientList}" path="typeClient"  itemValue="wording" itemLabel="wording" id="profilId"/>
				</div>
			</div>

			<div id="bloc_etablissement" class="bloc">
				<div class="titre">
					<h2><span><spring:message code="newsletter.etablissement"/></span></h2>
				</div>
				<div class="conteneur">
					<div class="label">
					<label for="etablissement"><spring:message code="newsletter.siOuiLequel"/></label>
					</div>
					<div class="input">
						<form:input path="etablissement"  maxlength="32"/>
						<form:errors path="etablissement" cssClass="errorPicture rouge" />

					</div>
				</div>
			</div>
			<div class="champs">
				<c:if test="${send != null && !send}"><span id="champs_obligatoires" class="error rouge">*&nbsp;<spring:message code="newsLetter.echec"/></span> </c:if>
				<span id="champs_obligatoires" class="rouge">*&nbsp;<spring:message code="login.champsObligatoires"/></span>
				<input class="envoyer" id="btnValiderFormNewsLetter" type="submit" />
			</div>
			
		</form:form>
		
	</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="moreJS">
		<script src="${contextPath}/resources/js/clientArea/newsletter.js" type="text/javascript"></script>
	</tiles:putAttribute>
</tiles:insertDefinition>