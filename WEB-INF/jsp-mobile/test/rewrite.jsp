<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk" %>

<html>
	<head>
	</head>
	<body>
		<c:set var="url">
			<fwk:rewrite url="/ContentDisplay.html?action=getPageContent&categoryId=5&langId=1" paramUnRewrited="catalogId=2&storeId=1" storeId="1"/>
		</c:set>
		<a href="${url}">essai</a>
	</body>
</html>