<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
debut contentsearch
<tiles:insertDefinition name="templateMenu">
	<tiles:putAttribute name="head">
		<style type="text/css">
			.templateMenu #contenu {
				padding-top:149px;
			}
		</style>
		
	</tiles:putAttribute>
	<tiles:putAttribute name="title"><spring:message code="catalogue.rechercherUnMot"/>${param.text}</tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="catalogue.rechercherUnMot"/>${param.text}</tiles:putAttribute>
	<tiles:putAttribute name="canonical" type="string">http://${pageContext['request'].serverName}${currentUrl}</tiles:putAttribute>
	
	<tiles:putAttribute name="breadcrumb">
		<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt;&nbsp;<span><spring:message code="catalogue.rechercherUnMot"/>${param.text}</span>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="hat">
		<div class="searchBanner">
			<div class="searchType">
				<div class="searchTabs">
					<c:forEach items="${bannerResult}" var="entry" varStatus="loop"  >
						<c:forEach items="${entry.value}" var="response" varStatus="loopResp">
							<c:set var="active"></c:set>
							<c:choose><c:when test="${response.selected}"><c:set var="active"><spring:message code="catalogue.active"/></c:set></c:when>
							<c:otherwise><c:set var="active"><spring:message code="catalogue.desactive"/></c:set></c:otherwise></c:choose>
							<c:set var="urlType"><fwk:rewrite url="${searchUrlNoRewrite}&collectionId=${response.collectionId}&collectionTypeId=${response.collectionType.collectionTypeId}"/></c:set>
							<a href="${urlType}" class="searchTab ${active}">${response.description}<br/>${response.numResults}&nbsp;<spring:message code="catalogue.resultats"/></a>
							
							<c:if test="${!(loop.last && loopResp.last)}">
								<div class="etapes_separations"></div>
							</c:if>
						</c:forEach>
					</c:forEach>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="menu">
		<div id="menu">
			<div class="ems">
				${animation}
				<img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/exEms_01.png" alt="ems_1" />
			</div>
		</div>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<div id="contenuTM" class="listPage">
			<div class="affinerContent">
				<div class="afficher">
					<spring:message code="catalogue.afficher"/>
					<c:choose>
						<c:when test="${facetContext.pageSize == 10}">
							<a href="${currentUrlPageSize}10" class="bold">10</a> |
							<a href="${currentUrlPageSize}20">20</a> |
							<a href="${currentUrlPageSize}100"><spring:message code="catalogue.tous"/></a>
						</c:when>
						<c:when test="${facetContext.pageSize == 20}">
							<a href="${currentUrlPageSize}10">10</a> |
							<a href="${currentUrlPageSize}20" class="bold">20</a> |
							<a href="${currentUrlPageSize}100"><spring:message code="catalogue.tous"/></a>
						</c:when>
						<c:otherwise>
							<a href="${currentUrlPageSize}10">10</a> |
							<a href="${currentUrlPageSize}20">20</a> |
							<a href="${currentUrlPageSize}100" class="bold"><spring:message code="catalogue.tous"/></a>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="resultats">${facetResult.numFound}&nbsp;<spring:message code="catalogue.contenus"/></div>
				<div class="paginationG"><jsp:include page="paging.jsp" /></div>
			</div>
			<div class="contentList">
				<h1><spring:message code="catalogue.resultatsRecherche"/></h1>
				<c:if test="${facetResult.numFound > 0}">
					<ul>
						<c:forEach items="${facetResult.docs}" var="document">
							<c:set var="urlTypeId"/>
							<c:choose>
								<c:when test="${!empty document.attr['rubriqueId']}">
									<c:set var="urlTypeId" value="&categoryId=${document.attr['rubriqueId']}"/>
								</c:when>
								<c:otherwise>
									<c:set var="urlTypeId" value="&articleId=${document.attr['articleId']}"/>
								</c:otherwise>
							</c:choose>
							<c:set var="urlContent"><fwk:rewrite url="/contentDisplay.html?action=getPageContent${urlTypeId}&langId=${document.attr['langId']}" /></c:set>
							<li><a href="${urlContent}" class="bold">${document.attr['title']}</a><br/>
							${document.attr['metaDescription']}</li>
							
						</c:forEach>
					</ul>
				</c:if>
			</div>

			<div class="paginationBas">
				<div class="paginationG"><jsp:include page="paging.jsp" /></div>
			</div>
		</div>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="moreJS">
		<script type="text/javascript">
			$(".contentStart").css("display","block");
		</script>
	</tiles:putAttribute>
	
</tiles:insertDefinition>