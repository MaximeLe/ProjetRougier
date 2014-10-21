<%@ page trimDirectiveWhitespaces="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://www.pictime.com/tags/core"   prefix="fwk"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"   prefix="fmt" %>

<fmt:setLocale value="fr_FR" scope="session"/>

<c:set var="description"><tiles:insertAttribute name="description" /></c:set>
<c:set var="canonical"><tiles:insertAttribute name="canonical" /></c:set>
<c:set var="robots"><tiles:insertAttribute name="robots" /></c:set>
<c:set var="bannerStyle">
	<c:if test="${(context.instanceType) == 'STORE_PREVIEW'}">
		body {background-image:url('${contextPath}/resources/${codeIsoLang}/img/StarterStore/Background_orange.jpg'); background-repeat:repeat-x;}
		#global {margin-top:0px;}
		#headerBG {top:34px;}
	</c:if>
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
		<c:if test="${not empty robots }"><meta name="robots" content="${robots }"/>
		</c:if>

		<link href="${contextPath}/resources/${codeIsoLang}/css/screen.css?2" rel="stylesheet" type="text/css" />
		<!--[if lt IE 8]><link href="${contextPath}/resources/${codeIsoLang}/css/ie.css" rel="stylesheet" type="text/css" /><![endif]-->
		
		<tiles:insertAttribute name="rel_prev" />
		<tiles:insertAttribute name="rel_next" />
		
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
	<body <tiles:insertAttribute name="microformat" defaultValue='itemscope itemtype="http://schema.org/WebPage"'/>>
			<!-- Common JS -->
			<tiles:insertAttribute name="commonJS" />
	<!--[if IE 10]>
	<div class="ie10">
	<![endif]-->
	<!--[if IE 9]>
	<div class="ie9">
	<![endif]-->
	<!--[if IE 8]>
	<div class="ie8">
	<![endif]-->
	<!--[if IE 7]>
	<div class="ie7">
	<![endif]-->
	<div id="fondsite">
		<!-- Header (header.jsp) -->
		<c:import url="/header.html"/>
		<fwk:cache key="headerTemplate:navigation:storeId=${storeId}:langId=${langId}:catalogId=${catalogId}">
			<c:import url="/navigation.html"/>
		</fwk:cache>
		<div id="global">		
			<!-- Chemin -->
			<div id="breadcrumb" itemprop="breadcrumb">
				<tiles:insertAttribute name="breadcrumb" />
			</div>	
			
			<!-- EMS -->
			<tiles:insertAttribute name="ems" />
			<!-- Contenu -->
			<div id="content">
				<!-- Menu -->
				<tiles:insertAttribute name="menu"/>
				<!-- Contenu -->
				<tiles:insertAttribute name="content"/>
			</div>
			<tiles:insertAttribute name="emsSurFooter" />
			<!-- Footer (footer.jsp) -->
			<fwk:cache key="footer:storeId=${storeId}:langId=${langId}:catalogId=${catalogId}">
				<c:import url="/footer.html?storeId=${storeId}&langId=${langId}&catalogId=${catalogId}&lol=2"/>	
			</fwk:cache>
			
			<c:choose>
				<c:when test="${category != null}">
					<c:import url="/footerSeo.html?categoryId=${category.categoryId}"/>
				</c:when>
				<c:when test="${catalog != null && category == null}">
					<c:import url="/footerSeo.html?catalogId=${catalog.catalogId}"/>
				</c:when>
				<c:otherwise>
					<c:import url="/footerSeo.html"/>
				</c:otherwise>
			</c:choose>
			
		</div>
	</div>
	<!--[if IE 10]>
	</div>
	<![endif]-->
	<!--[if IE 9]>
	</div>
	<![endif]-->
	<!--[if IE 8]>
	</div>
	<![endif]-->
	<!--[if IE 7]>
	</div>
	<![endif]-->
		<!-- More JS -->
		<tiles:insertAttribute name="moreJS"/>
		<c:import url="/footerTag.html?storeId=${storeId}&langId=${langId}&catalogId=${catalogId}"/>	
	</body>
</html>