<%@ page trimDirectiveWhitespaces="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


<!-- Slider -->

<div class="container">
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
</div>
<script src="${contextPath}/resources-mobile/js/jquery.js"></script>
<script src="${contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script>
  $(function (){
      $('.carousel').carousel();
  });  
</script>
<br>

<!-- Navigation -->

<div class="panel-group col-lg-6">
    <div class="panel panel-default">
      <div class="panel-heading"> 
        <h3 class="panel-title">
          <a class="accordion-toggle" href="#item1" data-toggle="collapse"style="display:block;">Beaux-Arts<img src="${contextPath}/resources-mobile/${codeIsoLang}/img/merchandising/pS_on.png" class="chevron_droit"></a> 
        </h3>
      </div>
      <div id="item1" class="panel-collapse collapse">
        <div class="panel-body"><a href="/peinture-huile.r.html"style="display:block;">Peinture à l'huile</a></div>
        <div class="panel-body"><a href="/peinture-acrylique.r.html"style="display:block;">Peinture Acrylique</a></div>
        <div class="panel-body"><a href="/peinture-aquarelle.r.html"style="display:block;">Peinture Aquarelle</a></div>
        <div class="panel-body"><a href="/peinture-gouache.r.html"style="display:block;">Peinture Gouache</a></div>
        <div class="panel-body"><a href="/pastel.r.html"style="display:block;">Pastel</a></div>
        <div class="panel-body"><a href="/dessin-artistique.r.html"style="display:block;">Dessin</a></div>
      </div>
    </div>
    <div class="panel panel-default">
      <div class="panel-heading"> 
        <h3 class="panel-title">
          <a class="accordion-toggle" href="#item2" data-toggle="collapse"style="display:block;">Arts-Graphiques<img src="${contextPath}/resources-mobile/${codeIsoLang}/img/merchandising/pS_on.png" class="chevron_droit"></a> 
        </h3>
      </div>
      <div id="item2" class="panel-collapse collapse">
        <div class="panel-body"><a href="/dessin-technique.r.html"style="display:block;">Dessin-technique</a></div>
        <div class="panel-body"><a href="/maquettisme.r.html"style="display:block;">Maquettisme</a></div>
        <div class="panel-body"><a href="/calligraphie.r.html"style="display:block;">Calligraphie</a></div>
        <div class="panel-body"><a href="/photographie-infographie.r.html"style="display:block;">Photographie Graphisme</a></div>
        <div class="panel-body"><a href="/aerographie.r.html"style="display:block;">Tag, Street Art Aérographie</a></div>
        <div class="panel-body"><a href="/encadrement.r.html"style="display:block;">Encadrement</a></div>
      </div>
    </div>
    <div class="panel panel-default">
      <div class="panel-heading"> 
        <h3 class="panel-title">
          <a class="accordion-toggle" href="#item3" data-toggle="collapse"style="display:block;">Papeterie<img src="${contextPath}/resources-mobile/${codeIsoLang}/img/merchandising/pS_on.png" class="chevron_droit"></a> 
        </h3>
      </div>
      <div id="item3" class="panel-collapse collapse">
		<div class="panel-body"><a href="/papeterie-scolaire-familiale.r.html"style="display:block;">Papeterie</a></div>
        <div class="panel-body"><a href="/papeterie-creative.r.html"style="display:block;">Papeterie créative</a></div>
        <div class="panel-body"><a href="/carterie-creative.r.html"style="display:block;">Correspondance</a></div>
        <div class="panel-body"><a href="/librairie-beaux-arts-loisirs-creatifs.r.html"style="display:block;">Librairie</a></div>
	  </div>
  </div>
  <div class="panel panel-default">
      <div class="panel-heading"> 
        <h3 class="panel-title">
          <a class="accordion-toggle" href="#item4" data-toggle="collapse"style="display:block;">Loisir Créatifs<img src="${contextPath}/resources-mobile/${codeIsoLang}/img/merchandising/pS_on.png" class="chevron_droit"></a> 
        </h3>
      </div>
      <div id="item4" class="panel-collapse collapse">
      	<div class="panel-body"><a href="/customisation-textile-et-objet-perso.r.html"style="display:block;">Customisation d'objets</a></div>
        <div class="panel-body"><a href="/peinture-deco.r.html"style="display:block;">Peinture Décorative</a></div>
        <div class="panel-body"><a href="/decopatch.r.html"style="display:block;">Collage, Décopatch</a></div>
        <div class="panel-body"><a href="/origami-kirigami-quilling-pliage-papier.r.html"style="display:block;">Origami Kirigami</a></div>
        <div class="panel-body"><a href="/confection-abat-jour.r.html"style="display:block;">Fabriquer un abat jour</a></div>
        <div class="panel-body"><a href="/art-table-patisserie.r.html"style="display:block;">Art de la table, Pâtisserie</a></div>
      	<div class="panel-body"><a href="/carterie-creative.r.html"style="display:block;">Carterie Créative</a></div>
        <div class="panel-body"><a href="/scrapbooking.r.html"style="display:block;">Scrapbooking</a></div>
        <div class="panel-body"><a href="/couture-mode.r.html"style="display:block;">Couture, Mode</a></div>
        <div class="panel-body"><a href="/modelage-fimo-pate-modeler-loisir.r.html"style="display:block;">Modelage Fimo</a></div>
        <div class="panel-body"><a href="/perle-bijou.r.html"style="display:block;">Perle, Bijou</a></div>
    </div>
  </div>
