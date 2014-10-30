<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<tiles:insertDefinition name="mobile-template">
	<tiles:putAttribute name="canonical">
		http://www.rougier-ple.fr
	</tiles:putAttribute>
	<tiles:putAttribute name="title"><c:if test="${isSolde}"><spring:message code="common.soldes"/></c:if><spring:message code="catalogue.homePageTitles"/></tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="catalogue.homePageDescription"/></tiles:putAttribute>
	<tiles:putAttribute name="webmasterTools"><meta name="google-site-verification" content="5UZLGIStZS9BRjs1mCLpMfVBGjzBZ-pG4-zGz1---0o" /></tiles:putAttribute>
	<tiles:putAttribute name="head">
		<style type="text/css">
		#breadcrumb {display:none;}
		</style>
	 	<link href="http://${pageContext['request'].serverName}${contextPath}/resources-mobile/${codeIsoLang}/img/common/logo.png" rel="image_src" />
		<c:forEach items="${IMG_FACEBOOK}" var="image">
			<link href="http://${pageContext['request'].serverName}${image}" rel="image_src" />
		</c:forEach>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="moreJS">
		<script src="${contextPath}/resources-mobile/js/merchandising/catalogEntry.js" type="text/javascript"></script>
		<script src="${contextPath}/resources-mobile/js/merchandising/visio.js" type="text/javascript"></script>
		<c:if test="${isTagMetafiliationActivated }">
			<script type="text/javascript" src="http://img.metaffiliation.com/u/11/p33385.js?zone=accueil"></script>
		</c:if>
	</tiles:putAttribute>
</tiles:insertDefinition>