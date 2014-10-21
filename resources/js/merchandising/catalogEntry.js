$(document).ready(function(){
	
	loadRepresentativeBreadcrumb();
	loadRepresentativeFooterSEO();
	
	$("#sendFriend").click(function(){
		openModalSendFriend();
	});
	
	/*Ouverture de la modal de selection de wishList */
	$(".colorTotal .addList").click(function(){
		if ($(".addBasket").html() != null && $(".addBasket").html() != ''){
			Box.open({ 
				url: contextPath+"/ajax/modalAddWishlist.html?add", 
				modal:true,
				success : function(res) {
					Box.maj(res);
				},
				afterShow:function(){
					initCheckBoxOpenAddToWishList();				
				}
			});
		}
	});	
});

function loadRepresentativeBreadcrumb(){
	var categoryId = window.location.hash;
	categoryId = categoryId.replace("#categoryId=", '');
	var catalogId = getURLParameter("catalogId");
	
	if($.isNumeric(categoryId) && $.isNumeric(ceId)){
		$.ajax( {
			type : "GET",
			url : contextPath+"/catalogEntry.html",
			data : {"action": "breadcrumbAjax", "ceId" : ceId, "categoryId" : categoryId},
			cache: false,
			async: false,
			error: function(){
				
			},
			success : function(html) {
				$("#breadcrumb").html(html);
			}
		});
	}
	
	$("#breadcrumb #chemin_categories").show();	
}

function loadRepresentativeFooterSEO(){
	
	var categoryId = window.location.hash;
	categoryId = categoryId.replace("#categoryId=", '');
	var catalogId = getURLParameter("catalogId");
	
	// Footer SEO de la catégorie associée au breadcrumb
	if($.isNumeric(categoryId) && catalogId=="null"){
		$.ajax({
			type : "GET",
			url : contextPath+"/footerSeo.html",
			data : {"categoryId": categoryId,"catalogId" : 2},
			cache : false,
			async : false,
			error : function() {

			},
			success : function(html) {
				$("#footerSEO").html(html);
			}
		});
	}
}

function getNavigationContext(){
	return (location.hash).substr(1);
}

/********************************************************************
 * JavaScript for													*
 * catalogEntry														*
 ********************************************************************/

function incQuantityNonDiscriminant(ceId, stock){
	var quantity = $("#quantityNonDiscriminant").val();
	if(quantity < stock ){
		quantity++;
	}
	$("#quantityNonDiscriminant").val(quantity);
}

function setQuantityNonDiscriminant(stock){
	var quantity = $("#quantityNonDiscriminant").val();
	if(quantity > stock ){
		quantity=stock;
	}
	$("#quantityNonDiscriminant").val(quantity);
}

function decQuantityNonDiscriminant(ceId){
	var quantity = $("#quantityNonDiscriminant").val();
	if(quantity > 1 ){
		quantity--;	
	}
	$("#quantityNonDiscriminant").val(quantity);
}

function addToCartNonDiscriminantProduct(ceId){
	
	// Si le client est authentifié, on vérifie qu'il n'a pas perdu sa session avant l'ajout au panier
	$.ajax({
		url: contextPath+"/ajax/cookieControl.html",
		cache : false,
		async: false,
		success : function(connecte) {
			// Si le client n'est pas connecté (en session) mais que le cookie montre un utilisateur connecté, cela signifie que le client a perdu sa session
			// On réadapte donc le header
			if(existsCookie("RougierAuthentificationCookie") && !isEmptyCookie("RougierAuthentificationCookie")) {
				if(isCustomerAuthentificated()== "true") {
					if(connecte == false) {
						updateAuthentificationCookieStatus("false");
						
						// Mise à jour du panier
						$.ajax({
							type: "POST",
							url: contextPath+"/ajax/cookieControl.html",
							data: {
								cartCookie : getCartCookieValue("cart")
							},
							cache : false,
							async: false,
							success : function() {
								$("#header .compte").html(function() {
									return $.i18n._("MSG_HEADER_BONJOUR")+'&nbsp;'+ getCustomerCookieInformation("RougierCustomerCookie", "fi")+'&nbsp;'+ getCustomerCookieInformation("RougierCustomerCookie", "la");
								});
								
								renderMenu();
							}
						});
					}
				}
			}
		}
	});
	
	if($.isNumeric($("#quantityNonDiscriminant").val()) && $("#quantityNonDiscriminant").val() > 0){
		
		Box.open({
			modal: true,
			urldata : "action=addToCartNuanceProduct&source=ficheProduit&nuancesChain="+ceId+"="+$("#quantityNonDiscriminant").val(),
			url : contextPath+"/cart.html",
			cache: false,
			afterShow:function(){
				majPanier();	
				$("#quantityNonDiscriminant").val(1);			
			}
		});
	}else{
		//alert("bug");
		// afficher message selection article
	}
}

function openModalYoutube(videoId){
	Box.open({
		modal: true,
		url: contextPath+"/modalYoutube.html?videoId=" + videoId
	});
}

/********************************************************************
 * JavaScript for													*
 * catalogEntryDiscriminant											*
 ********************************************************************/
function callDataForAjaxDiscriminant(divIdPrevious, divIdNext, url, ceId, catalogId, fctx){
	$.ajax( {
		type : "GET",
		url : url,
		data : {"action": "dataFromAjax", "ceId" : ceId, "catalogId" : catalogId},
		dataType : "json",
		cache: false,
		error: function(){this.success(); alert($.i18n._("bug"));},
		success : function(allAttributes) {
			discriminantSelection(allAttributes.attributes, allAttributes.attributeLibelle);
		}
	});
}

function callPriceForAjaxDiscriminant( url, ceId, catalogId){
	$.ajax( {
		type : "GET",
		url : url,
		data : {"action": "priceFromAjax", "ceId" : ceId, "catalogId" : catalogId},
		dataType : "json",
		cache: false,
		async: false,
		error: function(){this.success(); alert($.i18n._("bug"));},
		success : function(tariff) {
			var baseTarif = new Number(tariff.tariff.basePrice+"");
			var basePrice = formatPrice(baseTarif);
			var tarif = new Number(tariff.tariff.price+"");
			var price = formatPrice(tarif);
						
			if(baseTarif == null || isNaN(baseTarif) || baseTarif == tarif){
				$(".prixB").hide();
			}
			else{
				$(".prixB").show();
				$(".prixB").html(basePrice);
			}
			
			$(".catalogEntry .zInfos .infos .zPrix .prix").html(setPrice(price, basePrice));
			if(price != "0,00€"){
				priceDifferentZero = true;
			}else{
				priceDifferentZero = false;
			}
		}
	});
}

function initButtonNotBuyable(){
	$(".catalogEntry .zInfos .infos .zPrix .addBasket, .catalogEntry .zInfos .infos .zPrix .addList").hide();
}
function initButtonBuyable(){
	$(".catalogEntry .zInfos .infos .zPrix .addBasket, .catalogEntry .zInfos .infos .zPrix .addList").show();
}

function setPicture(color){
	$(".visuel>img").attr("src",picturePath+attributes[color].pictureUrl[0]);
	$(".miniature").html("");
	for (index=0;index<attributes[color].miniaturePicturesUrl.length;index++){
		$(".miniature").append("<div class='visuelMini'><img src='"+picturePath+attributes[color].miniaturePicturesUrl[index]+"' border='0' alt='' onclick=\"pictureChange("+index+",'"+picturePath+"')\"/></div>");
	}
	tabMainPicturePath = new Array();
	for (pictureIndex=0;pictureIndex<attributes[color].pictureUrl.length;pictureIndex++){
		tabMainPicturePath[pictureIndex] = attributes[color].pictureUrl[pictureIndex];
	}
}

