<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="devise"><c:choose><c:when test="${storeId==2}">&#36;</c:when><c:otherwise>€</c:otherwise></c:choose></c:set>

<tiles:insertDefinition name="mobile-templateHeaderSimplifie">
	<tiles:putAttribute name="title"><spring:message code="cart.title"/></tiles:putAttribute>
	
	<tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}${contextPath}${requestScope['javax.servlet.forward.servlet_path']}
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<div id="content" class="panier">
				<div id="conteneur_ariane">
					<div id="etapes">
						<img id="filet1" class="filet" src="${contextPath}/resources-mobile/${codeIsoLang}/img/cart/panier_filet_1.png" width="95" height="20" alt="filet"/>
						<img class="onglet1" src="${contextPath}/resources-mobile/${codeIsoLang}/img/cart/panier_onglet_1.png" width="20" height="20" alt="<spring:message code="delivery.commande"/>"/>
						<span class="actif"><spring:message code="tunnel.ariane.panier"/></span>
						<div class="etapes_separations"></div>
						<img class="onglet2" src="${contextPath}/resources-mobile/${codeIsoLang}/img/cart/panier_onglet_2.png" width="20" height="20" alt="<spring:message code="delivery.livraison"/>"/>
						<span><spring:message code="tunnel.ariane.livraison"/></span>
						<div class="etapes_separations"></div>
						<img class="onglet3" src="${contextPath}/resources-mobile/${codeIsoLang}/img/cart/panier_onglet_3.png" width="20" height="20" alt="<spring:message code="delivery.payement"/>"/>
						<span id="derniere_etape"><spring:message code="tunnel.ariane.paiement"/></span>
						<img class="filet" src="${contextPath}/resources-mobile/${codeIsoLang}/img/cart/panier_filet_1.png" width="95" height="20" alt="filet"/>
					</div>
				</div>
				<div id="conteneur_panier">
					<div id="contenant_droit" class="clear hidden">
						<!-- Partie gauche -->
						<div class="">
									
							<!--<c:if test="${!empty message}">
								<div class="cadregris grand">
									<div class="barretitre"><span>${message}</span></div>
								</div>
							</c:if>-->
							
							<c:if test="${!empty messageCoupon}">
								<div class="cadregris grand">
									<div class="barretitre"><span>${messageCoupon}</span></div>
								</div>
							</c:if>
							<c:if test="${!empty cart.giftSuggestions}">
								<div class="cadregris grand">
									<div class="cadrille">
										<form method="post" id="chooseGift" action="#">
											<c:forEach items="${cart.giftSuggestions}" var="opeGift" varStatus="status">
												<c:if test="${opeGift.value[0].state != 'UNIQUE_AND_FREE'}">
													<div class="ligne">
														<p>
															<label for="liste${status.index}_${opeGift.key}"><spring:message code="cart.graceAMaCommande"/></label>
															<select name="liste" id="liste${status.index}_${opeGift.key}">
																<c:forEach items="${opeGift.value}" var="gift">
																	<option value="${gift.articleId}">${gift.wordingProduct} (
																		<c:choose>
																			<c:when test="${gift.price >= 0.01}">
																				<spring:message code="cart.pour"/> <fmt:formatNumber value="${gift.price}" currencySymbol="${devise}" type="currency"/>&nbsp;<spring:message code="cart.auLieuDe"/><fmt:formatNumber value="${gift.originalPrice}" currencySymbol="${devise}" type="currency"/>
																			</c:when>
																			<c:otherwise>
																				<spring:message code="receipt.offert"/>&nbsp;<spring:message code="cart.auLieuDe"/> <fmt:formatNumber value="${gift.originalPrice}" currencySymbol="${devise}" type="currency"/>
																			</c:otherwise>
																		</c:choose>
																		)</option>
																</c:forEach>
															</select>
															<input type="submit" name="liste${status.index}_${opeGift.key}" value="<spring:message code="cart.boutonValider"/>" />
														</p>
													</div>
												</c:if>
											</c:forEach>
										</form>
									</div>
								</div>
							</c:if>
							<div class="cadregris grand">
								<c:choose>
									<c:when test="${fn:length(cart.cartLines) > 0}">
										
										<!-- Titres colonnes -->
										
										<div class="titre_tableau">
											<div class="colonne1">
												<span><spring:message code="cart.intituleProduit"/></span>
											</div>
											<div class="colonne2">
												<span><spring:message code="cart.prixUnitaire"/></span>
											</div>
											<div class="colonne3">
												<span><spring:message code="cart.quantite"/></span>
											</div>
											<div class="colonne4">
												<span><spring:message code="cart.total"/></span>
											</div>
										</div>
								
								<!-- Entrées colonnes -->
								<c:forEach items="${rougierCart.groupedCartLine}" var="group" varStatus="status2">
										<c:if test="${fn:length(group.cartLines)>1 }">
											<div class="cartLines">
												<c:set var="urlEc">											
													<fwk:rewrite url="/catalogEntry.html?langId=${rougierCart.langId}&ceId=${group.product_id}"  />
												</c:set>												
												<div class="images ${group.product_id}">
													<a href="${urlEc}" title="${group.libelle}"><img src="/phproduct/${group.image}" alt="${group.libelle}" width="88" /></a>
												</div>
												<div class="description">
													<a href="${urlEc}" title="${group.libelle}">
													<span class="bold">${group.libelle}</span>
													</a>
													<br/>${item.discriminant1Value}&nbsp;${item.discriminant2Value}
												</div>
												<div class="prix_unitaire">
													<span>&nbsp;</span>
												</div>
												<div class="quantite">
													<span class="black bold">${group.quantity }</span>
												</div>
												<div class="prix_total">
													<span class="black bold"><fmt:formatNumber value="${group.prix}" currencySymbol="${devise}" type="currency"/></span>
												</div>
												<c:if test="${not empty group.quantiteMinimum && group.quantiteMinimum>group.quantity}">
													<div class="notmini"><spring:message code="cart.quantiteMinimum"/>${group.quantiteMinimum}</div>
													<c:set var="nonValid">1</c:set>
												</c:if>
																					
											<div class="developpement">
												<a href="#" id="${status2.index}">Voir les détails de ces articles</a>
											</div>
											<div class="ensemble" id="ensemble_${status2.index}">
											<c:forEach items="${group.cartLines}" var="item" varStatus="status">
											
												<div class="cartLines">
													<div class="description">
														<span class="black bold"><spring:message code="cart.libelle.reference"/>: ${item.articleBiz}</span>
														<c:if test="${not empty item.discriminant1 }">
															<span class="gris">${item.discriminant1} : ${item.discriminant1Value}</span>
														</c:if>
														<c:if test="${not empty item.discriminant2 }">
															<span class="gris">${item.discriminant2} : ${item.discriminant2Value}</span>
														</c:if>
														
													</div>
													<div class="prix_unitaire">
														<span class="barre"><fmt:formatNumber value="${item.basePrice}" currencySymbol="${devise}" type="currency"/></span>
														<span class="black"><fmt:formatNumber value="${item.price}" currencySymbol="${devise}" type="currency"/></span>
														<!--<br /><span class="mini black">dont 12&euro; d'&eacute;co-participation</span>-->
													</div>
													<div class="quantite">
														<div class="selecteur">
															<img class="bouton_moins" src="${contextPath}/resources/${codeIsoLang}/img/cart/bouton_moins.jpg" width="15" height="15" alt="Bouton moins" /><input name="selectQuantity" value="${item.quantity}"/><img class="bouton_plus" src="${contextPath}/resources/${codeIsoLang}/img/cart/bouton_plus.jpg" width="15" height="15" alt="Bouton plus" />
														</div>
													</div>
													<div class="prix_total">
														<span class="black bold"><fmt:formatNumber value="${item.price * item.quantity}" currencySymbol="${devise}" type="currency"/></span><!-- <br /><span class="mini black">dont 12&euro; d'&eacute;co-participation</span> -->
													</div>
													<div class="corbeille_in">
														<a href="#" class="corbeille" ><spring:message code="cart.corbeille"/></a>
														<input type="hidden" name="skuIdLine" value="${item.articleId}"/>
													</div>
													<c:if test="${emballageCadeauActif==true && cart.mapLineAttribut[item.articleId].emballage=='Non'}">
														<div class="message">
															<span class="error"><spring:message code="cart.emballageNonDisponile"/></span>
														</div>
													</c:if>
													<c:if test="${cart.mapLineAttribut[item.articleId].encombrant=='Oui'}">
														<div class="message">
															<span class="error"><spring:message code="cart.articleEncombrant"/></span>
														</div>
													</c:if>
													
												</div>
											</c:forEach>
										</div>
										</div>
									</c:if>
									</c:forEach>
									<c:forEach items="${rougierCart.groupedCartLine}" var="group" varStatus="status2">
										<c:if test="${fn:length(group.cartLines)==1 }">
											<c:forEach items="${group.cartLines}" var="item" varStatus="status">
												<c:if test="${item.articleId!=emballage.catalogEntryId  }">
													<div class="cartLines">
															<div class="images">
																<c:set var="urlEc">											
																	<fwk:rewrite url="/catalogEntry.html?langId=${rougierCart.langId}&ceId=${group.product_id}"  />
																</c:set>												
																<a href="${urlEc}" title="${group.libelle}"><img src="/phproduct/${group.image}" alt="${group.libelle}" width="88" /></a>										
															</div>
															<div class="description">
									
																	<span class="bold">
																	<a href="${urlEc}" title="${group.libelle}">
																		${item.wordingProduct}<br/></a>
																		<spring:message code="cart.libelle.reference"/>: ${item.articleBiz}
																	</span>
																
																<c:if test="${not empty item.discriminant1 }">
																	<span class="gris">${item.discriminant1} : ${item.discriminant1Value}</span>
																</c:if>
																<c:if test="${not empty item.discriminant2 }">
																	<span class="gris">${item.discriminant2} : ${item.discriminant2Value}</span>
																</c:if>
																
															</div>
															<div class="prix_unitaire">
																<span class="barre"><fmt:formatNumber value="${item.basePrice}" currencySymbol="${devise}" type="currency"/></span>
																<span class="black"><fmt:formatNumber value="${item.price}" currencySymbol="${devise}" type="currency"/></span>
																<!--<br /><span class="mini black">dont 12&euro; d'&eacute;co-participation</span>-->
															</div>
															<div class="quantite">
																<div class="selecteur">
																	<img class="bouton_moins" src="${contextPath}/resources/${codeIsoLang}/img/cart/bouton_moins.jpg" width="15" height="15" alt="Bouton moins" />
																	<input name="selectQuantity" value="${item.quantity}"/>
																	<img class="bouton_plus" src="${contextPath}/resources/${codeIsoLang}/img/cart/bouton_plus.jpg" width="15" height="15" alt="Bouton plus" />
																</div>
															</div>
															<div class="prix_total">
																<span class="black bold"><fmt:formatNumber value="${item.price * item.quantity}" currencySymbol="${devise}" type="currency"/></span>
																<!-- <br /><span class="mini black">dont 12&euro; d'&eacute;co-participation</span> -->
															</div>
															<div class="corbeille_in">
																<a href="#" class="corbeille"><spring:message code="cart.corbeille"/></a>
																<input type="hidden" name="skuIdLine" value="${item.articleId}"/>
															</div>
														
														
														<c:if test="${not empty group.quantiteMinimum && group.quantiteMinimum>group.quantity}">
															<div class="message">
																<span class="quantite_minimun">
																<spring:message code="cart.quantiteMinimum"/>${group.quantiteMinimum}
																<c:set var="nonValid">1</c:set>
																</span>
															</div>
														</c:if>
														<c:if test="${cart.emballageCadeauActif==true && cart.mapLineAttribut[item.articleId].emballage=='Non'}">
															<div class="message">
																<span class="error"><spring:message code="cart.emballageNonDisponile"/></span>
															</div>
														</c:if>
