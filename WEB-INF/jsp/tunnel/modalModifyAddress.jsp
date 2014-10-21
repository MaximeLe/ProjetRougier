<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div id="modal" class="modal-modifyAddress">
		<div id="clients" class="address">
			<div id="contenu_interieur">
				<div class="coordonnees">
					<h2> <spring:message code="modifAdresse.adresseDe"/> <c:if test="${addressTypeId == 1}"><spring:message code="modifAdresse.livraison"/></c:if><c:if test="${addressTypeId == 2}"><spring:message code="modifAdresse.facturation"/></c:if> </h2><div class="btn_close"><img src="${contextPath}/resources/fr_FR/img/clientArea/btn-close.png" width="6" height="8" alt="" border="0"></div>		
				</div>
				<div class="contenu_blanc">
					<h2 style="color:red">${error}</h2>
					<form:form id="defaultAdress" commandName="defaultAdress">
					<br/>
					
					<center><label id="nomAdr"><spring:message code="modifAdresse.votreCarnet"/></label><span class="rouge">*</span>
					
					&nbsp;<select name="addressId" id="addressId" onchange="javascript:reloadModalAddress(this.value,${addressTypeId})">	
										<option value="0"><spring:message code="modifAdresse.saisirAutreAdresse"/></option>
										<c:forEach items="${addresses}" var="adr">											
											<option value="${adr.addressId}" <c:if test="${defaultAdress.addressId == adr.addressId}">selected="selected"</c:if>> ${adr.wording}</option>	
										</c:forEach>
									</select></center>		<br/>		
					
					<c:set var="isDisabled">
					<c:choose>
					<c:when test="${empty defaultAdress.addressId}">true</c:when>
					<c:otherwise>false</c:otherwise>
					</c:choose>				
					</c:set>
					
					
					<div id="contentAddress">
						<div class="interieur_contenu_coordonnees">
							<div class="coordonnees_droite">
									
									<label id="wording"><spring:message code="modifAdresse.nomAdresse"/></label><span class="rouge">*</span><br/>
									<label id="civilite"><spring:message code="modifAdresse.civilite"/></label><span class="rouge">*</span><br/>
									<label for="nom"><spring:message code="modifAdresse.nom"/></label><span class="rouge">*</span><br/>
									<label for="prenom"><spring:message code="modifAdresse.prenom"/></label><span class="rouge">*</span><br/>
									<label for="adresse"><spring:message code="modifAdresse.adresse"/></label><span class="rouge">*</span><br/>
									<label for="complement_adresse1"><spring:message code="modifAdresse.complementAdresse"/></label><br/>								
									<label for="code_postal"><spring:message code="modifAdresse.codePostal"/></label><span class="rouge">*</span><br/>							
									<label for="ville"><spring:message code="modifAdresse.ville"/></label><span class="rouge">*</span><br/>
									<label for="telephone"><spring:message code="modifAdresse.telephone"/></label><br/>
								
									<br/>
									<span id="champs_obligatoires" class="rouge">*<spring:message code="modifAdresse.champsObligatoires"/></span>
							</div>
							<div class="coordonnees_gauche">	
								<c:choose> 
								<c:when test="${isDisabled}">
								&nbsp;<input size="50" disabled="disabled" value="Adresse du compte"/><br/>																									
								</c:when>
								<c:otherwise>
								&nbsp;<form:input   path="wording" id="wording" size="50"/><form:errors path="lastName" cssClass="errorPicture rouge"/><br/>
								</c:otherwise>
								</c:choose>
								
								&nbsp;<div><form:radiobutton disabled="${isDisabled}" path="codeCivilityId" value="1" id="m" /><label for="m"><spring:message code="modifAdresse.monsieur"/></label>&nbsp;&nbsp;<form:radiobutton disabled="${isDisabled}" path="codeCivilityId" value="2" id="mme" /><label for="mme"><spring:message code="modifAdresse.madame"/></label>&nbsp;&nbsp;<form:radiobutton  disabled="${isDisabled}" path="codeCivilityId" value="3" id="melle" /><label for="melle"><spring:message code="modifAdresse.mademoiselle"/></label></div><br/>
								&nbsp;<form:input disabled="${isDisabled}" path="lastName" id="nom" size="50"/><form:errors path="lastName" cssClass="errorPicture rouge"/><br/>
								&nbsp;<form:input disabled="${isDisabled}" path="firstName" id="prenom" size="50"/><form:errors path="firstName" cssClass="errorPicture rouge"/><br/>
								&nbsp;<form:input disabled="${isDisabled}" path="addressLine1" id="adresse" size="50"/><form:errors path="addressLine1" cssClass="errorPicture rouge"/><br/>
								&nbsp;<form:input disabled="${isDisabled}" path="addressLine2" id="complement_adresse1" size="50"/><form:errors path="addressLine2" cssClass="errorPicture rouge"/><br/>								
								&nbsp;<form:input disabled="${isDisabled}" path="zipCode" id="code_postal" size="50" maxlength="5"/><form:errors path="zipCode" cssClass="errorPicture rouge"/><br/>
								&nbsp;<form:input disabled="${isDisabled}" path="city" id="ville" size="50"/><form:errors path="city" cssClass="errorPicture rouge"/><br/>
								&nbsp;<form:input disabled="${isDisabled}" path="phone" id="phone" size="50"/><form:errors path="phone" cssClass="errorPicture rouge"/><br/>
							</div>
							<br/>
						</div>
					</div>	
					<div style="float:right; margin-top: 80px">					
					<center>
					<input  type="image" class="bt_valider"  src="${contextPath}/resources/${codeIsoLang}/img/tunnel/Bt_valider.png"/>
					</center>	
					</div>
					</form:form>
				</div>
				<div id="fond_blanc"></div>
			</div>
		</div>		
</div>
		

		