var priceDifferentZero = null;

function selectSKU(){
	$('#selectDiscriminant').change(function(){
		if (this.value != ""){
			$(".addBasket").html("<img src='"+contextPath+"/resources/fr_FR/img/merchandising/btn_ajoutPanier.png' onclick='addToCartDiscriminantProduct("+this.value+");' width='169' height='38' alt='Ajouter au panier' border='0'/>");
			skuId = $('#selectDiscriminant').val();
			var color = $("#selectColor>option:selected").val();
			var sizeIndex = $("#selectSize>option:selected").index()-1;
			priceDifferentZero = null;
			callPriceForAjaxDiscriminant(urlRewrite, skuId, catalogId);
//			setStock(color, sizeIndex);
			if(priceDifferentZero){				
				initButtonBuyable();
			}else{
				initButtonNotBuyable();				
			}
		}else {
			initButtonNotBuyable();
		}
	});
}

function incQuantityDiscriminant(ceId){
	var stock = $("#quantityDiscriminantStock").val();
	var quantity = $("#quantityDiscriminant").val();
	if(quantity < stock ){
		quantity++;
	}
	$("#quantityDiscriminant").val(quantity);
}

function decQuantityDiscriminant(ceId){
	var quantity = $("#quantityDiscriminant").val();
	if(quantity > 1){
		quantity--;
	}
	$("#quantityDiscriminant").val(quantity);
}

function setQuantityDiscriminant(){
	var stock = $("#quantityDiscriminantStock").val();
	var quantity = $("#quantityDiscriminant").val();
	if(quantity > stock ){
		quantity=stock;
	}
	$("#quantityDiscriminant").val(quantity);
}

function addToCartDiscriminantProduct(ceId){

	// Si le client est authentifié, on vérifié qu'il n'a pas perdu sa session avant l'ajout au panier
	$.ajax({
		url: contextPath+"/ajax/cookieControl.html",
		cache : false,
		async: false,
		success : function(connecte) {
			// Si le client n'est pas connecté (en session) mais que le cookie montre un utilisateur connecté, cela signifie que le client a perdu sa session
			// On réadapte donc le header
			if(existsCookie("RougierAuthentificationCookie") && !isEmptyCookie("RougierAuthentificationCookie")) {
				if(isCustomerAuthentificated()== "true") {
					if(connecte == false) {
						updateAuthentificationCookieStatus("false");
						
						// Mise à jour du panier
						$.ajax({
							type: "POST",
							url: contextPath+"/ajax/cookieControl.html",
							data: {
								cartCookie : getCartCookieValue("cart")
							},
							cache: false,
							async: false,
							success : function() {
								$("#header .compte").html(function() {
									return $.i18n._("MSG_HEADER_BONJOUR")+'&nbsp;'+ getCustomerCookieInformation("RougierCustomerCookie", "fi")+'&nbsp;'+ getCustomerCookieInformation("RougierCustomerCookie", "la");
								});
								
								renderMenu();
							}
						});
					}
				}
			}
		}
	});
	
	if($.isNumeric($("#quantityDiscriminant").val()) && $("#quantityDiscriminant").val() > 0){
		
		Box.open({
			modal: true,
			urldata : "action=addToCartNuanceProduct&source=ficheProduit&nuancesChain="+ceId+"="+$("#quantityDiscriminant").val(),
			url : contextPath+"/cart.html",
			cache: false,
			afterShow:function(){
				majPanier();
				$("#quantityDiscriminant").val(1);				
			}
		});
		
	}else{
		//alert("bug");
		//Ajout message selection article
	}
}

function setPrice(price, offerPrice){
	var returnedPrice = "";
	price = price.replace("\.","</span><span class='sup'>"+currency);
	returnedPrice = "<div class='prixN solo'><span itemprop='price'>"+price+"</span>";

	return returnedPrice;
}

function discriminantSelection(discriminants, attributeLibelle){
	attributes = discriminants;
	$("#discriminantChoice").html(
		function (){
			var text = attributeLibelle +" : <select id='selectDiscriminant'>";
			for (i=0;i<discriminants.length;i++){
				if(discriminants[i].ceId==entryId){
					text += "<option value='"+discriminants[i].ceId+"' selected=\"selected\">"+discriminants[i].libelle+"</option>";		
				}else{				
					text += "<option value='"+discriminants[i].ceId+"'>"+discriminants[i].libelle+"</option>";		
				}
			}
			if (text.length != 77){
				text+"</select>";
			} else {
				text = "";
			}
			return text;
		}
	);
	selectSKU();
	$('#selectDiscriminant').change();
	
	if(isStockMagasinActivated == 'true') {
		modifierDiscriminantDisponibiliteMagasin();
	}
	
}

/*Ouverture de la modal de selection de wishList */
$(".zPrix .addList").click(function(){
	if ($(".addBasket").html() != null && $(".addBasket").html() != ''){

		Box.open({ 
			url: contextPath+"/ajax/modalAddWishlist.html?add", 
			modal:true,
			success : function(res) {
				Box.maj(res);
			},
			afterShow:function(){
				initCheckBoxOpenAddToWishList();				
			}
		});
	}
});


function postLoginModal(){
	$.ajax({
		type: "POST",
		url: contextPath + "/ajax/login.html",
		dataType: "html",
		async: false,
		data: {"login" : $("#adresse_mail").val(),"password":$("#mot_de_passe").val(), "pageType":"modal"},
		success : function(res) {
			Box.maj(res);
		}
	});
}

function postModalSignUp(){
	$.ajax({
		type: "POST",
		url: contextPath + "/ajax/signup.html",
		dataType: "html",
		async: false,
		
		data : {"pageType": "modal", "mail" : $("#adresse_email").val(),
		"login.password" : $("#mot_de_passe").val(),
		"login.confirmPassword" : $("confirmation_mot_de_passe").val(),
		"lastName" : $("#nom").val(),
		"firstName" : $("#prenom").val(),
		"addressLine1" : $("#adresse").val(),
		"addressLine2" : $("#complement_adresse1").val(),
		"zipCode" : $("#code_postal").val(),
		"city" : $("#ville").val(),
		"civility" : $(".ctn_civilite input:checked").val()},
		success : function(res) {
			Box.maj(res);
		}
	});
}

function openSignUp(){
	$.ajax({
		type: "GET",
		url: contextPath + "/ajax/signup.html",
		dataType: "html",
		data: {"pageType":"modal"},
		async: false,
		success : function(res) {
			Box.maj(res);
		}
	});
}

function openAddWishList(){

	$.ajax({
		type: "GET",
		url: contextPath + "/ajax/modalAddWishlist.html",
		data: {"newWishList":"x", "wishListName" : $("#wishListName").val()},
		dataType: "html",
		async: false,
		success : function(res) {
			Box.maj(res);
			$("#wishListId77").attr('checked', true);
			openAddToWishList();
		}
	});
}

