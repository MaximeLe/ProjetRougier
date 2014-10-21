<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="devise"><c:choose><c:when test="${storeId==2}">&#36;</c:when><c:otherwise>€</c:otherwise></c:choose></c:set>
<c:set var="urlRewrite"><fwk:rewrite url="/ajax/catalogEntry.html"/></c:set>
<c:set var="urlCanonical"><fwk:rewrite url="${ceDisplay.urlWithoutEcId}${ceDisplay.catalogEntry.catalogEntryId}"/></c:set>

<tiles:insertDefinition name="template">
<tiles:putAttribute name="title">
	<c:if test="${not empty ceDisplay.catalogEntryDescription.title1}">${ceDisplay.catalogEntryDescription.title1}&nbsp;</c:if>
	<c:if test="${not empty ceDisplay.catalogEntry.attributesNormalizedMapBizKey['MARQUE'].attributeNormalizeValues[0].attributeValueDescriptions[langId].description}">${ceDisplay.catalogEntry.attributesNormalizedMapBizKey['MARQUE'].attributeNormalizeValues[0].attributeValueDescriptions[langId].description}&nbsp;</c:if><spring:message code="catalogue.title"/>
</tiles:putAttribute><tiles:putAttribute name="description">${fn:substring(fn:escapeXml(ceDisplay.catalogEntryDescription.description), 0, 154)}</tiles:putAttribute>
<tiles:putAttribute name="canonical" type="string">http://${pageContext['request'].serverName}<fwk:rewrite url="${ceDisplay.urlWithoutEcId}${ceDisplay.catalogEntry.catalogEntryId}"/></tiles:putAttribute>
 
<tiles:putAttribute name="head">
	<link rel="image_src" href="${catalogPath}${ceDisplay.catalogEntryImage[0].path}" />
	<link href="${contextPath}/resources/${codeIsoLang}/css/modal.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/${codeIsoLang}/css/conseilexpert.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/js/shadowbox/shadowbox.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/${codeIsoLang}/css/jquery-bubble-popup-v3.css" rel="stylesheet" type="text/css" />
	<meta name="og:title" content="${ceDisplay.catalogEntryDescription.title1}" />
	<meta name="og:type" content="product" />
	<meta name="og:url" content="http://${pageContext['request'].serverName}${urlCanonical}" />
	<meta name="og:image" content="http://${pageContext['request'].serverName}${catalogPath}/${ceDisplay.catalogEntryImage[0].path}" />
	<meta name="og:site_name" content="http://www.rougier-ple.fr" />
	<meta name="og:description" content="${fn:escapeXml(ceDisplay.catalogEntryDescription.description)}" />
	<meta name="fb:app_id" content="${facebookAppId}" />
	<meta name="fb:page_id" content="${facebookPageId}" />
</tiles:putAttribute>

