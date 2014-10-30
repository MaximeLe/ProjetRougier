<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!-- début catalogEntrySearch -->
<c:set var="devise"><c:choose><c:when test="${storeId==2}">&#36;</c:when><c:otherwise>€</c:otherwise></c:choose></c:set>

<tiles:insertDefinition name="mobile-templateMenu">
	<tiles:putAttribute name="head">
		<style type="text/css">
			.templateMenu #contenu {
				padding-top:149px;
			}
		</style>
	</tiles:putAttribute>
<%--<tiles:putAttribute name="title"><c:forEach items="${title}" var="titleCategory" varStatus="statut"><c:if test="statut.last"><h1></c:if>${titleCategory.libelle}<c:if test="statut.last"></h1></c:if><c:if test="${!statut.last}"> / </c:if></c:forEach></tiles:putAttribute>--%>
<%-- 	<tiles:putAttribute name="title">${searchWord}&nbsp;<spring:message code="catalogue.title"/></tiles:putAttribute> --%>
	<tiles:putAttribute name="title"><c:if test="${isSolde}"><spring:message code="common.soldes"/></c:if>${searchWord}&nbsp;<spring:message code="catalogue.title"/></tiles:putAttribute>
	<tiles:putAttribute name="description">${category.categoryDescriptions[langId].description}</tiles:putAttribute>
	<tiles:putAttribute name="canonical" type="string">http://${pageContext['request'].serverName}${requestScope['javax.servlet.forward.servlet_path']}</tiles:putAttribute>
	<tiles:putAttribute name="robots">noindex</tiles:putAttribute>
		
	<c:choose>
		<c:when test="${facetResult.totalPage != 1}">
			<c:choose>
				<c:when test="${empty param.page || param.page == 0 || param.page == 1}">
					<tiles:putAttribute name="rel_next"><link rel="next" href="http://${pageContext['request'].serverName}${requestScope['javax.servlet.forward.servlet_path']}?pageSize=${pageSize}&page=2" /></tiles:putAttribute>
				</c:when>
				<c:otherwise>
					<tiles:putAttribute name="rel_prev"><link rel="prev" href="http://${pageContext['request'].serverName}${requestScope['javax.servlet.forward.servlet_path']}?pageSize=${pageSize}&page=${param.page-1}" /></tiles:putAttribute>
					
					<c:choose>
						<c:when test="${param.page != facetResult.totalPage}">
							<tiles:putAttribute name="rel_next"><link rel="next" href="http://${pageContext['request'].serverName}${requestScope['javax.servlet.forward.servlet_path']}?pageSize=${pageSize}&page=${param.page+1}" /></tiles:putAttribute>
						</c:when>
					</c:choose>					
				</c:otherwise>
			</c:choose>
		</c:when>
	</c:choose>

	<tiles:putAttribute name="breadcrumb">
		<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt;
		<h1 style="display:inline"><span>${searchWord}</span></h1>
		
		
	</tiles:putAttribute>
	<tiles:putAttribute name="ems">
	
	</tiles:putAttribute>
	
	
	
		<tiles:putAttribute name="menu">
		<div id="menu">
		<div class="panel-group col-lg-6">
					    <div class="panel panel-default">
					      <div class="panel-heading"> 
					        <h3 class="panel-title">
					          <a class="accordion-toggle" href="#filtre" data-toggle="collapse"style="display:block;"> Filtrer </a> 
					        </h3>
					      </div>
					      <div id="filtre" class="panel-collapse collapse ">
					        <div class="panel-body"> 
					      			<c:forEach items="${facetResult.facets}" var="facet">
					<c:if test="${facet.fieldName != 'hids' && facet.libelleWeb != 'categoryIds'}">					
						<div class="col-lg-6">
						  <div class="panel panel-info">
						    <div class="panel-heading">
						      <h4 class="panel-title">
						        <a data-toggle="collapse" href="#${facet.libelleWeb}">${facet.libelleWeb}</a>
						      </h4>
						    </div>
						    <ul id="${facet.libelleWeb}" class="list-group collapse in">
							  	<c:choose>
								<c:when test="${!empty facet.values}">
							<c:forEach items="${facet.values}" var="value">
							<li>
								<c:choose>
									<c:when test="${value.selected}">
										<input type="checkbox" name="${value.id}" id="${value.id}" onclick="addAFilter(this, '${facet.fieldName}')" checked="checked" />
									</c:when>
									<c:otherwise>
										<input type="checkbox" name="${value.id}" id="${value.id}" onclick="addAFilter(this, '${facet.fieldName}')"/>
									</c:otherwise>
								</c:choose>	
