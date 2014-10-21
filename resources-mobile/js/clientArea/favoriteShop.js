//Au chargement de la page 
$(document).ready(function(){
	/*if (shopListForGoogleMaps != null){
		initialize(shopListForGoogleMaps);
	}*/
		
	// Btn valid le formulaire code acces nouvelle adresse email
	$("#searchShop").validate({
		rules: {
			zipCode: {
				required: true,
				postalcode:true
			}
		},
		messages: {	
			zipCode: {
				required:	$.i18n._("MSG_CP_VIDE"),
				postalcode:	$.i18n._("MSG_CP_ERR")
			}
		}
	});
	$("#valider").click(function(){
		if($("#searchShop").valid()){
			checkGoogleInput();
			$('#searchShop').submit();
		}
		return false;
	});
	$("#btn_searchShop").click(function(){
		if($("#searchShop").valid()){
			checkGoogleInput();
		}
		return false;
	});
});

function checkGoogleInput(){
	if ($("#cityGoogle").val() != ""){
		$('#region').val(0);		
		getCoordonnee($("#cityGoogle").val());	
		//$('#zipcode_error').hide();
	}else{
		$('#zipcode_error').show();
		$('#zipcode_error').html($.i18n._("error.vide"));
	}
}

function getCoordonnee(adresse){
	// Vider lat/long
	$("#longitude").val("");
	$("#latitude").val("");
	 
	var tabLgt = new Array();
	var tabLat = new Array();
	//Ajout du pays 
	adresse += " france";
	//get lattitute/longitude
	var geocoder = new google.maps.Geocoder();
	geocoder.geocode({'address': adresse},function(results, status, longitude){
		if(results.length > 0) $('#zipcode_error').hide();
		if (status == google.maps.GeocoderStatus.OK) {
			for(i=0;i<results.length;i++){
				tabLgt[i] = results[i].geometry.location.lng();
				tabLat[i] = results[i].geometry.location.lat();
			}
			$('#tabLongitude').attr("value", tabLgt);
			$('#tabLattitude').attr("value", tabLat);
			$('#searchShop').submit();
		}
	});
}
