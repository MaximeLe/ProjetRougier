<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<div class="zCross">
	<ul class="titre">
		<c:if test="${not empty crossSelling}">
			<li><h2>Produits recommandés</h2></li>
		</c:if>
		<c:if test="${not empty upSelling}">
			<li><h2>
				<c:choose>
					<c:when test="${not empty libelleUpSelling && libelleUpSelling != ''}">${libelleUpSelling}</c:when>
					<c:otherwise>Kits et Coffrets</c:otherwise>
				</c:choose>
			</h2></li>
		</c:if>
	</ul>
	
	
	
	
	<c:if test="${not empty crossSelling || not empty upSelling}">
		<ul class="contenu">
	</c:if>
		<c:if test="${not empty crossSelling}">
			<li>
				<c:set var="count">1</c:set>	
				<c:forEach items="${crossSelling}" var="selling" varStatus="boucle">
				    <c:if test="${(count)<4 && not empty selling.pictures['liste'] && not empty selling.lowestPrice.price && selling.lowestPrice.price>0}">
						<c:set var="count">${count+1}</c:set>
				        <c:set var="urlRewriteSelling">
				            <fwk:rewrite url="/catalogEntry.html?langId=${langId}&ceId=${selling.catalogEntryId}" />
				        </c:set>
				       	<div class="produit">
				            
				            <div class="visuel"><a href="${urlRewriteSelling}">
				                <c:forEach items="${selling.pictures['cross']}" var="sellingImage" begin="0" end="0">
				                    <img src="${catalogPath}/${sellingImage.path}" width="128" height="128" alt="${sellingImage.picturesDescriptions[langId].alternateText}" border="0"/>
				                </c:forEach><br/>
				                				                
				            </div>
				            <div class="infos">
				            	<p><a href="${urlRewriteSelling}" title="">
				            		<c:forEach items="${selling.catalogEntry.attributesNormalizedMapBizKey}" var="attributNormalized">
										<c:if test="${attributNormalized.value.attributeBiz == 'MARQUE'}">
											<c:forEach items="${attributNormalized.value.attributeNormalizeValues}" var="attributeNormalizeValues">
												${attributeNormalizeValues.attributeValueDescriptions[langId].description}
											</c:forEach>
										</c:if>
									</c:forEach>
				            	</a></p>
				            	<h3><a href="${urlRewriteSelling}" title="">${selling.catalogEntryDescriptions[langId].title1}</a></h3>
					            <div class="prix">
					                <c:choose>
					                    <c:when test="${selling.lowestPrice.basePrice != null && selling.lowestPrice.price != ''}">
					                        <span><fwk:priceFormater price="${selling.lowestPrice.basePrice}" format="$1,$2€" showDecimalPartIfZero="true"/></span>
					                        <a href="${urlRewriteSelling}"><fwk:priceFormater price="${selling.lowestPrice.price}" format="$1,$2€" showDecimalPartIfZero="true"/></a>
					                    </c:when>
					                    <c:otherwise>
					                        <a href="${urlRewriteSelling}"><fwk:priceFormater price="${selling.lowestPrice.price}" format="$1,$2€" showDecimalPartIfZero="true"/></a>
					                    </c:otherwise>
					                </c:choose>
					            </div>
				            </div>
				        </div>
				    </c:if>
				</c:forEach>
			</li>
		</c:if>

	
	

		<c:if test="${not empty upSelling}">
			<c:set var="count">
					1
				</c:set>	
			<li>	
				<c:forEach items="${upSelling}" var="selling" varStatus="boucle">
				     <c:if test="${(count)<4 && not empty selling.pictures['liste'] && not empty selling.lowestPrice.price && selling.lowestPrice.price>0}">
						<c:set var="count">
							${count+1}
						</c:set>
				        <c:set var="urlRewriteSelling">
				            <fwk:rewrite url="/catalogEntry.html?langId=${langId}&ceId=${selling.catalogEntryId}" />
				        </c:set>
				       	<div class="produit">
				            <div class="visuel"><a href="${urlRewriteSelling}">
				                <c:forEach items="${selling.pictures['cross']}" var="sellingImage" begin="0" end="0">
				                    <img src="${catalogPath}/${sellingImage.path}" width="128" height="128" alt="${sellingImage.picturesDescriptions[langId].alternateText}" border="0"/>
				                </c:forEach><br/>
				                
								<!-- Gestion du sticker -->
				                <c:if test="${not empty selling.eventsStickers}">
				                    <c:choose>
				                        <c:when test="${fn:length(selling.eventsStickers) == 1}">
				                            <c:forEach items="${selling.eventsStickers}" var="sticker">
				                                <c:if test="${sticker != null}">
				                                    <c:forEach items="${sticker.stickerDescriptions}" var="stickerDescription">
				                                        <c:if test="${stickerDescription.value.picture1 != ''}">
				                                            <a style="cursor:pointer" class="second" id="nouveaute"><img src="${mediaPath}${stickerDescription.value.picture1}" height="22" alt="Nouveauté" /></a>
				                                        </c:if>
				                                    </c:forEach>
				                                </c:if>
				                            </c:forEach>	
				                        </c:when>
				                    </c:choose>
				                </c:if>
				                
				            </a>
				            </div>
				            <div class="infos">
				            	<p><a href="${urlRewriteSelling}" title="">
				            		<c:forEach items="${selling.catalogEntry.attributesNormalizedMapBizKey}" var="attributNormalized">
										<c:if test="${attributNormalized.value.attributeBiz == 'MARQUE'}">
											<c:forEach items="${attributNormalized.value.attributeNormalizeValues}" var="attributeNormalizeValues">
												${attributeNormalizeValues.attributeValueDescriptions[langId].description}
											</c:forEach>
										</c:if>
									</c:forEach>
				            	</a></p>
				            	<h3><a href="${urlRewriteSelling}" title="">${selling.catalogEntryDescriptions[langId].title1}</a></h3>
					            <div class="prix">
					                <c:choose>
					                    <c:when test="${selling.lowestPrice.basePrice != null && selling.lowestPrice.price != ''}">
					                        <span><fwk:priceFormater price="${selling.lowestPrice.basePrice}" format="$1,$2€" showDecimalPartIfZero="true"/></span>
					                        <a href="${urlRewriteSelling}"><fwk:priceFormater price="${selling.lowestPrice.price}" format="$1,$2€" showDecimalPartIfZero="true"/></a>
					                    </c:when>
					                    <c:otherwise>
					                        <a href="${urlRewriteSelling}"><fwk:priceFormater price="${selling.lowestPrice.price}" format="$1,$2€" showDecimalPartIfZero="true"/></a>
					                    </c:otherwise>
					                </c:choose>
					            </div>
				            </div>
				        </div>
				    </c:if>
				</c:forEach>
			</li>
		</c:if>
	<c:if test="${not empty crossSelling || not empty upSelling}">
		<ul/>
	</c:if>
</div>