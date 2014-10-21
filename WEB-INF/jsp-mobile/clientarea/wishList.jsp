<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="devise"><c:choose><c:when test="${storeId==2}">&#36;</c:when><c:otherwise>&euro;</c:otherwise></c:choose></c:set>

<tiles:insertDefinition name="templateMenu">
	<tiles:putAttribute name="title"><spring:message code="wishList.title"/></tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="wishList.title"/></tiles:putAttribute>
	
	<tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}${contextPath}${requestScope['javax.servlet.forward.servlet_path']}
	</tiles:putAttribute>
	
	<tiles:putAttribute name="breadcrumb">
		<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt;
		<span class="lien_chemin"><a href="${contextPath}/account.html"><spring:message code="clientAreaMenu.monCompte"/></a></span>&nbsp;&gt;
		<span class="lien_chemin"><spring:message code="wishList.title"/></span>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="ems">&nbsp;</tiles:putAttribute>
	
	<tiles:putAttribute name="menu">
		<c:import url="clientAreaMenu.jsp"/>
	</tiles:putAttribute>

	<tiles:putAttribute name="content">
		<div id="clients" class="liste_souhaits">
			<div id="contenu_interieur">
				<div id="wishlist">
					<div class="coordonnees">
						<h2>
							<spring:message code="clientAreaMenu.mesListesSouhaits"/>
							<c:if test="${customer.blackListed}">
								<span style="color: red;">&nbsp;<spring:message code="customerAccount.compteBlackliste"/></span>
							</c:if>
							<c:if test="${customer.disabled}">
								<span style="color: red;">&nbsp;<spring:message code="customerAccount.compteDesactive"/></span>
							</c:if>						
						</h2>
					</div>
					<div class="contenu_blanc">
						<form name="form_liste_souhaits" method="get" id="form_liste_souhaits">
							<div class="creation_liste">
								<label for="nouvelle"><spring:message code="wishList.creer"/></label>
								<input type="text" size="20" maxlength="255" value="<spring:message code="wishList.nomDeLaListe"/>" name="nouvelle" 
									onclick="javascript:deleteDefaultValue(this)" onblur="javascript:insertDefaultValue(this)"/>
								<c:set var="text"><spring:message code="favoriteShop.btnOk"/></c:set>
								<fwk:genericButton text="${text}" firstSpanClass="Org_small" btnId="btn_supprimer_wishProduct" buttonType="button" 
									onClick="createWishList()"/>
								<br><br><div id="messageOrError" class="error">${messageOrError}</div>
							</div>
						</form>
						<div class="resultats">
							
							<c:if test="${empty wishesList}">
								<div class="aucune">
									<spring:message code="wishList.aucuneListeCreee"/>
								</div>
							</c:if>
							<c:if test="${!empty wishesList}">
							
							
								<!-- 	Liste des WishList    -->
									
								
								<c:forEach items="${wishesList}" var="wishList">
									<form name="form_wishList${wishList.wishListId}" id="form_wishList${wishList.wishListId}" method="get">
										<div class="premiere_liste" id="wishList_${wishList.wishListId}">
											<div class="soustitre">
												<span><spring:message code="wishList.liste"/>${wishList.wishListName}</span>
												<div class="supprimer">
													<input type="button" class="btn_supprimer_wishList" id="btn_supprimer_wishList" value="X" onclick="javascript:submitDelete('${wishList.wishListId}')"/>
												</div>
											</div>
											<c:if test="${empty wishList.productsDisplayBean}">
												<spring:message code="whishList.aucunArticleDansLaListe"></spring:message>
											</c:if>
											<c:if test="${!empty wishList.productsDisplayBean}">
													
												<div class="ctn_tableau">
													<ul id="entete_tableau" class="tableau">
														<li class="colonne1"><span>&nbsp;</span></li>
														<li class="colonne2"><span><spring:message code="order.article"/></span></li>
														<li class="colonne3"><span><spring:message code="order.etat"/></span></li>
														<li class="colonne4"><span><spring:message code="order.prix"/></span></li>
														<li class="colonne5"><span><input type="checkbox" id="selectionne_tout${wishList.wishListId}" name="selectionne_tout" onclick="javascript:selectAll('${wishList.wishListId}', this)"/></span></li>
													</ul>
													<ul class="tableau separation" >
														<c:forEach items="${wishList.productsDisplayBean}" var="product" varStatus="status">
															<li class="colonne1">
																<img width="30" hight="30" src="${catalogPath}/${product.picturePath}" alt="${product.wordingProduct}"/>
															</li>
															<li class="colonne2">
																<span class="black">
																	<c:set var="urlRewriteProduct">
					            										<fwk:rewrite url="/catalogEntry.html?langId=${langId}&ceId=${product.catalogEntry.parentCompositions[0].catalogEntry.catalogEntryId}" />
					        										</c:set>
																	<a href="${urlRewriteProduct}">
																		${product.catalogEntry.titleBiz}
																	</a>
																</span>
															<li class="colonne3">
																<c:choose>
																	<c:when test="${product.catalogEntry.stock > 0}"><span class="vert"><spring:message code="wishList.enStock"/></span><span style="display:none" itemprop="availability">in_stock</span></c:when>
																	<c:otherwise><span class="rouge"><spring:message code="wishList.epuise"/></span><span style="display:none" itemprop="availability">out_of_stock</span></c:otherwise>
																</c:choose>
															</li>
															<li class="colonne4">
																<c:if test="${!empty product.basePrice and product.basePrice != product.price}"> 
																	<div class="prixbarre"><fmt:formatNumber value="${product.basePrice}" currencySymbol="${devise}" type="currency"/></div>
	 															</c:if>
																<span class="black bold"><fmt:formatNumber value="${product.price}" currencySymbol="${devise}" type="currency"/></span>
															</li>
															<li class="colonne5"><input type="checkbox" name="wishProductIdList" id="${product.catalogEntry.catalogEntryId}" value="${product.wishProductId}"/></li> 
														</c:forEach>
													</ul>
												</div>
												<div class="ctn_btn">
													<a href="#" id="submitAddWishProduct${wishList.wishListId}" onClick="addToCartWishlistProduct('${wishList.wishListId}');">
														<img src="${contextPath}/resources/fr_FR/img/clientArea/btn_ajouter_panier.png" alt="Ajouter au panier" width="123" height="28"></a>
													<a href="#" id="submitDeleteWishProduct_button${wishList.wishListId}" onClick="submitDeleteWishProduct('${wishList.wishListId}');">
														<img src="${contextPath}/resources/fr_FR/img/clientArea/btn_supprimer.png" alt="Supprimer" width="88" height="27"></a>
												</div>
											</c:if>
											<input type="hidden" name="wishListId" value="${wishList.wishListId}"/>
											<input type="hidden" name="action" id="action${wishList.wishListId}"/>
										</div>
									</form>
								</c:forEach>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="moreJS">		
		<script>
			$("#menu .contenu_menu ul:eq(0) li:eq(5) a").attr("style","color:#000000;");
			$("#menu .contenu_menu ul:eq(0) li:eq(5) a").removeAttr("href");
			var messageNouvelleListe = "<spring:message code="wishList.nomDeLaListe"/>";
		</script>
		<script src="${contextPath}/resources/js/clientArea/wishList.js" type="text/javascript"></script>
	</tiles:putAttribute>
</tiles:insertDefinition>