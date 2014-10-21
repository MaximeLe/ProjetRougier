<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<tiles:insertDefinition name="template">
	<tiles:putAttribute name="title"><spring:message code="login.title"/></tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="login.description"/></tiles:putAttribute>
	
	<tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}${contextPath}${requestScope['javax.servlet.forward.servlet_path']}
	</tiles:putAttribute>
	
	<tiles:putAttribute name="breadcrumb">
		<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt; <span class="lien_chemin"><spring:message code="login.title"/></span>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<c:import url="importLoginForm.jsp"/>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="moreJS">
		<script type="text/javascript">
			var referer = ('${request}' != '')? "request="+escape('${request}')+"&" : "";
			var connected = '${connected}';
			
			$(document).ready(function(){
// 				On check la case du cookie au chargement de la page
				$('input[name=isAutoIdChecked]').attr('checked', true);
				$('input[name=isNewsletterSuscribed]').attr('checked', true);
//				Initialisation Couple CodePostal/Ville en Ajax
				if($("#pays").val() != 0) {			
		  			Ville.load($("#customerAccountForm"), true);  			
				} else {
					Ville.load($("#customerAccountForm"), false);
					Ville.clear();			
				}
			});
			
		</script>
		<script src="http://connect.facebook.net/${codeIsoLang}/all.js"  type="text/javascript"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/clientArea/ville.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/clientArea/login.js"></script>
	</tiles:putAttribute>
</tiles:insertDefinition>