function openAddToWishList(){
	var articleId = -1;
	var chaine = [];
	if(skuId != null){
		articleId = skuId;
	}else{
		$(":checkbox[name='nuance']").each(function(){
			if( $(this).is(':checked') && $("#nuanceQuantity_"+$(this).val()).val() > 0 ){
				chaine.push($(this).val());
			}
		});
	}
		
	jQuery.ajaxSettings.traditional = true;
	
	var params = {
		addToWishList:"",
		articleId: articleId,
		wishListIds : [],
		multipleArticleIds : chaine};
	
    $("input[name=wishListIds]:checked").each(function() {
    	params.wishListIds.push($(this).val());
    });

	$.ajax({
		type: "POST",
		url: contextPath + "/ajax/modalAddWishlist.html",
		data: $.param(params),
		dataType: "html",
		async: false,
		success : function(res) {
			Box.maj(res);
		}
	});
}

function initCheckBoxOpenAddToWishList() {
	$('.addToWishList form input:first').attr('checked',true);
}


/********************************************************************
 * JavaScript for													*
 * catalogEntryDiscriminantNuance									*
 ********************************************************************/
function initNuance(){
	$(":checkbox[name='nuance']").change(function(){
		var ceId = $(this).val();
		if( $(this).is(':checked') ){
			atLeastOneNuanceProductChecked();
			showQuantityForm(ceId);

			// Controle de la disponibilite en magasin
			showDisponibiliteMagasinDiscriminantNuance(ceId);
		}else{
			atLeastOneNuanceProductChecked();
			$("#infoBulleMagasin"+ceId).remove();
			setQuantityForCeId(ceId, 0);
		}
		majNbrCatalogEntryAndPrice();
	});
}

function showQuantityForm(ceId){
	if($("#nuanceQuantity_"+ceId).val() == 0){
		$("#nuanceQuantity_"+ceId).val(1);
	}
	$(".nuanceQuantity_"+ceId).show();
}

function hideQuantityForm(ceId){
	$(".nuanceQuantity_"+ceId).hide();
}

function incQuantityKey(ceId, stock) {
	var quantity = parseInt($("#nuanceQuantity_"+ceId).val(), 10);
	$("#infoBulleMagasin"+ceId).remove();
	atLeastOneNuanceProductChecked();
	if(quantity <= 0) {
		$(":checkbox[name='nuance'][value='"+ceId+"']").attr("checked", false);
		quantity = 0;
	} else {
		$(":checkbox[name='nuance'][value='"+ceId+"']").attr("checked", true);
		if(isStockMagasinActivated == 'true') {
			// Controle de la disponibilite en magasin
			showDisponibiliteMagasinDiscriminantNuance(ceId);
			if(quantity > stock ){
				quantity=stock;
			}
		}
	}
	$("#nuanceQuantity_"+ceId).val(quantity);
	majNbrCatalogEntryAndPrice();	
}

function incQuantity(ceId, stock){
	var quantity = $("#nuanceQuantity_"+ceId).val();
	if(quantity < stock ){
		quantity++;
	}
	// Controle de la disponibilite en magasin
	if(isStockMagasinActivated == 'true') {
		if(quantity == 1) {
			$("#infoBulleMagasin"+ceId).remove();
			showDisponibiliteMagasinDiscriminantNuance(ceId);
		}
	}
	$(":checkbox[name='nuance'][value='"+ceId+"']").attr("checked", true);
	atLeastOneNuanceProductChecked();
	$("#nuanceQuantity_"+ceId).val(quantity);
	majNbrCatalogEntryAndPrice();
}

function decQuantity(ceId){
	var quantity = $("#nuanceQuantity_"+ceId).val();
	atLeastOneNuanceProductChecked();
	if(quantity == 1) {
		$(":checkbox[name='nuance'][value='"+ceId+"']").attr("checked", false);
		$("#infoBulleMagasin"+ceId).remove();
	}
	if(quantity > 0){
		quantity--;
	}
	$("#nuanceQuantity_"+ceId).val(quantity);
	majNbrCatalogEntryAndPrice();
}

function setQuantityForCeId(ceId, quantity){
	$("#nuanceQuantity_"+ceId).val(quantity);
}

var atLeastOneChecked = false;

function atLeastOneNuanceProductChecked(){
	$(":checkbox[name='nuance']").each(function(){
		if( $(this).is(':checked') ){
			atLeastOneChecked = true;
			buttonsReactivate();
		}
	});
}

function addToCartNuanceProduct(){
	
	if(!atLeastOneChecked){
		buttonsRedirectAnchor();
	}else{
		// Si le client est authentifié, on vérifié qu'il n'a pas perdu sa session avant l'ajout au panier
		$.ajax({
			url: contextPath+"/ajax/cookieControl.html",
			cache : false,
			async: false,
			success : function(connecte) {
				// Si le client n'est pas connecté (en session) mais que le cookie montre un utilisateur connecté, cela signifie que le client a perdu sa session
				// On réadapte donc le header
				if(existsCookie("RougierAuthentificationCookie") && !isEmptyCookie("RougierAuthentificationCookie")) {
					if(isCustomerAuthentificated()== "true") {
						if(connecte == false) {
							updateAuthentificationCookieStatus("false");
							
							// Mise à jour du panier
							$.ajax({
								type: "POST",
								url: contextPath+"/ajax/cookieControl.html",
								data: {
									cartCookie : getCartCookieValue("cart")
								},
								cache: false,
								async: false,
								success : function() {
									$("#header .compte").html(function() {
										return $.i18n._("MSG_HEADER_BONJOUR")+'&nbsp;'+ getCustomerCookieInformation("RougierCustomerCookie", "fi")+'&nbsp;'+ getCustomerCookieInformation("RougierCustomerCookie", "la");
									});
									
									renderMenu();
								}
							});
						}
					}
				}
			}
		});
		
		var chaine = "";
		
		$(":checkbox[name='nuance']").each(function(){
			if( $(this).is(':checked') && $("#nuanceQuantity_"+$(this).val()).val() > 0 ){
				var ceId = $(this).val();
				if(chaine == ""){
					chaine = $(this).val() +"="+ $("#nuanceQuantity_"+ceId).val();
				}else{
					chaine = chaine + "," + $(this).val() +"="+ $("#nuanceQuantity_"+ceId).val();
				}
				$("#nuanceQuantity_"+ceId).val(0);
				$(":checkbox[name='nuance'][value='"+ceId+"']").attr("checked", false);
				$("#infoBulleMagasin"+ceId).remove();
			}
		});
		
		
		Box.open({
			modal: true,
			urldata : "action=addToCartNuanceProduct&source=ficheProduit&nuancesChain="+chaine,
			url : contextPath+"/cart.html",
			cache: false,
			afterShow:function(){
				majPanier();
				majNbrCatalogEntryAndPrice();	
			}
		});
	}
}

