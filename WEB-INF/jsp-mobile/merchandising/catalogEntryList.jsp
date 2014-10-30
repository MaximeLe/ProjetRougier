<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!-- debut page -->
<c:set var="devise"><c:choose><c:when test="${storeId==2}">&#36;</c:when><c:otherwise>€</c:otherwise></c:choose></c:set>

<tiles:insertDefinition name="mobile-templateMenu">
	<tiles:putAttribute name="title">
		<c:if test="${isSolde}"><spring:message code="common.soldes"/></c:if>
		<c:choose>
			<c:when test="${category.categoryDescriptions[langId].description != null && category.categoryDescriptions[langId].description != ''}">
				${fn:trim(category.categoryDescriptions[langId].description)}
			</c:when>
			<c:otherwise>
				${fn:trim(titre)}&nbsp;<spring:message code="catalogue.title"/>
			</c:otherwise>
		</c:choose>
	</tiles:putAttribute>
	<c:choose>
		<c:when test="${catalog.catalogDescriptions[langId].title == catalogMarques.catalogBiz}">
			<tiles:putAttribute name="description">
				<spring:message code="catalogue.pageMarqueMetaDescription" arguments="${fn:toUpperCase(fn:trim(titre))}"/>
			</tiles:putAttribute>	
		</c:when>
		<c:otherwise>			
			<tiles:putAttribute name="description">
				<spring:message code="catalogue.pageListeMetaDescription" arguments="${fn:toUpperCase(fn:trim(titre))}"/>
			</tiles:putAttribute>	
		</c:otherwise>	
	</c:choose>	
	<tiles:putAttribute name="canonical" type="string">
			<c:choose >
				<c:when test="${empty category.categoryDescriptions[langId].aliasUrl}">
					http://${pageContext['request'].serverName}${catalog.catalogDescriptions[langId].aliasUrl}
				</c:when>
				<c:otherwise>
					http://${pageContext['request'].serverName}${category.categoryDescriptions[langId].aliasUrl}
				</c:otherwise>
			</c:choose>
	</tiles:putAttribute>
		
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
		&nbsp;<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt;
		<c:set var="urlRewriteCatalog">
			<fwk:rewrite url="${baseUrlWithoutCatalogId}&catalogId=${catalog.catalogId}" paramUnRewrited="${paramRewriteCategory}" />
		</c:set>
		<c:set var="catalogType">
			<c:choose>
				<c:when test="${catalog.catalogTypeId=='2'}">CAT_BOUTIQUE</c:when>
				<c:when test="${catalog.catalogTypeId=='6'}">CAT_IDEES_CREATIVES</c:when>
				<c:when test="${catalog.catalogTypeId=='7'}">CAT_PRODUIT</c:when>
				<c:when test="${catalog.catalogTypeId=='8'}">CAT_CADEAUX</c:when>
			</c:choose>
		</c:set>
		<c:choose>
			<%-- Catalogue boutique --%>
			<c:when test="${catalogType=='CAT_BOUTIQUE'}">
				<a href="${urlRewriteCatalog}">${catalog.catalogDescriptions[langId].title}</a>
			</c:when>
			<%-- Catalogue cadeau --%>
			<c:when test="${catalogType=='CAT_CADEAUX'}">
				<a href="${urlRewriteCatalog}">${catalog.catalogDescriptions[langId].title}</a>
			</c:when>
			<%-- Catalogue idées créatives --%>
			<c:when test="${catalogType=='CAT_IDEES_CREATIVES'}">
				<a href="${urlRewriteCatalog}">${catalog.catalogDescriptions[langId].title}</a>
			</c:when>
		</c:choose>
		<c:if test="${not empty breadcrumb and (catalogType=='CAT_BOUTIQUE' or catalogType=='CAT_IDEES_CREATIVES' or catalogType=='CAT_CADEAUX')}">
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
			</c:choose>
		</c:forEach>


		<c:if test="${!empty urlEndOfSearch}">
			| ${param.text}
			<a href="${urlEndOfSearch}" class="filter"><img src="${contextPath}/resources-mobile/${codeIsoLang}/img/StarterStore/btn_croix.png" alt="X"/></a>
		</c:if>
	</tiles:putAttribute>
	