<div class="panel panel-default">
      <div class="panel-heading"> 
        <h3 class="panel-title">
          <a class="accordion-toggle" href="#item5" data-toggle="collapse"style="display:block;">Artisanat d'art<img src="${contextPath}/resources-mobile/${codeIsoLang}/img/merchandising/pS_on.png" class="chevron_droit"></a> 
        </h3>
      </div>
      <div id="item5" class="panel-collapse collapse">
        <div class="panel-body"><a href="/pyrogravure.r.html"style="display:block;">Pyrogravure</a></div>
        <div class="panel-body"><a href="/reliure.r.html"style="display:block;">Reliure</a></div>
        <div class="panel-body"><a href="/moulage.r.html"style="display:block;">Moulage</a></div>
        <div class="panel-body"><a href="/modelage.r.html"style="display:block;">Modelage</a></div>
        <div class="panel-body"><a href="/linogravure.r.html"style="display:block;">Linogravure</a></div>
      </div>
    </div> <div class="panel panel-default">
      <div class="panel-heading"> 
        <h3 class="panel-title">
          <a class="accordion-toggle" href="#item6" data-toggle="collapse"style="display:block;">Enfant<img src="${contextPath}/resources-mobile/${codeIsoLang}/img/merchandising/pS_on.png" class="chevron_droit"></a> 
        </h3>
      </div>
      <div id="item6" class="panel-collapse collapse">
        <div class="panel-body"><a href="/dessin-coloriage.r.html"style="display:block;">Coloriage, Dessin</a></div>
        <div class="panel-body"><a href="/decoupage-pliage-gomette.r.html"style="display:block;">Découpage, Pliage, Collage</a></div>
        <div class="panel-body"><a href="/peinture-pochoirs-tampons.r.html"style="display:block;">Peinture, Pochoirs, Tampons</a></div>
        <div class="panel-body"><a href="/modelage-pate-modeler.r.html"style="display:block;">Pâte à modeler, Pâte à sel</a></div>
        <div class="panel-body"><a href="/matieres-feutrine-sable.r.html"style="display:block;">Matieres, Feutrine, Sable</a></div>
        <div class="panel-body"><a href="/fetes-maquillage.r.html"style="display:block;">Jeu de fête, Maquillage</a></div>
      	<div class="panel-body"><a href="maquettes-experiences-scientifiques.r.html"style="display:block;">Jeu éducatif, Construction</a></div>
        <div class="panel-body"><a href="/bijoux-perles.r.html"style="display:block;">Bijoux, Perles</a></div>
        <div class="panel-body"><a href="/customisation-de-poupees.r.html"style="display:block;">Customisation poupée</a></div>
        <div class="panel-body"><a href="/livres-jeunesse.r.html"style="display:block;">Livre jeunesse</a></div>
        <div class="panel-body"><a href="/coffrets-eveil-creatif.r.html"style="display:block;">Coffret jeunesse</a></div>
      </div>
    </div> <div class="panel panel-default">
      <div class="panel-heading"> 
        <h3 class="panel-title">
          <a class="accordion-toggle" href="/event" data-toggle="collapse"style="display:block;">Evenement</a> 
        </h3>
    </div>
</div>

</div>
 
 