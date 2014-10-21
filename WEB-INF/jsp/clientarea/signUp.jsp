<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<tiles:insertDefinition name="templateMenu">
	<tiles:putAttribute name="title"><spring:message code="signUp.title"/></tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="signUp.description"/></tiles:putAttribute>
	
	<tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}${requestScope['javax.servlet.forward.servlet_path']}
	</tiles:putAttribute>
	
	<tiles:putAttribute name="breadcrumb">
		||&nbsp;<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt; <span class="lien_chemin"><spring:message code="signUp.title"/></span>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="menu">
		<div id="menu">
			<div class="menu_titre">
				<div class="titre"><spring:message code="signUp.title"/></div>
			</div>
			<div id="menu_bas">
			</div>
		</div>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<div id="clients" class="creation_compte">
			<div id="contenu_interieur">
				<div class="coordonnees">
					<h2><spring:message code="signUp.coordonnees"/></h2>
					<c:set var="text"><spring:message code="signUp.carteFidelite"/></c:set>
					<fwk:genericButton text="${text}" href="#" firstSpanClass="Blue" />
				</div>
				<div class="contenu_blanc">
					<h2 style="color:red">${error}</h2>
					<form:form id="customerAccountForm" commandName="customerAccount" action="${contextPath}/signup.html" method="post">
						<div class="interieur_contenu_coordonnees">
							<div class="coordonnees_droite">
									<label for="adresse_email"><spring:message code="login.adresseEmail"/></label><span class="rouge">*</span><br/>
									<label for="mot_de_passe"><spring:message code="login.motDePasse"/></label><span class="rouge">*</span><br/>
									<label for="confirmation_mot_de_passe"><spring:message code="signUp.confirmationMotDePasse"/></label><span class="rouge">*</span><br/>
									<label id="civilite"><spring:message code="signUp.civilite"/></label><span class="rouge">*</span><br/>
									<label for="nom"><spring:message code="signUp.nom"/></label><span class="rouge">*</span><br/>
									<label for="prenom"><spring:message code="signUp.prenom"/></label><span class="rouge">*</span><br/>
									<label for="adresse"><spring:message code="signUp.adresse"/></label><span class="rouge">*</span><br/>
									<label for="complement_adresse1"><spring:message code="signUp.complementAdresse"/></label><br/>
									<!--<label for="complement_adresse2">Compl&eacute;ment d'adresse</label><br/>-->
									<label for="code_postal"><spring:message code="signUp.codePostal"/></label><span class="rouge">*</span><br/>							
									<label for="ville"><spring:message code="signUp.ville"/></label><span class="rouge">*</span><br/>
									<!--<label for="pays">Pays</label><br/>
									<label for="telephone">T&eacute;l&eacute;phone</label><span class="rouge">*</span><br/>-->
									<br/>
									<span id="champs_obligatoires" class="rouge">* <spring:message code="login.champsObligatoires"/></span>
							</div>
							<div class="coordonnees_gauche">
								&nbsp;<form:input path="mail" size="50" id="adresse_email" /><form:errors path="mail" cssClass="errorPicture rouge"/><br/>
								&nbsp;<form:password path="login.password" id="mot_de_passe" size="50" /><form:errors path="login.password" cssClass="errorPicture rouge"/><br/>
								&nbsp;<form:password path="login.confirmPassword" id="confirmation_mot_de_passe" size="50"/><form:errors path="login.confirmPassword" cssClass="errorPicture rouge"/><br/>
								&nbsp;<div id="radio"><form:radiobutton path="civility" value="1" id="m"/><label for="m"><spring:message code="signUp.monsieur"/></label>&nbsp;&nbsp;<form:radiobutton path="civility" value="2" id="mme" /><label for="mme"><spring:message code="signUp.madame"/></label>&nbsp;&nbsp;<form:radiobutton path="civility" value="3" id="melle" /><label for="melle"><spring:message code="signUp.mademoiselle"/></label></div><br/>
								&nbsp;<form:input path="lastName" id="nom" size="50" maxlength="40"/><form:errors path="lastName" cssClass="errorPicture rouge"/><br/>
								&nbsp;<form:input path="firstName" id="prenom" size="50" maxlength="40"/><form:errors path="firstName" cssClass="errorPicture rouge"/><br/>
								&nbsp;<form:input path="addressLine1" id="adresse" size="50" maxlength="40"/><form:errors path="addressLine1" cssClass="errorPicture rouge"/><br/>
								&nbsp;<form:input path="addressLine2" id="complement_adresse1" size="50" maxlength="40"/><form:errors path="addressLine2" cssClass="errorPicture rouge"/><br/>
								<!--&nbsp;<input type="text" id="complement_adresse2" name="complement_adresse2" size="50"/><br/>-->
								&nbsp;<form:input path="zipCode" id="code_postal" size="50" maxlength="5"/><form:errors path="zipCode" cssClass="errorPicture rouge"/><br/>
								&nbsp;<form:input path="city" id="ville" size="50" maxlength="40"/><form:errors path="city" cssClass="errorPicture rouge"/><br/>
								<!--&nbsp;<select name="pays" value="S&eacute;lectionnez..."><option value="France">France</option><option value="Belgique">Belgique</option></select><br/>
								&nbsp;<input type="text" id="telephone" name="telephone" size="50"/>T&eacute;l&eacute;phone incorrect<br/>-->
							</div>
							<br/>
						</div>
						<br/><br/><br/>
						<c:set var="text"><spring:message code="signUp.jeCreeMonCompte"/></c:set>
						<fwk:genericButton text="${text}" firstSpanClass="Black_small" buttonType="button" btnId="je_cree_mon_compte" />
					</form:form>
				</div>
				<div id="fond_blanc"></div>
			</div>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="moreJS">
		<script language="javascript" src="${contextPath}/resources/js/clientArea/verif_form.js"></script>
		<script language="javascript">
			$("#je_cree_mon_compte").click(function(){
				Validator.valid({
					// obligatoire pour faire un submit du formulaire
					btn_valid	: "#je_cree_mon_compte",
					IdForm 		: "#customerAccountForm",
					// class ou ID du span créée qui contiendra les erreurs (classe personalisable)
					spanError	: "error",
					email		: ["#adresse_email"], // ["#id2"]]
					mdp			: [["#mot_de_passe","#confirmation_mot_de_passe"],"#mot_de_passe"],
					cdp			: ["#code_postal"],
					champs		: ["#nom","#prenom","#adresse","#ville"],
					radio		: ["input[name='civility']"],
					
					// messages d'erreurs personalisés correspondant au différents champs
					msg		: ValidatorMessage.init({
						cdp		: $.i18n._("signup.error.cdp"),
						vide	: $.i18n._("signup.error.vide"),
						mdp		: $.i18n._("signup.error.mdp"),
						size	: $.i18n._("signup.error.size"),
						conf_mdp: $.i18n._("signup.error.conf_mdp"),
						radio	: $.i18n._("signup.error.radio")
					})
				});
			});
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>