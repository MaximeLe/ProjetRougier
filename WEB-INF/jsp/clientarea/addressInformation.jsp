<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<tiles:insertDefinition name="templateMenu">
	<tiles:putAttribute name="title"><spring:message code="clientAreaMenu.mesCoordonnees"/></tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="clientAreaMenu.mesCoordonnees"/></tiles:putAttribute>
	
	<tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}${contextPath}${requestScope['javax.servlet.forward.servlet_path']}
	</tiles:putAttribute>
	
	<tiles:putAttribute name="breadcrumb">
		<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt;
		<span class="lien_chemin"><a href="${contextPath}/account.html"><spring:message code="clientAreaMenu.monCompte"/></a></span>&nbsp;&gt;
		<span class="lien_chemin"><spring:message code="clientAreaMenu.mesCoordonnees"/></span>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="ems">&nbsp;</tiles:putAttribute>
	
	<tiles:putAttribute name="menu">
		<c:import url="clientAreaMenu.jsp"/>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<div id="clients" class="mes_coordonnees">
			<div id="contenu_interieur">
				<div class="coordonnees">
					<span><spring:message code="clientAreaMenu.mesCoordonnees"/></span>								
					<c:if test="${customer.blackListed}">
						<span style="color: red;">&nbsp;<spring:message code="customerAccount.compteBlackliste"/></span>
					</c:if>
					<c:if test="${customer.disabled}">
						<span style="color: red;">&nbsp;<spring:message code="customerAccount.compteDesactive"/></span>
					</c:if>
				</div>
				<div class="contenu_blanc">
					<div id="messageOrError" class="error">${message}</div>
					<form:form commandName="customerDisplayBean" method="post">

							<div class="col_gauche">
								<div class="ligne">
									<div class="label">
										<label><spring:message code="signUp.civilite"/><span>&nbsp;*</span></label>
									</div> 
									<div class="civilite">
										<form:radiobutton path="civility" value="1"></form:radiobutton><label for="m"><spring:message code="signUp.monsieur"/></label>&nbsp;
										<form:radiobutton path="civility" value="2"></form:radiobutton><label for="mme"><spring:message code="signUp.madame"/></label>&nbsp;
										<form:radiobutton path="civility" value="3"></form:radiobutton><label for="melle"><spring:message code="signUp.mademoiselle"/></label>
									</div>
									<div class="message_erreur">

									</div>
								</div>
								<div class="ligne">
									<div class="label">
										<label for="nom"><spring:message code="signUp.nom"/><span>&nbsp;*</span></label>
									</div>
									<div class="input">
										<form:input path="lastName" id="nom" size="40" maxlength="40"/>
										<form:errors path="lastName" cssClass="errorPicture rouge"/>
									</div>
								</div>
								<div class="ligne">
									<div class="label">
										<label for="prenom"><spring:message code="signUp.prenom"/><span>&nbsp;*</span></label>
									</div>
									<div class="input">
										<form:input path="firstName" id="prenom" size="40" maxlength="40"/>
										<form:errors path="firstName" cssClass="errorPicture rouge"/>
									</div>
								</div>
								<div id="espace_naissance" class="ligne">
									<div class="label">
										<label for="date_naissance"><spring:message code="address.dateDeNaissance"/><span>&nbsp;*</span></label>
									</div>
									<div class="date">
										<select id="dayOfBirth" name="dayOfBirth" class="valid">
											<option value="">JJ</option>
										</select>
										<!--<form:input path="dayOfBirth" size="2" maxlength="2"/>-->
										<select id="monthOfBirth" name="monthOfBirth" class="valid">
											<option value="">MM</option>
										</select>
										<!--<form:input path="monthOfBirth" size="2" maxlength="2"/>-->
										<select id="yearOfBirth" name="yearOfBirth" class="valid">
											<option value="">AAAA</option>
										</select>
										<!--<form:input path="yearOfBirth" size="4" maxlength="4"/>-->
									</div>
								</div>
								<form:errors path="dateInPast" cssClass="errorPicture rouge"/>
								<div class="ligne">
									<div class="info"><span id="complement_form" class="complement_form"><spring:message code="address.renseignezDate"/></span></div>
								</div>
								<div id="espace_telephone" class="ligne">
									<div class="label"><label for="telephone"><spring:message code="order.telephone"/>&nbsp;*</label></div>
									<div class="input">
										<form:input path="phone" id="telephone" maxlength="18" size="18"/>
										<form:errors path="phone" cssClass="errorPicture rouge"/>
									</div>
								</div>	
								<div class="ligne">
									<div class="info"><span class="complement_form"><spring:message code="address.dixChiffres"/></span></div>
								</div>
								<div id="espace_portable" class="ligne">
									<div class="label"><label for="portable"><spring:message code="address.potable"/></label></div>
									<div class="input">
										<form:input path="mobile" id="portable" maxlength="18" size="18"/>
										<form:errors path="mobile" cssClass="errorPicture rouge"/>
									</div>
								</div>
								<div class="ligne">
									<div class="info"><span class="complement_form">(<spring:message code="address.destineAuSuivi"/>)</span></div>
								</div>
							</div>
							<div class="col_droite">
								<div class="ligne">
									<div class="label"><label for="adresse"><spring:message code="signUp.adresse"/><span>&nbsp;*</span></label></div>
									<div class="input">
										<form:input path="addressLine1" id="adresse" size="40" maxlength="40"/>
											<form:errors path="addressLine1" cssClass="errorPicture rouge"/>
									</div>
								</div>
								<div id="complement_adr1" class="ligne">
									<div class="label"><label for="complement_adresse1"><spring:message code="signUp.complementAdresse"/></label></div>
									<div class="input">
										<form:input path="addressLine2" id="complement_adresse1" size="40" maxlength="40"/>
									</div>

								</div>
								<div class="ligne">
									<div class="label">&nbsp;</div>
									<div class="input">
										<form:input path="addressLine3" id="complement_adresse2" size="40" maxlength="40"/>
									</div>

								</div>
								<div class="ligne">
									<div class="label"><label for="code_postal"><spring:message code="signUp.codePostal"/><span>&nbsp;*</span></label></div>
									<div class="input"><form:input path="zipCode" id="cp" size="10" maxlength="5"/></div>
									<form:errors path="zipCode" cssClass="errorPicture rouge"/>
								</div>	
								
									
								<div class="ligne">
									<div class="label"><label for="ville"><spring:message code="signUp.ville"/> *</label></div>
									<div class="select"><form:select path="city" id="ville"/><form:errors path="city" cssClass="errorPicture rouge"/><br/></div>
									<form:errors path="city" cssClass="errorPicture rouge"/>
								</div>
								
								<div class="ligne displayNone" id="divsaisieville">
									<div class="label"><label for="otherCity"><spring:message code="signUp.ville"/> *</label></div>
									<div class="input"><form:input path="otherCity" id="saisieville" size="40" maxlength="40"/><form:errors path="city" cssClass="errorPicture rouge"/><br/></div>
									<form:errors path="otherCity" cssClass="errorPicture rouge"/>
								</div>
								
								<div style="display:none">
									<div id="zipCodeOriginal">${customerDisplayBean.zipCode}</div>
									<div id="villeOriginal">${customerDisplayBean.city}</div>
								</div>
								
								<div class="ligne">
									<div class="label"><label for="country"><spring:message code="signUp.pays"/><span>&nbsp;*</span></label></div>
									<div class="select">
										<form:select path="countryId" id="pays">
											<form:options items="${customerDisplayBean.countryList}" itemValue="countryId" itemLabel="countryName"/>
										</form:select>
									</div>
								</div>
							</div>
							<div class="col_basse">
								<div class="ligne">
									<div class="label"><label id="typesClient"><spring:message code="signUp.typesClient"/></label></div>
									<div class="select">
										<form:select path="typeClientId">
											<form:options items="${customerDisplayBean.typesClientList}" itemValue="profilId" itemLabel="wording"/>
										</form:select>	
									</div>
								</div>
								<div class="ligne">
									<div id="student">
										<div class="bloc">
											<label for=etablissement><spring:message code="signUp.etablissement"/></label>
											<form:input path="etablissement" id="etablissement" size="255"/>
										</div>
										<div class="bloc">
											<label for=formation><spring:message code="signUp.formation"/></label>
											<form:input path="formation" id="formation" size="255"/>
										</div>
										<div class="bloc">
											<label for=promotion><spring:message code="signUp.promotion"/></label>
											<form:select path="promotion">
												<form:option value="0" label="Choissisez une promotion"/>
												<form:options items="${customerDisplayBean.promotionList}"/>
											</form:select>
										</div>
										<div class="certifS">
											<form:checkbox path="isValidStudent" id="isValidStudent"/>
											<label for="isValidStudent"><spring:message code="signUp.certifieEtreEtudiant"/></label>
										</div>
									</div>
								</div>
								<div class="ligne">
									<div class="label"><label for="activiteList"><spring:message code="signUp.activites"/></label></div>
									<div class="activite"><form:checkboxes items="${customerDisplayBean.activiteList}" path="activitesId" itemValue="profilId" itemLabel="wording"/></div>
								</div>
							</div>
							<div class="validation">&nbsp;
								<c:set var="text"><spring:message code="accessCode.boutonJeValide"/></c:set>
								<fwk:genericButton text="${text}" firstSpanClass="Org" btnId="je_valide"/>								
							</div>
						</form:form>
					</div>
					<span id="champs_obligatoires" class="rouge">*&nbsp;<spring:message code="login.champsObligatoires"/></span>
				</div>
			</div>

	</tiles:putAttribute>
	<tiles:putAttribute name="moreJS">
		<script>
			$("#menu .contenu_menu ul:eq(0) li:eq(2) a").attr("style","color:#000000;");
			$("#menu .contenu_menu ul:eq(0) li:eq(2) a").removeAttr("href");
		</script>
		<script src="${contextPath}/resources/js/clientArea/addressInformation.js" type="text/javascript"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/clientArea/ville.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				// Initialisation Couple CodePostal/Ville en Ajax
				if($("#pays").val() != 0) {			
		  			Ville.load($("#customerDisplayBean"), true);  			
				} else {
					Ville.load($("#customerDisplayBean"), false);
					Ville.clear();			
				}
				
				// Remplissage des champs dates de naissance.		
				var day = "";
				for(i=1;i<=31;i++)
				{
					// On récupère la date depuis le model
					var dayBirth = "<c:out value="${dayOfBirth}"/>";
			
					// Si on est arrivé à la date correcte, on l'affiche comme selectionnée
					if(i == dayBirth) {
						if(i<10)
							i = "0"+i;
						day += '<option selected value="'+i+'">'+i+'</option>';
					}
					
					else {
						if(i<10)
							i = "0"+i;
						day += '<option value="'+i+'">'+i+'</option>';
					}
				}
				$("#dayOfBirth").append(day);
				
				var month = "";
				for(i=1;i<=12;i++)
				{					
					var monthBirth = "<c:out value="${monthOfBirth}"/>";
			
					if(i == monthBirth) {
						if(i<10)
							i = "0"+i;
						month += '<option selected value="'+i+'">'+i+'</option>';
					}
					
					else {
						if(i<10)
							i = "0"+i;
						month += '<option value="'+i+'">'+i+'</option>';
					}
				}
				$("#monthOfBirth").append(month);
				
				var year = "";
				var date = new Date();
				for(i=1900;i<=date.getFullYear();i++)
				{					
					var yearBirth = "<c:out value="${yearOfBirth}"/>";
			
					if(i == yearBirth)
						year += '<option selected value="'+i+'">'+i+'</option>';
					
					else
						year += '<option value="'+i+'">'+i+'</option>';
				}
				$("#yearOfBirth").append(year);		
			});
		</script>
		
	</tiles:putAttribute>
	
</tiles:insertDefinition>