<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div id="modal">
	<div class="btn_close"></div>
	<div class="content cadeau">
		<div class="titre">Votre papier cadeau</div>
		<div class="papier_cadeau">
			<img src="${mediaPath}/pictogrammes/paquet-cadeau.jpg" width="400" height="400" alt="Papier Cadeau" />
		</div>
	</div>
</div>		