function majNbrCatalogEntryAndPrice(value){
	var chaine = "";
	var nbr = 0;
	
	if(value != null){
		var productId = value.id.substring((value.id.search("_")+1), value.id.length);		
		if(value.value > 0 && productId != null){
			$(":checkbox[name='nuance'][value='"+productId+"']").attr("checked",true);
			atLeastOneNuanceProductChecked();
		}else{
			$(":checkbox[name='nuance'][value='"+productId+"']").attr("checked",false);
			atLeastOneNuanceProductChecked();
		}
	}
	
	$(":checkbox[name='nuance']").each(function(){
		if( $(this).is(':checked') && $("#nuanceQuantity_"+$(this).val()).val() > 0 ){
			if(chaine == ""){
				chaine = $(this).val() +"="+ $("#nuanceQuantity_"+$(this).val()).val();
			}else{
				chaine = chaine + "," + $(this).val() +"="+ $("#nuanceQuantity_"+$(this).val()).val();
			}
			nbr = nbr + parseInt($("#nuanceQuantity_"+$(this).val()).val());
		}
	});
	
	//On appel le controlleur pour calculer le total
	if(chaine != null && chaine != ''){
		$.ajax( {
			type : "GET",
			url : contextPath+"/catalogEntry.html",
			data : {
				"action": "getTotalCatalogEntryNuance",
				"nuancesChain" : chaine
			},
			dataType : "json",
			cache: false,
			error: function(){
//				alert($.i18n._("bug"));
			},
			success : function(result) {
				$(".colorTotal .prix").html(formatPrice(result));
				
			}
		});
	}else{
		$(".colorTotal .prix").html("0,00€");
		buttonsRedirectAnchor();
	}
	
	//On affiche le nombre d'articles
	if(nbr <= 1){
		$(".catalogEntry .colorTotal .nbArticles").html("<span>"+nbr+" article<span>");
	}else{
		$(".catalogEntry .colorTotal .nbArticles").html("<span>"+nbr+" articles<span>");
	}
}

function buttonsRedirectAnchor(){
//	$(".catalogEntry .colorTotal .addBasket img, .catalogEntry .zInfos .infos .zPrix .addBasket img").attr("onclick", "window.scrollTo(0,$('#couleurs').offset().top);$('.warningSelectionNuance').show()");
	
	$(".catalogEntry .colorTotal .addBasket img, .catalogEntry .zInfos .infos .zPrix .addBasket img").removeAttr("onclick");
	$(".catalogEntry .colorTotal .addBasket img, .catalogEntry .zInfos .infos .zPrix .addBasket img").off("click");
	$(".catalogEntry .colorTotal .addBasket img, .catalogEntry .zInfos .infos .zPrix .addBasket img").click(function(e){
		e.preventDefault();
		window.scrollTo(0,$('#couleurs').offset().top);
		$('.warningSelectionNuance').css('color','#E30613');
	});
	$(".catalogEntry .zInfos .infos .zPrix .addList, .catalogEntry .colorTotal .addList").hide();
}

function buttonsReactivate(){
	//$(".catalogEntry .colorTotal .addBasket img, .catalogEntry .zInfos .infos .zPrix .addBasket img").attr("onclick", "addToCartNuanceProduct();");
	
	$(".catalogEntry .colorTotal .addBasket img, .catalogEntry .zInfos .infos .zPrix .addBasket img").removeAttr("onclick");
	$(".catalogEntry .colorTotal .addBasket img, .catalogEntry .zInfos .infos .zPrix .addBasket img").off("click");
	$(".catalogEntry .colorTotal .addBasket img, .catalogEntry .zInfos .infos .zPrix .addBasket img").click(function(e){
		e.preventDefault();
		addToCartNuanceProduct();
	});
	
	$(".catalogEntry .zInfos .infos .zPrix .addList, .catalogEntry .colorTotal .addList").show();
	$('.warningSelectionNuance').css('color','#FFFFFF');
}

function openModalSendFriend(ceId){
	Box.open({
		url: contextPath+"/modalSendFriend.html?ceId="+ceId,
		modal:true,					
		show: function(){
			validateEnvoiAmiForm();
			
			$("#bt_valider").click(function(){
				if($("#sendFriendForm").valid()){
					$.ajax({
						type: "POST",
						url: contextPath+"/modalSendFriend.html",
						data : $("#sendFriendForm").serialize(),
						dataType: "json",
						async: false,
						success : function(res) {
							Box.open({
								url: contextPath+"/bienEnvoye.html",
								modal:true
							});
						},
						error : function(){
							$(".error").html("Veuillez réessayer ultérieurement.");
						}
					});
				}					
			});	
		}
	});
}

/********************************************************************
 * JavaScript for													*
 * Avis Client														*
 ********************************************************************/

function openModalAvisClient(){
	Box.open({
		url: contextPath+"/review.html?action=displayFormReview"+urlReview,
		modal:true,
		show:function(){
			giveStar("#modal .review .note li","#modal #note","#modal .review .noteTxt span");
			validateAvicClientForm();
			
			$("#form_avis").submit(function(){
				if($("#form_avis").valid()){
					postmodalavisclient();
					$("#input").hide();
				}else{
					return false;
				}
			});
		}
	});
}

//Fonction gérant l'attribution de la note
function giveStar(selector,note,noteTxt)
{
	//Gestion du survol
	$(selector).hover(
		function(){
			$(this).addClass("on").prevAll().addClass("on");
			$(this).nextAll().removeClass("on");
			var data = $(this).text().split(";");
			$(noteTxt).text(data[1]);
		},
		function(){
			$(this).removeClass("on").prevAll().removeClass("on");
			if($(this).parent().find("li").is(".checked")){
				$(this).parent().find(".checked").addClass("on");
				$(this).parent().find(".checked").prevAll().addClass("on");
				$(this).parent().find(".checked").nextAll().removeClass("on");
				var data = $(this).parent().find(".checked").text().split(";");
				$(noteTxt).text(data[1]);
			}else{
				$(noteTxt).text(0);
			}
		}
	);
	
	//Gestion du click
	$(selector).click(function(){
		//Coche la note clické
		$(this).parent().find("li").removeClass("checked");
		$(this).addClass("checked")
		
		//On enregistre la variable
		var data = $(this).text().split(";");
		$(note).val(data[0]);
	});
	
}

function postmodalavisclient(){
	$.ajax({
		type: "POST",
		url: contextPath+"/review.html?action=displayPostFormReview",
		datatype: "json",
		async: false,
		data: $("#form_avis").serialize(),
		success : function(res) {
			$(".messageRetour").html($.i18n._("MSG_AVIS_INFO"));
		},
		error : function(){
			$(".messageRetour").html($.i18n._("MSG_AVIS_XSS"));
		}
	});	
}

function validateAvicClientForm(){
	
	$("#form_avis").validate({
		ignore: "input[type='text']:hidden",
		rules: {
			pseudonym:{
				required: true
			},
			email:{
				required: true,
				email: true
			},
			generalRating:{
				number: true
			},
			comment:{
				required: true,
				maxlength: 255
			}
		},
		messages: {
			pseudonym:{
				required: $.i18n._("MSG_NOM_VIDE")
			},
			email:{
				required: $.i18n._("MSG_EMAIL_VIDE"),
				email: 	  $.i18n._("MSG_EMAIL_ERR")
			},
			generalRating:{
				number: $.i18n._("MSG_EVALUATION_ERR")
			},
			comment:{
				required:$.i18n._("MSG_TXT_AREA_VIDE"),
				maxlength:$.i18n._("MSG_TXT_AREA_MAX")
			}
		}
	});	
}

function validateEnvoiAmiForm(){
	
	//form validation
	$("#sendFriendForm").validate({
		rules: {
			nom:{
				required: true
			},
			emailExpediteur:{
				required: true,
				email: true
			},
			emailDestinataire:{
				required: true,
				email: true
			},
			message:{
				required: true
			}
		},
		messages: {
			nom:{
				required: $.i18n._("MSG_NOM_VIDE")
			},
			emailExpediteur:{
				required: $.i18n._("MSG_EMAIL_VIDE"),
				email: 	  $.i18n._("MSG_EMAIL_ERR"),
				"regex":  $.i18n._("MSG_EMAIL_ERR")
			},
			emailDestinataire:{
				required: $.i18n._("MSG_EMAIL_VIDE"),
				email: 	  $.i18n._("MSG_EMAIL_ERR"),
				"regex":  $.i18n._("MSG_EMAIL_ERR")
			},
			message:{
				required:$.i18n._("MSG_TXT_AREA_VIDE")
			}
		}
	});
}

