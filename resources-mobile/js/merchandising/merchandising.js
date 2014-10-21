/*******************************************

JS du Lot Merchandising

Auteur : Hervé FRACKOWIAK
Date : 30/11/2010
Version : 1.00

*******************************************/


// Fonctions s'executant au chargement de la page
$(document).ready(function(){
	//Initialisation partie zVisu (visuel,zoom,mini)
	init_zVisu('.zVisu .visuel', '.zVisu ul li img')
	
	//Init Onglets produits
	init_onglets('.zInfos .onglets');
	init_onglets('.zAvis');
	init_onglets('.zCross');
	
	
	//Initialisation des couleurs
	init_colors('.catalogEntry .colorFilter','.catalogEntry .colorList')
	
	//Initialisation preview
	init_preview('.catalogEntry .colorList .color .preview');
	
	// Clic sur la photo
	$('.zVisu .visuel > img').click(function(e){
		Box.open({
			modal: true,
			relative: true,
			url: contextPath+"/zoom.html",
			urldata: "url="+picturePath+"/"+tabPictureZoom[$('.zVisu .visuel > img').data("index")]
		});
		return false;
	});
	
	// Clic sur le zoom
	$('.zVisu .visuel .zoom').click(function(e){
		Box.open({
			modal: true,
			relative: true,
			url: contextPath+"/zoom.html",
			urldata: "url="+picturePath+"/"+tabPictureZoom[$('.zVisu .visuel > img').data("index")]
		});
		return false;
	});
	// chargement des urls des images zoom correspondant a l'entree catalogue
	chargeImagesZoom(ceId, catalogId);
});

//Gestion de la preview des couleurs
function init_preview(list) {
      if(isExist($(list))) {
            //Gestion au survol
            $(list).hover(
                  function(){
                        // Impossible d'utiliser le jquery .attr car sous IE7, l'url du background est retournée en minuscule
                        var picto = this.getAttribute("style");

                        // getAttribute retourne un object sous IE7 et une String sur tous les autres navigateurs, on corrige donc le type
                        if(typeof picto == 'object') picto = picto.cssText;
                        picto = picto.replace("_PICTO","_PICTO_GRAND");
                        
                        // Sous IE9, le replace echappe les quotes, on les retire
                        picto = picto.replace(/\\/g,'');
                        
                        $("body").append("<div id='preview_color' style='"+picto+"'></div>");
                        $(this).bind("mousemove",function(e){$("#preview_color").css({"left":e.pageX+20,"top":e.pageY+20,"display":"block"});});
                  },
                  function(){
                        $(this).unbind("mousemove");
                        $("#preview_color").remove();
                  }
            );
      }
}

//Gestion du nuancier
function init_colors(filter, list) {
	if(isExist($(filter))) {
		//On associe les valeurs à l'input
		$(filter+" input").each(function(){
			$(this).data("color",$(this).val().split(';'));
		});
		
		//On masque l'ajout à la wishlist
		$(".catalogEntry .zInfos .infos .zPrix .addList, .catalogEntry .colorTotal .addList").hide();
	
		//Au click on va rafraichir la liste
		$(filter+" input").click(function(){
			var pdb = false;
			var pdbOnly = false;
			
			//Condition spécifique pour allColor
			if($(this).attr("name")=="allColor") {
				if($(this).is(":checked")) {
					$(filter+" input").prop("checked",true);
					$(filter+" input[name='paletteBase']").prop("checked",false);
				}
				else {
					$(filter+" input").prop("checked",false);
				}
			}
			
			//Condition spécifique pour Palette de base
			if($(filter+" input[name='paletteBase']").is(":checked")) {
				pdb = true;
				//On teste si il est seul
				if($(filter+" input:checked").length < 2) {
					pdbOnly = true;
				}
			}
			
			//On masque tout
			$(list+" .color").hide();
			
			//On parcours tous les checked si il n'y a pas que palette de base
			if(pdbOnly) {
				$.each($(filter+" input[name='paletteBase']").data("color"),function(ipdb, valuepdb){
						$(list+" .color .colorCode[value='"+valuepdb+"']").parent(".color").show();
				});
			}
			else {
				$(filter+" input:checked").not("[name='paletteBase']").each(function(){					
					//On affiche
					$.each($(this).data("color"), function(index, value){
						//Si palette de base alors on refiltre
						if(pdb) {
							$.each($(filter+" input[name='paletteBase']").data("color"),function(ipdb, valuepdb){
								if(value == valuepdb) {
									$(list+" .color .colorCode[value='"+value+"']").parent(".color").show();
								}
							});
						}
						//Si non on affiche tout
						else {
							$(list+" .color .colorCode[value='"+value+"']").parent(".color").show();
						}
					})
				});
			}
			
			//Permet de cocher ou décocher allColor, si on coche ou décoche (plusieurs/toutes ?) les couleurs
			var allColor = true;
			$(filter+" [name='baseColor']").each(function(){
				if(!$(this).is(":checked")) {
					allColor = false;
				}
			});
			$(filter+" input[name='allColor']").prop("checked", allColor);
			
			// Cas par défaut avec aucune coche
			var noCoche = true;
			$("input#color").each(function(){
				if($(this).is(":checked")) {
					noCoche = false;
				}
			});
			if(noCoche && !pdb) {
				$.each($(".color"), function(){
					$(this).show();
				});
			}
		});
	}
}

