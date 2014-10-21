$(document).ready(function() {
	
	// On met à jour le cookie de persistence
	// 03-04-2012 - modification - updateCookieExpiration("persist");

	
	// Si il existe un cookie de panier et qu'il est n'est pas vide
	if(existsCookie("cart") && !isEmptyCookie("cart"))
	{
		$("#header .panier").toggleClass("on",true);
		$("#header .panier .nbArticles").text(getCartCookieInformation("cart","nb"));
		$("#header .panier .infos .total").text(getCartCookieInformation("cart","m")+" €");
	}	
	else {
		$("#header .panier").toggleClass("on",false);
		$("#header .panier .nbArticles").text("0");
		$("#header .panier .infos .total").text("0 €");
	}
	
	// Si il existe un cookie d'authentification et qu'il n'est pas vide
//	if(existsCookie("RougierAuthentificationCookie") && !isEmptyCookie("RougierAuthentificationCookie")) {	 
		// On met à jour le cookie d'authentification
		// 03-04-2012 - modification - updateCookieExpiration("RougierAuthentificationCookie");
		
		// Si le client est authentifié, on affiche ses infos personnelles et un clic de déconnection
		if(isCustomerAuthentificated() == "true") {
			displayInfosCustomer('<a href="'+contextPath+'/login.html?logout">'+$.i18n._("MSG_HEADER_DECONNECTION")+'</a>');
			$(".comptec").children(".content").attr("onclick",'window.location=\''+contextPath+'/login.html?logout\'');
		} // Sinon, on affiche juste son nom et prénom
		else {
			displayInfosCustomer('');
		}
//	}	
//	else {
//		// Sinon si le client n'est pas du tout authentifié mais qu'on a des informations sur lui, on les affiche
//		displayInfosCustomer('');
//	}
	
	// Affichage du menu
	renderMenu();
	
});

function displayInfosCustomer(ext) {
		if(existsCookie("RougierCustomerCookie") && !isEmptyCookie("RougierCustomerCookie")) {
			$("#header .compte").html(function() {
				return $.i18n._("MSG_HEADER_BONJOUR")+'&nbsp;'+ getCustomerCookieInformation("RougierCustomerCookie", "fi")+'&nbsp;'+ getCustomerCookieInformation("RougierCustomerCookie", "la");
			});
			if(ext == ''){
				$("#header #urlcompte").html('<a href="'+contextPath+'/login.html?request=account.html">'+$.i18n._("MSG_HEADER_CONNECTION")+'</a>');
			}else{
				$("#header #urlcompte").html(ext);
			}
			$("#header .compte").show();
		} else {
			$("#header .compte").html(function() {
				return null;
			});
		}
}

/**
 * Retrouver les informations du cookie à propos du panier
 * @param name: nom du cookie
 * @param flag: nom du tag
 * @returns valeur du flag
 */
function getCartCookieInformation(name,flag) {
	if(document.cookie.length != 0) {
		var cookies = document.cookie.split('; ');
		for(var i = 0; i < cookies.length; i++){
			var cookie = cookies[i].split('="');
			if(cookie[0] == name) {
				var formattage = cookie[1].substr(0,cookie[1].length-1);
				var valeurs = formattage.split('|');
				for(var j = 0; j<valeurs.length; j++) {
					var couple = valeurs[j].split('=');
					if(couple[0] == flag)
						return couple[1];
				}
			}
		}
	}
	return null;
}

/**
 * Retrouver les informations du cookie à propos du client
 * @param name: nom du cookie
 * @param flag: nom du tag (la:lastname, fi:firstname, cid: customerId)
 * @returns valeur du flag
 */