<%-- 								///value.selected = "${value.selected}" // value.id = "${value.id}" // value.image = "${value.image}" // value.count = "${value.count}"/// --%>
								<c:choose>
									<c:when test="${!empty value.image}">
										<label for="${value.id}"><img src="${value.image}" title="${value.value}" alt="${value.value}" /></label>
									</c:when>
									<c:otherwise>
										<label for="${value.id}">${value.value} (${value.count})</label>
									</c:otherwise>
								</c:choose>
							<br/></li>
							</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach items="${facet.ranges}" var="ranges">
										<li>
											<c:choose>
												<c:when test="${ranges.selected}">
													<input type="checkbox" name="[${ranges.startValue} TO ${ranges.endValue}]" onclick="addAFilter(this, '${facet.fieldName}')" checked="checked" />
												</c:when>
												<c:otherwise>
													<input type="checkbox" name="[${ranges.startValue} TO ${ranges.endValue}]" onclick="addAFilter(this, '${facet.fieldName}')"/>
												</c:otherwise>
											</c:choose>
											<label for="">
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
											 (${ranges.count})</label>
										<br/></li>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						    </ul>
						  </div>
						</div>
						</c:if>
					</c:forEach>		
					        </div>
					      </div>
					    </div>
					</div>


						
<script src="${contextPath}/resources-mobile/js/jquery.js"></script>
<script src="${contextPath}/bootstrap/js/bootstrap.min.js"></script>
						
	
	</tiles:putAttribute>


	<tiles:putAttribute name="content">
		<div id="contentMenu" class="catalogEntryList">
			<div class="affiner">
				<!-- ${facetResult.numFound}&nbsp;<spring:message code="catalogue.produits"/> -->
				<div class="trier">
					<select name="sort"  onchange="order(this)">
						<option value=""><spring:message code="catalogue.trierPar"/></option>
						<option value="price:asc" ${(paramOrderField == 'price:asc')? 'selected="selected"':''} ><spring:message code="catalogue.prixPlusBas"/></option>
						<option value="price:desc" ${(paramOrderField == 'price:desc')? 'selected="selected"':''}><spring:message code="catalogue.prixPlusEleve"/></option>
					</select>
				</div>
				<div class="nbArticle">${facetResult.numFound}<span>&nbsp;articles disponibles</span></div>
				<div class="pagination"><jsp:include page="paging.jsp" /></div>
				<div class="clear"></div>
			</div>
			<div id="zoneP">
				<c:forEach items="${facetResult.docs}" var="document" varStatus="status">
