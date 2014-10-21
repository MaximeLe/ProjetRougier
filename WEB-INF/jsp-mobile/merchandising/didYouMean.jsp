<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- **************************************
	***************************************
	remplacer class="panier"
	et effectuer le design avec les nouvelles classes
	Actuellement les class sont celle de "panier" ex : "ligne titre", "cadregris petit"
	***************************************
	***************************************
 -->
 
<tiles:insertDefinition name="template">

<tiles:putAttribute name="title"><spring:message code="catalogue.aucunResultatTrouve"/>${facetResult.keywords}</tiles:putAttribute>

<tiles:putAttribute name="head">
	<style type="text/css">
		#fenetre_centre {color: white;}
		#fenetre_centre a {text-decoration:none; color:#BBBBBB;}
		#fenetre_centre a:hover {text-decoration:underline;}
	</style>
</tiles:putAttribute>
	
	
<tiles:putAttribute name="breadcrumb">
	<span id="chemin_categories">
		<a href="/" class="lien_chemin"><spring:message code="breadcrumb.accueil"/></a> &gt;
	</span>
</tiles:putAttribute>	

<tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}${requestScope['javax.servlet.forward.servlet_path']}
</tiles:putAttribute>
	
<tiles:putAttribute name="content">
	<div id="content" class="panier">
		<!-- Début du content -->
		<div class="contentStart"></div>
		
		<!-- Contenu -->
		<div id="contenu">
				
			<div class="clear hidden">
				<!-- Partie gauche -->
				<div class="floatLeft">
					<div class="cadregris grand">
						<div class="barretitre"><span><spring:message code="catalogue.aucunResultatTrouve"/>${facetResult.keywords}</span></div>
						<div class="ligne">
							<spring:message code="catalogue.essayerAvec"/><a href="${contextPath}/search.html?text=${facetResult.spellCheckWord}">${facetResult.spellCheckWord}</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</tiles:putAttribute>
	
</tiles:insertDefinition>