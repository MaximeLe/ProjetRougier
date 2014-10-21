<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<tiles:insertDefinition name="templateMenu">
	<tiles:putAttribute name="title"><spring:message code="clientAreaMenu.mesCodesAcces"/></tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="accessCode.modificationAcces"/></tiles:putAttribute>
	
	<tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}${contextPath}${requestScope['javax.servlet.forward.servlet_path']}
	</tiles:putAttribute>
	
	<tiles:putAttribute name="breadcrumb">
		<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt;
		<span class="lien_chemin"><a href="${contextPath}/account.html"><spring:message code="clientAreaMenu.monCompte"/></a></span>&nbsp;&gt;
		<span class="lien_chemin"><spring:message code="clientAreaMenu.mesCodesAcces"/></span>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="ems">&nbsp;</tiles:putAttribute>
	
	<tiles:putAttribute name="menu">
		<c:import url="clientAreaMenu.jsp"/>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<div id="clients" class="code_acces">
			<div id="contenu_interieur">
				<div class="coordonnees">
					<span><spring:message code="clientAreaMenu.mesCodesAcces"/></span>
						<c:if test="${customer.blackListed}">
							<span style="color: red;">&nbsp;<spring:message code="customerAccount.compteBlackliste"/></span>
						</c:if>
						<c:if test="${customer.disabled}">
							<span style="color: red;">&nbsp;<spring:message code="customerAccount.compteDesactive"/></span>
						</c:if>
				</div>
				<div class="contenu_blanc">
					<div class="contenu_intro">
						<span>En modifiant votre adresse e-mail, vous recevrez votre newsletter à cette nouvelle adresse e-mail</span>
					</div>
					<div class="error_page">${errorEmail}${messagePassword}${messageEmail}${errorPassword}</div>
					<form id="form_modification_email" name="form_modification_email" method="post">
						<div class="modification_email">
							<div class="ligne">
								<div class="label">
									<label for="email_actuel"><spring:message code="accessCode.emailActuel"/></label>
								</div>
								<div class="input">
									<span id="email_actuel" name="email_actuel">${customer.mail}</span>
								</div>
							</div>
							<div class="ligne">
								<div class="label">
									<label for="nouvel_email"><spring:message code="accessCode.nouvelleAdresse"/>&nbsp;<span class="rouge">*</span></label>
								</div>
								<div class="input">
									<input type="text" name="nouvelEmail" size="57" id="nouvelEmail" path="login" maxlength="70"/>
									
								</div>
							</div>

							<c:set var="text"><spring:message code="accessCode.boutonJeValide"/></c:set>
							<fwk:genericButton text="${text}" firstSpanClass="Org" btnId="valider"/>
						</div>
					</form>
					<form id="form_modification_mdp" name="form_modification_mdp" method="post">
						<div class="modification_mdp">
							<div class="ligne">
								<div class="label">
									<label for="mdp_actuel"><spring:message code="accessCode.motDePasseActuel"/></label><span class="rouge">*</span>
								</div>
								<div class="input">
									<input type="password" id="mdpActuel" name="mdpActuel" size="57" minlength="6" maxlength="20"/>
								</div>
							</div>
							<div class="ligne">
								<div class="label">
									<label for="nouveau_mdp"><spring:message code="accessCode.nouveauMotDePasse"/></label><span class="rouge">*</span>
								</div>
								<div class="input">
									<input type="password" id="nouveauMdp" name="nouveauMdp" size="57" minlength="6" maxlength="20"/>
								</div>
							</div>
							<div class="ligne">
								<div class="label">
									<label for="confirmation_nouveau_mdp"><spring:message code="accessCode.ConfimationNouveauMotDePasse"/></label><span class="rouge">*</span>
								</div>
								<div class="input">
									<input type="password" id="confirmationNouveauMdp" name="confirmationNouveauMdp" size="57" minlength="6" maxlength="20"/>
								</div>
							</div>
							<c:set var="text"><spring:message code="accessCode.boutonJeValide"/></c:set>
							<fwk:genericButton text="${text}" firstSpanClass="Org" btnId="je_valide"/>
						</div>
					</form>
					<br/>
					<span id="champs_obligatoires" class="rouge">*&nbsp;<spring:message code="login.champsObligatoires"/></span>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="moreJS">
		<script>
			$("#menu .contenu_menu ul:eq(0) li:eq(1) a").attr("style","color:#000000;");
			$("#menu .contenu_menu ul:eq(0) li:eq(1) a").removeAttr("href");
		</script>
		<script src="${contextPath}/resources/js/clientArea/function.js" type="text/javascript"></script>
		<script src="${contextPath}/resources/js/clientArea/accessCode.js" type="text/javascript"></script>
	</tiles:putAttribute>
</tiles:insertDefinition>