<%-- 	<tiles:putAttribute name="ems"> --%>
<%-- 	 ${animation}   --%>
<!-- 	<style type="text/css"> 
/*  	#emsCML {width:990px;height:80px;background:url("${mediaPath}/ems/emsCML_bg.png") no-repeat;margin-bottom:30px;}  */
/*  	#emsCML h1 {float:left;width:138px;margin:14px 0 0 29px;font-size:34px;color:#fff;text-align:center;line-height:26px;}  */
/*  	#emsCML h1 span {font-size:22px;} */ */
/*  	#emsCML p {float:left;width:580px;margin:14px 0 0 133px;font-size:14px;line-height:17px;color:#777777;}  */
<!-- 	</style> -->
<%-- 	${CAT_PC_BANDEAU} --%>
<%-- 	</tiles:putAttribute> --%>
<%-- 	<tiles:putAttribute name="emsSurFooter"> --%>
<%-- 	 ${animation}   --%>
<%-- 	${CAT_PC_SURFOOTER} --%>
<%-- 	</tiles:putAttribute> --%>

	<tiles:putAttribute name="menu">
		<div id="menu">
<%-- 			<div class="msgFiltre"><spring:message code="catalogue.affinezVotreRecherche"/></div> --%>
				<!-- Version Dynamique -->
				
				
					<div class="panel-group col-lg-6">
					    <div class="panel panel-default">
					      <div class="panel-heading"> 
					        <h3 class="panel-title">
					          <a class="accordion-toggle" href="#ffiltre" data-toggle="collapse"style="display:block;"> Filtrer </a> 
					        </h3>
					      </div>
					      <div id="ffiltre" class="panel-collapse collapse ">
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
						
	
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<div id="contentMenu" class="catalogEntryList">
			<div class="affiner">
				<div class="trier">
					<select name="sort"  onchange="order(this)">
						<option value=""><spring:message code="catalogue.trierPar"/></option>
						<option value="price:asc" ${(paramOrderField == 'price:asc')? 'selected="selected"':''} ><spring:message code="catalogue.prixPlusBas"/></option>
						<option value="price:desc" ${(paramOrderField == 'price:desc')? 'selected="selected"':''}><spring:message code="catalogue.prixPlusEleve"/></option>
					</select>
				</div>
			</div>
				<div class="nbArticle">${facetResult.numFound}<span>&nbsp;articles disponibles</span></div>
				<div class="pagination"><jsp:include page="paging.jsp" /></div>	
				<div class="clear"></div>
						

			<!-- Boucle de produits -->


			<div id="zoneP">
			
			<c:forEach items="${facetResult.docs}" var="document" varStatus="status">
				<c:if test="${not empty position_ems and status.count==position_ems and nb_produits > 19 and facetContext.page != 1}">
					<div class="ems">${REASSURANCE_LIST}</div>
				</c:if>
			
				<c:set var="marque">
					${document.attr[ATTR_MARQUE_ID][0]}
				</c:set>
				<c:set var="paramUrlEc">
					<c:if test="${withCatalogId == true}">catalogId=${catalog.catalogId}</c:if>
				</c:set>
				<c:set var="urlEc">
					<fwk:rewrite url="/catalogEntry.html?langId=${facetContext.langId}&ceId=${document.attr['id']}"  paramUnRewrited="${paramUrlEc}" /><c:if test="${catalog.catalogBiz!='CAT_CADEAUX'}">#categoryId=${category.categoryId}</c:if>
				</c:set>
				<c:set var ="cProduit">
					<c:choose>
						<c:when test="${facetContext.page ==1 and status.index == 0}">produit mea</c:when>
						<c:otherwise>produit</c:otherwise>
					</c:choose>
				</c:set>
				<div class="${cProduit}">
					<div class="stickers">
						<!-- Gestion des stickers -->
							<c:choose>
								<c:when test="${!empty document.attr['stickersEvents'] && fn:length(document.attr['stickersEvents']) > 1}">
									<c:forEach items="${document.attr['stickersEvents']}" var="sticker" begin="0" end="1">
										<div class="flag"><img src="${mediaPath}${sticker}" border="0" alt="sticker" id="${document.attr['id']}_${sticker}"/></div>
									</c:forEach>
								</c:when>
								<c:when test="${!empty document.attr['stickersEvents'] && fn:length(document.attr['stickersEvents']) == 1}">
									<c:forEach items="${document.attr['stickersEvents']}" var="sticker" begin="0" end="0">
										<div class="flag"><img src="${mediaPath}${sticker}" border="0" alt="sticker" id="${document.attr['id']}_${sticker}"/></div>
									</c:forEach>
									<c:if test="${!empty document.attr['stickersPerm']}">
										<c:forEach items="${document.attr['stickersPerm']}" var="sticker" begin="0" end="0">
											<div class="flag"><img src="${mediaPath}${sticker}" border="0" alt="sticker" id="${document.attr['id']}_${sticker}"/></div>
										</c:forEach>
									</c:if>
								</c:when>
								<c:otherwise>
									<c:if test="${!empty document.attr['stickersPerm']}">
										<c:if test="${fn:length(document.attr['stickersPerm']) > 1}">
											<c:forEach items="${document.attr['stickersPerm']}" var="sticker" begin="0" end="1">
												<div class="flag"><img src="${mediaPath}${sticker}" border="0" alt="sticker" id="${document.attr['id']}_${sticker}"/></div>
											</c:forEach>
										</c:if>
										<c:if test="${fn:length(document.attr['stickersPerm']) == 1}">
											<c:forEach items="${document.attr['stickersPerm']}" var="sticker" begin="0" end="0">
												<div class="flag"><img src="${mediaPath}${sticker}" border="0" alt="sticker" id="${document.attr['id']}_${sticker}"/></div>
											</c:forEach>
										</c:if>
									</c:if>
								</c:otherwise>
							</c:choose>
						<!-- Fin de gestion des stickers -->
					</div>
					<div class="visuel">
						<a href="${urlEc}" title="<spring:message code="catalogue.boutonVoirProduit"/>">
							<c:choose>
