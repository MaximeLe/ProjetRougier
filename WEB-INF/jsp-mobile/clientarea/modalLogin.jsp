<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div id="modal" class="modal-login">
		<div id="clients" class="content_modal-login">
			<div id="contenu_interieur">
				<div class="contenu_blanc">
					<div class="bouton_close">X</div>
					<div class="error"> ${error}</div>
					<div class="bloc_droit">
						<span class="gras"><spring:message code="login.dejaSurLeSite"/></span>
						<form:form id="loginForm" commandName="loginCustomer">
						<label for="adresse_mail"><spring:message code="login.adresseEmail"/> <span>*</span></label>
						<form:input path="login" id="adresse_mail" /> <span class="error"><form:errors path="login"/></span>
						<label for="mot_de_passe"><spring:message code="login.motDePasse"/> <span>*</span></label>
						<form:password path="password" id="mot_de_passe" /> <span class="error"><form:errors path="password"/></span>
						<a><spring:message code="login.motDePasseOublie"/></a>
						<div class="login_me">
							<c:set var="text"><spring:message code="login.boutonConnexion"/></c:set>
							<fwk:genericButton text="${text}" firstSpanClass="Org" onClick="postLoginModal()" buttonType="button"/>
						</div>
						<div class="sauvegarde"><input type="checkbox" id="reconnu" name="reconnu"/><label><a><spring:message code="login.sauvegarde"/></a></label></div>
						</form:form>
						<span class="required" >* <spring:message code="login.champsObligatoires"/></span>
					</div>
					<div class="bloc_gauche">
						<div class="haut">
							<span class="gras"><spring:message code="login.nouveauClient"/></span>
							<div class="creation_Compte">
								<span><spring:message code="login.creationCompteWeb"/></span>
								<c:set var="text"><spring:message code="login.creationCompte"/></c:set>
								<fwk:genericButton text="${text}" firstSpanClass="Org" onClick="openSignUp()" buttonType="button"/>
							</div>
						</div>
						<%-- <div class="facebook">
							<div id="fb-root"></div>
							<span class="gras">Facebook Connect</span>
							<div class="creation_Compte">
								<span>J'ai un compte Facebook, j'utilise Facebook Connect</span>
								<img src="${contextPath}/resources/${codeIsoLang}/img/clientArea/facebook_connect.png" alt="Facebook Connect" id="fbConnect"/>
							</div>
						</div> --%>
					</div>
				</div>
				<div id="fond_blanc"></div>
			</div>
		</div>		
</div>