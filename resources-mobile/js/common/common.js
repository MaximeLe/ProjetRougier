/*******************************************

JS des fonctions principales Rougier & Plé

Auteur : Hervé FRACKOWIAK
Date : 08/12/2011
Version : 1.00

*******************************************/


//Fonctions s'executant au chargement de la page
jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + 
                                                $(window).scrollTop()) + "px");
    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + 
                                                $(window).scrollLeft()) + "px");
    return this;
}

function validsearch(){
	if($("#recherche").val() == $.i18n._("header.recherche")){
		return false;
	}
	return true;
}

$(document).ready(function(){
	
	// Taille du conteneur - Dynamique
//	$(window).resize(function() { // si changement de dimension alors que la page est ouverte
//		if( $(window).width() < 1050) {
//			$('#fondsite').css('width', '1000px');	
//		} else {
//			$('#fondsite').css('width', '1090px');	
//		}
//	});
//
//
//	if( $(window).width() < 1050) {
//		$('#fondsite').css('width', '1000px');	
//	}

	
	//Test Modal
	$("#ems .gauche .voirProduit").click(function(){
		Box.open({ url: "/StarterStore/jsp/modal/test.jsp", modal:true});
	});
	
	//Modal panier chiffre peinturluré
	/*$(".nbArticles").click(function(){
		Box.open({ url: "/VAD/cart.html", modal:true});
	});*/
	
	//Recherche
	//init_search("#recherche");
	init_search(".inNewsletter input[type=text]");
	
	loadCart();
	
	init_validator();
	
	// Suppression du cookie reloadable si on est pas sur la page de paiement
	var url = window.location.pathname;
	var pageName = url.substring(url.lastIndexOf('/') +1);
	// Si on est pas sur la page de payment, on supprime le cookie
	if(pageName != "payment.html")
		deleteCookie("reloadable");
	
	$(".moteurRecherche").html($(".recherche .input").html());
	$(".moteurRecherche").each(function(){
		if($(this).attr("srcRep")!=null){
			$(".moteurRecherche form img").attr("src", $(this).attr("srcRep"));
		}
	});
	
});


function loadCart(){

	if($.cookie("persist")==null && $.cookie("cart") != null && $.cookie("cart").indexOf("nb=")!= -1){
		var retrieveCart="";
		var val=($.cookie("cart").split("|")[0]);
		if(val.indexOf("a=")>-1){
			val = val.replace('\"a=', '');
			var lines = val.split(",");
			for(i=0;i<lines.length;i++){
				if(line!=""){
					var line=lines[i].split(":");
					var articleId=line[0];
					var quantity=line[1];
					if(articleId!="" && quantity!=""){
						if(""==retrieveCart){
							retrieveCart = articleId +"="+ quantity;
						}else{
							retrieveCart = retrieveCart + "," + articleId +"="+ quantity;
						}
					}
				}
			}
		}
		Box.open({
			modal: true,
			urldata : "action=addToCartNuanceProduct&source=persistancePanier&nuancesChain="+retrieveCart,
			url : contextPath+"/cart.html",
			cache: false,
			
			afterShow:function(){
				majPanier();				
			}
		});
	}
}

//Verification existant
function isExist(selector)
{
	if($(selector).length>0)
		return true;
	else
		return false;
}

//Retourne une valeur sans px
function returnWPX(value)
{
	var retour = value.split("px");
	return retour[0];
}

// Mode edition
function onClickSiteEditMod()
{	
	$.ajax({
		type: "POST",
		url: contextPath + "/ajax/header.html",
		async: false,
		data: {"action": "changeSiteEditMode"},
		dataType: "script"
	});	
	location.reload(true);
}

//Fonction de recherche
function init_search(selector)
{
	//Verification de l'existant
	if(isExist(selector))
	{
		var searchValue = "";
		
		//Au focus
		$(selector).focus(function(){
			if(!$(this).hasClass("on"))
			{
				searchValue = $(this).val();
				$(this).val("");
				$(this).addClass("on");
			}
		});
		
		//Au blur
		$(selector).blur(function(){
			if($(this).val()=="")
			{
				$(this).removeClass("on");
				$(this).val(searchValue);
			}
		});
	}
}


function formatPrice(price){
	var result = price.toFixed(2)+"";
//	Affiche XX€XX
//	result = result.replace("\.",currency);
//	Affiche XX,XX€
	result = result.replace("\.",",");
	result = result + currency;
	return result;
}

function init_validator(){
	
	jQuery.validator.addMethod("postalcode", function(postalcode, element) {
		return this.optional(element) || postalcode.match(/^[0-9]{4,10}$/i);
	}, $.i18n._("MSG_ZIPCODE_FORMAT"));
	
	jQuery.validator.addMethod('regex', function(value, element, param) {
		    return this.optional(element) || value.match(param);
		},'This value doesn\'t match the acceptable pattern.');
}

function majPanier(){
	/*$.ajax({
		type: "GET",
		url: contextPath + "/header.html",
		dataType: "html",
		async: false,
		cache: false,
		success : function(res) {
			$("#header").html(res);
		}
	});*/
	if(existsCookie("cart") && !isEmptyCookie("cart"))
	{
		$("#header .panier").toggleClass("on",true);
		$("#header .panier .nbArticles a").text(getCartCookieInformation("cart","nb"));
		$("#header .panier .infos .total").text(getCartCookieInformation("cart","m")+" €");
	}
	else
	{
		$("#header .panier").toggleClass("on",false);
		$("#header .panier .nbArticles a").text("0");
		$("#header .panier .infos .total").text("0 €");
	}
}

// Récupérer un paramètre dans une URL
function getURLParameter(name) {
    return decodeURIComponent(
        (location.search.match(RegExp("[?|&]"+name+'=(.+?)(&|$)'))||[,null])[1]
    );
}

