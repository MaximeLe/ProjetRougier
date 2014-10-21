<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="urlCanonical">
	<c:choose>
		<c:when test="${category != null}">
			<fwk:rewrite url="${baseUrlWithoutCatalogId}&catalogId=${catalog.catalogId}&categoryId=${category.categoryId}" />
		</c:when>
		<c:otherwise>
			<fwk:rewrite url="${baseUrlWithoutCatalogId}&catalogId=${catalog.catalogId}" />
		</c:otherwise>
	</c:choose>
</c:set>

<tiles:insertDefinition name="template">
	<tiles:putAttribute name="canonical" type="string">http://${pageContext['request'].serverName}${urlCanonical}</tiles:putAttribute>
	<tiles:putAttribute name="title">
		<c:choose>
			<c:when test="${category.categoryDescriptions[langId].description != null && category.categoryDescriptions[langId].description != ''}">
				${fn:trim(category.categoryDescriptions[langId].description)}
			</c:when>
			<c:when test="${catalog.catalogId != null && category==null}">
				${fn:trim(catalog.catalogDescriptions[langId].title)}&nbsp;<spring:message code="catalogue.title"/>
			</c:when>
			<c:otherwise>
				${fn:trim(category.categoryDescriptions[langId].title)}&nbsp;<spring:message code="catalogue.title"/>
			</c:otherwise>
		</c:choose>
	</tiles:putAttribute>
	<tiles:putAttribute name="description">
		<c:choose>
			<c:when test="${catalog.catalogId==5}">
				<spring:message code="catalogue.ideeCreative.description"/>
			</c:when>
			<c:otherwise>
				${fn:trim(category.categoryDescriptions[langId].title)}&nbsp;:&nbsp;
				<spring:message code="categorie.meta.description.premiere.partie"/>&nbsp;
				${fn:trim(category.categoryDescriptions[langId].title)}&nbsp;
				<spring:message code="categorie.meta.description.deuxieme.partie"/>
			</c:otherwise>
		</c:choose>
	</tiles:putAttribute>


	<tiles:putAttribute name="breadcrumb">
		&nbsp;<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt;
		<c:set var="urlRewriteCatalog">
			<fwk:rewrite url="${baseUrlWithoutCatalogId}&catalogId=${catalog.catalogId}" paramUnRewrited="${paramRewriteCategory}" />
		</c:set>
		<c:choose>
			<c:when test="${catalog.catalogBiz=='CAT_IDEE_CREATIVE'}">
				<a href="${urlRewriteCatalog}">${catalog.catalogDescriptions[langId].title}</a>&nbsp;
			</c:when>
<%-- 			<c:otherwise> --%>
<%-- 				${catalog.catalogDescriptions[langId].title}&nbsp; --%>
<%-- 			</c:otherwise> --%>
		</c:choose>
		<c:if test="${not empty breadcrumb and catalog.catalogBiz=='CAT_IDEE_CREATIVE'}">
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
				<c:when test="${!cat.last && category.url != ''}">
					<span>${category.libelle}</span>&nbsp;&gt;
				</c:when>
				<c:when test="${cat.last}">
					<span>${category.libelle}</span>
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
		</c:forEach>


		<c:if test="${!empty urlEndOfSearch}">
			| ${param.text}
			<a href="${urlEndOfSearch}" class="filter"><img src="${contextPath}/resources/${codeIsoLang}/img/StarterStore/btn_croix.png" alt="X"/></a>
		</c:if>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<div id="content" class="categoryMultipleList">
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
					<c:if test="${categorie.categoryBiz != 'KITS' || (categorie.categoryBiz == 'KITS' && (fn:length(categorie.childsCategories) > 1))}">
						<c:choose>
							<c:when test="${categorieStatus.index % 2 == 0}">
								<div class="clear"></div>
								<div class="cat floatLeft">
									<div class="bg">
										<c:if test="${categorie.image != '' && categorie.image != null}">
											<img src="${mediaPath}${categorie.image}" width="160" height="160" alt="" border="0"/>
										</c:if>
										<ul>
											<li><h2>${categorie.parentCategory.libelle}</h2></li>
											<c:forEach items="${categorie.childsCategories}" var="childCategorie">
												<li><h3><a href="${childCategorie.lien}">${childCategorie.libelle}</a></h3></li>
											</c:forEach>
										</ul>
										<div class="tache"></div>
									</div>
								</div>
							</c:when>
							
							<c:otherwise>
								<div class="cat floatRight">
									<div class="bg">
										<c:if test="${categorie.image != '' && categorie.image != null}">
											<img src="${mediaPath}${categorie.image}" width="160" height="160" alt="" border="0"/>
										</c:if>
										<ul>
											<li><h2>${categorie.parentCategory.libelle}</h2></li>
											<c:forEach items="${categorie.childsCategories}" var="childCategorie">
												<li><h3><a href="${childCategorie.lien}">${childCategorie.libelle}</a></h3></li>
											</c:forEach>
										</ul>
										<div class="tache"></div>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</c:if>
				</c:forEach>
			</c:if>
			
			
			<c:if test="${fn:length(categories) > 0}">
				<c:forEach items="${categories}" var="categorie" varStatus="categorieStatus">
					<c:if test="${categorie.categoryBiz == 'KITS' && (fn:length(categorie.childsCategories) == 1)}">
						<div class="cat catU">
							<div class="bg">
								<p><span class="bold uppercase">DÉCOUVREZ AUSSI :</span> <a href="${categorie.childsCategories[0].lien}">${categorie.childsCategories[0].libelle}</a></p>
								<div class="tache"></div>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</c:if>
			
			
			<div id="emsPC">${EMS_PC}</div>
			
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="moreJS">
		<c:if test="${isTagMetafiliationActivated }">
			<script type="text/javascript" src="http://img.metaffiliation.com/u/11/p33385.js?zone=categorie&idcategorie=${fn:trim(category.categoryBiz) }"></script>
		</c:if>
	</tiles:putAttribute>
</tiles:insertDefinition>