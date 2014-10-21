<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<script src="/VAD/resources/js/merchandising/visio_ficheproduit.js" type="text/javascript"></script>

<c:if test="${facetResult.numFound > 1}">
	<div class="onglets">
		<ul class="titre">
			<li class="on"><h2>Dans la même catégorie</h2></li>
		</ul>
	</div>
	<div id="visio">
		<div class="prev"><img width="6" height="9" border="0" alt="" src="/VAD/resources/fr_FR/img/merchandising/prev_fiche_produit.png"></div>
		<div class="scroll">
			<div class="content">
							
				<c:set var="count">1</c:set>
				<c:forEach items="${facetResult.docs}" var="article" varStatus="boucle">
					<c:set var="itemClass">item<c:if test="${count >= facetResult.numFound }"> original</c:if></c:set>
					<c:if test="${article.attr['id']!= ceId}">
						<div class="${itemClass}">
					        <c:set var="urlRewriteSelling">
					            <fwk:rewrite url="/catalogEntry.html?langId=${langId}&ceId=${article.attr['id']}" />
					        </c:set>
							<a href="${urlRewriteSelling}">
								<img width="88" height="88" border="0" alt="" src="/phproduct/${article.attr['img_vignette']}">
								<div class="car_description">${article.attr['title']}</div>						
								<c:if test="${not empty article.attr['basePrice'] && article.attr['price'] != article.attr['basePrice']}">
								   	<span class="prix_barre"><fwk:priceFormater price="${article.attr['basePrice']}" format="$1,$2€" showDecimalPartIfZero="true"/></span>
								</c:if>
								<span class="prix"><fwk:priceFormater price="${article.attr['price']}" format="$1,$2€" showDecimalPartIfZero="true"/></span>
							</a>
						</div>
					</c:if>
					<c:set var="count">${count+1}</c:set>
				</c:forEach>
				
			</div>
			
		</div>
		<div class="next"><img width="6" height="9" border="0" alt="" src="/VAD/resources/fr_FR/img/merchandising/next_fiche_produit.png"></div>
	</div>
</c:if>