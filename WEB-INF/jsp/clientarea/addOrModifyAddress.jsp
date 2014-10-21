<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>


<div id="clients" class="carnet_adresse_popin">
<div class="btn_close"><img src="${contextPath}/resources/fr_FR/img/clientArea/bouton_fermer_modale.png" width="29" height="30" alt="Close" border="0"></div>
	<div id="contenu_interieur">
		<div class="coordonnees">
			<h2>
				<spring:message code="clientAreaMenu.monCarnetAdresses"/>
				<c:if test="${customer.blackListed}">
					<span style="color: red;">&nbsp;<spring:message code="customerAccount.compteBlackliste"/></span>
				</c:if>
				<c:if test="${customer.disabled}">
					<span style="color: red;">&nbsp;<spring:message code="customerAccount.compteDesactive"/></span>
				</c:if>								
			</h2>
		</div>
		<div class="contenu_blanc">
			<form:form commandName="address" action=""  modelAttribute="address" method="post">
				<form:hidden path="addressId"/>
				<c:choose>
					<c:when test="${param.addressType == 'billing' }">
						<form:hidden path="wording" />
					</c:when>
					<c:otherwise>
						<div class="ligne">
							<label><spring:message code="address.entete"/>&nbsp;*</label>
							<div class="input">
								<form:input path="wording" id="wording" maxlength="40"/>
								<form:errors path="wording" cssClass="errorPicture rouge" />
							</div>
						</div>
					</c:otherwise>
				</c:choose>
				
				<div class="ligne">	
					<label for="raison_sociale"><spring:message code="signUp.raisonSociale"/></label>
					<div class="input">
						<form:input path="company" id="raison_sociale" maxlength="40"/>
					</div>
				</div>
				<div class="ligne">	
					<label for="labelCivilite"><spring:message code="signUp.civilite"/>&nbsp;*</label>
					<div class="radios">
						<div class="civilite">
							<form:radiobutton path="codeCivilityId" value="1"></form:radiobutton><label for="m"><spring:message code="signUp.monsieur"/></label>
							<form:radiobutton path="codeCivilityId" value="2"></form:radiobutton><label for="mme"><spring:message code="signUp.madame"/></label>
							<form:radiobutton path="codeCivilityId" value="3"></form:radiobutton><label for="melle"><spring:message code="signUp.mademoiselle"/></label>
						</div>
						<form:errors path="codeCivilityId" cssClass="errorPicture rouge"/>
					</div>
				</div>
				<div class="ligne">	
					<label for="nom"><spring:message code="signUp.nom"/>&nbsp;*</label>
					<div class="input">
						<form:input path="lastName" id="nom" maxlength="40"/>
						<form:errors path="lastName" cssClass="errorPicture rouge"/>
					</div>
				</div>
				<div class="ligne">	
					<label for="prenom"><spring:message code="signUp.prenom"/>&nbsp;*</label>
					<div class="input">
						<form:input path="firstName" id="prenom" maxlength="40"/>
						<form:errors path="firstName" cssClass="errorPicture rouge"/>
					</div>
				</div>
				<div class="ligne">	
					<label for="telephone"><spring:message code="signUp.telephone"/>&nbsp;*</label>
					<div class="input">
						<form:input path="phone" id="telephone" maxlength="18" />
						<form:errors path="phone" cssClass="errorPicture rouge"/>
					</div>
				</div>
				<div class="ligne">	
					<label for="mobile"><spring:message code="signUp.mobile"/></label>
					<div class="input">
						<form:input path="mobile" id="mobile" maxlength="18"/>
						<form:errors path="mobile" cssClass="errorPicture rouge"/>
					</div> 
				</div>
				<div class="ligne">	
					<div class="label"><label for="adresse"><spring:message code="signUp.adresse"/>&nbsp;*</label></div>
					<div class="input">
						<form:input path="addressLine1" id="adresse" maxlength="40"/>
						<form:errors path="addressLine1" cssClass="errorPicture rouge"/>
					</div>
				</div>
				
				<div id="complement_adr1" class="ligne">
					<div class="label"><label for="complement_adresse1"><spring:message code="signUp.complementAdresse"/></label></div>
					<div class="input">
						<form:input path="addressLine2" id="complement_adresse1" maxlength="40" />
						<form:errors path="addressLine2" cssClass="errorPicture rouge"/>
					</div>

				</div>
				<div class="ligne">
					<div class="label">&nbsp;</div>
					<div class="input">
						<form:input path="addressLine3" id="complement_adresse3" maxlength="40"/>
						<form:errors path="addressLine3" cssClass="errorPicture rouge"/>
					</div>

				</div>

				<div class="ligne">		
					<label for="code_postal"><spring:message code="signUp.codePostal"/>&nbsp;*</label>
					<div class="input">
						<form:input path="zipCode" id="cp" size="50" maxlength="5"/>
						<form:errors path="zipCode" cssClass="errorPicture rouge"/>
					</div>
				</div>
				<div class="ligne">	
					<label for="ville"><spring:message code="signUp.ville"/>&nbsp;*</label>
					<div class="select">
						<form:select path="city" id="ville"/>
						<form:errors path="city" cssClass="errorPicture rouge"/>
					</div>
				</div>
				<div class="ligne">	
					<div id="divsaisieville" class="form" style="display: none">
						<label for="otherCity"><spring:message code="signUp.ville"/>&nbsp;*</label>
						<div class="input">
							<form:input path="otherCity" id="saisieville" size="50" maxlength="40"/>
							<form:errors path="otherCity" cssClass="errorPicture rouge"/>
						</div>
					</div>
				</div>
				<div class="ligne">	
					<div style="display:none">
						<div id="zipCodeOriginal">${address.zipCode}</div>
						<div id="villeOriginal">${address.city}</div>
					</div>
				</div>
				<div class="ligne">	
					<label for="country"><spring:message code="signUp.pays"/>&nbsp;*</label>
					<div class="select">
						<form:select path="countryId" id="pays">
							<form:options items="${countries}" itemValue="countryId" itemLabel="countryName"/>
						</form:select>
						<form:errors path="countryId" cssClass="errorPicture rouge"/>
					</div>
				</div>
				
				<div class="validation_modif_add">
					<c:set var="text"><spring:message code="accessCode.boutonJeValide"/></c:set>
					<fwk:genericButton text="${text}" firstSpanClass="Org" btnId="je_valide"/>
					<c:set var="text"><spring:message code="delivery.retour"/></c:set>
					<c:choose>
						<c:when test="${not empty param.origine}">
							<fwk:genericButton text="${text}" firstSpanClass="Black_small" btnId="retour" href="${contextPath}/tunnel/delivery.html"/>
						</c:when>
						<c:otherwise>
							<fwk:genericButton text="${text}" firstSpanClass="Black_small" btnId="retour" href="${contextPath}/addressBook.html"/>
						</c:otherwise>
					</c:choose>
				</div>
				</form:form>
		</div>
		<span id="champs_obligatoires" class="rouge">*&nbsp;<spring:message code="login.champsObligatoires"/></span>
				
	</div>
</div>