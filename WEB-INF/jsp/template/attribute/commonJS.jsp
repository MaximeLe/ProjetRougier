<%@ page trimDirectiveWhitespaces="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib uri="http://www.pictime.com/tags/core"  prefix="fwk"%>

<!-- Appel du Framework Jquery -->
<script src="${contextPath}/resources/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>

<!-- Appel des plugins Jquery -->
<script src="${contextPath}/resources/js/jquery/box.js" type="text/javascript"></script>
<script src="${contextPath}/resources/js/jquery/jquery.i18n.js" type="text/javascript"></script>
<script src="${contextPath}/resources/js/jquery/jquery.cookie.js" type="text/javascript"></script>
<script src="${contextPath}/resources/js/jquery/jquery-ui-1.8.14.custom.min.js" type="text/javascript"></script>
<script src="${contextPath}/resources/js/jquery/jquery.validate.min.js" type="text/javascript"></script>
<script src="${contextPath}/resources/js/common/cookieHeader.js" type="text/javascript"></script>

<c:set var="devise" scope="page"><c:choose><c:when test="${storeId==2}">&#36;</c:when><c:otherwise>&euro;</c:otherwise></c:choose></c:set>
<script type="text/javascript">
	var currency = '${devise}';
</script>

<!-- Appel des JS -->
<script src="${contextPath}/resources/js/dictionary/dictionary_${codeIsoLang}.js" type="text/javascript"></script>
<script src="${contextPath}/resources/js/common/common.js" type="text/javascript"></script>


<!-- autre JS -->
<script type="text/javascript">
	var contextPath = '${contextPath}';
	var codeIsoLang = '${codeIsoLang}';
</script>
<script src="${contextPath}/resources/js/common/header.js" type="text/javascript"></script>
