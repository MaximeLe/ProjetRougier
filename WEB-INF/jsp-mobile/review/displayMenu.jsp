<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>



<tiles:insertDefinition name="headerBodyFooter">

<tiles:putAttribute name="title">Menu général des avis</tiles:putAttribute>
<tiles:putAttribute name="breadcrumb"><span id="chemin_categories"><a href="${contextPath}" class="lien_chemin">Accueil</a> > <a href="?action=displayMenu" class="lien_chemin">Retour au menu général</a></span></tiles:putAttribute>

<tiles:putAttribute name="head">
</tiles:putAttribute>

<tiles:putAttribute name="body">
	
	<div id="fenetre_centre">
		<h1></h1>
		
	</div>
</tiles:putAttribute>
	
</tiles:insertDefinition>