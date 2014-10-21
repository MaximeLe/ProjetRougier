<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="devise"><c:choose><c:when test="${storeId==2}">&#36;</c:when><c:otherwise>€</c:otherwise></c:choose></c:set>

<tiles:insertDefinition name="templateMenu">
	<tiles:putAttribute name="head">
		<style type="text/css">
			.templateMenu #contenu {
				padding-top:149px;
			}
		</style>
	</tiles:putAttribute>
	<tiles:putAttribute name="title"><c:forEach items="${title}" var="titleCategory" varStatus="statut">${titleCategory.libelle}<c:if test="${!statut.last}"> / </c:if></c:forEach></tiles:putAttribute>
	<tiles:putAttribute name="description">${category.categoryDescriptions[langId].description}</tiles:putAttribute>
	<tiles:putAttribute name="canonical" type="string">http://${pageContext['request'].serverName}${category.categoryDescriptions[langId].aliasUrl}</tiles:putAttribute>
	
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
			<c:if test="${(searchPage || ((empty searchPage) && filter.field != 'hids')) && (filter.field != 'published' && filter.field != 'type' && filter.field != 'isAvailable')}">
				| 
				<c:choose>
					<c:when test="${filter.field == 'averageRating'}">
						<c:set var="noMaxRating" value="true" scope="request" />
						<c:set var="rating" value="${filter.value}" scope="request"/>
						<c:import url="showRatingFacet.jsp" />
					</c:when>
					<c:otherwise>
						${filter.value}
					</c:otherwise>
				</c:choose>
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
				<a href="${urlRewriteBreadCrumb}" class="filter"><img src="${contextPath}/resources/${codeIsoLang}/img/StarterStore/btn_croix.png" alt="X"/></a>
			</c:if>
		</c:forEach>
		<c:if test="${!empty urlEndOfSearch}">
			| ${param.text}
			<a href="${urlEndOfSearch}" class="filter"><img src="${contextPath}/resources/${codeIsoLang}/img/StarterStore/btn_croix.png" alt="X"/></a>
		</c:if>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="hat">
		<c:if test="${!empty (category.categoryDescriptions[langId].banner)}">
			<img src="${mediaPath}${category.categoryDescriptions[langId].banner}" border="0" alt="${category.categoryDescriptions[langId].title}" class="bannerCategory"/>
		</c:if>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="menu">
		<div id="menu">
			<div class="menuCeList">
				<div class="titre">${category.categoryDescriptions[langId].title}</div>
				<c:forEach items="${facetResult.facets}" var="facet">
					<c:if test="${facet.fieldName == 'hids'}">
						<ul class="categories">
							<c:set var="values" value="${facet.values}" scope="request" />
							<c:import url="menuCategory.jsp"/>
						</ul>
					</c:if>
				</c:forEach>
			</div>
			<div class="ems">
				${animation}
			</div>
		</div>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<div id="contenuTM" class="listPage">
			<div class="affiner">
				<div class="filtres">
					<div class="titre"><spring:message code="catalogue.affinezVotreRecherche"/></div>
					<c:forEach items="${facetResult.facets}" var="facet">
						<c:if test="${facet.fieldName != 'hids' }">
						<ul>
							<li class="filtre">${facet.libelleWeb} :</li>
							<c:choose>
								<c:when test="${!empty facet.values}">
							<c:forEach items="${facet.values}" var="value">
							<li>
								<c:choose>
									<c:when test="${value.selected}">
										<input type="checkbox" name="${value.id}" id="${value.id}" onchange="addFilter(this, '${facet.fieldName}')" checked="checked"/>
									</c:when>
									<c:otherwise>
										<input type="checkbox" name="${value.id}" id="${value.id}" onchange="addFilter(this, '${facet.fieldName}')"/>
									</c:otherwise>
								</c:choose>	
								<c:choose>
									<c:when test="${!empty value.image}">
										<label for="${value.id}"><img src="${value.image}" title="${value.value}" alt="${value.value}" /></label>
									</c:when>
									<c:otherwise>
										<label for="${value.id}">${value.value} (${value.count})</label>
									</c:otherwise>
								</c:choose>
							</li>
							</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach items="${facet.ranges}" var="ranges">
										<li>
											<c:choose>
												<c:when test="${ranges.selected}">
													<input type="checkbox" name="[${ranges.startValue} TO ${ranges.endValue}]" onchange="addFilter(this, '${facet.fieldName}')" checked="checked"/>
												</c:when>
												<c:otherwise>
													<input type="checkbox" name="[${ranges.startValue} TO ${ranges.endValue}]" onchange="addFilter(this, '${facet.fieldName}')"/>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${facet.libelleBiz == 'note_moyenne'}">
													<c:set var="noMaxRating" value="" scope="request" />
													<c:set var="rating" value="${ranges.wording}" scope="request"/>
													<c:import url="showRatingFacet.jsp" />
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${!empty ranges.wording}">
															${ranges.wording}
														</c:when>
														<c:otherwise>
															[${ranges.startValue} TO ${ranges.endValue}]
														</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose>
											 (${ranges.count})
										</li>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</ul>
						</c:if>
					</c:forEach>
				</div>
				<div class="trier">
					<select name="sort"  onchange="order(this)">
						<option value=""><spring:message code="catalogue.trierPar"/></option>
						<option value="price:asc" ${(paramOrderField == 'price:asc')? 'selected="selected"':''} ><spring:message code="catalogue.prixPlusBas"/></option>
						<option value="price:desc" ${(paramOrderField == 'price:desc')? 'selected="selected"':''}><spring:message code="catalogue.prixPlusEleve"/></option>
						<option value="id:asc" ${(paramOrderField == 'id:asc')? 'selected="selected"':''}><spring:message code="catalogue.idPlusPetit"/></option>
						<option value="id:desc" ${(paramOrderField == 'id:desc') ? 'selected="selected"':''}><spring:message code="catalogue.idPlusGrand"/></option>
						<option value="averageRating:asc" ${(paramOrderField == 'averageRating:asc')? 'selected="selected"':''}><spring:message code="catalogue.moinsBienNote"/></option>
						<option value="averageRating:desc" ${(paramOrderField == 'averageRating:desc') ? 'selected="selected"':''}><spring:message code="catalogue.mieuxNote"/></option>
						<option value="countRating:desc" ${(paramOrderField == 'countRating:desc') ? 'selected="selected"':''}><spring:message code="catalogue.plusNote"/></option>
					</select>
				</div>
				<div class="afficher">
					<spring:message code="catalogue.afficher"/>
					<c:choose>
						<c:when test="${facetContext.pageSize == 10}">
							<a href="${urlRewritePageSize}10" class="bold">10</a> |
							<a href="${urlRewritePageSize}20">20</a> |
							<a href="${urlRewritePageSize}100"><spring:message code="catalogue.tous"/></a>
						</c:when>
						<c:when test="${facetContext.pageSize == 20}">
							<a href="${urlRewritePageSize}10">10</a> |
							<a href="${urlRewritePageSize}20" class="bold">20</a> |
							<a href="${urlRewritePageSize}100"><spring:message code="catalogue.tous"/></a>
						</c:when>
						<c:otherwise>
							<a href="${urlRewritePageSize}10">10</a> |
							<a href="${urlRewritePageSize}20">20</a> |
							<a href="${urlRewritePageSize}100" class="bold"><spring:message code="catalogue.tous"/></a>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="resultats">${facetResult.numFound}&nbsp;<spring:message code="catalogue.produits"/></div>
				<div class="paginationG"><jsp:include page="paging.jsp" /></div>
			</div>
			
			<!-- Boucle de produits -->
			<c:forEach items="${facetResult.docs}" var="document">
				<div class="produit">
					<div style="height: 200px;">
						<div class="visuel"><img src="${catalogPath}/${document.attr['img_lp']}" alt="${document.attr['title']}" style="max-width:130px;max-height:130px" border="0" /></div>
						<div class="floatRight">
							<c:choose>
								<c:when test="${document.attr['isAvailable']}"><c:set var="puceStock" value="puceVerte" /></c:when>
								<c:otherwise><c:set var="puceStock" value="puceRouge" /></c:otherwise>
							</c:choose>
							<div class="puce"><img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/${puceStock}.png" width="5" height="40" border="0" alt=""/></div>
							<div class="prix">
								<c:if test="${!empty document.attr['basePrice'] and document.attr['basePrice'] != document.attr['price']}"><div class="prixB"><fwk:priceFormater price="${document.attr['basePrice']}" format="<span>$1</span><span class='sup'>${devise}$2</span>"/></div></c:if>
								<c:if test="${document.attr['price'] > 0}"><div class="prixN"><fwk:priceFormater price="${document.attr['price']}" format="$1<span class='sup'>${devise}$2</span>"/></div></c:if>
							</div>
							<c:if test="${!empty document.attr['stickersEvents']}">
								<c:forEach items="${document.attr['stickersEvents']}" var="sticker" begin="0" end="0">
										<div class="flag"><img src="${mediaPath}${sticker}" border="0" alt="sticker"/><!--<img src="${contextPath}/resources/${codeIsoLang}/img/StarterStore/${sticker}" border="0" alt="sticker"/>--></div>
								</c:forEach>
							</c:if>
							
							<c:if test="${document.attr['averageRating'] != null}">
							<ul class="note">
								<fmt:formatNumber maxFractionDigits="2" var="rating" value="${document.attr['averageRating']}" scope="request" />
								<c:set var="betweenLi" value="true" scope="request"/>
								<c:import url="showRatingFacet.jsp" />
								<li class="txt"><spring:message code="catalogue.note"/>&nbsp;<fmt:formatNumber value="${document.attr['averageRating']}" maxFractionDigits="2"/>/5 - (${document.attr['countRating']})</li>
							</ul>
							</c:if>
							
						</div>
						<div class="marque"><!--SONY--></div>
						<div class="description">${document.attr['title']}</div>
					</div>
					<div class="voir">
						<c:set var="paramUrlEc">
							<c:if test="${withCatalogId == true}">catalogId=${catalog.catalogId}</c:if>
						</c:set>
						<c:set var="urlEc">
							<fwk:rewrite url="/catalogEntry.html?langId=${facetContext.langId}&ceId=${document.attr['id']}"  paramUnRewrited="${paramUrlEc}" />
						</c:set>
						<a href="${urlEc}" onfocus="addNavigationContext(this)"><img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/btn_voirProduit.png" width="114" height="21" border="0" alt="<spring:message code="catalogue.boutonVoirProduit"/>"/></a>
					</div>
				</div>
			</c:forEach>
			<div class="paginationBas">
				<div class="paginationG"><jsp:include page="paging.jsp" /></div>
			</div>
		</div>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="moreJS">
		<script type="text/javascript">
		var currency = '${devise}';
		var urlSort = '${urlRewriteSort}';
		var urlFilter = '${urlRewriteFilter}';
		var paramNavigationContext = '${paramNavigationContext}';
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>