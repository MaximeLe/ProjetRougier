<%@ page trimDirectiveWhitespaces="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://www.pictime.com/tags/core"   prefix="fwk"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<c:set var="description"><tiles:insertAttribute name="description" /></c:set>
<c:set var="canonical"><tiles:insertAttribute name="canonical" /></c:set>
<c:set var="bannerStyle">
	<c:if test="${(context.instanceType) == 'STORE_PREVIEW'}">
		style="background-image:url('${contextPath}/resources/fr_FR/img/StarterStore/Background_orange.jpg');"
	</c:if>
</c:set>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
	<head>
		<title><tiles:insertAttribute name="title" /></title>
		
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		
		<meta name="description" content="${description}" />
		<link rel="canonical" href="${canonical}" />
		
		<!-- meta -->
		<!-- favicon -->
		<link rel="icon" type="image/ico" href="${contextPath}/resources/fr_FR/img/common/favicon16.ico" />
		<link rel="icon" type="image/ico" href="${contextPath}/resources/fr_FR/img/common/favicon32.ico" />
		<link rel="icon" type="image/ico" href="${contextPath}/resources/fr_FR/img/common/favicon48.ico" />
		<link rel="icon" type="image/ico" href="${contextPath}/resources/fr_FR/img/common/favicon64.ico" />
		
		<!-- common css -->
		<link href="${contextPath}/resources/fr_FR/css/StarterStore.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/js/shadowbox/shadowbox.css" rel="stylesheet" type="text/css" />
		<!-- common js -->
		
		
		<!-- googleAnalytics  -->
		<tiles:insertAttribute name="googleAnalytics" />
		
		
		<script type="text/javascript">
			var contextPath = '${contextPath}';
			var codeIsoLang = '${codeIsoLang}';
		</script>
		<script type="text/javascript">
			if(!window.slider) var slider={};slider.data=[{"id":"slide-img-1","client":"nature beauty","desc":"nature beauty photography"},{"id":"slide-img-2","client":"nature beauty","desc":"add your description here"},{"id":"slide-img-3","client":"nature beauty","desc":"add your description here"},{"id":"slide-img-4","client":"nature beauty","desc":"add your description here"},{"id":"slide-img-5","client":"nature beauty","desc":"add your description here"},{"id":"slide-img-6","client":"nature beauty","desc":"add your description here"},{"id":"slide-img-7","client":"nature beauty","desc":"add your description here"}];
		</script>
		<script src="${contextPath}/resources/js/jquery/box.js" type="text/javascript"></script> 					<!-- MI DS TEMPLATE -->
		<script src="${contextPath}/resources/js/jquery/jquery.bgiframe.min.js" type="text/javascript"></script>	<!-- MI DS TEMPLATE -->
		<script src="${contextPath}/resources/js/jquery/jquery.i18n.js" type="text/javascript"></script>			<!-- MI DS TEMPLATE -->
		<script src="${contextPath}/resources/js/dictionary/dictionary_${codeIsoLang}.js" type="text/javascript"></script> <!-- MI DS TEMPLATE -->
		<script src="${contextPath}/resources/js/common/header.js" type="text/javascript"></script>					<!-- MI DS TEMPLATE -->
		<script src="${contextPath}/resources/js/common/functions.js" type="text/javascript"></script>				<!-- Remplacer par common -->
		<script src="${contextPath}/resources/js/shadowbox/shadowbox.js" type="text/javascript"></script>
		<script type="text/javascript">
			Shadowbox.init();
		</script>
		
		<script src="${contextPath}/resources/js/merchandising/catalogEntry.js" type="text/javascript"></script>
		
		
		<tiles:insertAttribute name="head" />		
	</head>
	<body ${bannerStyle}>
		<!-- ********************************************************************** -->
		<!-- ENTETE (header.jsp) -->
		<!-- ********************************************************************** -->
		<fwk:cache key="header:storeId=${storeId}:langId=${langId}:catalogId=${catalogId}">
			<c:import url="/header.html?storeId=${storeId}&langId=${langId}&catalogId=${catalogId}"/>
		</fwk:cache>		
		<!-- ********************************************************************** -->
		<!-- CHEMIN -->
		<!-- ********************************************************************** -->
		<div id="fenetre_haut2">
			<div id="chemin">
				<tiles:insertAttribute name="breadcrumb" />
			</div>
		</div>		
		<!-- ********************************************************************** -->
		<!-- CORPS DU SITE -->
		<!-- ********************************************************************** -->
		<tiles:insertAttribute name="body"/>
		<!-- ********************************************************************** -->
		<!-- PIED DE PAGE -->
		<!-- ********************************************************************** -->
		<fwk:cache key="footer:storeId=${storeId}:langId=${langId}:catalogId=${catalogId}">
			<c:import url="/footer.html?storeId=${storeId}&langId=${langId}&catalogId=${catalogId}"/>
		</fwk:cache>
	</body>
	<c:import url="/footerTag.html?storeId=${storeId}&langId=${langId}&catalogId=${catalogId}"/>	
</html>