<%-- 								<c:when test="${status.index == 0 && facetContext.page == 1}"> --%>
<%-- 									<img src="${catalogPath}/${document.attr['img_liste_mea']}" alt="${document.attr['title']}" border="0" /> --%>
<%-- 								</c:when> --%>
								<c:when test="${document.attr['img_liste'] != null}">
									<img src="${catalogPath}/${document.attr['img_liste']}" alt="${document.attr['title']}" border="0" />
								</c:when>
								<c:when test="${document.attr['img_360'] != null}">
									<img src="${catalogPath}/${document.attr['img_360']}" alt="${document.attr['title']}" style="max-width:130px;max-height:130px" border="0" />
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
							<c:if test="${document.attr['price'] > 0}"><a href="${urlEc}"><fwk:priceFormater price="${document.attr['price']}" format="$1,$2 ${devise}"/></a></c:if>
						</div>
<%-- 						<c:if test="${facetContext.page ==1 and status.index == 0}"> --%>
<%-- 							<a href="${urlEc}" title="<spring:message code="catalogue.boutonVoirProduit"/>"><img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/btn_voirProduit.png" width="116" height="28" alt="<spring:message code="catalogue.boutonVoirProduit"/>" border="0"/></a> --%>
<%-- 						</c:if> --%>
					</div>
				</div>
			</c:forEach>
				<c:if test="${nb_produits < 20}">
					<div class="ems">${REASSURANCE_LIST}</div>
				</c:if>
		</div>
			<div class="clear"></div>
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
		<script src="${contextPath}/resources/js/merchandising/catalogEntryList.js" type="text/javascript"></script>
		<script type="text/javascript">
		var currency = '${devise}';
		var urlSort = '${urlRewriteSort}';
		var urlFilter = '${urlRewriteFilter}';
		var paramNavigationContext = '${paramNavigationContext}';
		</script>
		<c:if test="${isTagMetafiliationActivated }">
			<script type="text/javascript" src="http://img.metaffiliation.com/u/11/p33385.js?zone=categorie&idcategorie=${fn:trim(category.categoryBiz) }"></script>
		</c:if>
		
    
<!-- 		fin de la page ? -->
	</tiles:putAttribute>
</tiles:insertDefinition>