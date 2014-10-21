<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<html>
	<head>
		<script type="text/javascript">
			var data;
			if ('${error_reason}' == ''){
				var code = '${code}';
				data = "code="+escape(code);
			
			} else {
				data = 'error_reason=${error_reason}';
			}
			var referer = ('${request}' != '')? "request="+escape('${request}')+"&" : "";
			window.opener.location = "${contextPath}/login.html?"+referer+data;
			
			window.close();
		</script>
	</head>
	<body style="background-color: #444444;">
		<div style="text-align:center"><spring:message code="facebook.vousEtesDeja"/></div>
	</body>
</html>