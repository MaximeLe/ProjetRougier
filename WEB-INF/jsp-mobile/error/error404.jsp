<%@ page trimDirectiveWhitespaces="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- **************************************
	***************************************
	remplacer class="panier"
	et effectuer le design avec les nouvelles classes
	Actuellement les class sont celle de "panier" ex : "ligne titre", "cadregris petit"
	***************************************
	***************************************
 -->

<tiles:insertDefinition name="mobile-template">

	<tiles:putAttribute name="header">
<!-- 		<meta http-equiv="refresh" content="5;url=/">	 -->
	</tiles:putAttribute>

<tiles:putAttribute name="title"><spring:message code="error.erreur404"/></tiles:putAttribute>
	
<tiles:putAttribute name="content">
	<div id="content" class="panier">
		<!-- Début du content -->
		<div class="contentStart"></div>
		
		<!-- Contenu -->
		<div id="contenu">
				
			<div class="clear hidden">
				<!-- Partie gauche -->
				<div class="floatLeft">
					<!-- EMS -->
					${PAGE_404}
				</div>
			</div>
		</div>
	</div>
	
	
	
	</tiles:putAttribute>
</tiles:insertDefinition>