<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div id="modal" class="modal-forgotPassword">
	<div class="btn_close"><img src="${contextPath}/resources/fr_FR/img/clientArea/bouton_fermer_modale.png" width="29" height="30" alt="Close" border="0"></div>	
	<div id="forgotPassword" class="login">
			<div id="contenu_interieur">
				<div class="contenu_blanc">
					<form:form id="forgotPasswordForm" >					
						<center>
							<div class="label">
								<label for="forgotPasswordLogin" id="nomLog"><spring:message code="login.entrerLogin"/>&nbsp;*</label>
							</div>
							<div class="input">					
								<input type="text" value="${login}" id="forgotPasswordLogin" size="50" name="login"/>
								<label class="error">${error}</label>
							</div>
							<div class="boutons">	
								<input type="submit" id="validForm" type="image" class="bt_valider"  src="${contextPath}/resources/${codeIsoLang}/img/tunnel/Bt_valider.png"/>
							</div>
							<div class="commentaires">	
								<spring:message code="login.vousRecevrez"/>
							</div>
						</center>	
					</form:form>
					</div>
				</div>
			</div>
	
</div>
		
