<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div id="modal" class="modal-signUp">
		<div id="clients" class="content_modal-signUp">
			<div id="contenu_interieur">
				<div class="coordonnees">
					<a href="#"><img src="${contextPath}/resources/${codeIsoLang}/img/clientArea/J_ai_la_carte_de_fidelite.jpg" class="carte_fidelite" width="180" height="23" alt="<spring:message code="signUp.carteFidelite"/>"/></a>
					<h2><spring:message code="signUp.coordonnees"/></h2>
				</div>
				<div class="contenu_blanc">
				<div class="bouton_close">X</div>
					<h2 class="error"> ${error}</h2>
					<form:form id="customerAccountForm" commandName="customerAccount">
						<div class="interieur_contenu_coordonnees">
							<div class="coordonnees_droite">
									<label for="adresse_email"><spring:message code="login.adresseEmail"/></label><span class="error">*</span><br/>
									<label for="mot_de_passe"><spring:message code="login.motDePasse"/></label><span class="error">*</span><br/>
									<label for="confirmation_mot_de_passe"><spring:message code="signUp.confirmationMotDePasse"/></label><span class="error">*</span><br/>
									<label id="civilite"><spring:message code="signUp.civilite"/></label><span class="error">*</span><br/>
									<label for="nom"><spring:message code="signUp.nom"/></label><span class="error">*</span><br/>
									<label for="prenom"><spring:message code="signUp.prenom"/></label><span class="error">*</span><br/>
									<label for="adresse"><spring:message code="signUp.adresse"/></label><span class="error">*</span><br/>
									<label for="complement_adresse1"><spring:message code="signUp.complementAdresse"/></label><br/>
									<!--<label for="complement_adresse2">Compl&eacute;ment d'adresse</label><br/>-->
									<label for="code_postal"><spring:message code="signUp.codePostal"/></label><span class="error">*</span><br/>							
									<label for="ville"><spring:message code="signUp.ville"/></label><span class="error">*</span><br/>
									<!--<label for="pays">Pays</label><br/>
									<label for="telephone">T&eacute;l&eacute;phone</label><span class="error">*</span><br/>-->
									<br/>
									<span id="champs_obligatoires" class="error">* <spring:message code="login.champsObligatoires"/></span>
							</div>
							<div class="coordonnees_gauche">
								<div><form:input path="mail" size="50" id="adresse_email" /><form:errors path="mail" cssClass="errorPicture rouge"/></div>
								<div><form:password path="login.password" id="mot_de_passe" size="30" /><form:errors path="login.password" cssClass="errorPicture rouge"/></div>
								<div><form:password path="login.confirmPassword" id="confirmation_mot_de_passe" size="30"/><form:errors path="login.confirmPassword" cssClass="errorPicture rouge"/></div>
								<div class="ctn_civilite"><form:radiobutton path="civility" value="1" id="m" /><label for="m"><spring:message code="signUp.monsieur"/></label>&nbsp;&nbsp;<form:radiobutton path="civility" value="2" id="mme" /><label for="mme"><spring:message code="signUp.madame"/></label>&nbsp;&nbsp;<form:radiobutton path="civility" value="3" id="melle" /><label for="melle"><spring:message code="signUp.mademoiselle"/></label></div>
								<div><form:input path="lastName" id="nom" size="30" maxlength="40"/><form:errors path="lastName" cssClass="errorPicture rouge"/></div>
								<div><form:input path="firstName" id="prenom" size="30" maxlength="40"/><form:errors path="firstName" cssClass="errorPicture rouge"/></div>
								<div><form:input path="addressLine1" id="adresse" size="30" maxlength="40"/><form:errors path="addressLine1" cssClass="errorPicture rouge"/></div>
								<div><form:input path="addressLine2" id="complement_adresse1" size="30" maxlength="40"/><form:errors path="addressLine2" cssClass="errorPicture rouge"/></div>
								<!--&nbsp;<input type="text" id="complement_adresse2" name="complement_adresse2" size="30"/><br/>-->
								<div><form:input path="zipCode" id="code_postal" size="30" maxlength="5"/><form:errors path="zipCode" cssClass="errorPicture rouge"/></div>
								<div><form:input path="city" id="ville" size="30" maxlength="40"/><form:errors path="city" cssClass="errorPicture rouge"/></div>
								<!--&nbsp;<select name="pays" value="S&eacute;lectionnez..."><option value="France">France</option><option value="Belgique">Belgique</option></select>
								&nbsp;<input type="text" id="telephone" name="telephone" size="30"/>T&eacute;l&eacute;phone incorrect<br/>-->
							</div>
						</div>
						<input id="je_cree_mon_compte" type="button" onclick="javascript:postModalSignUp()"/>
					</form:form>
				</div>
				<div id="fond_blanc"></div>
			</div>
		</div>
</div>