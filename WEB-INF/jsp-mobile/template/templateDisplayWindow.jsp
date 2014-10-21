<%@ page trimDirectiveWhitespaces="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://www.pictime.com/tags/core"   prefix="fwk"%>

<c:set var="description"><tiles:insertAttribute name="description" /></c:set>
<c:set var="canonical"><tiles:insertAttribute name="canonical" /></c:set>
<c:set var="bannerStyle">
	<c:if test="${(context.instanceType) == 'STORE_PREVIEW'}">
		style="background-image:url('${contextPath}/resources/${codeIsoLang}/img/StarterStore/Background_orange.jpg'); background-repeat:repeat-x;"
	</c:if>
</c:set>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
	<head>
		<!-- Titre -->
		<title><tiles:insertAttribute name="title" /></title>
		
		<!-- Meta -->
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<meta name="description" content="${description}" />
		
		<!-- Canon et CSS -->
		<link rel="canonical" href="${canonical}" />
		<link rel="shortcut icon" type="images/x-icon" href="" />
		<link href="${contextPath}/resources/${codeIsoLang}/css/screen.css?2" rel="stylesheet" type="text/css" />
		
		<!-- googleAnalytics  -->
		<tiles:insertAttribute name="googleAnalytics" />
		
		<link href="${contextPath}/resources/${codeIsoLang}/css/creation_compte.css" rel="stylesheet" type="text/css" />
		<script src="${contextPath}/resources/js/merchandising/catalogEntryList.js" type="text/javascript"></script>
		
		<!-- More CSS -->
		<tiles:insertAttribute name="head" />

		<tiles:insertAttribute name="visualWebsiteOptimizer" />
	</head>
	<body ${bannerStyle}>
			<!-- Common JS -->
			<tiles:insertAttribute name="commonJS" />
		
			<!-- Header (header.jsp) -->
			<fwk:cache key="header:storeId=${storeId}:langId=${langId}:catalogId=${catalogId}">	
				<c:import url="/header.html?storeId=${storeId}&langId=${langId}&catalogId=${catalogId}"/>
			</fwk:cache>
		<div id="global">
					
			<!-- Chemin -->
			<div id="breadcrumb">
				<tiles:insertAttribute name="breadcrumb" />
			</div>	
				
			<!-- Contenu -->
				<div id="contenu">
					<tiles:insertAttribute name="content"/>
				</div>
				
				<!-- Fin du content -->
				<div class="contentEnd"></div>

			
			<!-- Footer (footer.jsp) -->
			<fwk:cache key="footer:storeId=${storeId}:langId=${langId}:catalogId=${catalogId}">
				<c:import url="/footer.html?storeId=${storeId}&langId=${langId}&catalogId=${catalogId}&lol=2"/>	
			</fwk:cache>
		</div>
		
		<!-- More JS -->
		<tiles:insertAttribute name="moreJS" />
		<c:import url="/footerTag.html?storeId=${storeId}&langId=${langId}&catalogId=${catalogId}"/>	
	</body>
</html>