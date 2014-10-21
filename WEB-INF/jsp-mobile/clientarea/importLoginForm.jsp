<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div id="content" class="login">
			<div class="gauche floatLeft">
				<div class="titre"><spring:message code="login.dejaSurLeSite"/></div>
				<div class="error" id="errorLogin"> ${authentificationError}</div>
				<c:choose>
					<c:when test="${empty param.ajax }">
						<c:set var="formAction" value="${contextPath}/login.html"/>
					</c:when>
					<c:otherwise>
						<c:set var="formAction" value="javascript:loginAjax()"/>
					</c:otherwise>
				</c:choose>
				<form:form cssClass="form" id="loginForm" commandName="loginCustomer" action="${formAction}">
					<div class="bloc t1">
						<label for="adresse_mail"><spring:message code="login.adresseEmail"/><span>&nbsp;*</span></label>
						<form:input path="login" id="adresse_mail"  size="70"/>
						<form:errors path="login" cssClass="error"/>
						<input type="hidden" id="request" value="${request}" name="request"/>
						<c:if test="${not empty param.ajax }">
							<input type="hidden" id="ajax" value="true" name="ajax"/>
						</c:if>
					</div>
					
					<div class="bloc t1">
						<label for="mot_de_passe"><spring:message code="login.motDePasse"/><span>&nbsp;*</span></label>
						<form:password path="password" id="mot_de_passe" size="20"/>
						<form:errors path="password" cssClass="error"/>
					</div>
					
					<div id="forgotPassword"><spring:message code="login.motDePasseOublie"/></div><div class="clear"></div>
					<div class="sauvegarde"><form:checkbox path="isAutoIdChecked"/><label><spring:message code="login.sauvegarde"/></label></div>
					<input class="floatRight" type="image" src="${contextPath}/resources/${codeIsoLang}/img/clientArea/btn_identification.png" value="<spring:message code="login.boutonConnexion"/>"/>
				</form:form>
				<span class="co">* <spring:message code="login.champsObligatoires"/></span>
			</div>
			
			<div class="droite floatRight">
				<div class="titre"><spring:message code="login.nouveauClient"/> <!--<spring:message code="login.creationCompteWeb"/>--></div>
				<c:set var="requestUrl"><c:if test="${!empty param.request}">request=${param.request}</c:if></c:set>
				<h2 style="color:red">${creationError}</h2>
				<c:choose>
					<c:when test="${empty param.ajax }">
						<c:set var="formAction" value="${contextPath}/signup.html"/>
					</c:when>
					<c:otherwise>
						<c:set var="formAction" value="javascript:signupAjax();"/>
					</c:otherwise>
				</c:choose>
				<form:form cssClass="form" id="customerAccountForm" commandName="customerAccount" action="${formAction}">
					<c:if test="${not empty param.ajax }">
						<input type="hidden" id="ajax" value="true" name="ajax"/>
					</c:if>
					<div class="bloc t1">
						<label for="adresse_email"><spring:message code="login.adresseEmail"/>&nbsp;*</label>
						<form:input path="mail" id="adresse_email" size="70" />
						<form:errors path="mail" cssClass="error"/>
						<form:hidden path="customerId" id="customerId"/>
						<input type="hidden" id="request" value="${request}" name="request"/>
					</div>
					
					<img src="${contextPath}/resources/${codeIsoLang}/img/clientArea/btn_creation.png" width="168" height="38" alt="Je créé mon compte" border="0" id="accountCreation"/>
					
					<div id="maskedForm" style="display:none" class="clear">
					
					<div class="bloc t2">
						<label for="mot_de_passe"><spring:message code="login.motDePasse"/> *</label>
						<form:password path="login.password" id="creationCompte_mot_de_passe" size="20" />
						<form:errors path="login.password" cssClass="errorPicture rouge"/>
					</div>
					<div class="bloc t2 mb">
						<label for="confirmation_mot_de_passe"><spring:message code="signUp.confirmationMotDePasse"/> *</label>
						<form:password path="login.confirmPassword"  id="confirmation_mot_de_passe" size="20"/>
						<form:errors path="login.confirmPassword" cssClass="errorPicture rouge"/>
					</div>
					<div class="bloc">
						<label id="civilite"><spring:message code="signUp.civilite"/> *</label>
						<div class="civ"><form:radiobutton path="civility" value="3" id="melle" />
							<label for="melle"><spring:message code="signUp.mademoiselle"/></label>
							<form:radiobutton path="civility" value="2" id="mme" />
							<label for="mme"><spring:message code="signUp.madame"/></label>
							<form:radiobutton path="civility" value="1" id="m" />
							<label for="m"><spring:message code="signUp.monsieur"/></label>
						</div>
					</div>
					<div class="bloc">
						<label for="nom"><spring:message code="signUp.nom"/> *</label>
						<form:input path="lastName" id="nom" size="40" maxlength="40"/><form:errors path="lastName" cssClass="errorPicture rouge"/><br/>
						<form:errors path="lastName" cssClass="errorPicture rouge"/>
					</div>
					<div class="bloc">
						<label for="prenom"><spring:message code="signUp.prenom"/> *</label>
						<form:input path="firstName" id="prenom" size="40" maxlength="40"/><form:errors path="firstName" cssClass="errorPicture rouge"/><br/>
						<form:errors path="firstName" cssClass="errorPicture rouge"/>
					</div>
					<div class="bloc">
						<label for="adresse"><spring:message code="signUp.adresse"/> *</label>
						<form:input path="addressLine1" id="adresse" size="40" maxlength="40"/><form:errors path="addressLine1" cssClass="errorPicture rouge"/><br/>
						<form:errors path="addressLine1" cssClass="errorPicture rouge"/>
					</div>
					<div class="bloc">
						<label for="complement_adresse1">&nbsp;</label>
						<form:input path="addressLine2" id="complement_adresse1" size="40" maxlength="40"/><form:errors path="addressLine2" cssClass="errorPicture rouge"/><br/>
					</div>
					<div class="bloc">
						<label for="code_postal"><spring:message code="signUp.codePostal"/> *</label>
						<form:input path="zipCode" id="cp" size="10" maxlength="5"/><form:errors path="zipCode" cssClass="errorPicture rouge"/><br/>
						<form:errors path="zipCode" cssClass="errorPicture rouge"/>
					</div>
					<div class="bloc">
						<label for="phone" class="tel"><spring:message code="signUp.phone"/> </label>
						<form:input path="phone" id="phone" size="10" maxlength="15"  cssClass="tel"/><br/>
						<form:errors path="phone" cssClass="phone errorPicture rouge"/>
						<label for="phoneError" class="phoneError error rouge"></label>
					</div>
					
					<div class="bloc">
						<label for="mobile"><spring:message code="signUp.mobile"/></label>
						<form:input path="mobile" id="mobile" size="10" maxlength="15" cssClass="tel"/>
						<form:errors path="mobile" cssClass="mobile errorPicture rouge"/><br/>
						<label for="mobileError" class="mobileError error rouge"></label>
						
					</div>
					<div class="bloc">
						<label for="ville"><spring:message code="signUp.ville"/> *</label>
						<form:select path="city" id="ville" /><form:errors path="city" cssClass="errorPicture rouge"/><br/>
						<form:errors path="city" cssClass="errorPicture rouge"/>
					</div>
					
					<div class="bloc displayNone" id="divsaisieville">
						<label for="otherCity"><spring:message code="signUp.ville"/> *</label>
						<form:input path="otherCity" id="saisieville" size="40" maxlength="40" /><form:errors path="city" cssClass="errorPicture rouge"/><br/>
						<form:errors path="otherCity" cssClass="errorPicture rouge"/>
					</div>
					
					<div class="displayNone">
						<div id="zipCodeOriginal">${customerDatas.zipCode}</div>
						<div id="villeOriginal">${customerDatas.city}</div>
					</div>
					
					<div class="bloc">
						<label for="country"><spring:message code="signUp.pays"/> *</label>
						<form:select path="countryCode" id="pays">
							<form:options items="${customer.countryList}" itemValue="countryId" itemLabel="countryName"/>
						</form:select>
					</div>
					<div class="bloc">
						<label id="typesClient"><spring:message code="signUp.typesClient"/> *</label>
						<form:select path="typeClientId">
							<form:options items="${customer.typesClientList}" itemValue="profilId" itemLabel="wording"/>
						</form:select>
					</div>
					<div id="student">
						<div class="bloc">
							<label for=etablissement><spring:message code="signUp.etablissement"/></label>
							<form:input path="etablissement" id="etablissement"/>
						</div>
						<div class="bloc">
							<label for=formation><spring:message code="signUp.formation"/></label>
							<form:input path="formation" id="formation"/>
						</div>
						<div class="bloc">
							<label for=promotion><spring:message code="signUp.promotion"/></label>
							<form:select path="promotion">
								<form:option value="0" label="Choissisez une promotion"/>
								<form:options items="${customer.promotionList}"/>
							</form:select>
						</div>
						<div class="certifS">
							<form:checkbox path="isValidStudent" id="isValidStudent"/>
							<label for="isValidStudent"><spring:message code="signUp.certifieEtreEtudiant"/></label>
						</div>
					</div>
					<div class="bloc mb2">
						<label for="activiteList"><spring:message code="signUp.activites"/></label>
						<div class="activite"><form:checkboxes items="${customer.activiteList}" path="activitesId" itemValue="profilId" itemLabel="wording"/></div>
					</div>
					<span class="creationCompte" onclick="checkCreationCompte();"><spring:message code="signUp.jeCreeMonCompte"/></span>
					<input class="floatRight" type="image" src="${contextPath}/resources/${codeIsoLang}/img/clientArea/btn_validation.png" alt="<spring:message code="signUp.jeCreeMonCompte"/>" name="submit"/>
					<div class="newsletter">
						<form:checkbox path="isNewsletterSuscribed" id="isNewsletterSuscribed"/>
						<label for="isNewsletterSuscribed"><spring:message code="signUp.inscriptionNewsletter"/></label>
					</div>
					</div>
				</form:form>
			</div>
		</div>