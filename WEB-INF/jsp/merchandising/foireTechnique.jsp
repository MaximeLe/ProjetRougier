<%@ page trimDirectiveWhitespaces="true" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>

<tiles:insertDefinition name="template">
	<tiles:putAttribute name="canonical">
		http://${pageContext['request'].serverName}/VAD/foireTechnique.html
	</tiles:putAttribute>
	<tiles:putAttribute name="title"><spring:message code="fat.title"/></tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="fat.description"/></tiles:putAttribute>

	<tiles:putAttribute name="breadcrumb">
		<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt; <span class="lien_chemin"><spring:message code="fat.title"/></span>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">

	<c:forEach items="${foireTechnique}" var="foire">
		${foire}<br>
	</c:forEach>

	</tiles:putAttribute>
</tiles:insertDefinition>