<%-- 														<c:if test="${cart.mapLineAttribut[item.articleId].encombrant=='Oui'}"> --%>
<!-- 															<div class="message"> -->
<%-- 																<span class="error"><spring:message code="cart.articleEncombrant"/></span> --%>
<!-- 															</div> -->
<%-- 														</c:if> --%>
														<c:if test="${group.encombrant=='Oui'}">
															<div class="message">
																<span class="error"><spring:message code="cart.articleEventuellementEncombrant"/></span>
															</div>
														</c:if>											
														<c:if test="${articleNonDispo==item.articleId}">
															<div class="message">
																<span class="article_non_disponible">
																	<spring:message code="cart.articlePlusDispo"/>
																</span>
															</div>
														</c:if>
													</div>
												</c:if>
											</c:forEach>
										</c:if>
									
								</c:forEach>
							<!--  ici -->
								<c:forEach items="${cart.cartGiftsLines}" var="giftItem" varStatus="status">
									<c:if test="${giftItem.state != 'DELETED_UNIQUE_AND_FREE'}">
									<div class="separation giftLines">
										<div class="images">
											<img src="${contextPath}/resources/${codeIsoLang}/img/tunnel/Produit_cadeau.png" alt="Offert" width="88" />
										</div>
										<div class="description">
											<span class="bold">${giftItem.wordingProduct}</span>
										</div>
										<div class="prix_unitaire">
											<span class="barre">
											<c:set var="giftPrice">
												<c:choose>
													<c:when test="${giftItem.price >= 0.01}">
														<fmt:formatNumber value="${giftItem.price}" currencySymbol="${devise}" type="currency"/>
													</c:when>
													<c:otherwise>
														<spring:message code="receipt.offert"/>
													</c:otherwise>
												</c:choose>
											</c:set>
											</span>
											
											<span class="black">${giftPrice}</span>
										</div>
										<div class="quantite">
											<span class="black bold">1</span>
										</div>
										<div class="prix_total">
											<span class="black bold">${giftPrice}</span>
										</div>
										<div class="corbeille_in">
											<a href="#" class="corbeille"><spring:message code="cart.corbeille"/></a>
											<input type="hidden" name="giftId" value="${giftItem.articleId}_${giftItem.operationId}"/>
										</div>
										
										
									</div>
									</c:if>
								</c:forEach>
								
								<c:if test="${not empty emballage and cart.cartEmballable==true}">
									<div class="emballage_cadeau">	
										<div class="images">
											<img src="${contextPath}/resources/${codeIsoLang}/img/cart/emballage_cadeau.png" width="27" height="28" alt="Emballage" />
											
										</div>
										<form id="emballage" name="emballage" method="GET">
											<div class="bloc_1">
												<c:set var="checkedOrNot">
													<c:if test="${isEmballageCadeauActif==true }">
														checked
													</c:if>
												</c:set>
												<input type="checkbox" id="emballageCheck" name="skuId" value="${emballage.catalogEntryId }" ${checkedOrNot }/>
												<input type="hidden" name="quantityAdd" value="1"/>
												<label><spring:message code="cart.emballage"/></label>
											</div>
											<div class="emballage_tarif">
												<span><fmt:formatNumber value="${emballage.tariffs[0].price }" currencySymbol="${devise}" type="currency"/></span>
											</div>
											<c:if test="${isEmballageCadeauActif==true }">
												<div class="emballage_tarif_total">
													<span class="valeur_totale"><fmt:formatNumber value="${emballage.tariffs[0].price }" currencySymbol="${devise}" type="currency"/></span>
												</div>
											</c:if>
										</form>
										
										<c:if test="${isEmballageCadeauActif==true }">
											<c:if test="${cart.fullEmballage==false}">
											<span class="error"><spring:message code="cart.emballagePartiel"/></span>
												
											</c:if>
											<textarea id="messageCadeau" name="message" onKeyUp="limitMessageGift(${messageCadeauSize })" onKeyPress="limitMessageGift(${messageCadeauSize})">${cart.message }</textarea>
											<a class="papier_cadeau" href="#">Voir le papier cadeau</a>
											<span class="error right" id="error_msg_kdo"></span>
										</c:if>
										<br/>
									</div>
								</c:if>
								
								<div class="total">
								
									<div class="sous_total">
										<div class="intitule">
											<span class="bold"><spring:message code="cart.sousTotal"/></span>
										</div>
										<div class="valeur">
											<span class="bold" ><fmt:formatNumber value="${cart.subTotal}" currencySymbol="${devise}" type="currency"/></span>
										</div>
									</div>
									
									<div class="sous_total">
										<div class="intitule">
											<span class="bold"><spring:message code="cart.estimationFDP"/></span>
											<span class="modeLiv">* sur la base d'une livraison ${cart.wordingServiceTransport }</span>
										</div>
										<div class="valeur">
											<span class="bold" ><fmt:formatNumber value="${cart.shippingFee.fee - cart.shippingFee.sumOfDiscount}" currencySymbol="${devise}" type="currency"/></span>
										</div>
									</div>
									
									<c:forEach items="${cart.promoCoupon}" var="promo">
										<div class="promo_coupon">
											<div class="intitule">
												<span class="bold"><a href="cart.html?couponCodeDelete=${promo.value.code}" class="bt_annuler">Supprimer</a>${promo.value.message}</span>
											</div>
 											<c:if test="${promo.value.montant > 0 }"> 
 												<div class="valeur">
													<span class="bold"><fmt:formatNumber value="${promo.value.montant}" currencySymbol="${devise}" type="currency"/></span>
 												</div> 
											</c:if> 
										</div>
									</c:forEach>
									
									<c:forEach items="${cart.promoCommande}" var="promo">
										<div class="promo_commande">
											<div class="intitule">
												<span class="bold">${promo.value.message}</span>
											</div>
											<div class="valeur">
												<span class="bold"><fmt:formatNumber value="${promo.value.montant}" currencySymbol="${devise}" type="currency"/></span>
											</div>
										</div>
									</c:forEach>
									
									
									<c:forEach items="${cart.promoLigne}" var="promo">
										<div class="promo_ligne">
											<div class="intitule">
												<span class="bold">${promo.value.message}</span>
											</div>
											<div class="valeur">
												<span class="bold"><fmt:formatNumber value="${promo.value.montant}" currencySymbol="${devise}" type="currency"/></span>
											</div>
										</div>
									</c:forEach>
									
								
									
									<c:choose>
										<%-- <c:when test="${not empty cart.coupons }">
											<div class="coupons"></div>
										</c:when> --%>
										<c:when test="${empty cart.coupons or(fn:length(cart.coupons)==1 and isCouponServiceClient)}">
											<div class="coupons">
												<form method="post" id="couponForm" action="cart.html">
												<div class="intitule">
													<input id="valide_coupons" type="submit"  value="Valider">
													<input type="text" name="couponCode" id="codes" value="" />
													<label for="codes"><spring:message code="cart.mesCodesPromo"/></label>												
													<!-- <input type="image" src="${contextPath}/resources/${codeIsoLang}/img/common/searchOk.png" value="ok"> -->
													
												</div>
												<div class="valeur">
	
												</div>
													<div class="erreur">${messageCoupon}</div>
												</form>
											</div>
										</c:when>
									</c:choose>
									<div class="total_commande">
										<div class="intitule">
											<span class="bold"><spring:message code="cart.totalCommande"/></span>
										</div>
										<div class="valeur">
											<span class="bold"><fmt:formatNumber value="${cart.subTotal - cart.sumOfCartDiscount - cart.sumOfItemDiscount +cart.shippingFee.fee - cart.shippingFee.sumOfDiscount}" currencySymbol="${devise}" type="currency"/></span>
										</div>
									</div>
									<c:if test="${remiseLigne > 0.00 || remiseCommande > 0.00 || cart.shippingFee.sumOfDiscount > 0.00 }">
										<div class="economies">
											<div>
												<span class="label">Vous économisez</span><span class="montant"><fmt:formatNumber value="${remiseCommande + remiseLigne + cart.shippingFee.sumOfDiscount}" currencySymbol="${devise}" type="currency"/></span>
											</div>
											<c:if test="${remiseLigne > 0.00 }">
												<div class="details">Dont <fmt:formatNumber value="${remiseLigne}" currencySymbol="${devise}" type="currency"/> prix promo</div>
											</c:if>
											<c:if test="${remiseCommande > 0.00 }">
												<div class="details">Dont <fmt:formatNumber value="${remiseCommande}" currencySymbol="${devise}" type="currency"/> remises panier</div>
											</c:if>
											<c:if test="${cart.shippingFee.sumOfDiscount > 0.00}">
												<div class="details">Dont <fmt:formatNumber value="${cart.shippingFee.sumOfDiscount}" currencySymbol="${devise}" type="currency"/> remises frais de port</div>
											</c:if>
										</div>
									</c:if>
								</div>
								<!-- Boutons -->	
									<div class="floatRight zonebas">
										<c:choose>
											<c:when test="${nonValid==1 }">
												<span class="error"> 
													<spring:message code="cart.invalid"/>
												</span>
											</c:when>
											<c:otherwise>
												<div class="conditions_cgv">
													<input type="checkbox" id="cgv" name="cgv" />
													<label for="cgv">J'accepte les <a href="/cgv.r.html" class="lien_noir" onclick="window.open(this.href); return false;"><u>Conditions Générales de Vente</u></a></label>
													<span class="error right" id="error_cgv"></span>
												</div>
												<c:choose>
													<c:when test="${empty customer}">
														<a class="identification" href="#"><spring:message code="cart.boutonMidentifie"/></a>
													</c:when>
													<c:when test="${customer.blackListed }">
														<spring:message code="cart.customer.blacklisted"/>
													</c:when>
													<c:otherwise>
														<a href="#" class="bt_suivant"><spring:message code="cart.boutonChoisisLivraison"/></a>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</div>
								
									</c:when>
									<c:otherwise><div class="ligne"><spring:message code="cart.aucunArticle"/></div></c:otherwise>
								</c:choose>
							
						</div>
					</div>
				<div class="ems_mot">${animationBody }</div>
				
				
			</div>


			<div class="colonne_gauche">
				<div class="poursuivre">
					<a href="${cart.originalUrl}">Poursuivre mes achats</a>
				</div>
			
				<c:import url="pushProduitPanier.jsp"></c:import>
			</div>
		
			</div>
		</div>
