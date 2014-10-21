<%@ page trimDirectiveWhitespaces="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.pictime.com/tags/core"  prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!-- BANDE ORANGE -->
<c:if test="${(context.instanceType) == 'STORE_PREVIEW'}">
	<div id="bandeorange">
		<div class="floatLeft"><spring:message code="header.vousEtes"/>&nbsp;<span class="gras"><spring:message code="header.modePreview"/></span></div>
		<div class="date">
			<spring:message code="header.date"/>&nbsp;<span class="gras"><fmt:formatDate value="${context.date}" pattern="dd/MM/yyyy HH:mm"/></span>
			<c:if test="${((context.instanceType) == 'STORE_PREVIEW') && (context.siteEditMode)}">
				<span style="margin-left: 5px;">
					<a href="/StoreManager/secure/ADM/modifierParametreValeurs.htm?action=editer&parametreId=1" title="modifier la date preview" target="storeManager"><img src="${contextPath}/resources/${codeIsoLang}/img/common/modifyBlack.png" style="border: 0px;"/></a>
				</span>
			</c:if>
		</div>
		<c:set var="activer"><spring:message code="header.activer"/></c:set>
		<c:set var="desactiver"><spring:message code="header.desactiver"/></c:set>
		<div class="floatRight"><a href="#" onclick="onClickSiteEditMod()" class="lien_blanc">${(context.siteEditMode)? desactiver:activer}&nbsp;<spring:message code="header.modeEdition"/></a></div>
	</div>
</c:if>

<!-- Header -->
<div id="header">

	<div class="logo">
		<a href="${contextPath}">
			<div class="image1">
				<img
					src="${contextPath}/resources-mobile/${codeIsoLang}/img/common/logo.png"
					alt="Rougier &amp; Plé – Matériel de Beaux-Arts et Loisirs créatifs"
					border="0" />
			</div>
		</a>
	</div>
	<div class="comptec">
		<a href="${contextPath}/login.html?request=account.html">
			<div class="image2">
				<div class="imgCentreCompte">
					<img
						src="${contextPath}/resources-mobile/${codeIsoLang}/img/common/picto-compte.png"
						alt="Mon compte" border="0" />
				</div>
			</div>
		</a>
	</div>
	<div class="panier">
		<a href="${contextPath}/cart.html">
			<div class="image3">
				<div class="nbArticles"></div>
				<div class="imgCentrePanier">
					<%-- 						<img src="${contextPath}/resources-mobile/${codeIsoLang}/img/common/picto-panier.png"  alt="Mon panier" border="0"/> --%>
				</div>
			</div>
		</a>
	</div>
	<div class="blocRecherche">
		<div class="recherche">
			<c:set var="url">
				<fwk:rewrite url="/search.html?catalogId=2" />
			</c:set>
			<form:form action="${url}" method="get"
				onsubmit="return validsearch(this);">
				<input id="recherche" type="text"
					value="<spring:message code='header.rechercher' />" name="text"
					autocomplete="off" maxlength="255"
					onFocus="if($('#recherche').val() == '<spring:message code='header.rechercher' />'){$('#recherche').val('');}"
					onBlur="if($('#recherche').val().trim() == ''){$('#recherche').val('<spring:message code='header.rechercher' />');}" />
				<input type="submit"
					value="<spring:message code='header.boutonOK' />" />
			</form:form>
		</div>
	</div>

</div>

<div class="container">
<!--   <div class="col-lg-offset-2 col-lg-8"> -->
<div id="carousel" class="carousel slide">
  <ol class="carousel-indicators">
    <li data-target="#carousel" data-slide-to="0" class="active"></li>
    <li data-target="#carousel" data-slide-to="1"></li>
    <li data-target="#carousel" data-slide-to="2"></li>
  </ol>
  <div class="carousel-inner">
    <div class="item active"> <img alt="" src="${contextPath}/bootstrap/img/1.jpg"></div>
    <div class="item"> <img alt="" src="${contextPath}/bootstrap/img/2.jpg"></div>
    <div class="item"> <img alt="" src="${contextPath}/bootstrap/img/3.jpg"></div>
  </div>
</div>
<!--   </div> -->
</div>
<script src="${contextPath}/resources-mobile/js/jquery.js"></script>
<script src="${contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script>
  $(function (){
      $('.carousel').carousel();
  });  
</script>
<br>

