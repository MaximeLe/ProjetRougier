<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
TU ME VOIS banane?
<tiles:insertDefinition name="template">

	<tiles:putAttribute name="title">
		<c:choose>
			<c:when test="${category.categoryDescriptions[langId].description != null && category.categoryDescriptions[langId].description != ''}">
				${fn:trim(category.categoryDescriptions[langId].description)}
			</c:when>
			<c:otherwise>
				${category.categoryDescriptions[langId].title}&nbsp;<spring:message code="catalogue.title"/>
			</c:otherwise>
		</c:choose>
	</tiles:putAttribute>
	<tiles:putAttribute name="canonical" type="string">http://${pageContext['request'].serverName}${category.categoryDescriptions[langId].aliasUrl}</tiles:putAttribute>

	<tiles:putAttribute name="breadcrumb">
		&nbsp;<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt;
		<c:set var="urlRewriteCatalog">
			<fwk:rewrite url="${baseUrlWithoutCatalogId}&catalogId=${catalog.catalogId}" paramUnRewrited="${paramRewriteCategory}" />
		</c:set>
		<c:choose>
			<c:when test="${catalog.catalogId==5}">
				<a href="${urlRewriteCatalog}">${catalog.catalogDescriptions[langId].title}</a>&nbsp;
			</c:when>
			<c:otherwise>
				${catalog.catalogDescriptions[langId].title}&nbsp;
			</c:otherwise>
		</c:choose>
		<c:if test="${not empty breadcrumb}">
			&gt;
		</c:if>
		<c:forEach items="${breadcrumb}" var="category" varStatus="cat">
			<c:set var="urlRewriteBreadcrumb">
				<c:choose >
					<c:when test="${category.url == ''}">
					</c:when>
					<c:otherwise>
						<fwk:rewrite url="${baseUrlWithoutCategoryId}&categoryId=${category.url}" paramUnRewrited="${paramRewriteCategory}" />
					</c:otherwise>
				</c:choose>
			</c:set>
			<c:choose>
				<c:when test="${!cat.last && category.url != ''}">
					<a href="${urlRewriteBreadcrumb}">${category.libelle}</a>&nbsp;&gt;
				</c:when>
				<c:when test="${cat.last}">
					<span>${category.libelle}</span>
				</c:when>
			</c:choose>
		</c:forEach>


		<c:if test="${!empty urlEndOfSearch}">
			| ${param.text}
			<a href="${urlEndOfSearch}" class="filter"><img src="${contextPath}/resources/${codeIsoLang}/img/StarterStore/btn_croix.png" alt="X"/></a>
		</c:if>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<div id="content" class="categorySimpleList">
			<!-- ${animation}  -->
			<style type="text/css">
			#emsCML {width:990px;height:80px;background:url("${mediaPath}/ems/emsCML_bg.png") no-repeat;margin-bottom:30px;}
			#emsCML h1 {float:left;width:138px;margin:14px 0 0 29px;font-size:34px;color:#fff;text-align:center;line-height:26px;}
			#emsCML h1 span {font-size:22px;}
			#emsCML p {float:left;width:580px;margin:14px 0 0 133px;font-size:14px;line-height:17px;color:#777777;}
			</style>
			${CAT_PC_BANDEAU}

		<c:if test="${fn:length(categories) > 0}">
			<c:forEach items="${categories}" var="categorie" varStatus="categorieStatus">
				<c:choose>
					<c:when test="${categorieStatus.index % 2 == 0}">
						<div class="clear"></div>
						<div class="cat floatLeft">
							<h2 class="titre"><a href="${categorie.category.lien}">${categorie.category.libelle}</a></h2>
							<div class="visuel">
								<a href="${categorie.category.lien}"><img src="${mediaPath}${categorie.image}" width="474" height="157" alt="" border="0"/></a>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="cat floatRight">
							<h2 class="titre"><a href="${categorie.category.lien}">${categorie.category.libelle}</a></h2>
							<div class="visuel">
								<a href="${categorie.category.lien}"><img src="${mediaPath}${categorie.image}" width="474" height="157" alt="" border="0"/></a>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:if>
		
		<div id="emsPC">${EMS_PC}</div>
		
		</div>	
	</tiles:putAttribute>
	
	<tiles:putAttribute name="moreJS">
		<script type="text/javascript">
		</script>
		<c:if test="${isTagMetafiliationActivated }">
			<script type="text/javascript" src="http://img.metaffiliation.com/u/11/p33385.js?zone=categorie&idcategorie=${fn:trim(category.categoryBiz) }"></script>
		</c:if>
	</tiles:putAttribute>
	FIN DE LA PAGE ?
</tiles:insertDefinition>