function init_onglets(selection) {
	if(isExist($(selection))) {
		//On masque les li sauf les premiers
		$(selection+" .contenu > li:gt(0)").hide();
		$(selection+" .titre > li:eq(0)").addClass("on");
		
		//On impregne la taille de description pour éviter les effets d'accordéon
		$(selection+" .contenu").css("min-height",$(selection+" .contenu").height());
		
		//Gestion du click
		$(selection+" .titre > li").click(function(){
			//Si on ne reclicke pas sur le même
			if(!$(this).hasClass("on"))
			{
				$(selection+" .titre > li.on").removeClass("on");
				$(this).addClass("on");
				
				$(selection+" .contenu > li:visible").hide();
				$(selection+" .contenu > li:eq("+$(this).index()+")").slideDown(400);
			}
		})
		
		if($(selection+" .contenu .avis > #realisationStickers").val() == "TRUE") {
			$(selection+" .titre > li:eq(1)").click();
		}
	}
}

//Gestion de la zone zVisu
function init_zVisu(visuel, mini)
{
	//Vue 360 ?
	if(isExist($(visuel+" .spritespin")))
	{
		//On masque stickers + zoom // On charge la valeur de zoom
		$(visuel+" .zoom,"+visuel+" > img").hide();
		$(visuel+" > img").data("index",-1);
		load360();
	}
	else
	{
		//Chargement de la valeur de zoom
		$(visuel+" > img").data("index",0);
	}
	
	//On va associé le click au miniature
	$(mini).click(function(){
		pictureChange($(this).parent().index(), picturePath, visuel,$(this).attr("class"));
	});
}

//Changement d'images
function pictureChange(imageIndex, path, visuel, option){
	//Vue 360 ?
	if(option=="v360")
	{
		//On est déjà dessus ?
		if(!$(visuel+" .spritespin").is(":visible"))
		{
			$(visuel+" .zoom,"+visuel+" > img").hide();
			//$(visuel+ " .stickers ,"+visuel+" .zoom,"+visuel+" > img").hide();
			$(visuel+" .spritespin").show();
		}
	}
	else
	{
		//Vidéos ?
		if(option!="vVideo")
		{
			$(visuel+" .spritespin").hide();
			$(visuel+" .zoom,"+visuel+" > img").show();
			//$(visuel+" .stickers ,"+visuel+" .zoom,"+visuel+" > img").show();
			$(visuel+" > img").data("index",imageIndex); //Change l'index de l'image a zoomée
			$(visuel+" > img").attr('src',path+'/'+tabMainPicturePath[imageIndex]);
			$(visuel+" > img").attr('alt',tabMainPictureAlternate[imageIndex]);
		}
	}
}

//Chargement de la vue 360
function load360()
{
	$(".spritespin").spritespin({
	    width     : 388,
	    height    : 388,
	    frames    : 36,
	    image     : image360
	  });
}

var nbImageZoom = 0;
var imageCourante = 0;
var erreur = 0;
function chargeImagesZoom(ceId, catalogId) {
	$.ajax( {
		type : "POST",
		url:contextPath+"/catalogEntry.html",
		data : {"action": "getImageZoomVoisins", "ceId" : ceId, "catalogId" : catalogId},
		dataType : "json",
		cache: false,
		success : function(imgZoomVoisins) {
			nbImageZoom = imgZoomVoisins.length;
			if (nbImageZoom > 1) {
				for (var i = 0; i < nbImageZoom; i++) {
					$('#chargementImagesZoom').append("<p class=\"zoom" + i + "\">/phproduct/" + imgZoomVoisins[i]+"</p>");
				}
			}
		  },
		error : function(){
			erreur = 1;
		}
	});
}

function afficheImageZoomSuivante() {
	var imagesZoom = $(".zoom"+(imageCourante+1)%nbImageZoom).html();
	$('.zoom').attr('src',imagesZoom);
	imageCourante=(imageCourante+1)%nbImageZoom;
}

function afficheImageZoomPrecedente() {
	var imagesZoom = $(".zoom"+(imageCourante-1+nbImageZoom)%nbImageZoom).html();
	$('.zoom').attr('src',imagesZoom);
	imageCourante=(imageCourante-1+nbImageZoom)%nbImageZoom;
}

function determineImageCourante(i) {
	imageCourante = i;
}

function afficherMasquerFleches() {
	if (nbImageZoom <= 1 || erreur == 1) {
		$("#fleche_gauche").hide();
		$("#fleche_droite").hide();
	}
}
function toggle(showHideDiv) {
	var ele = document.getElementById(showHideDiv);
	if (ele.style.display =="block"){
		ele.style.display="none";
	} else {
		ele.style.display="block";
	}
}