<div class="panel-group col-lg-6">
    <div class="panel panel-default">
      <div class="panel-heading"> 
        <h3 class="panel-title">
          <a class="accordion-toggle" href="#item1" data-toggle="collapse">Beaux-Arts</a> 
        </h3>
      </div>
      <div id="item1" class="panel-collapse collapse">
        <div class="panel-body"><a href="/peinture-huile.r.html"style="display:block;width:100%;height:100%;">Peinture à l'huile</a></div>
        <div class="panel-body"><a href="/peinture-acrylique.r.html"style="display:block;width:100%;height:100%;">Peinture Acrylique</a></div>
        <div class="panel-body"><a href="/peinture-aquarelle.r.html"style="display:block;width:100%;height:100%;">Peinture Aquarelle</a></div>
        <div class="panel-body"><a href="/peinture-gouache.r.html"style="display:block;width:100%;height:100%;">Peinture Gouache</a></div>
        <div class="panel-body"><a href="/pastel.r.html"style="display:block;width:100%;height:100%;">Pastel</a></div>
        <div class="panel-body"><a href="/dessin-artistique.r.html"style="display:block;width:100%;height:100%;">Dessin</a></div>
      </div>
    </div>
    <div class="panel panel-default">
      <div class="panel-heading"> 
        <h3 class="panel-title">
          <a class="accordion-toggle" href="#item2" data-toggle="collapse">Arts-Graphiques</a> 
        </h3>
      </div>
      <div id="item2" class="panel-collapse collapse">
        <div class="panel-body"><a href="/dessin-technique.r.html"style="display:block;width:100%;height:100%;">Dessin-technique</a></div>
        <div class="panel-body"><a href="/maquettisme.r.html"style="display:block;width:100%;height:100%;">Maquettisme</a></div>
        <div class="panel-body"><a href="/calligraphie.r.html"style="display:block;width:100%;height:100%;">Calligraphie</a></div>
        <div class="panel-body"><a href="/photographie-infographie.r.html"style="display:block;width:100%;height:100%;">Photographie Graphisme</a></div>
        <div class="panel-body"><a href="/aerographie.r.html"style="display:block;width:100%;height:100%;">Tag, Street Art Aérographie</a></div>
        <div class="panel-body"><a href="/encadrement.r.html"style="display:block;width:100%;height:100%;">Encadrement</a></div>
      </div>
    </div>
    <div class="panel panel-default">
      <div class="panel-heading"> 
        <h3 class="panel-title">
          <a class="accordion-toggle" href="#item3" data-toggle="collapse">Papeterie</a> 
        </h3>
      </div>
      <div id="item3" class="panel-collapse collapse">
		<div class="panel-body"><a href="/papeterie-scolaire-familiale.r.html"style="display:block;width:100%;height:100%;">Papeterie</a></div>
        <div class="panel-body"><a href="/papeterie-creative.r.html"style="display:block;width:100%;height:100%;">Papeterie créative</a></div>
        <div class="panel-body"><a href="/carterie-creative.r.html"style="display:block;width:100%;height:100%;">Correspondance</a></div>
        <div class="panel-body"><a href="/librairie-beaux-arts-loisirs-creatifs.r.html"style="display:block;width:100%;height:100%;">Librairie</a></div>
	  </div>
  </div>
  <div class="panel panel-default">
      <div class="panel-heading"> 
        <h3 class="panel-title">
          <a class="accordion-toggle" href="#item4" data-toggle="collapse">Loisir Créatifs</a> 
        </h3>
      </div>
      <div id="item4" class="panel-collapse collapse">
      	<div class="panel-body"><a href="/customisation-textile-et-objet-perso.r.html"style="display:block;width:100%;height:100%;">Customisation d'objets</a></div>
        <div class="panel-body"><a href="/peinture-deco.r.html"style="display:block;width:100%;height:100%;">Peinture Décorative</a></div>
        <div class="panel-body"><a href="/decopatch.r.html"style="display:block;width:100%;height:100%;">Collage, Décopatch</a></div>
        <div class="panel-body"><a href="/origami-kirigami-quilling-pliage-papier.r.html"style="display:block;width:100%;height:100%;">Origami Kirigami</a></div>
        <div class="panel-body"><a href="/confection-abat-jour.r.html"style="display:block;width:100%;height:100%;">Fabriquer un abat jour</a></div>
        <div class="panel-body"><a href="/art-table-patisserie.r.html"style="display:block;width:100%;height:100%;">Art de la table, Pâtisserie</a></div>
      	<div class="panel-body"><a href="/carterie-creative.r.html"style="display:block;width:100%;height:100%;">Carterie Créative</a></div>
        <div class="panel-body"><a href="/scrapbooking.r.html"style="display:block;width:100%;height:100%;">Scrapbooking</a></div>
        <div class="panel-body"><a href="/couture-mode.r.html"style="display:block;width:100%;height:100%;">Couture, Mode</a></div>
        <div class="panel-body"><a href="/modelage-fimo-pate-modeler-loisir.r.html"style="display:block;width:100%;height:100%;">Modelage Fimo</a></div>
        <div class="panel-body"><a href="/perle-bijou.r.html"style="display:block;width:100%;height:100%;">Perle, Bijou</a></div>
    </div>
  </div>
