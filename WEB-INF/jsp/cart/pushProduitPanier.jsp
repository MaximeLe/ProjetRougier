<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>

<c:if test="${not empty pushProduit }">
<div class="recommandations">
				<span>Recommandations</span>
			</div>
<c:forEach items="${pushProduit}" var="catalogEntry">


	<c:set var="urlAddCart">
    	<fwk:rewrite url="/cart.html?skuId=${catalogEntry.catalogEntryId}&quantityAdd=1" />
	</c:set>

	
	<c:set var="imgProduct" value="false"></c:set>
	<c:forEach items="${catalogEntry.parentCompositions[0].catalogEntry.pictures['cross']}" var="pushImage" begin="0" end="0">
		<c:if test="${pushImage.path != null && pushImage.path != ''}">
			<c:set var="imgProduct" value="true"></c:set>
		</c:if>
    </c:forEach>
	
	<c:if test="${imgProduct == true}">
		<div class="bloc_article">
			<div class="image">
				<div class="stickers">

	                <c:if test="${not empty catalogEntry.eventsStickers}">
	                    <c:choose>
	                        <c:when test="${fn:length(catalogEntry.eventsStickers) == 1}">
	                            <c:forEach items="${catalogEntry.eventsStickers}" var="sticker">
	                                <c:if test="${sticker != null}">
	                                    <c:forEach items="${sticker.stickerDescriptions}" var="stickerDescription">
	                                        <c:if test="${stickerDescription.value.picture1 != ''}">
	                                            <div class="flag"><a style="cursor:pointer" class="second" id="nouveaute"><img src="${mediaPath}${stickerDescription.value.picture1}" height="22" alt="Sticker" /></a></div>
	                                        </c:if>
	                                    </c:forEach>
	                                </c:if>
	                            </c:forEach>	
	                        </c:when>
	                    </c:choose>
	                </c:if>
					
					<!-- Fin de gestion des stickers -->
				</div>
				<a>
					<c:forEach items="${catalogEntry.parentCompositions[0].catalogEntry.pictures['cross']}" var="sellingImage" begin="0" end="0">
	                   <img src="${catalogPath}/${sellingImage.path}" width="128" height="128" alt="${sellingImage.picturesDescriptions[langId].alternateText}" border="0"/>
	                </c:forEach>
				</a> 
			</div>
			<div class="intitule">
				<span>
					<c:forEach items="${catalogEntry.parentCompositions[0].catalogEntry.attributesNormalizedMapBizKey}" var="attributNormalized">
						<c:if test="${attributNormalized.value.attributeBiz == 'MARQUE'}">
							<c:forEach items="${attributNormalized.value.attributeNormalizeValues}" var="attributeNormalizeValues">
								${attributeNormalizeValues.attributeValueDescriptions[langId].description}
							</c:forEach>
						</c:if>
					</c:forEach>
				</span>
			</div>
			<div class="description">
				<span>${catalogEntry.parentCompositions[0].catalogEntry.catalogEntryDescriptions[langId].title1}</span>
				<span>&nbsp;</span>
			</div>
			<div class="prix">
				<c:choose>
		             <c:when test="${catalogEntry.tariffs[0].basePrice != null && catalogEntry.tariffs[0].price != ''}">
		                 <span class="barre"><fwk:priceFormater price="${catalogEntry.tariffs[0].basePrice}" format="$1,$2€" showDecimalPartIfZero="true"/></span>
		                 <span class="rouge"><fwk:priceFormater price="${catalogEntry.tariffs[0].price}" format="$1,$2€" showDecimalPartIfZero="true"/></span>
		             </c:when>
		             <c:otherwise>
		                 <span class="rouge"><fwk:priceFormater price="${catalogEntry.tariffs[0].price}" format="$1,$2€" showDecimalPartIfZero="true"/></span>
		             </c:otherwise>
		         </c:choose>
				

			</div>
			<div class="addCart">
				<a href="${urlAddCart }">Ajouter au panier</a>
			</div>
		</div>
	</c:if>


	<%-- <c:set var="urlAddCart">
    	<fwk:rewrite url="/cart.html?skuId=${catalogEntry.childCompositions[0].catalogEntry.catalogEntryId}&quantityAdd=1" />
	</c:set>
	
	<c:set var="imgProduct" value="false"></c:set>
	<c:forEach items="${catalogEntry.pictures['vignette']}" var="pushImage" begin="0" end="0">
		<c:if test="${pushImage.path != null && pushImage.path != ''}">
			<c:set var="imgProduct" value="true"></c:set>
		</c:if>
    </c:forEach>
	
	<c:if test="${imgProduct == true}">
		<div class="bloc_article">
			<div class="image">
				<div class="stickers">

	                <c:if test="${not empty catalogEntry.eventsStickers}">
	                    <c:choose>
	                        <c:when test="${fn:length(catalogEntry.eventsStickers) == 1}">
	                            <c:forEach items="${catalogEntry.eventsStickers}" var="sticker">
	                                <c:if test="${sticker != null}">
	                                    <c:forEach items="${sticker.stickerDescriptions}" var="stickerDescription">
	                                        <c:if test="${stickerDescription.value.picture1 != ''}">
	                                            <div class="flag"><a style="cursor:pointer" class="second" id="nouveaute"><img src="${mediaPath}${stickerDescription.value.picture1}" height="22" alt="Sticker" /></a></div>
	                                        </c:if>
	                                    </c:forEach>
	                                </c:if>
	                            </c:forEach>	
	                        </c:when>
	                    </c:choose>
	                </c:if>
					
					<!-- Fin de gestion des stickers -->
				</div>
				<a>
					<c:forEach items="${catalogEntry.pictures['vignette']}" var="sellingImage" begin="0" end="0">
	                   <img src="${catalogPath}/${sellingImage.path}" width="128" height="128" alt="${sellingImage.picturesDescriptions[langId].alternateText}" border="0"/>
	                </c:forEach>
				</a> 
			</div>
			<div class="intitule">
				<span>
					<c:forEach items="${catalogEntry.attributesNormalizedMapBizKey}" var="attributNormalized">
						<c:if test="${attributNormalized.value.attributeBiz == 'MARQUE'}">
							<c:forEach items="${attributNormalized.value.attributeNormalizeValues}" var="attributeNormalizeValues">
								${attributeNormalizeValues.attributeValueDescriptions[langId].description}
							</c:forEach>
						</c:if>
					</c:forEach>
				</span>
			</div>
			<div class="description">
				<span>${catalogEntry.catalogEntryDescriptions[langId].title1}</span>
				<span>&nbsp;</span>
			</div>
			<div class="prix">
				<c:choose>
		             <c:when test="${catalogEntry.highestPrice.basePrice != null && catalogEntry.highestPrice.price != ''}">
		                 <span class="barre"><fwk:priceFormater price="${catalogEntry.highestPrice.basePrice}" format="$1,$2€" showDecimalPartIfZero="true"/></span>
		                 <span class="rouge"><fwk:priceFormater price="${catalogEntry.highestPrice.price}" format="$1,$2€" showDecimalPartIfZero="true"/></span>
		             </c:when>
		             <c:otherwise>
		                 <span class="rouge"><fwk:priceFormater price="${catalogEntry.highestPrice.price}" format="$1,$2€" showDecimalPartIfZero="true"/></span>
		             </c:otherwise>
		         </c:choose>
				

			</div>
			<div class="addCart">
				<a href="${urlAddCart }">Ajouter au panier</a>
			</div>
		</div>
	</c:if> --%>
</c:forEach>
</c:if>