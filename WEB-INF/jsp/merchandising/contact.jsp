<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>

<tiles:insertDefinition name="template">
	<tiles:putAttribute name="canonical">
		http://${pageContext['request'].serverName}<fwk:rewrite url="/contact.html" />
	</tiles:putAttribute>
	<tiles:putAttribute name="title"><spring:message code="contact.title"/></tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="contact.description"/></tiles:putAttribute>
	
	<tiles:putAttribute name="breadcrumb">
		<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt; <span class="lien_chemin"><spring:message code="contact.title"/></span>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<form:form id="contactFormId" commandName="contactBean">
			<div class="formulaire_contact">
				<div class="ligne">
					<div class="label">
						<label for="nom"><spring:message code="contact.civilite"/> *</label>
					</div>
					<div class="input">
						<div class="civ">
							<form:radiobutton path="civility" value="3" id="melle" />
							<label for="melle"><spring:message code="signUp.mademoiselle"/></label>
							<form:radiobutton path="civility" value="2" id="mme" />
							<label for="mme"><spring:message code="signUp.madame"/></label>
							<form:radiobutton path="civility" value="1" id="m" />
							<label for="m"><spring:message code="signUp.monsieur"/></label>
							<div class="contains_error"></div>
						</div>
					</div>
				</div>
				<div class="ligne">
					<div class="label">
						<label for="nom"><spring:message code="contact.nom"/> *</label>
					</div>
					<div class="input">
						<form:input path="nom" maxlength="255"/>
					</div>
				</div>
				<div class="ligne">
					<div class="label">
						<label for="prenom"><spring:message code="contact.prenom"/> *</label>
					</div>
					<div class="input">
						<form:input path="prenom" maxlength="255"/>
					</div>
				</div>
				<div class="ligne">
					<div class="label">
						<label for="email"><spring:message code="contact.email"/> *</label>
					</div>
					<div class="input">
						<form:input path="email" maxlength="70" />
						<span class="gris"><spring:message code="contact.emailMessage"/></span>
					</div>
				</div>
				<div class="ligne">
					<div class="label">
						<label for="typeClient"><spring:message code="contact.typeClient"/> *</label>
					</div>
					<div class="select">
						<form:select path="typeClient" items="${listTypeClient}" itemValue="numero" itemLabel="value"/>
					</div>
				</div>
				<div class="ligne">
					<div class="label">
						<label for="typeDemande"><spring:message code="contact.typeDemande"/> *</label>
					</div>
					<div class="select">
						<form:select path="typeDemande" items="${listObjetsMail}" itemValue="numero"  itemLabel="value" ></form:select>
					</div>
				</div>
				<div id="info_num_com" class="ligne">
					<div class="label">
						<label for="numeroCommande"><spring:message code="contact.numeroCommande"/> *</label>
					</div>
					<div class="input">
						<form:input path="numeroCommande" maxlength="32"/>
					</div>
				</div>
				<div id="info_message" class="ligne">
					<div class="label">
						<label for="texteContact"><spring:message code="contact.texteContact"/> *</label>
					</div>
					<div class="textarea">
						<form:textarea path="texteContact" />
					</div>
				</div>
				<div class="lienNewsLetter" >
					<a href="#"><spring:message code="contact.seDesinscrireNewsLetter"/></a>
				</div>
	
				<span class="envoyer" onclick="checkForm();"><spring:message code="contact.boutonJeValide"/></span>
			</div>
			<div class="ems_contact">
				${emsDroit}
			</div>
		
			<span id="champs_obligatoires">*&nbsp;<spring:message code="login.champsObligatoires"/></span>
		</form:form>
		<div id="divErreurEnvoiFormulaire" class="form" style="display: none">
			<span class="error"><spring:message code="contact.errorContact"/></span>
		</div>
		<div class="ems">
			${ems}
		</div>
		
	</tiles:putAttribute>
	<tiles:putAttribute name="moreJS">
		<script src="${contextPath}/resources/js/merchandising/contact.js"></script>
	</tiles:putAttribute>
</tiles:insertDefinition>