<div class="panel panel-default">
      <div class="panel-heading"> 
        <h3 class="panel-title">
          <a class="accordion-toggle" href="#item5" data-toggle="collapse">Artisanat d'art</a> 
        </h3>
      </div>
      <div id="item5" class="panel-collapse collapse">
        <div class="panel-body"><a href="/pyrogravure.r.html"style="display:block;width:100%;height:100%;">Pyrogravure</a></div>
        <div class="panel-body"><a href="/reliure.r.html"style="display:block;width:100%;height:100%;">Reliure</a></div>
        <div class="panel-body"><a href="/moulage.r.html"style="display:block;width:100%;height:100%;">Moulage</a></div>
        <div class="panel-body"><a href="/modelage.r.html"style="display:block;width:100%;height:100%;">Modelage</a></div>
        <div class="panel-body"><a href="/linogravure.r.html"style="display:block;width:100%;height:100%;">Linogravure</a></div>
      </div>
    </div> <div class="panel panel-default">
      <div class="panel-heading"> 
        <h3 class="panel-title">
          <a class="accordion-toggle" href="#item6" data-toggle="collapse">Enfant</a> 
        </h3>
      </div>
      <div id="item6" class="panel-collapse collapse">
        <div class="panel-body"><a href="/dessin-coloriage.r.html"style="display:block;width:100%;height:100%;">Coloriage, Dessin</a></div>
        <div class="panel-body"><a href="/decoupage-pliage-gomette.r.html"style="display:block;width:100%;height:100%;">Découpage, Pliage, Collage</a></div>
        <div class="panel-body"><a href="/peinture-pochoirs-tampons.r.html"style="display:block;width:100%;height:100%;">Peinture, Pochoirs, Tampons</a></div>
        <div class="panel-body"><a href="/modelage-pate-modeler.r.html"style="display:block;width:100%;height:100%;">Pâte à modeler, Pâte à sel</a></div>
        <div class="panel-body"><a href="/matieres-feutrine-sable.r.html"style="display:block;width:100%;height:100%;">Matieres, Feutrine, Sable</a></div>
        <div class="panel-body"><a href="/fetes-maquillage.r.html"style="display:block;width:100%;height:100%;">Jeu de fête, Maquillage</a></div>
      	<div class="panel-body"><a href="maquettes-experiences-scientifiques.r.html"style="display:block;width:100%;height:100%;">Jeu éducatif, Construction</a></div>
        <div class="panel-body"><a href="/bijoux-perles.r.html"style="display:block;width:100%;height:100%;">Bijoux, Perles</a></div>
        <div class="panel-body"><a href="/customisation-de-poupees.r.html"style="display:block;width:100%;height:100%;">Customisation poupée</a></div>
        <div class="panel-body"><a href="/livres-jeunesse.r.html"style="display:block;width:100%;height:100%;">Livre jeunesse</a></div>
        <div class="panel-body"><a href="/coffrets-eveil-creatif.r.html"style="display:block;width:100%;height:100%;">Coffret jeunesse</a></div>
      </div>
    </div> <div class="panel panel-default">
      <div class="panel-heading"> 
        <h3 class="panel-title">
          <a class="accordion-toggle" href="/event" data-toggle="collapse">Evenement</a> 
        </h3>
    </div>
</div>
 
<!-- Test si la session est vide, alors on déconnecte le client (hormis le cas ou le paiement a été annulé) -->
<c:if test="${sessionScope.cart == null && orderId == null}">

	<script type="text/javascript">
		if(existsCookie("RougierAuthentificationCookie")){	
			updateAuthentificationCookieStatus("false");			
		}
	</script>
</c:if>

<!-- Fin Popin Newsletter -->