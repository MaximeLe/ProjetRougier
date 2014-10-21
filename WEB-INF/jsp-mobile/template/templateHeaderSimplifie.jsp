<%@ page trimDirectiveWhitespaces="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://www.pictime.com/tags/core"   prefix="fwk"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"   prefix="fmt" %>

<fmt:setLocale value="fr_FR" scope="session"/>   

<c:set var="description"><tiles:insertAttribute name="description" /></c:set>
<c:set var="canonical"><tiles:insertAttribute name="canonical" /></c:set>
<c:set var="bannerStyle">
		body {
			background-attachment: fixed;
			background-clip: border-box;
			background-color: #FBFBFB;
			background-image: url("/library/css/img/bg.png");
			background-origin: padding-box;
			background-position: center center;
			background-repeat: no-repeat;
			background-size: cover;
			}
</c:set>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
	<head>
		<!-- Titre -->
		<title><tiles:insertAttribute name="title" /></title>
		
		<!-- Meta -->
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<meta name="description" content="${description}" />
		
		<!-- Canon et CSS -->
		<link rel="canonical" href="${canonical}" />
		<link rel="shortcut icon" href="${contextPath}/resources/fr_FR/img/common/favicon16.ico"> 
		<link rel="icon" type="image/ico" href="${contextPath}/resources/fr_FR/img/common/favicon16.ico"> 
		<link rel="shortcut icon" type="images/x-icon" href="${contextPath}/resources/fr_FR/img/common/favicon16.ico" />

		<link href="${contextPath}/resources/${codeIsoLang}/css/screen.css?2" rel="stylesheet" type="text/css" />
		<!--[if lt IE 8]><link href="${contextPath}/resources/${codeIsoLang}/css/ie.css" rel="stylesheet" type="text/css" /><![endif]-->
		
		<!-- googleAnalytics  -->
		<tiles:insertAttribute name="googleAnalytics" />
		
		<!-- More CSS -->
		<tiles:insertAttribute name="head" />
		
		<!-- Banner Style -->
		<c:if test="${bannerStyle != null}">
		<style type="text/css">
			${bannerStyle}
		</style>
		</c:if>	
		
		<tiles:insertAttribute name="visualWebsiteOptimizer" />
	</head>
	<body <tiles:insertAttribute name="microformat" defaultValue='itemscope itemtype="http://schema.org/WebPage"'/> onunload="">
		
		<!-- Common JS -->
		<tiles:insertAttribute name="commonJS" />
		<div id="fondsite">
			<!-- Header (header.jsp) -->
			<c:import url="/header.html?storeId=${storeId}&langId=${langId}&catalogId=${catalogId}&tunnel=true"/>
			<div id="global" class="md100">	
				<!-- Contenu -->
				<tiles:insertAttribute name="content"/>
			
				<!-- Footer (footer.jsp) -->
				<fwk:cache key="footer:storeId=${storeId}:langId=${langId}:catalogId=${catalogId}">
					<c:import url="/footer.html?storeId=${storeId}&langId=${langId}&catalogId=${catalogId}&lol=2"/>	
				</fwk:cache>	
			</div>
		</div>
		<!-- More JS -->
		<tiles:insertAttribute name="moreJS" />
		<c:import url="/footerTag.html?storeId=${storeId}&langId=${langId}&catalogId=${catalogId}"/>	
	</body>
</html>