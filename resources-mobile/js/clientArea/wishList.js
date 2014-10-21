function selectAll(wishListId, input) {
	if (input.checked==true) {
		$("#wishList_"+wishListId+" input[name='wishProductIdList']").attr("checked","checked");
	} else {
		$("#wishList_"+wishListId+" input[name='wishProductIdList']").removeAttr("checked");
	}
}

function deleteDefaultValue(input) {
	input.value = "";
}

function insertDefaultValue(input) {
	if(input.value == "" || input.value == null) {
		input.value = "Nom de la liste";
	}
}

//function submitAddWishProduct(wishListId) {
//	if ($("input[name=wishProductIdList]:checked", $("#form_wishList"+wishListId)).length > 0){
//		$('#action'+wishListId).val('add');
//		$('#form_wishList'+wishListId).submit();
//	} else {
//		$("#messageOrError").html($.i18n._("error.noProductSelected"));
//	}
//}

function createWishList() {
	var val = $("#form_liste_souhaits input").val();
	// Si on créé une nouvelle liste avec un nom vide, on passe au controller un message vide plutôt que "Nom de la liste"
	if(val == messageNouvelleListe) $('input[name$="nouvelle"]').val('');;
	$("#form_liste_souhaits").submit();
}


function submitDeleteWishProduct(wishListId) {
	if ($("input[name=wishProductIdList]:checked", $("#form_wishList"+wishListId)).length > 0){
		$('#action'+wishListId).val('delete');
		$('#form_wishList'+wishListId).submit();
	} else {
		$("#messageOrError").html($.i18n._("error.noProductSelected"));
	}
}


function submitDelete(wishListId) {
	$('#action'+wishListId).val('deleteWishList');
	$('#form_wishList'+wishListId).submit();
}

function addToCartWishlistProduct(wishListId){
	
	if ($("input[name=wishProductIdList]:checked", $("#form_wishList"+wishListId)).length > 0){
		$('#action'+wishListId).val('delete');
		
		var chaine = "";
		
		$("#form_wishList"+wishListId).find("input[name=wishProductIdList]:checked").each(function(){
			if( $(this).is(':checked')){
				if(chaine == ""){
					chaine = $(this)[0].id +"=1";
				}else{
					chaine = chaine + "," + $(this)[0].id +"=1";
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
		
	} else {
		$("#messageOrError").html($.i18n._("error.noProductSelected"));
	}
	
}