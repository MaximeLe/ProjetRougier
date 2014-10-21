<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div id="modal" class="modal-nl">
	<div class="btn_close"><img src="${contextPath}/resources/fr_FR/img/clientArea/bouton_fermer_modale.png" width="29" height="30" alt="Close" border="0"></div>	
	<div class="contenu">
		${POPIN_NEWSLETTER_HAUT}
		<form:form id="popinNewsletter" commandName="newsletter">
			<form:input path="email" onfocus="if($(this).val()=='votre adresse mail'){$(this).val('');}" onblur="if($(this).val()==''){$(this).val('votre adresse mail');}" maxlength="255" />
			<img src="${contextPath}/resources/${codeIsoLang}/img/common/newsletter_ok.gif" value="<spring:message code="header.boutonOK"/>" onclick="postPopinNewsletterForm()" />
			<div class="clear"></div>
		</form:form>
		${POPIN_NEWSLETTER_BAS}
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		$("#email").val('votre adresse mail');
	});
</script>