function openModalDispoMagasin() {
	
	Box.open({ 
		url: contextPath+"/disponibiliteMagasin.html?modal", 
		modal:true
	});
}

// Afficher les informations des magasins (ou choix d'un magasin) suivant le cookie sur la page nuance (pas de controle de disponibilité immédiat)
function initDisponibiliteMagasin() {
	// Vérification du cookie de disponibilite magasin
	if(existsCookie("RougierMagasinRattachement") && !isEmptyCookie("RougierMagasinRattachement")) {
		
		var informations = null;
		
		// On récupère les informations du magasin de rattachement (adresse, tel, etc.) pour les afficher
		$.ajax({
			type: "POST",
			url: contextPath+"/disponibiliteMagasin.html?shopInformation",
			data : {"siteBiz":getCookieValue("RougierMagasinRattachement")},
			dataType: "json",
			async: false,
			beforeSend : function (xhr) {
				xhr.setRequestHeader('Accept', "text/html; charset=utf-8");
			},
			success : function(res) {
				if(res != null) {
					$("#informationsMagasin").html(function() {
						var informations =
							'<p id="nomMagasin" class="stock_magasin_infos_nom">'+res.shopNameBiz+'</p>'+
							'<p id="adresseMagasin" class="stock_magasin_infos_adresse">'+res.zipCode+' - '+res.city+'</p>'+
							'<p class="stock_magasin_infos_changerMagasin"><a onclick="openModalDispoMagasin();">Changer de magasin</a></p>';
						
						return informations;
					});
				}
			},
			error : function(){
				$(".error").html("Veuillez réessayer ultérieurement.");
			}
		});
		
		// Affichage du point d'interrogation pour l'infobulle
		$("#infoBulleMagasin").html(function(){
			var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/info_disponibilite_20130208.png';
			var image = '<img style="float:left" src='+lien+' />';	
			
			return image;
		});
		
	}
	// Affichage du message de choix d'un magasin de rattachement
	else {
		
		// On essaie de définir comme magasin par défaut le magasin préféré du client, si celui-ci est dans la liste
		if(isCustomerAuthentificated() == "true") {
			$.ajax({
				type: "POST",
				url: contextPath+"/disponibiliteMagasin.html?favoriteShopCompatible",
				dataType: "json",
				async: false,
				success : function(res) {
					if(res != null) {
						
						// Création du cookie du magasin de rattachement (correspondant au magasin préféré)
						var expiration = new Date();
						expiration.setTime(expiration.getTime() + (30*24*60*60*1000));
						document.cookie = "RougierMagasinRattachement="+res.siteBiz+";path=/;expires="+expiration.toGMTString();
						
						// Affichage des informations
						$("#informationsMagasin").html(function() {
							var informations =
								'<p id="nomMagasin" class="stock_magasin_infos_nom">'+res.shopNameBiz+'</p>'+
								'<p id="adresseMagasin" class="stock_magasin_infos_adresse">'+res.zipCode+' - '+res.city+'</p>'+
								'<p class="stock_magasin_infos_changerMagasin"><a onclick="openModalDispoMagasin();">Changer de magasin</a></p>';
							
							return informations;
						});
					}
					else {
						$("#dispoMagasin").html(function() {
							var disponible = 
								'<span class="stock_magasin_voir_dispo">&nbsp;Voir la disponibilité du produit </span>&nbsp;'+
								'<span class="stock_magasin_voir_dispo_suite"><a onclick="openModalDispoMagasin();">en magasin</a></span>';
							
							return disponible;
						});
					}
				},
				error : function(){
					$(".error").html("Veuillez réessayer ultérieurement.");
				}
			});
		}
		
		// Sinon on affiche un message de choix du magasin manuellement
		else {
			$("#dispoMagasin").html(function() {
				var disponible = 
					'<span class="stock_magasin_voir_dispo">&nbsp;Voir la disponibilité du produit </span>&nbsp;'+
					'<span class="stock_magasin_voir_dispo_suite"><a onclick="openModalDispoMagasin();">en magasin</a></span>';
				
				return disponible;
			});
		}
	}
}

function initDisponibiliteMagasinForNuancePage() {
	// Vérification du cookie de disponibilite magasin
	if(existsCookie("RougierMagasinRattachement") && !isEmptyCookie("RougierMagasinRattachement")) {
		
		var informations = null;
		
		// On récupère les informations du magasin de rattachement (adresse, tel, etc.) pour les afficher
		$.ajax({
			type: "POST",
			url: contextPath+"/disponibiliteMagasin.html?shopInformation",
			data : {"siteBiz":getCookieValue("RougierMagasinRattachement")},
			dataType: "json",
			async: false,
			beforeSend : function (xhr) {
				xhr.setRequestHeader('Accept', "text/html; charset=utf-8");
			},
			success : function(res) {
				if(res != null) {
					$("#informationsMagasin").html(function() {
						var informations =
							'<p class="stock_magasin_dispo_nuance">Voir ci-dessous (choix couleur)</p>'+
							'<p id="nomMagasin" class="stock_magasin_infos_nom">'+res.shopNameBiz+'</p>'+
							'<p id="adresseMagasin" class="stock_magasin_infos_adresse">'+res.zipCode+' - '+res.city+'</p>'+
							'<p class="stock_magasin_infos_changerMagasin"><a onclick="openModalDispoMagasin();">Changer de magasin</a></p>';
						
						return informations;
					});
				}
			},
			error : function(){
				$(".error").html("Veuillez réessayer ultérieurement.");
			}
		});
		
		// Affichage du point d'interrogation pour l'infobulle
		$("#infoBulleMagasin").html(function(){
			var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/info_disponibilite_20130208.png';
			var image = '<img style="float:left" src='+lien+' />';	
			
			return image;
		});
		
	}
	// Affichage du message de choix d'un magasin de rattachement
	else {
		
		// On essaie de définir comme magasin par défaut le magasin préféré du client, si celui-ci est dans la liste
		if(isCustomerAuthentificated() == "true") {
			$.ajax({
				type: "POST",
				url: contextPath+"/disponibiliteMagasin.html?favoriteShopCompatible",
				dataType: "json",
				async: false,
				success : function(res) {
					if(res != null) {
						
						// Création du cookie du magasin de rattachement (correspondant au magasin préféré)
						var expiration = new Date();
						expiration.setTime(expiration.getTime() + (30*24*60*60*1000));
						document.cookie = "RougierMagasinRattachement="+res.siteBiz+";path=/;expires="+expiration.toGMTString();
						
						// Affichage des informations
						$("#informationsMagasin").html(function() {
							var informations =
								'<p class="stock_magasin_dispo_nuance">Voir ci-dessous (choix couleur)</p>'+
								'<p id="nomMagasin" class="stock_magasin_infos_nom">'+res.shopNameBiz+'</p>'+
								'<p id="adresseMagasin" class="stock_magasin_infos_adresse">'+res.zipCode+' - '+res.city+'</p>'+
								'<p class="stock_magasin_infos_changerMagasin"><a onclick="openModalDispoMagasin();">Changer de magasin</a></p>';
							
							return informations;
						});
					}
					else {
						$("#dispoMagasin").html(function() {
							var disponible = 
								'<span class="stock_magasin_voir_dispo">&nbsp;Voir la disponibilité du produit </span>&nbsp;'+
								'<span class="stock_magasin_voir_dispo_suite"><a onclick="openModalDispoMagasin();">en magasin</a></span>';
							
							return disponible;
						});
					}
				},
				error : function(){
					$(".error").html("Veuillez réessayer ultérieurement.");
				}
			});
		}
		
		// Sinon on affiche un message de choix du magasin manuellement
		else {
			$("#dispoMagasin").html(function() {
				var disponible = 
					'<span class="stock_magasin_voir_dispo">&nbsp;Voir la disponibilité du produit </span>&nbsp;'+
					'<span class="stock_magasin_voir_dispo_suite"><a onclick="openModalDispoMagasin();">en magasin</a></span>';
				
				return disponible;
			});
		}
	}
}

