<%@ page trimDirectiveWhitespaces="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"   prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- **************************************
	***************************************
	remplacer class="panier"
	et effectuer le design avec les nouvelles classes
	Actuellement les class sont celle de "panier" ex : "ligne", "cadregris grand"
	***************************************
	***************************************
 -->

<tiles:insertDefinition name="template">
	<tiles:putAttribute name="title"><spring:message code="signUp.thanksTitle"/></tiles:putAttribute>
	
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
							<div class="barretitre"><span><spring:message code="signUp.thanks"/></span></div>
							<div class="ligne">
								${animationBody}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>