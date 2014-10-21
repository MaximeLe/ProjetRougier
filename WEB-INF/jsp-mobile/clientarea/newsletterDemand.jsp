<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<tiles:insertDefinition name="templateMenu">
	<tiles:putAttribute name="title"><c:forEach items="${title}" var="titleCategory" varStatus="statut">${titleCategory.libelle}<c:if test="${!statut.last}"> / </c:if></c:forEach></tiles:putAttribute>
	<tiles:putAttribute name="description">${category.categoryDescriptions[langId].description}</tiles:putAttribute>
	<tiles:putAttribute name="canonical" type="string">${category.categoryDescriptions[langId].aliasUrl}</tiles:putAttribute>
	
	<tiles:putAttribute name="breadcrumb">
		||&nbsp;<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt;
		<c:set var="urlRewriteCatalog">
			<fwk:rewrite url="${baseUrlWithoutCatalogId}&catalogId=${catalog.catalogId}" paramUnRewrited="${paramRewriteCategory}" />
		</c:set>
		<a href="${urlRewriteCatalog}">${catalog.catalogDescriptions[langId].title}</a>&nbsp;&gt;
		<c:forEach items="${breadcrumb}" var="category" varStatus="cat">
			<c:set var="urlRewriteBreadcrumb">
				<fwk:rewrite url="${baseUrlWithoutCategoryId}&categoryId=${category.url}" paramUnRewrited="${paramRewriteCategory}" />
			</c:set>
			<c:choose>
				<c:when test="${!cat.last}">
					<a href="${urlRewriteBreadcrumb}">${category.libelle}</a>&nbsp;&gt;
				</c:when>
				<c:otherwise>
					<span>${category.libelle}</span>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<c:forEach items="${filters}" var="filter">
			<c:if test="${filter.field != 'hids' && filter.field != 'published' && filter.field != 'type'}">
				<c:set var="urlRewriteBreadCrumb">
					<c:choose>
						<c:when test="${!empty paramRewriteRemoveFilter && !empty filter.params}">
							<fwk:rewrite url="${baseUrlRewrited}"  paramUnRewrited="${paramRewriteRemoveFilter}&${filter.params}" />
						</c:when>
						<c:when test="${!empty paramRewriteRemoveFilter}">
							<fwk:rewrite url="${baseUrlRewrited}" paramUnRewrited="${paramRewriteRemoveFilter}" />
						</c:when>
						<c:when test="${empty filter.params}">
							<fwk:rewrite url="${baseUrlRewrited}" paramUnRewrited="" />
						</c:when>
						<c:otherwise>
							<fwk:rewrite url="${baseUrlRewrited}" paramUnRewrited="${filter.params}" />
						</c:otherwise>
					</c:choose>
				</c:set>
				<a href="${urlRewriteBreadCrumb}" class="filter">&nbsp;&nbsp;<span>X</span> ${filter.value}</a>
			</c:if>
		</c:forEach>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="hat">
		<!--  <img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/exHat.png" width="980" height="220" border="0" alt=""/>-->
		<c:if test="${!empty (category.categoryDescriptions[langId].backgroundPicture)}">
			<!-- A decommenter pour Prod -->
			<!-- <img src="${category.categoryDescriptions[langId].backgroundPicture}" alt="${category.categoryDescriptions[langId].backgroundPicture}"/>  -->
		</c:if>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="menu">
		<div id="menu">
			<div class="menu_titre">
				<div class="titre"><spring:message code="newsletter.title"/></div>
			</div>
			<div id="menu_bas">
			</div>
		</div>

	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<div id="clients" class="newsletter_demande">
			<div id="contenu_interieur">
				<div class="coordonnees">
					<h2><spring:message code="newsletter.gestionNewsletters"/></h2>
				</div>
				<div class="contenu_blanc">
					<form name="form_newsletter_demande" action="?action=displayNLD" method="post">
						<div class="titre">
							<span><spring:message code="newsletter.desinscriptionNewsletters"/></span>
						</div>
						<div class="bloc_droit">
							<label for="adresse_mail"><spring:message code="newsletter.votreAdresseEmail"/><span>*</span></label>
							<label for="newsletter_1"><spring:message code="newsletter.title"/>&nbsp;1</label>
							<label for="newsletter_2"><spring:message code="newsletter.title"/>&nbsp;2</label>
						</div>
						<div class="bloc_gauche">
							<input id="adresse_mail" type="text" value=""/>
							<div>
								<input type="checkbox" />
								<select size="1"><option value="0" class="grise"><spring:message code="newsletter.selectionnezMotif"/></option><option value="1">test</option><option value="2">test2</option></select>
							</div>
							<div>
								<input type="checkbox" />
								<select size="1"><option value="0" class="grise"><spring:message code="newsletter.selectionnezMotif"/></option><option value="1">test</option><option value="2">test2</option></select>
							</div>
						</div>
						<div class="bloc_central">
							<a><img src="${contextPath}/resources/${codeIsoLang}/img/clientArea/Je_valide.jpg" alt="<spring:message code="accessCode.boutonJeValide"/>"/></a>
						</div>
					</form>
				</div>
				<div id="fond_blanc"></div>
			</div>				
		</div>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="moreJS">
		<script type="text/javascript">
		var urlSort = '${urlRewriteSort}';
		var urlFilter = '${urlRewriteFilter}';
		var paramNavigationContext = '${paramNavigationContext}';
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>