<%-- 					<c:if test="${not empty position_ems and status.count == position_ems and nb_produits > 13}"> --%>
<%-- 					<div class="ems">${REASSURANCE_LIST}</div> --%>
<%-- 				</c:if> --%>
					<c:set var="marque">
						${document.attr[ATTR_MARQUE_ID][0]}
					</c:set>
					<c:set var="paramUrlEc">
						<c:if test="${withCatalogId == true}">catalogId=${catalog.catalogId}</c:if>
					</c:set>
					<c:set var="urlEc">
						<fwk:rewrite url="/catalogEntry.html?langId=${facetContext.langId}&ceId=${document.attr['id']}"  paramUnRewrited="${paramUrlEc}" />
					</c:set>
					<div class="produit">
						<div class="stickers">
							<!-- Gestion des stickers -->
							<c:choose>
								<c:when test="${!empty document.attr['stickersEvents'] && fn:length(document.attr['stickersEvents']) > 1}">
									<c:forEach items="${document.attr['stickersEvents']}" var="sticker" begin="0" end="1">
										<div class="flag"><img src="${mediaPath}${sticker}" border="0" alt="sticker"/></div>
									</c:forEach>
								</c:when>
								<c:when test="${!empty document.attr['stickersEvents'] && fn:length(document.attr['stickersEvents']) == 1}">
									<c:forEach items="${document.attr['stickersEvents']}" var="sticker" begin="0" end="0">
										<div class="flag"><img src="${mediaPath}${sticker}" border="0" alt="sticker"/></div>
									</c:forEach>
									<c:if test="${!empty document.attr['stickersPerm']}">
										<c:forEach items="${document.attr['stickersPerm']}" var="sticker" begin="0" end="0">
											<div class="flag"><img src="${mediaPath}${sticker}" border="0" alt="sticker"/></div>
										</c:forEach>
									</c:if>
								</c:when>
								<c:otherwise>
									<c:if test="${!empty document.attr['stickersPerm']}">
										<c:if test="${fn:length(document.attr['stickersPerm']) > 1}">
											<c:forEach items="${document.attr['stickersPerm']}" var="sticker" begin="0" end="1">
												<div class="flag"><img src="${mediaPath}${sticker}" border="0" alt="sticker"/></div>
											</c:forEach>
										</c:if>
										<c:if test="${fn:length(document.attr['stickersPerm']) == 1}">
											<c:forEach items="${document.attr['stickersPerm']}" var="sticker" begin="0" end="0">
												<div class="flag"><img src="${mediaPath}${sticker}" border="0" alt="sticker"/></div>
											</c:forEach>
										</c:if>
									</c:if>
								</c:otherwise>
							</c:choose>
						<!-- Fin de gestion des stickers -->
						</div>
						<!-- <div class="visuel"><a href="${urlEc}" title="<spring:message code="catalogue.boutonVoirProduit"/>"><img src="${catalogPath}/${document.attr['img_liste']}" alt="${document.attr['title']}" border="0" /></a></div> -->
						
						<div class="visuel">
							<a href="${urlEc}" title="<spring:message code="catalogue.boutonVoirProduit"/>">
								<c:choose>
									<c:when test="${document.attr['img_liste'] != null}">
										<img src="${catalogPath}/${document.attr['img_liste']}" alt="${document.attr['title']}" border="0" />
									</c:when>
									<c:when test="${document.attr['img_360'] != null}">
										<img src="${catalogPath}/${document.attr['img_360']}" alt="${document.attr['title']}" style="max-width:130px;max-height:130px;" border="0" />
									</c:when>
								</c:choose>
							</a>
						</div>
						
						<div class="infos">
							<p><a href="${urlEc}" title="<spring:message code="catalogue.boutonVoirProduit"/>">${marque}</a></p>
							<h2><a href="${urlEc}" title="<spring:message code="catalogue.boutonVoirProduit"/>">${document.attr['title']}</a></h2>
							<div class="prix">
								<span class="aPartirDe" id="${document.attr['id']}" style="text-decoration: none;"></span>
								<c:if test="${!empty document.attr['basePrice'] and document.attr['basePrice'] != document.attr['price']}"><span class="prixBarre"><fwk:priceFormater price="${document.attr['basePrice']}" format="$1,$2 ${devise}"/></span></c:if>
								<c:if test="${document.attr['price'] > 0}"><a href="${urlEc}" title="<spring:message code="catalogue.boutonVoirProduit"/>"><fwk:priceFormater price="${document.attr['price']}" format="$1,$2 ${devise}"/></a></c:if>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
<%-- 			<c:if test="${nb_produits < 20}"> --%>
<%-- 					<div class="ems">${REASSURANCE_LIST}</div> --%>
<%-- 				</c:if> --%>
			
			<div class="affiner">
				<!-- ${facetResult.numFound}&nbsp;<spring:message code="catalogue.produits"/> -->
				<div class="nbArticle">${facetResult.numFound}<span>&nbsp;articles disponibles</span></div>
				<div class="pagination"><jsp:include page="paging.jsp" /></div>
			<div class="trier">
					<select name="sort"  onchange="order(this)">
						<option value=""><spring:message code="catalogue.trierPar"/></option>
						<option value="price:asc" ${(paramOrderField == 'price:asc')? 'selected="selected"':''} ><spring:message code="catalogue.prixPlusBas"/></option>
						<option value="price:desc" ${(paramOrderField == 'price:desc')? 'selected="selected"':''}><spring:message code="catalogue.prixPlusEleve"/></option>
					</select>
				</div>
			</div>
		</div>
	</tiles:putAttribute>	
	
	
	<tiles:putAttribute name="moreJS">
		<script type="text/javascript">
			var currency = '${devise}';
			var urlSort = '${urlRewriteSort}';
			var urlFilter = '${urlRewriteFilter}';
			var paramNavigationContext = '${paramNavigationContext}';
		
			$(".contentStart").css("display","block");
		</script>
		<script src="${contextPath}/resources/js/merchandising/catalogEntryList.js" type="text/javascript"></script>
	</tiles:putAttribute>
</tiles:insertDefinition>