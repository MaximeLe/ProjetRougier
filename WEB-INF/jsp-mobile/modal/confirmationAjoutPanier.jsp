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
	<div class="content addBasket">
		<div class="titre">Ajout au panier</div>
		<div class="message">
		<c:forEach items="${recapAjoutPanier}" var="recap">
			${recap}<br>
		</c:forEach>
		</div>
		<img class="input_close" src="${contextPath}/resources/${codeIsoLang}/img/merchandising/btn_poursuivre.png" width="189" height="38" border="0" alt="Poursuivre mes achats"/>
		<a href="${contextPath}/cart.html" class="btnRight"><img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/btn_voirpanier.png" width="122" height="28" border="0" alt="Voir mon panier"/></a>
	</div>
</div>