function getCustomerCookieInformation(name,flag) {
	if(document.cookie.length != 0) {
		var cookies = document.cookie.split('; ');
		
		for(var i = 0; i < cookies.length; i++){
			var cookie = cookies[i].split('=');
			if(cookie[0] == name) {
				var valeurs = cookie[1];
				var decodage = decodeURIComponent(valeurs);
				var valeur = decodage.split(':');
							
				if(flag == "la")
					return valeur[2].replace("+"," ");
				else if(flag == "lanId")
					return valeur[4];
				else if(flag == "shId")
					return valeur[3];
				else if(flag == "fi")
					return valeur[1].replace("+"," ");
				else if(flag == "cId")
					return valeur[0];
			}
		}
	}
	return null;
}

/**
 * Retrouver les informations du cookie d'authentification
 * @param name: nom du cookie
 * @param flag: nom du tag (cid: customerId, auth: authentification)
 * @returns valeur du flag
 */
function getAuthentificationCookieInformation(name,flag) {
	if(document.cookie.length != 0) {
		var cookies = document.cookie.split('; ');

		for(var i = 0; i < cookies.length; i++){
			var cookie = cookies[i].split('=');
			if(cookie[0] == name) {
				var valeurs = cookie[1];
				var decodage = decodeURIComponent(valeurs);
				var valeur = decodage.split(':');
				if(flag == "cId") {
					return valeur[0];
				}
				else if(flag == "auth") {
					return valeur[1];
				}
			}
		}
	}
	return null;
}

/**
 * Analyse le cookie d'authentification pour connaitre le statut de connexion de l'utilisateur
 * @returns true si le client est connecté, false sinon
 */
function isCustomerAuthentificated() {	
	var response = getAuthentificationCookieInformation("RougierAuthentificationCookie", "auth");
	var responseCustomer = getCustomerCookieInformation("RougierCustomerCookie", "cId");
	// Perte du cookie d'authentification, mais est-il connecté ?
	if(response != "true" || responseCustomer == null) {
		// Vérifier le customer de session;
		$.ajax({ 
			url: contextPath + "/ajax/cookieControl.html", 
			cache : false,
			async: false,
			success: function(connect){
				response = ""+connect;
				if(connect == true) {
					// S'il est connecté, on lui remet un cookie d'auth
					updateAuthentificationCookieStatus("true");
				}
			}
		});
	 }
	 return response;	
}

/**
 * Analyse si un cookie d'authentification existe
 * @returns true si un cookie d'authentification existe, false sinon
 */
function existsCookie(name) {	
	var retour = false;
	
	if(document.cookie.length != 0) {
		var cookies = document.cookie.split('; ');
		for(var i = 0; i < cookies.length; i++){
			var cookie = cookies[i].split('=');
			if(cookie[0] == name)
			{
				retour = true;
				break;
			}
		}
	}	
	return retour;		
}

/**
 * Analyse si un cookie n'est pas vide
 * @returns true si un cookie d'authentification existe, false sinon
 */
function isEmptyCookie(name) {	
	var retour = true;
	
	if(document.cookie.length != 0) {
		var cookies = document.cookie.split('; ');
		for(var i = 0; i < cookies.length; i++){
			var cookie = cookies[i].split('=');
			if(cookie[0] == name && (cookie[1] != '""' && cookie[1] != "" && cookie[1] != null)) {
				retour = false;
				break;
			}
		}
	}	
		
	return retour;		
}

/**
 * Retrouver les variables d'un cookie
 * @returns les valeurs
 */
function getCookieValue(name) {
	
	var valeurs;
	
	if(document.cookie.length == 0)
		valeurs = null;

	var cookies = document.cookie.split('; ');
	
	for(var i = 0; i < cookies.length; i++){
		var cookie = cookies[i].split('=');
		if(cookie[0] == name) {
			valeurs = cookie[1];
		}
	}
	
	return valeurs;
}

/**
 * Retrouver les variables du cookie de cart
 * @returns les valeurs
 */
function getCartCookieValue(name) {
	
	var valeurs;
	
	if(document.cookie.length == 0)
		valeurs = null;

	var cookies = document.cookie.split('; ');
	
	for(var i = 0; i < cookies.length; i++){
		var cookie = cookies[i].split('="');
		if(cookie[0] == name) {
			valeurs = cookie[1];
		}
	}
	
	return valeurs;
}

