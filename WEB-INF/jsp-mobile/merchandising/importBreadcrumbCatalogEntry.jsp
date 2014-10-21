<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<span id="chemin_categories" style="display: none">
	<a href="/" class="lien_chemin"><spring:message code="breadcrumb.accueil"/></a> &gt;
	<c:if test="${ceCatalog.catalogBiz == 'CAT_IDEE_CREATIVE'}">
		<a href="${ceCatalog.catalogDescriptions[langId].aliasUrl}" class="lien_chemin">${ceCatalog.catalogDescriptions[langId].title}</a> &gt;
	</c:if>
	<c:if test="${!empty ceDisplay.breadcrumbTitle}">
		<c:set var="breacrumbRecursivity"></c:set>
		<c:forEach items="${ceDisplay.breadcrumbTitle}" var="category" varStatus="statut">
			<c:set var="breacrumbChild">
				<c:set var="urlRewriteBreadcrumb"><fwk:rewrite url="${ceDisplay.urlPageCatalogEntryList}&categoryId=${category.categoryId}"/></c:set>
				<c:choose>
					<c:when test="${!statut.first}">
						<c:choose>
							<c:when test="${statut.index == 1 || statut.index == 3}">
									<span>
										${breacrumbRecursivity}
									</span>
							</c:when>
							<c:otherwise>
								
								<span>
									<a href="${urlRewriteBreadcrumb}" class="lien_chemin">
									 	${category.categoryDescriptions[langId].title}
									</a> >
									<span>
										${breacrumbRecursivity}
									</span>
								</span>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<span>
							<a href="${urlRewriteBreadcrumb}" class="lien_chemin">
								${category.categoryDescriptions[langId].title}
							</a> >
							<span>
								<span>
									<c:set var="currentUrlRewrite"><fwk:rewrite url="${ceDisplay.urlWithoutEcId}${ceDisplay.catalogEntry.catalogEntryId}" paramUnRewrited="${ceDisplay.paramUrlWithoutEcId}" /></c:set>
									<span class="lien_chemin">
									 	${ceDisplay.catalogEntryDescription.title1}
									</span>
									<%--
									 suppression de la référence à l'URL courante
									<span style="display:none">${currentUrlRewrite}</span>--%>
								</span>
							</span>
						</span>
					</c:otherwise>
				</c:choose>
			</c:set>
			<c:set var="breacrumbRecursivity">${breacrumbChild}</c:set>
		</c:forEach>
		${breacrumbRecursivity}
	</c:if>
	<c:if test="${empty ceDisplay.breadcrumbTitle}">
		<c:set var="urlRewriteBreadcrumb">
			<fwk:rewrite url="${ceDisplay.urlPageCatalogEntryList}&categoryId=${categoryId}"/>
		</c:set>
		<span>
			<a href="${urlRewriteBreadcrumb}" class="lien_chemin">
			 	${ceCategory.categoryDescriptions[langId].title}
			</a> >
			<span>
				${ceDisplay.catalogEntryDescription.title1}
			</span>
		</span>
	</c:if>
</span>