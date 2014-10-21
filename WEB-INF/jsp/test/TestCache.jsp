<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<tiles:insertDefinition name="headerBodyFooter">

	<tiles:putAttribute name="head">
	</tiles:putAttribute>

	<tiles:putAttribute name="body">
       	<h1>Body</h1>
       	<h1>le code HTML ci-dessous est caché</h1>
	</tiles:putAttribute>
	
</tiles:insertDefinition>