// Afficher la disponibilite magasin d'un code produit (ean)
function showDisponibiliteMagasin(codeProduit) {
	// Vérification du cookie de disponibilite magasin
	if(existsCookie("RougierMagasinRattachement") && !isEmptyCookie("RougierMagasinRattachement")) {
		
		// On récupère les informations de stock
		// URL de test : url: contextPath+"/disponibiliteMagasin.html?stockMagasinTest"
		$.ajax({
			type: "POST",
			url: contextPath+"/disponibiliteMagasin.html?stockMagasin",
			data : {"siteBiz":getCookieValue("RougierMagasinRattachement"),"codeProduit":codeProduit},
			dataType: "json",
			async: true,
			cache: false,
			beforeSend: function() {
				
				$("#dispoMagasin").html(function() {
					var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/stock_info.png';
					var disponible = 
						'<img style="float:left" src='+lien+' />'+
						'<span style="font-size:12px; line-height:20px; color:#888888; text-align:justify; padding-left:3px; font-weight:bold">Chargement en cours...</span>';
					
					return disponible;
				});
			  },
			success : function(stock) {
				
				var infobulle = null;
				
				// Un stock égal à -1 signifie qu'un erreur est survenue, on affiche une croix
				if(stock == null || stock == -1) {
					var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/stock_info.png';
					$("#dispoMagasin").html(function() {
						var disponible = 
							'<img style="float:left" src='+lien+' />'+
							'<span style="font-size:12px; line-height:20px; vertical-align:middle; padding-left:3px; color:#888888; text-align:justify; font-weight:bold">Impossible de vérifier le stock</span>';
						
						return disponible;
					});
					
					infobulle = 'Le service n\'est actuellement pas disponible, <b>merci de rééssayer plus tard</b>.';
				}
				
				// Produit indisponible
				if(stock == 0) {
					var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/stock_ko.png';
					$("#dispoMagasin").html(function() {
						var disponible = 
							'<img style="float:left" src='+lien+' />'+
							'<span style="font-size:12px; line-height:20px; vertical-align:middle; padding-left:3px; color:#ff0000; text-align:justify; font-weight:bold">Indisponible</span>';
						
						return disponible;
					});
					
					infobulle = '<b>Le stock indiqué ici ne tient pas compte <br />des réceptions en cours. N’hésitez pas à consulter <br />à nouveau le site dans quelques jours. </b>'+$("#nomMagasin").html();
				}
				
				// Quantité limitées
				else if(stock>0 && stock<3) {
					var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/stock_limite.png';
					$("#dispoMagasin").html(function() {
						var disponible = 
							'<img style="float:left" src='+lien+' />'+
							'<span style="font-size:12px; line-height:20px; vertical-align:middle; padding-left:3px; color:#ffa500; text-align:justify; font-weight:bold">Quantités limitées</span>';
						
						return disponible;
					});
					
					infobulle = '<b>Le stock remonté ici ne tient pas compte <br />des éventuels derniers achats survenus<br /> dans votre magasin. </b>'+$("#nomMagasin").html();
				}
				
				// En stock
				else if(stock>=3) {
					$("#dispoMagasin").html(function() {
						var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/stock_ok.png';
						var disponible = 
							'<img style="float:left" src='+lien+' />'+
							'<span style="font-size:12px; line-height:20px; vertical-align:middle; padding-left:3px; color:#059C02; text-align:justify; font-weight:bold">Disponible</span>';
						
						return disponible;
					});
					
					infobulle = '<b>Le stock remonté ici ne tient pas compte <br />des éventuels derniers achats survenus<br /> dans votre magasin. </b>'+$("#nomMagasin").html();
				}
				
				// Création de l'infobulle
				$('#infoBulleMagasin').CreateBubblePopup({
					position : 'right',
					align	 : 'center',
					innerHtml: infobulle,
					innerHtmlStyle: {
										color:'#888888', 
										'text-align':'justify',
										'padding':'10px'
									},
					themeName: 'grey',
					themePath: contextPath+'/resources/'+codeIsoLang+'/img/jquerybubblepopup-themes'
				});
			},
			error : function(){
				$(".error").html("Veuillez réessayer ultérieurement.");
			}
		});
	}
}

