<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
	<head></head>
	<body onload="document.getElementById('form').submit();" style="background-color: #444444;">
		<form id="form" action="${url}" method="${method}">
			<c:forEach items="${param}" var="item">
				<c:if test="${(item.key) != 'switchData'}">
					<input type="hidden" name="${item.key}" value="${item.value}">
				</c:if>
			</c:forEach>
			<c:if test="${! empty switchData}">
				<input type="hidden" name="switchData" value="${switchData}">
			</c:if>
		</form>
	</body>
</html>