</tiles:putAttribute>
	
<tiles:putAttribute name="moreJS">
	<script src="${contextPath}/resources-mobile/js/merchandising/catalogEntry.js" type="text/javascript"></script>
	<script src="${contextPath}/resources-mobile/js/cart/cart.js" type="text/javascript"></script><script type="text/javascript">
			$(document).ready(function(){
				var messageCadeauSize = '${messageCadeauSize}';
				limitMessageGift(messageCadeauSize);
				
				var messageUpdate = "${messageUpdate}";
				if(messageUpdate != '' && messageUpdate != null){
					showModalUpdateQuantityImpossible(messageUpdate);
				}
			});
		</script>
		<c:if test="${isTagMetafiliationActivated }">
			<script type="text/javascript" src="http://img.metaffiliation.com/u/11/p33385.js?zone=panier&montant=${cart.subTotal - cart.sumOfCartDiscount - cart.sumOfItemDiscount}&listeids=<c:forEach items="${rougierCart.groupedCartLine}" var="group" varStatus="status2"><c:if test="${status2.index >= 1 }">,</c:if><c:forEach items="${group.cartLines}" var="item" varStatus="status"><c:if test="${status.index >= 1 }">,</c:if>${item.articleBiz }</c:forEach></c:forEach>"></script>
		</c:if>
</tiles:putAttribute>
</tiles:insertDefinition>
