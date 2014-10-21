<%@ page trimDirectiveWhitespaces="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<tiles:insertDefinition name="template">

<!-- **************************************
	***************************************
	remplacer class="panier"
	et effectuer le design avec les nouvelles classes
	Actuellement les class sont celle de "panier" ex : "ligne titre", "cadregris petit"
	***************************************
	***************************************
 -->
	<tiles:putAttribute name="head">
	<!--
		<meta http-equiv="refresh" content="5;url=/"> 
	 -->	
	</tiles:putAttribute>

<tiles:putAttribute name="title"><spring:message code="error.erreur500"/></tiles:putAttribute>
	
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
					${PAGE_500}
				</div>
			</div>
		</div>
	</div>
	</tiles:putAttribute>
	
</tiles:insertDefinition>