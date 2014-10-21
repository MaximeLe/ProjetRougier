<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<c:choose>
<c:when test="${not empty rejectedProduct or param.source=='ficheProduit'}">
<div id="modal">
	<div class="btn_close"></div>
	<div class="content pBasket">
		<div class="titre">
			<c:choose>
				<c:when test="${param.source=='ficheProduit'}">
					<c:choose>
						<c:when test="${not empty rejectedProduct }">
							<span class="light"><spring:message code="addCart.message.ajoutPanier"/></span>
						</c:when>
						<c:otherwise>
							<span class="light"><spring:message code="addCart.ajoutOk"/></span>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<span class="light"><spring:message code="addCart.title.persist"/></span>
					<c:choose>
						<c:when test="${not empty rejectedProduct }">
							<c:if test="${not empty rejectedNotPublishedArticles}">							
								<c:choose>
									<c:when test="${rejectedNotPublishedArticles < 2}"><span class="light">${rejectedNotPublishedArticles} <spring:message code="addCart.message.ArticleNotPublished"/></span></c:when>
									<c:otherwise><span class="light">${rejectedNotPublishedArticles} <spring:message code="addCart.message.ArticlesNotPublished"/></span></c:otherwise>
								</c:choose>
								<br>
							</c:if>
							<c:if test="${not empty rejectedProduct && rejectedNotPublishedArticles<fn:length(rejectedProduct)}">
								<span class="light"><spring:message code="addCart.message.persist"/></span>	
							</c:if>					
						</c:when>
						<c:otherwise>
							<span class="light"><spring:message code="addCart.ajoutOk"/></span>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</div>
		<c:if test="${not empty rejectedProduct && ((rejectedNotPublishedArticles lt fn:length(rejectedProduct)) || empty rejectedNotPublishedArticles)}">
			<table cellpadding="0" cellspacing="0" border="0">
				<c:forEach items="${rejectedProduct }" var="reject">
					<c:if test="${reject.published}">
						<tr>
							<td class="col1"><img src="${catalogPath}/${reject.catalogEntryDisplayBean.catalogEntry.parentCompositions[0].catalogEntry.pictures['vignette'][0].path }" width="105" height="105" border="0" alt=""/></td>
							<td class="col2"><span>${reject.catalogEntryDisplayBean.catalogEntry.parentCompositions[0].catalogEntry.attributesNormalizedMapBizKey['MARQUE'].attributeNormalizeValues[0].attributeValueDescriptions[langId].description}</span>
								<br/><br/>${reject.catalogEntryDisplayBean.catalogEntry.parentCompositions[0].catalogEntry.catalogEntryDescriptions[langId].title1 } 
								<c:if test="${not empty nuances}">
									<c:forEach items="${nuances}" var="nuance" varStatus="nuanceStatus">
										<c:if test="${nuance.ceId == reject.catalogEntryDisplayBean.catalogEntry.catalogEntryId}">
											- <br> ${nuance.libelle}
										</c:if>
									</c:forEach>
								</c:if>
								<br/>
		<%-- 						<c:forEach items="${reject.catalogEntryDisplayBean.catalogEntry.attributesMapBizKey }" var="discriminant"> --%>
		<%-- 						${discriminant.value.attributeValues[0].attributeValueDescriptions[langId].description}  --%>
		<%-- 						</c:forEach> --%>
							</td>
							<td class="col3">
								<c:if test="${not empty reject.catalogEntryDisplayBean.catalogEntryPrice.basePrice }">
									<span>${reject.catalogEntryDisplayBean.catalogEntryPrice.basePrice } €</span><br/>
								</c:if>
								${reject.catalogEntryDisplayBean.catalogEntryPrice.price } €
							</td>
							<td class="col4">${reject.quantity }&nbsp;
								<c:choose>
									<c:when test="${reject.quantity > 1}">
										<spring:message code="addCart.quantitesDemandes"/>
									</c:when>
									<c:otherwise>
										<spring:message code="addCart.quantiteDemande"/>
									</c:otherwise>
								</c:choose>
							</td>
							<td class="col5">
								<c:choose>
									<c:when test="${reject.quantityAdded > 0}">
										${reject.quantityAdded } <spring:message code="addCart.dispo.limite"/>
									</c:when>
									<c:otherwise>
										<spring:message code="addCart.indispo"/>
									</c:otherwise>
								</c:choose>
							</td>						
						</tr>
					</c:if>				
				</c:forEach>			
			</table>
		</c:if>
		
		<c:if test="${not empty rejectedProduct && nbArticle>fn:length(rejectedProduct)}">
			<div class="titre">
				<span  class="light"><spring:message code="addCart.autresArticles"/></span>
			</div>
		</c:if>
		<c:if test="${not empty crossSelling}">
		<div class="zCross">
		<ul class="titre">
			<c:if test="${not empty crossSelling}">
				<li><h2>Produits recommandés</h2></li>
			</c:if>
		</ul>
		
	<c:if test="${not empty crossSelling}">
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
	<c:if test="${not empty crossSelling}">
		<ul/>
	</c:if>
	</div>
	</c:if>
		<c:choose>
			<c:when test="${param.source=='ficheProduit'}">
				<img class="input_close" src="${contextPath}/resources/${codeIsoLang}/img/common/btn_poursuivre.png" width="199" height="38" border="0" alt=""/>
				<a href="${contextPath}/cart.html?fromProduct=1" class="btnRight2"><img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/btn_voirpanier2.png" width="169" height="38" border="0" alt="Voir mon panier"/></a>
			</c:when>
			<c:otherwise>
				<img class="input_close" src="${contextPath}/resources/${codeIsoLang}/img/common/btn_poursuivre.png" width="199" height="38" border="0" alt=""/>
				<a href="${contextPath}/cart.html?fromProduct=0" class="btnRight2"><img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/btn_voirpanier2.png" width="169" height="38" border="0" alt="Voir mon panier"/></a>
			</c:otherwise>
		</c:choose>
		
	</div>
</div>
</c:when>
<c:otherwise>
	<c:if test="${param.source!='ficheProduit'}">
		majPanier();
	</c:if>
</c:otherwise>
</c:choose>
