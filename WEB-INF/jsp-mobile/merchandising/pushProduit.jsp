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
debut push produit
<c:forEach items="${pushProduit}" var="catalogEntry">
	<c:set var="urlRewriteSelling">
    	<fwk:rewrite url="/catalogEntry.html?langId=${langId}&ceId=${catalogEntry.catalogEntryId}" />
	</c:set>
	
	<c:set var="imgProduct" value="false"></c:set>
	<c:forEach items="${catalogEntry.pictures['cross']}" var="sellingImage" begin="0" end="0">
		<c:if test="${sellingImage.path != null && sellingImage.path != ''}">
			<c:set var="imgProduct" value="true"></c:set>
		</c:if>
    </c:forEach>
	
	<c:if test="${imgProduct == true}">
		<div class="bloc_article">
			<div class="image">
				<div class="stickers">
					<!-- Gestion des stickers -->
	<%-- 				<div class="flag"><a href="#"><img src="${contextPath}/resources/${codeIsoLang}/img/moteur/nouveau.png" border="0" alt="sticker" /></a></div>  --%>
	<%-- 				<div class="flag"><a href="#"><img src="${contextPath}/resources/${codeIsoLang}/img/moteur/promo.png" border="0" alt="sticker" /></a></div> --%>
					
					<!-- Gestion du sticker -->
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
	<%-- 			<a href="${urlRewriteSelling}"><img src="${contextPath}/resources/${codeIsoLang}/img/moteur/article_1.jpg" width="128" height="127" alt="Article_1" /> --%>
					<c:forEach items="${catalogEntry.pictures['cross']}" var="sellingImage" begin="0" end="0">
	                    <a href="${urlRewriteSelling}"><img src="${catalogPath}/${sellingImage.path}" width="128" height="128" alt="${sellingImage.picturesDescriptions[langId].alternateText}" border="0"/></a>
	                </c:forEach>
				</a> 
			</div>
			<div class="intitule">
				<a href="${urlRewriteSelling}"><span>
					<c:forEach items="${catalogEntry.attributesNormalizedMapBizKey}" var="attributNormalized">
						<c:if test="${attributNormalized.value.attributeBiz == 'MARQUE'}">
							<c:forEach items="${attributNormalized.value.attributeNormalizeValues}" var="attributeNormalizeValues">
								${attributeNormalizeValues.attributeValueDescriptions[langId].description}
							</c:forEach>
						</c:if>
					</c:forEach>
				</span></a>
			</div>
			<div class="description">
				<a href="${urlRewriteSelling}"><span>${catalogEntry.catalogEntryDescriptions[langId].title1}</span></a>
				<a href="${urlRewriteSelling}"><span>&nbsp;</span></a>
			</div>
			<div class="prix">
				<c:choose>
		             <c:when test="${catalogEntry.highestPrice.basePrice != null && catalogEntry.highestPrice.price != ''}">
		                 <span class="barre"><fwk:priceFormater price="${catalogEntry.highestPrice.basePrice}" format="$1,$2€" showDecimalPartIfZero="true"/></span>
		                 <a href="${urlRewriteSelling}"><span class="rouge"><fwk:priceFormater price="${catalogEntry.highestPrice.price}" format="$1,$2€" showDecimalPartIfZero="true"/></span></a>
		             </c:when>
		             <c:otherwise>
		                 <a href="${urlRewriteSelling}"><span class="rouge"><fwk:priceFormater price="${catalogEntry.highestPrice.price}" format="$1,$2€" showDecimalPartIfZero="true"/></span></a>
		             </c:otherwise>
		         </c:choose>
				
	<%-- 			<a href="${urlRewriteSelling}"><span class="barre">32,00&euro;</span></a> --%>
	<%-- 			<a href="${urlRewriteSelling}"><span class="rouge">26,80&euro;</span></a> --%>
			</div>
		</div>
	</c:if>
</c:forEach>