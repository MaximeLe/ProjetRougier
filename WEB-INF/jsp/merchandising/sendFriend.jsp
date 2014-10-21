<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="urlRewrite"><fwk:rewrite url="/ajax/catalogEntry.html"/></c:set>

<div id="modal">
	<div class="btn_close"></div>
	<form:form id="sendFriendForm" commandName="sendFriendBean">
	<div class="content sendFriend">
		<div class="titre">Envoyer à un(e) ami(e)</div>

 			<label for="nom"><spring:message code="contact.nom"/> *</label> 
			<form:input path="nom" maxlength="70"/>
			<form:errors path="nom" cssClass="error"/>	

 			<label for="emailExpediteur"><spring:message code="contact.email"/> *</label> 
			<form:input path="emailExpediteur" maxlength="70"/>
			<form:errors path="emailExpediteur" cssClass="error"/>	

			<label for="emailDestinataire">Email du destinaire *</label>
			<form:input path="emailDestinataire" maxlength="70"/>
			<form:errors path="emailDestinataire" cssClass="error"/>
 
				
			<label for="message"><spring:message code="contact.texteContact"/> *</label>
			<form:textarea path="message"/>
			<div class="error"></div>
			<img class="cursor floatRight" id="bt_valider" src="${contextPath}/resources/${codeIsoLang}/img/common/btn_valider.png" width="72" height="28" border="0" alt=""/>
			<div id="divErreurEnvoiFormulaire" class="form" style="display: none">
			<span class="error"><spring:message code="contact.errorContact"/></span>

			<form:hidden path="ceId"/>
		</div>
	</div>					

<%-- obsolete	<label for="nom"><spring:message code="contact.nom"/> *</label> --%>
<%-- 	<form:input path="nom" maxlength="255"/> --%>
<%-- 	<form:errors path="nom" cssClass="error"/> --%>



	</form:form>
<%-- obsolete				<span id="champs_obligatoires">*&nbsp;<spring:message code="login.champsObligatoires"/></span> --%>
	<tiles:putAttribute name="moreJS">
		<script type="text/javascript">
			var ceId = '${ceId}';
	 	</script> 
		<script src="${contextPath}/resources/js/merchandising/catalogEntry.js" type="text/javascript"></script>
	</tiles:putAttribute>
</div>