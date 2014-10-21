<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div id="clients" class="carnet_adresse_popin">
<div class="btn_close"><img src="${contextPath}/resources/fr_FR/img/clientArea/bouton_fermer_modale.png" width="29" height="30" alt="Close" border="0"></div> <br>
	<div id="contenu_interieur">
		<c:choose>
			<c:when test="${param.type==9 }">
				<spring:message code="client.sucessUnSubscribe"/>
			</c:when>
			<c:when test="${param.type!=9 }">
				<spring:message code="client.sucessMailContact"/>
			</c:when>
		</c:choose>
	</div>
</div>