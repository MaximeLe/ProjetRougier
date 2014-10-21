<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<tiles:insertDefinition name="templateDisplayWindow">
	<tiles:putAttribute name="head">
		<style type="text/css">
.templateMenu #contenu {
	padding-top: 149px;
}
</style>
	</tiles:putAttribute>
	<tiles:putAttribute name="title">
		<c:forEach items="${title}" var="titleCategory" varStatus="statut">${titleCategory.libelle}<c:if
				test="${!statut.last}"> / </c:if>
		</c:forEach>
	</tiles:putAttribute>
	<tiles:putAttribute name="description">${category.categoryDescriptions[langId].description}</tiles:putAttribute>
	<tiles:putAttribute name="canonical" type="string">http://${pageContext['request'].serverName}${category.categoryDescriptions[langId].aliasUrl}</tiles:putAttribute>

	<tiles:putAttribute name="breadcrumb">
		||&nbsp;<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt;
		<c:set var="urlRewriteCatalog">
			<fwk:rewrite
				url="${baseUrlWithoutCatalogId}&catalogId=${catalog.catalogId}"
				paramUnRewrited="${paramRewriteCategory}" />
		</c:set>
		<a href="${urlRewriteCatalog}">${catalog.catalogDescriptions[langId].title}</a>&nbsp;&gt;
		<c:forEach items="${breadcrumb}" var="category" varStatus="cat">
			<c:set var="urlRewriteBreadcrumb">
				<fwk:rewrite
					url="${baseUrlWithoutCategoryId}&categoryId=${category.url}"
					paramUnRewrited="${paramRewriteCategory}" />
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

	</tiles:putAttribute>

	<tiles:putAttribute name="hat">
		<c:if test="${!empty (category.categoryDescriptions[langId].banner)}">
			<img
				src="${mediaPath}${category.categoryDescriptions[langId].banner}"
				border="0" alt="${category.categoryDescriptions[langId].title}"
				class="bannerCategory" />
		</c:if>
	</tiles:putAttribute>



	<tiles:putAttribute name="content">
		<div id="contenuTM" class="listPage">
		<c:forEach
			items="${categoriesList}" var="category">
			<div class="categorie">
			<div style="height: 200px;"><c:set var="url">
				<fwk:rewrite
					url="/catalogEntryList.html?storeId=${storeId}&langId=${langId}&catalogId=${catalogId}&categoryId=${category.categoryId}" />
			</c:set>
			<p><a href="${url}" class="categorieLink">${category.categoryDescriptions[langId].title}</a></p>
			 
			 <img src="${catalogPath}/${category.categoryDescriptions[langId].backgroundPicture}" alt="${category.categoryBiz}" style="max-width:130px;max-height:130px" border="0" />
			 </div>

			</div>
		</c:forEach></div>
	</tiles:putAttribute>

	<tiles:putAttribute name="moreJS">
		<script type="text/javascript">
		var urlSort = '${urlRewriteSort}';
		var urlFilter = '${urlRewriteFilter}';
		var paramNavigationContext = '${paramNavigationContext}';
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>