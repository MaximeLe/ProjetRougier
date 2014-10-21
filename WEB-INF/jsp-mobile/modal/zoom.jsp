<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<div id="modal">
	<div class="btn_close"></div>
	<a id="fleche_gauche" onClick="afficheImageZoomPrecedente()"><img src="${contextPath}/resources/fr_FR/img/merchandising/fleche_gauche.png" width="32" height="32" alt="flèche gauche" /></a>
    <a id="fleche_droite" onClick="afficheImageZoomSuivante()"><img src="${contextPath}/resources/fr_FR/img/merchandising/fleche_droite.png" width="32" height="32" alt="flèche droite" /></a> 
	<img class="zoom" src="${param.url}" width="675" height="675" border="0" alt=""/>		
</div>

<tiles:putAttribute name="moreJS">
		<script src="${contextPath}/resources/js/merchandising/merchandising.js" type="text/javascript"></script>
</tiles:putAttribute>
<script type="text/javascript">
	window.onload = afficherMasquerFleches();
</script>