/**
 * Modification du prénom et/ou du nom du customer
 */
function updateCustomerCookie(firstname, lastname) {
	var cookie = getCookieValue("RougierCustomerCookie");
	var decodage = decodeURIComponent(cookie);
	var valeur = decodage.split(':');
	//TODO
	valeur[1] = firstname;
	valeur[2] = lastname;
	var nouveauCookie = valeur[0]+encodeURIComponent(":")+valeur[1]+encodeURIComponent(":")+valeur[2]+encodeURIComponent(":")+valeur[3]+encodeURIComponent(":")+valeur[4];
	// set time, it's in milliseconds
	var expiration = new Date();
	expiration.setTime(expiration.getTime() + (1000 * 3600 * 24 * 30));
	document.cookie = "RougierCustomerCookie"+"="+nouveauCookie+";path=/;expires="+expiration.toGMTString();
}


/**
 * Ajouter 15 minutes de validité au cookie
 */
function updateAuthentificationCookieStatus(connected) {

	var cookie = getCookieValue("RougierAuthentificationCookie");
	var decodage = decodeURIComponent(cookie);
	var valeur = decodage.split(':');
	valeur[1] = connected;
	var nouveauCookie = valeur[0]+encodeURIComponent(":")+valeur[1];

	document.cookie = "RougierAuthentificationCookie"+"="+nouveauCookie+";path=/";
}

/**
 * Supprimer un cookie
 */
function deleteCookie(cookiename)
{
    var d = new Date();
    d.setDate(d.getDate() - 1);
    var expires = ";expires="+d;
    var name=cookiename;
    var value="";
    document.cookie = name + "=" + value + expires + "; path=/";                    
}

/**
 * Ajouter 15 minutes de validité au cookie
 */
function updateCookieExpiration(name) {

	// set time, it's in milliseconds
	var expiration = new Date();
	expiration.setTime(expiration.getTime() + (15 * 60 * 1000));

	document.cookie = name+"="+getCookieValue(name)+";path=/;expires="+expiration.toGMTString();
}

/**
 * Affichage du menu
 */
function renderMenu()
{
	var shopDefaultId = getCustomerCookieInformation("RougierCustomerCookie","shId");
	var langId = getCustomerCookieInformation("RougierCustomerCookie","lanId");
	
	if(isCustomerAuthentificated() == "true")
		$("#headerWishList").html(function() {
			return '<a href="'+contextPath+'/wishList.html">'+$.i18n._("MSG_HEADER_MA_WISHLIST")+'</a>';
		});
	
	else
		$("#headerWishList").remove();
	
	
	if(isCustomerAuthentificated() == "true" && (shopDefaultId != "null" && shopDefaultId != null && shopDefaultId !="") && (langId != "null" && langId != null && langId !=""))
	{
		var shopUrlRewrited = '<a href="'+contextPath+'/shop.html?shopId='+shopDefaultId+'"&langId='+langId+'">'+$.i18n._("MSG_HEADER_MON_MAGASIN")+'</a>';
		$.ajax({
			type: "POST",
			url: contextPath+"/ajax/getUrlRewrited.html",
			data : {
				url : '/shop.html?shopId='+shopDefaultId+'&langId='+langId
			},
			cache : false,
			async: false,
			success : function(urlRewrited) {
				shopUrlRewrited = '<a href="'+urlRewrited+'">'+$.i18n._("MSG_HEADER_MON_MAGASIN")+'</a>';
			}
		});
		$("#headerShop").html(function() {
			return shopUrlRewrited;
		});
	}
	
	else
	{
		$("#headerShop").html(function() {
			  return '<a href="/magasins.r.html">'+$.i18n._("MSG_HEADER_LES_MAGASINS")+'</a>';
		});
	}
}