//Afficher la disponibilite magasin d'un code produit (ean)
function showDisponibiliteMagasinForDiscriminantPage(ceId, codeProduit) {
	
	// On récupère les informations de stock web
	$.ajax( {
		type : "GET",
		url : urlRewrite,
		data : {"action": "stockWebFromAjax", "ceId" : ceId, "catalogId" : catalogId},
		dataType : "json",
		cache: false,
		async: true,
		cache: false,
		beforeSend: function() {
			
			$("#dispoWeb").html(function() {
				var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/stock_info.png';
				var disponible = 
					'<img style="float:left" src='+lien+' />'+
					'<span style="font-size:12px; line-height:20px; color:#888888; text-align:justify; padding-left:3px; font-weight:bold">Chargement en cours...</span>';
				
				return disponible;
			});
		  },
		success : function(stock) {
							
			// Un stock égal à -1 signifie qu'un erreur est survenue, on affiche une croix
			if(stock == null || stock == -1) {
				var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/stock_info.png';
				
				$("#dispoWeb").html(function() {
					var disponible =
						'<img style="float:left" src='+lien+' />'+
						'<span class="erreurDisponibilite">Impossible de vérifier le stock</span>';
					
					return disponible;
				});
			}
			
			// Produit indisponible
			if(stock == 0) {
				var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/stock_ko.png';
				
				$("#dispoWeb").html(function() {
					var disponible =
						'<img style="float:left" src='+lien+' />'+
						'<span class="produitIndisponible">Indisponible</span>';
					
					return disponible;
				});
			}
			
			// Quantité limitées
			else if(stock>0 && stock<3) {
				var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/stock_limite.png';
				$("#dispoWeb").html(function() {
					var disponible =
						'<img style="float:left" src='+lien+' />'+
						'<span class="produitLimite">Quantités limitées</span>';
					
					return disponible;
				});
			}
			
			// En stock
			else if(stock>=3) {
				var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/stock_ok.png';
				$("#dispoWeb").html(function() {
					var disponible =
						'<img style="float:left" src='+lien+' />'+
						'<span class="produitDisponible">Disponible</span>';
					
					return disponible;
				});
			}
			$("#quantityDiscriminantStock").val(stock).trigger('change');
			
		},
		error : function(){
			$(".error").html("Veuillez réessayer ultérieurement.");
		}
	});
	
	// Vérification du cookie de disponibilite magasin pour la consultation stock magasin
	if(existsCookie("RougierMagasinRattachement") && !isEmptyCookie("RougierMagasinRattachement")) {
		
		// On récupère les informations de stock magasin
		// URL de test : url: contextPath+"/disponibiliteMagasin.html?stockMagasinTest"
		$.ajax({
			type: "POST",
			url: contextPath+"/disponibiliteMagasin.html?stockMagasin",
			data : {"siteBiz":getCookieValue("RougierMagasinRattachement"),"codeProduit":codeProduit},
			dataType: "json",
			async: true,
			cache: false,
			beforeSend: function() {
				
				$("#dispoMagasin").html(function() {
					var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/stock_info.png';
					var disponible = 
						'<img style="float:left" src='+lien+' />'+
						'<span style="font-size:12px; line-height:20px; color:#888888; text-align:justify; padding-left:3px; font-weight:bold">Chargement en cours...</span>';
					
					return disponible;
				});
			  },
			success : function(stock) {
				
				var infobulle = null;
				
				// Un stock égal à -1 signifie qu'un erreur est survenue, on affiche une croix
				if(stock == null || stock == -1) {
					var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/stock_info.png';
					$("#dispoMagasin").html(function() {
						var disponible = 
							'<img style="float:left" src='+lien+' />'+
							'<span style="font-size:12px; line-height:20px; vertical-align:middle; padding-left:3px; color:#888888; text-align:justify; font-weight:bold">Impossible de vérifier le stock</span>';
						
						return disponible;
					});
					
					infobulle = 'Le service n\'est actuellement pas disponible, <b>merci de rééssayer plus tard</b>.';
				}
				
				// Produit indisponible
				if(stock == 0) {
					var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/stock_ko.png';
					$("#dispoMagasin").html(function() {
						var disponible = 
							'<img style="float:left" src='+lien+' />'+
							'<span style="font-size:12px; line-height:20px; vertical-align:middle; padding-left:3px; color:#ff0000; text-align:justify; font-weight:bold">Indisponible</span>';
						
						return disponible;
					});
					
					infobulle = 'N\'hésitez pas à contacter votre <br />magasin <b>pour connaître la date <br />de livraison du produit</b>';
				}
				
				// Quantité limitées
				else if(stock>0 && stock<3) {
					var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/stock_limite.png';
					$("#dispoMagasin").html(function() {
						var disponible = 
							'<img style="float:left" src='+lien+' />'+
							'<span style="font-size:12px; line-height:20px; vertical-align:middle; padding-left:3px; color:#ffa500; text-align:justify; font-weight:bold">Quantités limitées</span>';
						
						return disponible;
					});
					
					infobulle = '<b>Le stock remonté ici ne tient pas compte<br />des éventuels derniers achats</b> survenus<br /> dans votre magasin.'+
								'<br /><br />Pour plus de sécurité, <b>n\'hésitez pas à<br />appeler votre magasin !</b>';
				}
				
				// En stock
				else if(stock>=3) {
					var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/stock_ok.png';
					$("#dispoMagasin").html(function() {
						var disponible = 
							'<img style="float:left" src='+lien+' />'+
							'<span style="font-size:12px; line-height:20px; vertical-align:middle; padding-left:3px; color:#059C02; text-align:justify; font-weight:bold">Disponible</span>';
						
						return disponible;
					});
					
					infobulle = '<b>Pour réserver cet article, appelez vite<br />votre magasin </b>'+$("#nomMagasin").html();
				}
				
				// Création de l'infobulle
				$('#infoBulleMagasin').CreateBubblePopup({
					position : 'right',
					align	 : 'center',
					innerHtml: infobulle,
					innerHtmlStyle: {
										color:'#888888', 
										'text-align':'justify',
										'padding':'10px'
									},
					themeName: 'grey',
					themePath: contextPath+'/resources/'+codeIsoLang+'/img/jquerybubblepopup-themes'
				});
			},
			error : function(){
				$(".error").html("Veuillez réessayer ultérieurement.");
			}
		});
	}
}

//Afficher la disponibilite magasin d'un code produit (ean) sur une page nuance
function showDisponibiliteMagasinForNuancePage(ceId, codeProduit) {
	// Vérification du cookie de disponibilite magasin
	if(existsCookie("RougierMagasinRattachement") && !isEmptyCookie("RougierMagasinRattachement")) {
		
		// On récupère les informations de stock
		 
		// URL de test : url: contextPath+"/disponibiliteMagasin.html?stockMagasinTest"
		$.ajax({
			type: "POST",
			url: contextPath+"/disponibiliteMagasin.html?stockMagasin",
			data : {"siteBiz":getCookieValue("RougierMagasinRattachement"),"codeProduit":codeProduit},
			dataType: "json",
			async: true,
			cache: false,
			beforeSend: function() {
				var infobulle = null;
				$(".nuanceDispo_"+ceId).html(function() {
					var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/loadingDispo.gif';
					$(".nuanceDispo_"+ceId).html('<div id="infoBulleMagasin'+ceId+'" style="width:30px; display:inline-block; height:35px; cursor:pointer">'+'<img style="float:left; margin:5px 5px" src='+lien+' /></div>');
					infobulle = '<span style="color:#888888"><b>Chargement en cours...</b></span>';
				});
				// Création de l'infobulle
				$('#infoBulleMagasin'+ceId).CreateBubblePopup({
					position : 'left',
					align	 : 'middle',
					tail	 : {align:'center'},
					innerHtml: infobulle,
					innerHtmlStyle: {
										color:'#888888', 
										'text-align':'justify',
										'padding':'10px'
									},
					themeName: 'grey',
					themePath: contextPath+'/resources/'+codeIsoLang+'/img/jquerybubblepopup-themes'
				});
			  },
			success : function(stock) {
				$('#infoBulleMagasin'+ceId).RemoveBubblePopup();		
				if(stock == null) {
					stock = -1;
				}
				var stockRevise = stock;// - quantity;
				var infobulle = null;
				// Un stock égal à -1 signifie qu'un erreur est survenue, on affiche une croix
				if(stockRevise == null || stockRevise < 0) {
					var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/stock_info.png';
					$(".nuanceDispo_"+ceId).html('<div id="infoBulleMagasin'+ceId+'" style="width:30px; display:inline-block; height:35px; cursor:pointer">'+'<img style="float:left; margin:5px 5px" src='+lien+' /></div>');
					infobulle = '<span style="color:#888888"><b>Impossible de vérifier le stock</b></span> <br /><br />'+
								'Le service n\'est actuellement pas disponible, <b>merci de rééssayer plus tard</b>.';
				}
				
				// Produit indisponible
				if(stockRevise == 0) {
					var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/stock_ko.png';
					$(".nuanceDispo_"+ceId).html('<div id="infoBulleMagasin'+ceId+'" style="width:30px; display:inline-block; height:35px; cursor:pointer">'+'<img style="float:left; margin:5px 5px" src='+lien+' /></div>');
					infobulle = '<span style="color:#ff0000"><b>Indisponible: Le stock indiqué ici ne tient pas compte des réceptions en cours.<br />N’hésitez pas à consulter à nouveau le site dans quelques jours.</b></span> <br /><br />'+
								'<b><span style="color:#000">'+$("#nomMagasin").html()+'</span></b><br />'+
								'<span style="color:#000">'+$("#adresseMagasin").html()+'</span><br />';
				}
				
				// Quantité limitées
				else if(stockRevise > 0 && stockRevise < 3) {
					var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/stock_limite.png';
					$(".nuanceDispo_"+ceId).html('<div id="infoBulleMagasin'+ceId+'" style="width:30px; display:inline-block; height:35px; cursor:pointer">'+'<img style="float:left; margin:5px 5px" src='+lien+' /></div>');
					infobulle = '<span style="color:#ffa500"><b>Quantités limitées: Le stock indiqué ne tient pas compte<br />des éventuels derniers achats survenus dans votre magasin.</b></span> <br /><br />'+
								'<b><span style="color:#000">'+$("#nomMagasin").html()+'</span></b><br />'+
								'<span style="color:#000">'+$("#adresseMagasin").html()+'</span><br />';
				}
				
				// En stock
				else if(stockRevise >= 3) {
					var lien = contextPath+'/resources/'+codeIsoLang+'/img/merchandising/stock_ok.png';
					$(".nuanceDispo_"+ceId).html('<div id="infoBulleMagasin'+ceId+'" style="width:30px; display:inline-block; height:35px; cursor:pointer">'+'<img style="float:left; margin:5px 5px" src='+lien+' /></div>');
					infobulle = '<span style="color:#059C02"><b>Disponible: Le stock indiqué ne tient pas compte<br />des éventuels derniers achats survenus dans votre magasin.</b></span> <br /><br />'+
								'<b><span style="color:#000">'+$("#nomMagasin").html()+'</span></b><br />'+
								'<span style="color:#000">'+$("#adresseMagasin").html()+'</span><br />';
				}
				
				// Création de l'infobulle
				$('#infoBulleMagasin'+ceId).CreateBubblePopup({
					position : 'left',
					align	 : 'middle',
					tail	 : {align:'center'},
					innerHtml: infobulle,
					innerHtmlStyle: {
										color:'#888888', 
										'text-align':'justify',
										'padding':'10px'
									},
					themeName: 'grey',
					themePath: contextPath+'/resources/'+codeIsoLang+'/img/jquerybubblepopup-themes'
				});
			},
			error : function(){
				$(".error").html("Veuillez réessayer ultérieurement.");
			}
		});
	}
}