<tiles:putAttribute name="microformat">itemscope itemtype="http://schema.org/ItemPage"</tiles:putAttribute>

	<tiles:putAttribute name="breadcrumb">
		<c:import url="importBreadcrumbCatalogEntry.jsp"></c:import>
		<div class="floatRight retour"><a href="javascript:history.back();">Retour</a></div>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<div id="content" class="catalogEntry" itemscope itemtype="http://schema.org/Product">
			<c:import url="importVisuelCatalogEntry.jsp"/>
			
			<div class="zInfos">
				<div class="infos">
					<div class="marque" itemprop="brand" itemscope itemtype="http://schema.org/Organization">
        				<span itemprop="name">
        					<c:choose>
        						<c:when test="${empty brandBean}">
									<c:forEach items="${ceDisplay.catalogEntry.attributesNormalizedMapBizKey}" var="attributNormalized">
										<c:if test="${attributNormalized.value.attributeBiz == 'MARQUE'}">
											<c:forEach items="${attributNormalized.value.attributeNormalizeValues}" var="attributeNormalizeValues">
												${attributeNormalizeValues.attributeValueDescriptions[langId].description}
											</c:forEach>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<a class="brandLink" href="${brandBean.link}">${brandBean.name}</a>
								</c:otherwise>
							</c:choose>
						</span>
					</div>
					<h1 itemprop="name">${ceDisplay.catalogEntryDescription.title1}</h1>
					<c:if test="${((context.instanceType) == 'STORE_PREVIEW') && (context.siteEditMode)}">
						<span style="margin-left: 5px;">
							<a href="/StoreManager/secure/CAT/ModifierPropAttributsWebGeneral.htm?entreeCatId=${ceDisplay.catalogEntry.catalogEntryId}&lg=${langId}" title="modifier l'entrée de catalogue" target="storeManager"><img src="${contextPath}/resources/${codeIsoLang}/img/common/modifyBlack.png" style="border: 0px;"/></a>
						</span>
					</c:if>
					<!-- Obsolete : ${ceDisplay.catalogEntryDescription.hook} ${ceDisplay.catalogEntryDescription.title2} -->
					
					<c:if test="${(!empty (ceDisplay.globalRating))}">
						<ul class="rating" itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
							<fmt:formatNumber maxFractionDigits="2" var="rating" value="${ceDisplay.globalRating}" scope="request" />
							<c:set var="betweenLi" value="true" scope="request"/>
							<c:set var="ratingInPageProduct" value="true" scope="request"/>
							<c:import url="showRatingFacetUnderTitle.jsp"></c:import>
							<li class="txt">(<span class="underline"><span itemprop="reviewCount">${ceDisplay.summaryCount}</span> votes</span>)</li>
							<li class="displayNone" itemprop="ratingValue">${ceDisplay.globalRating}</li>
						</ul>
					</c:if>
					
					<!-- Stock Magasin -->
					<c:if test="${stockMagasinActivated}">
						<div class="contenant_wording_disponibilite">
							<span class="wordingDisponibilite">Disponibilité de ce produit :</span>
						</div>
					</c:if>
					
					<div itemprop="offers" itemscope itemtype="http://schema.org/Offer">
					
						<c:choose>
							<c:when test="${stockMagasinActivated}">
 								<div class="contenant_stock_magasin"> 
 									<div class="emplacement"> 
 										<span class="enLigne">En ligne</span> 
 									</div> 
 									<div class="disponibilite"> 
 										<span class="separateur">:</span> 
 										
										<c:choose>
											<c:when test="${not empty ceDisplay.catalogEntry.stock}">
												<c:choose>
													<c:when test="${ceDisplay.catalogEntry.stock == 0}">
														<img style="float:left" src="${contextPath}/resources/${codeIsoLang}/img/merchandising/stock_ko.png" alt="" border="0" />
														<span class="produitIndisponible">Indisponible</span>
													</c:when>
													<c:when test="${ceDisplay.catalogEntry.stock>0 && ceDisplay.catalogEntry.stock<3}">
														<img style="float:left" src="${contextPath}/resources/${codeIsoLang}/img/merchandising/stock_limite.png" alt="" border="0" />
														<span class="produitLimite">Quantités limitées</span>
													</c:when>
													<c:when test="${ceDisplay.catalogEntry.stock>=3}">
														<img style="float:left" src="${contextPath}/resources/${codeIsoLang}/img/merchandising/stock_ok.png" alt="" border="0" />
														<span class="produitDisponible">Disponible</span>
													</c:when>
													<c:otherwise>
														<img style="float:left" src="${contextPath}/resources/${codeIsoLang}/img/merchandising/stock_info.png" alt="" border="0" />
														<span class="erreurDisponibilite">Impossible de vérifier le stock</span>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												<img style="float:left" src="${contextPath}/resources/${codeIsoLang}/img/merchandising/stock_info.png" alt="" border="0" />
												<span class="erreurDisponibilite">Impossible de vérifier le stock</span>
											</c:otherwise>
										</c:choose>
										
 									</div> 
 								</div> 
						
								<div class="contenant_stock_magasin_nuance">
									<div class="emplacement">
										<span class="enMagasin">En magasin</span>
									</div>
									<div class="disponibilite">
										<span class="separateur">:</span>
										<div id="dispoMagasin" class="disponibiliteMagasinNuance">
								
										</div>
										<div id="informationsMagasin" class="infosMagasinNuance">

										</div>
									</div>
								</div> 
							</c:when>
							
							<c:otherwise>
								<div class="stock" itemprop="availability" href="http://schema.org/InStock">
									<spring:message code="catalogue.enStock"/>
								</div>
							</c:otherwise>
						</c:choose>
						
						<div class="quantity" style="clear:both">
