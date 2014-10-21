<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page import="com.pictime.rougier.merchandising.controller.CatalogEntryListController" %>

<tiles:insertDefinition name="template">
	<tiles:putAttribute name="title"><spring:message code="catalogue.cadeauSearchTitle"/></tiles:putAttribute>
	<tiles:putAttribute name="description">${catalog.catalogDescriptions[langId].title}</tiles:putAttribute>
	<tiles:putAttribute name="canonical" type="string">http://${pageContext['request'].serverName}${catalog.catalogDescriptions[langId].aliasUrl}</tiles:putAttribute>
	<tiles:putAttribute name="ems">&nbsp;</tiles:putAttribute>
	<tiles:putAttribute name="breadcrumb">
		<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt; <span class="lien_chemin"><spring:message code="cadeau.title"/></span>
	</tiles:putAttribute>




	<tiles:putAttribute name="content">	
	
		<div id="moteur_cadeaux">
			<div class="titre">
				<span>Le moteur</span>
				<span class="petit"> à cadeaux</span>
			</div>
			<div class="facettes">	
				<div class="recherche">
					<span>Je recherche par...</span>
				</div>	
				<div class="fcontainer">
				<c:forEach items="${facetResult.facets}" var="facet">	
				<c:if test="${facet.libelleBiz=='age' || facet.libelleBiz=='hids' || facet.libelleBiz=='price'}">	
					<c:choose>
						<c:when test="${facet.libelleBiz=='hids'}">
							<select id="categoryId" name="categoryId" class="hids">
								<option value="0">UNIVERS</option> 					
								<c:forEach items="${facet.values}" var="values">
									<option value="${values.id}">${values.value}</option>							
								</c:forEach>								
							</select>
						</c:when>
					</c:choose>
				</c:if>
				</c:forEach>
				<c:forEach items="${facetResult.facets}" var="facet">	
				<c:if test="${facet.libelleBiz=='age' || facet.libelleBiz=='hids' || facet.libelleBiz=='price'}">	
					<c:choose>
						<c:when test="${facet.libelleBiz=='price'}">
							<select id="${facet.fieldName}" name="${facet.fieldName}" class="price">
								<option value="0">PRIX</option> 					
								<c:forEach items="${facet.ranges}" var="ranges">
									<option value="[${ranges.startValue} TO ${ranges.endValue}]">${ranges.wording}</option>							
								</c:forEach>								
							</select>
						</c:when>
					</c:choose>
				</c:if>
				</c:forEach>
				<c:forEach items="${facetResult.facets}" var="facet">	
				<c:if test="${facet.libelleBiz=='age' || facet.libelleBiz=='hids' || facet.libelleBiz=='price'}">	
					<c:choose>
						<c:when test="${facet.libelleBiz=='age'}">
							<select id="${facet.fieldName}" name="${facet.fieldName}" class="age">
								<option value="0">CLASSE D'AGE</option>
								<c:forEach items="${facet.values}" var="values">
									<option value="${values.id}">${values.value}</option>
								</c:forEach>
							</select>
						</c:when>
					</c:choose>
				</c:if>
				</c:forEach>
				</div>
				<div class="valide">	
					<c:set var="text"><spring:message code="accessCode.rechercher"/></c:set>
					<fwk:genericButton text="${text}" firstSpanClass="Org" btnId="valide"/>
				</div>	
			</div>
			</div>
		
	
			
			<div id="mot_ems" class="ems_mot">
				
				<!--  EMS 1 -->
				${IDEES_CADEAUX}
				<!--  /EMS 1 -->
				
				<!--  EMS 2 -->
				<style>
					.ems_2{float:left;width:973px;height:270px;margin-top:29px;padding-left:18px;background:url(${contextPath}/resources/${codeIsoLang}/img/moteur/ems_2.jpg) no-repeat #ffffff;}
					.ems_2 .bloc_article{float:left;width:188px;margin-top:19px;margin-left:19px;margin-right:30px;}
					.ems_2 .bloc_article .image{float:left;width:188px;height:136px;position:relative}
					.ems_2 .bloc_article .image .stickers{position:absolute;right:0px;top:0px;}
					.ems_2 .bloc_article .intitule{float:left;width:188px;}
					.ems_2 .bloc_article .intitule span{font-family:Arial;font-size:16px;font-weight:bold;color:#303030}
					.ems_2 .bloc_article .description{float:left;width:188px;margin-top:11px;}
					.ems_2 .bloc_article .description span{float:left;width:188px;font-family:Arial;font-size:12px;line-height:14px;color:#777777}
					.ems_2 .bloc_article .prix{float:left;width:188px;margin-top:20px;}
					.ems_2 .bloc_article .prix .barre{float:left;font-family:Arial;font-size:14px;color:#777777;text-decoration:line-through;margin-top:3px;}
					.ems_2 .bloc_article .prix .rouge{float:left;margin-left:10px;font-family:Arial;font-size:20px;color:#e30613;font-weight:bold;}
					
					
				</style>
				<div class="ems_2">
					<c:import url="pushProduit.jsp"></c:import>
				</div>
				<!--  /EMS 2 -->

			</div>		
	</tiles:putAttribute>
	
	<tiles:putAttribute name="moreJS">
		<script src="${contextPath}/resources/js/merchandising/catalogEntryList.js" type="text/javascript"></script>
		<script type="text/javascript">
		var currency = '${devise}';
		var urlSort = '${urlRewriteSort}';
		var urlFilter = '${urlRewriteFilter}';
		var paramNavigationContext = '${paramNavigationContext}';
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>