<%@ page trimDirectiveWhitespaces="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="sitemapQuiSommeNous">/qui-sommes-nous.r.html</c:set>
<c:set var="sitemapRewrite"><fwk:rewrite url="/sitemap.html?action=sitemapHtml&langId=${langId}&storeId=${storeId}" /></c:set>

<div id="footer">
	${FOOTER}
	${FOOTER_LENGOW}
</div>