<!-- 							<div class="select"> -->
<%-- 								<img onClick="decQuantityNonDiscriminant(${ceDisplay.catalogEntry.catalogEntryId});" src="${contextPath}/resources/${codeIsoLang}/img/merchandising/btn_moins.png" width="15" height="15" alt="" border="0"/> --%>
<!-- 								<input type="text" id="quantityNonDiscriminant" value="1" maxlength="4"> -->
<%-- 								<img onClick="incQuantityNonDiscriminant(${ceDisplay.catalogEntry.catalogEntryId});" src="${contextPath}/resources/${codeIsoLang}/img/merchandising/btn_plus.png" width="15" height="15" alt="" border="0"/> --%>
<!-- 							</div> -->
							
							<c:set var="quantiteMinimum"></c:set>
							<c:forEach items="${ceDisplay.catalogEntry.attributesMapBizKey}" var="attribut">
								<c:if test="${attribut.value.attributeBiz == 'QUANTITE_MINIMUM'}">
										<c:forEach items="${attribut.value.attributeValues}" var="attributeValues">
											<c:set var="quantiteMinimum" value="${attributeValues.attributeValueDescriptions[langId].description}"></c:set>
									</c:forEach>
								</c:if>
							</c:forEach>
							<c:if test="${quantiteMinimum != null && quantiteMinimum != '' && quantiteMinimum > 1}">
								<div class="txt">Quantité minimum&nbsp;${quantiteMinimum}</div>
							</c:if>
						</div>
						
						<div class="zPrix tall">
							<div class="prixA">à partir de</div>
							<c:choose>
								<c:when test="${!empty ceDisplay.catalogEntryPrice.basePrice and ceDisplay.catalogEntryPrice.basePrice != ceDisplay.catalogEntryPrice.price}">
									<div class="prixB"><fwk:priceFormater price="${ceDisplay.catalogEntryPrice.basePrice}" format="$1,$2${devise}"/></div>
									<c:if test="${ceDisplay.catalogEntryPrice.price > 0}">
										<div class="prix"><span itemprop="price"><fwk:priceFormater price="${ceDisplay.catalogEntryPrice.price}" format="$1,$2"/></span><fwk:priceFormater price="${ceDisplay.catalogEntryPrice.price}" format="${devise}"/></div>
									</c:if>
								</c:when>
								<c:otherwise>
									<div class="prix solo">
										<c:if test="${ceDisplay.catalogEntryPrice.price > 0}">
											<span itemprop="price"><fwk:priceFormater price="${ceDisplay.catalogEntryPrice.price}" format="$1,$2"/></span><fwk:priceFormater price="${ceDisplay.catalogEntryPrice.price}" format="${devise}"/>
										</c:if>
									</div>
								</c:otherwise>
							</c:choose>
							<meta itemprop="priceCurrency" content="EUR" />
							<a href="#couleurs" class="color">Choisissez une couleur</a>
							<div class="addBasket nuanceBasket">
							<c:choose>
								<c:when test="${ceDisplay.child!=null}">
									<c:set var="oneSKU" value="false"/>
									<c:forEach items="${ceDisplay.child}" var="child">
										<c:if test="${!oneSKU && child.catalogEntry.catalogEntryTypeId == 2}">
											<img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/btn_ajoutPanier.png" onClick="window.scrollTo(0,$('#couleurs').offset().top);$('.warningSelectionNuance').css('color','#E30613');" width="169" height="38" alt="Ajouter au panier" border="0"/>
											<c:set var="oneSKU" value="true"/>
										</c:if>
									</c:forEach>
								</c:when>
								<c:when test="${ceDisplay.child==null && ceDisplay.catalogEntry.catalogEntryTypeId == 2}">
									<img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/btn_ajoutPanier.png" onclick="addToCartNonDiscriminantProduct(${ceDisplay.catalogEntry.catalogEntryId});" width="169" height="38" alt="Ajouter au panier" border="0"/>
								</c:when>
							</c:choose>
							</div>
							<div class="addList nuanceList">Ajouter à ma liste</div>
							
						</div>
						<br/>
					</div>
				</div>
				
				<c:import url="importInfoPlusCatalogEntry.jsp"></c:import>
				
				<c:import url="importOngletsTechniquesCatalogEntry.jsp"></c:import>
				
			</div>		
			
			<div class="clear"></div>
			
			<div class="colorFilter" id="couleurs">
				<div class="txt">
				Sélectionnez les coloris que vous souhaitez parmi l’ensemble des références :
				<span class="warningSelectionNuance"><br/><spring:message code="addCart.selectionNuance"/></span>
				</div>
				
				<div class="filter">
					<c:forEach items="${ceDisplay.catalogEntry.attributesNormalizedMapBizKey}" var="attributNormalized">
						<c:choose>
							<c:when test="${attributNormalized.value.attributeBiz == 'COULEUR'}">
								<c:forEach items="${attributNormalized.value.attributeNormalizeValues}" var="attributeNormalizeValues">
									<c:set var="colorChain" value=""></c:set>
									<c:forEach items="${attributeNormalizeValues.childs}" var="child">
										<c:set var="colorChain" value="${colorChain}${child.attributeValueBiz};" />
									</c:forEach>
									<input type="checkbox" id="color" name="baseColor" value="${colorChain}" id=""><label for="">${attributeNormalizeValues.attributeValueDescriptions[langId].description}</label>
								</c:forEach>
							</c:when>
							
							<c:when test="${attributNormalized.value.attributeBiz == 'PALETTE_DE_BASE'}">
								<c:forEach items="${attributNormalized.value.attributeNormalizeValues}" var="attributeNormalizeValues">
									<c:if test="${fn:toUpperCase(attributeNormalizeValues.attributeValueDescriptions[langId].description) == 'OUI'}">
										<c:set var="colorChain" value=""></c:set>
										<c:forEach items="${attributeNormalizeValues.childs}" var="child">
											<c:set var="colorChain" value="${colorChain}${child.attributeValueBiz};" />
										</c:forEach>
										<input type="checkbox" name="paletteBase" value="${colorChain}" id=""><label for="">Palette de base</label>
									</c:if>
								</c:forEach>
							</c:when>
						</c:choose>
					</c:forEach>
					<input type="checkbox" name="allColor" id=""><label for="">Toutes les couleurs</label>
				</div>
			</div>
			
			<div class="colorList">
				<%--Si le stock magasin est activé, une colonne est affichée en plus --%>
				<c:choose>
					<c:when test="${stockMagasinActivated}">
						<div class="header" style="height:30px; float:left">
							<div class="c1" style="height:30px">Coloris</div>
							<div class="c2" style="width:110px; height:30px">Prix Unitaire</div>
							<div class="c3" style="width:50px; vertical-align:middle">Quantité</div>
							<div style="float:left;width:69px; height:30px; text-align:center; padding-left:10px">Disponibilité magasin</div>
						</div>
						
						<div class="header" style="height:30px; float:left">
							<div class="c1" style="height:30px">Coloris</div>
							<div class="c2" style="width:110px; height:30px">Prix Unitaire</div>
							<div class="c3" style="width:50px; vertical-align:middle">Quantité</div>
							<div style="float:left;width:69px; height:30px; text-align:center; padding-left:10px">Disponibilité magasin</div>
						</div>
					</c:when>
					
					<c:otherwise>
						<div class="header">
							<div class="c1">Coloris</div>
							<div class="c2">Prix Unitaire</div>
							<div class="c3">Quantité</div>
						</div>
						
						<div class="header">
							<div class="c1">Coloris</div>
							<div class="c2">Prix Unitaire</div>
							<div class="c3">Quantité</div>
						</div>
					</c:otherwise>
				</c:choose>
				<div class="clear"></div>
				<div class="bg_colorlist">
				<c:forEach items="${nuances}" var="nuance" varStatus="nuanceStatus">
					<div class="color">
						<input type="hidden" class="colorCode" value="${nuance.nuanceBiz}">
						<input type="checkbox" name="nuance" value="${nuance.ceId}" title="${nuance.libelle}">
						<c:choose>
							<%-- C'est un code HTML --%>
							<c:when test="${fn:contains(nuance.coloris, '#')}">
								<div class="preview" style="background-color:${nuance.coloris};">
									<img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/preview.png" width="25" height="21" alt="Preview ${nuance.libelle}" border="0"/>
								</div>
							</c:when>
							<%-- Sinon c'est une image --%>
							<c:otherwise>
								<div class="preview" style='background:url("${catalogPath}/${nuance.coloris}") no-repeat;'>
									<img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/preview.png" width="25" height="21" border="0"/>
								</div>
							</c:otherwise>
						</c:choose>
						<table class="titre" cellpadding="0" cellspacing="0" border="0"><tr><td>${nuance.libelle}</td></tr></table>
						<div class="grey">
							<div class="prix"><fwk:priceFormater price="${nuance.price}" format="$1,$2${devise}"/></div>
							<div class="nuanceQuantity_${nuance.ceId}">
								<div class="select">
									<img onClick="decQuantity(${nuance.ceId});" src="${contextPath}/resources/${codeIsoLang}/img/merchandising/btn_moins.png" width="15" height="15" alt="" border="0"/>
									<input type="text" id="nuanceQuantity_${nuance.ceId}" value="0" maxlength="4" onBlur="incQuantityKey(${nuance.ceId},${nuance.stock});" onkeypress="if (event.keyCode == 13){incQuantityKey(${nuance.ceId},${nuance.stock});}">
									<img onClick="incQuantity(${nuance.ceId},${nuance.stock});" src="${contextPath}/resources/${codeIsoLang}/img/merchandising/btn_plus.png" width="15" height="15" alt="" border="0"/>
								</div>
								<div class="nuanceDispo_${nuance.ceId}"></div>
								<%-- Image de disponibilite magasin ajouté en js dans catalogEntry.js --%>
							</div>
						</div>
					</div>
				</c:forEach>
				<div class="clear"></div>
				</div>
				<div class="footer clear"></div>
				<div class="footer"></div>
				<div class="colorTotal clear">
					<div class="localisation"><%-- <a href="#">Voir les produits disponibles en magasin</a> --%></div>
					<div class="nbArticles"><span>0 article</span></div>
					<div class="prix">0,00€</div>
					<div class="addBasket">
					<c:choose>
						<c:when test="${ceDisplay.child!=null}">
							<c:set var="oneSKU" value="false"/>
							<c:forEach items="${ceDisplay.child}" var="child">
								<c:if test="${!oneSKU && child.catalogEntry.catalogEntryTypeId == 2}">
									<img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/btn_ajoutPanier.png" onClick="window.scrollTo(0,$('#couleurs').offset().top);$('.warningSelectionNuance').css('color','#E30613');" width="169" height="38" alt="Ajouter au panier" border="0"/>
									<c:set var="oneSKU" value="true"/>
								</c:if>
							</c:forEach>
						</c:when>
						<c:when test="${ceDisplay.child==null && ceDisplay.catalogEntry.catalogEntryTypeId == 2}">
							<img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/btn_ajoutPanier.png" onclick="addToCartNonDiscriminantProduct(${ceDisplay.catalogEntry.catalogEntryId});" width="169" height="38" alt="Ajouter au panier" border="0"/>
						</c:when>
					</c:choose>
					</div>
					<div class="addList">Ajouter à ma liste</div>
				</div>
			</div>
				
			<c:import url="importAvisClientAndIdeesRealisations.jsp"/>
			
			<c:import url="importCrossUpSelling.jsp"/>
			
			<div class="clear"></div>
		</div>
	</tiles:putAttribute>	
	
	<tiles:putAttribute name="moreJS">
		<script src="${contextPath}/resources/js/merchandising/merchandising.js" type="text/javascript"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery/jquery.spritespin.js"></script>
		<script src="${contextPath}/resources/js/shadowbox/shadowbox.js" type="text/javascript"></script>
		<script type="text/javascript">
		  window.___gcfg = {lang: 'fr'};
		
		  (function() {
		    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
		    po.src = 'https://apis.google.com/js/plusone.js';
		    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
		  })();
		</script>
		
		<div id="fb-root"></div>
		<script>(function(d, s, id) {
			  var js, fjs = d.getElementsByTagName(s)[0];
			  if (d.getElementById(id)) return;
			  js = d.createElement(s); js.id = id;
			  js.src = "//connect.facebook.net/fr_FR/all.js#xfbml=1&appId=${facebookAppId}";
			  fjs.parentNode.insertBefore(js, fjs);
			}(document, 'script', 'facebook-jssdk'));</script>
		
		<script type="text/javascript">
		var ceId = ${ceDisplay.catalogEntry.catalogEntryId};
		var urlReview = '${urlReview}';
		var image360 = [<c:forEach items="${ceDisplay.catalogEntry.pictures['360']}" var="sellingImage" varStatus="status">
							"${catalogPath}/${sellingImage.path}"
							<c:if test="${status.count!=0}">,</c:if>
						</c:forEach>];
		var currency = '${devise}';
			var contextPath = '${contextPath}';
			var catalogId = '${catalogId}';
			var codeIsoLang = '${codeIsoLang}';
			var picturePath = '${catalogPath}';
			var skuId;
			
			var tabMainPicturePath = new Array();
			//console.log(${ceDisplay.picturesPath});
			<c:if test="${not empty ceDisplay.picturesPath}">
  				tabMainPicturePath = ${ceDisplay.picturesPath};
				//console.log(tabMainPicturePath[0]);
  			</c:if>

			var tabMainPictureAlternate = new Array();
			<c:if test="${not empty ceDisplay.picturesAlternate}">
				tabMainPictureAlternate = ${ceDisplay.picturesAlternate};
			</c:if>
			
			var tabPictureZoom = new Array();
			<c:if test="${not empty ceDisplay.zoomPicturesPath}">
				tabPictureZoom = ${ceDisplay.zoomPicturesPath};
			</c:if>
			
			$(document).ready(
				function (){
					initNuance();
// 					var context = getNavigationContext();
// 					callDataForAjaxNuance('previousNeighbor', 'nextNeighbor', '${urlRewrite}', '${ceDisplay.catalogEntry.catalogEntryId}', '${catalogId}', context);
// 					Shadowbox.init();
				}
			);
			
		</script>
		<script src="${contextPath}/resources/js/merchandising/catalogEntry.js?20130802" type="text/javascript"></script>
		
		<script type="text/javascript">
			var isStockMagasinActivated = '${stockMagasinActivated}';
			// On réduit la taille de la colonne de prix pour afficher le stock magasin
			if(isStockMagasinActivated == 'true') {
				$(".prix").css("width","110px");
			}
		</script>
		
		<c:if test="${stockMagasinActivated}">
			<!-- Disponibilite en magasin -->
			<script type="text/javascript">
				
				// Initialisation des informations de magasin (suivant la valeur du cookie)
				initDisponibiliteMagasinForNuancePage();
			
				// Récupération de la liste des nuances et des ean associés pour la disponibilité magasin
				var mapNuanceDisponibiliteMagasin = $.parseJSON('${listeCodeProduitNuanceJson}');
			</script>
			
			<script src="${contextPath}/resources/js/jquery/jquery-bubble-popup-v3.min.js" type="text/javascript"></script>	
		</c:if>
		<c:if test="${isTagMetafiliationActivated }">
			<script type="text/javascript" src="http://img.metaffiliation.com/u/11/p33385.js?zone=produit&idproduit=${ceDisplay.catalogEntry.catalogEntryBiz}&idcategorie=<c:if test='${ not empty category}'>${fn:trim(category.categoryBiz)}</c:if>"></script>
		</c:if>	
	</tiles:putAttribute>
</tiles:insertDefinition>