// Afficher la disponibilité magasin d'un discriminant (à partir de la liste des discriminants et de son index)
function showDisponibiliteMagasinDiscriminant(ceId, listeCodeProduit, index) {
	showDisponibiliteMagasinForDiscriminantPage(ceId,listeCodeProduit[index]);
}

function showDisponibiliteMagasinDiscriminantNuance(ceId) {
	if(typeof mapNuanceDisponibiliteMagasin != 'undefined') {
		showDisponibiliteMagasinForNuancePage(ceId, mapNuanceDisponibiliteMagasin[ceId]);
	}
}

function changeDisplayShopDisponibiliteMagasin(shop,index) {
	$("#nomMagasin").html(function() {
		var nom = shop[index].shopNameBiz;
		return nom;
	});
	
	$("#adresse1Magasin").html(function() {
		var adresse1 = shop[index].addressLine1;
		return adresse1;
	});
	
	$("#adresse2Magasin").html(function() {
		var adresse2 = shop[index].addressLine2;
		if(adresse2 == null) $("#adresse2Magasin").hide();
		else $("#adresse2Magasin").show();
		return adresse2;
	});
	
	$("#adresse3Magasin").html(function() {
		var adresse3 = shop[index].addressLine3;
		if(adresse3 == null) $("#adresse3Magasin").hide();
		else $("#adresse3Magasin").show();
		return adresse3;
	});
	
	$("#villeMagasin").html(function() {
		var cp = shop[index].zipCode;
		var ville = shop[index].city;
		return cp+' '+ville;
	});
	
	$("#telMagasin").html(function() {
		var tel = shop[index].phone1;
		return '<span style="font-weight:normal">Tél : </span>'+tel;
	});
}

function validateShopDisponibiliteMagasin(shop,index) {
	
	var expiration = new Date();
	expiration.setTime(expiration.getTime() + (30*24*60*60*1000));

	document.cookie = "RougierMagasinRattachement="+shop[index].siteBiz+";path=/;expires="+expiration.toGMTString();
}



// Permet dajouter un article sans passer par la page produit (utilisé par la liste étudiant)
function addToCartListOfProduct(ceId, quantity){

	// Si le client est authentifié, on vérifié qu'il n'a pas perdu sa session avant l'ajout au panier
	$.ajax({
		url: contextPath+"/ajax/cookieControl.html",
		cache : false,
		async: false,
		success : function(connecte) {
			// Si le client n'est pas connecté (en session) mais que le cookie montre un utilisateur connecté, cela signifie que le client a perdu sa session
			// On réadapte donc le header
			if(existsCookie("RougierAuthentificationCookie") && !isEmptyCookie("RougierAuthentificationCookie")) {
				if(isCustomerAuthentificated()== "true") {
					if(connecte == false) {
						updateAuthentificationCookieStatus("false");
						
						// Mise à jour du panier
						$.ajax({
							type: "POST",
							url: contextPath+"/ajax/cookieControl.html",
							data: {
								cartCookie : getCartCookieValue("cart")
							},
							cache : false,
							async: false,
							success : function() {
								$("#header .compte").html(function() {
									return $.i18n._("MSG_HEADER_BONJOUR")+'&nbsp;'+ getCustomerCookieInformation("RougierCustomerCookie", "fi")+'&nbsp;'+ getCustomerCookieInformation("RougierCustomerCookie", "la");
								});
								
								renderMenu();
							}
						});
					}
				}
			}
		}
	});
	
	if($.isNumeric(quantity) && quantity > 0){
		
		Box.open({
			modal: true,
			urldata : "action=addToCartNuanceProduct&source=ficheProduit&nuancesChain="+ceId+"="+quantity,
			url : contextPath+"/cart.html",
			cache: false,
			afterShow:function(){
				majPanier();				
			}
		});
	}
}

// Permet d'ajouter un ensemble d'articles sans passer par la page produit
// La chaine doit etre du type 'article1=quantite1,..., article N = quantite N)
function addToCartAllProduct(chaine){
	
	// Si le client est authentifié, on vérifié qu'il n'a pas perdu sa session avant l'ajout au panier
	$.ajax({
		url: contextPath+"/ajax/cookieControl.html",
		cache : false,
		async: false,
		success : function(connecte) {
			// Si le client n'est pas connecté (en session) mais que le cookie montre un utilisateur connecté, cela signifie que le client a perdu sa session
			// On réadapte donc le header
			if(existsCookie("RougierAuthentificationCookie") && !isEmptyCookie("RougierAuthentificationCookie")) {
				if(isCustomerAuthentificated()== "true") {
					if(connecte == false) {
						updateAuthentificationCookieStatus("false");
						
						// Mise à jour du panier
						$.ajax({
							type: "POST",
							url: contextPath+"/ajax/cookieControl.html",
							data: {
								cartCookie : getCartCookieValue("cart")
							},
							cache : false,
							async: false,
							success : function() {
								$("#header .compte").html(function() {
									return $.i18n._("MSG_HEADER_BONJOUR")+'&nbsp;'+ getCustomerCookieInformation("RougierCustomerCookie", "fi")+'&nbsp;'+ getCustomerCookieInformation("RougierCustomerCookie", "la");
								});
								
								renderMenu();
							}
						});
					}
				}
			}
		}
	});
	
		Box.open({
			modal: true,
			urldata : "action=addToCartNuanceProduct&source=ficheProduit&nuancesChain="+chaine,
			url : contextPath+"/cart.html",
			cache: false,
			afterShow:function(){
				majPanier();				
			}
	});
}