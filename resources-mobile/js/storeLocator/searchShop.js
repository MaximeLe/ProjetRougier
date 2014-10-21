$(document).ready(function(){
	if ($('#city option').eq() == 1){
		$('#city').attr("disabled", true);
		$('#region option').removeAttr("selected");
		$('#region option:eq(0)').attr("selected","selected");
	}
	initMap();

	//$('#searchShop').attr("onsubmit","return false;");


	$("#submitSearchInput").click(function() {
		checkGoogleInput();			
	});
	
	$("#searchShop").keyup(function(event) {
		if(event.keyCode == 13){
			checkGoogleInput();
		}
	});
	$("#searchShop").submit(function() {
		if(! isExist($("#searchShop input[name=action]"))){
			//alert("Annulation du submit");
		}
		else {
			//alert("submit");
			return true;
		}
		return false;
	});
	
	if (shopListForGoogleMaps != null){
		initialize(shopListForGoogleMaps);
	}
	
});

/**
 * Si le champs n'est pas vide, regarde les coordonnÃ©es correspondantes et submite le formulaire si elles existent
 */
function checkGoogleInput(){
	if ($("#cityGoogle").val() != ""){
		$('#region').val(0);		
		getCoordonnee($("#cityGoogle").val());
	}else{
		$('#inputError.error').show();
		$('#inputError.error').html($.i18n._("error.vide"));
	}
}

function initMap(){
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
		if (status == google.maps.GeocoderStatus.OK) {
			for(i=0;i<results.length;i++){
//				$('#searchShop').append("<input type='hidden' id='tabLongitude' name='tabLongitude' value='"+(results[i].geometry.location.lng()+"'/>"));
//				$('#searchShop').append("<input type='hidden' id='tabLattitude' name='tabLattitude' value='"+(results[i].geometry.location.lat()+"'/>"));

				tabLgt[i] = results[i].geometry.location.lng();
				tabLat[i] = results[i].geometry.location.lat();
			}
			$('#tabLongitude').attr("value", tabLgt);
			$('#tabLattitude').attr("value", tabLat);
			$('#searchShop').append("<input type='hidden' name='action' value='input'/>");
			$('#searchShop').submit();
		} else {
			$('#inputError').html("La recherche n'a pas abouti, veuillez préciser d'avantage votre recherche.");
		}
	});
}


//Fonction appelée lors d'un clic sur la carte (peut aussi contenir le paramètre name)
function selectRegion(regionId)
{
	//ajaxShopForGoogleMapByRegion(regionId);
	$("#region").val(regionId);
}




/**
 * initialise la carte google et place un marker par magasin prÃ©sent dans shops
 * @param shops
 */
function initialize(shops) {
	var myLatlng = new google.maps.LatLng(shops.middleLatitude, shops.middleLongitude);
	var bounds = extremeCoordinate(shops);
	var autoFit = false;
	if(shops.shopList.length == 1) {
		var myOptions = {
	      zoom: 13,
	      center: bounds.getCenter(),
	      mapTypeId: google.maps.MapTypeId.ROADMAP
	    };
	}
	else {
		autoFit = true;
		var myOptions = {
	      zoom: 12,
	      center: bounds.getCenter(),
	      mapTypeId: google.maps.MapTypeId.ROADMAP
		};
	}
    $("#map_canvas").css({height: "252px", width:"100%"});

    
    var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
    if(autoFit) map.fitBounds(bounds); // configure le zoom automatiquement / au coordonnÃ©es extrÃªmes
    
    
    setDirections(map, shops);
    setMarkers(map, shops.shopList);
}

/**
 * Retourne les coordonnÃ©es les plus extrÃªmes.
 * @param shops
 * @returns {google.maps.LatLngBounds}
 */
function extremeCoordinate(shops){
	var maxMyLatlng = new google.maps.LatLng(shops.maxLatitude, shops.maxLongitude);
	var minMyLatlng = new google.maps.LatLng(shops.minLatitude, shops.minLongitude);
	var bounds = new google.maps.LatLngBounds(minMyLatlng, maxMyLatlng); // configure les points extrÃªmes
	return bounds;
}

/**
 * GÃ©nÃ©re l'itinaire entre le magasin le plus proche et la localisation demandÃ©e.
 * @param map
 * @param shops
 */
function setDirections(map, shops){
	var directionsService = new google.maps.DirectionsService();
	directionsDisplay = new google.maps.DirectionsRenderer();
	directionsDisplay.setMap(map);
	
	var originLatlng = new google.maps.LatLng(originLatitude, originLongitude);
	var myLatLng = new google.maps.LatLng(shops.shopList[0].latitude, shops.shopList[0].longitude);
	var request = {
		origin : originLatlng,
		destination : myLatLng,
		travelMode : google.maps.DirectionsTravelMode.DRIVING
	};
	directionsService.route(request, function(response, status) {
		if (status == google.maps.DirectionsStatus.OK) {
			directionsDisplay.setDirections(response);
			var distance = response.routes[0].legs[0].distance.text;
			var duration = response.routes[0].legs[0].duration.text;
		    $("#directionDuration").html(distance+" / "+duration);
		    $("#directionDuration").css("visibility","visible");
		}
	});
}


/**
 * crÃ©e les markers de magasins et la gestion du clic
 * @param map
 * @param locations
 */
function setMarkers(map, locations) {
	var markers = [{}];
	for (shopIndex in locations){
		var shop = locations[shopIndex];
		var myLatLng = new google.maps.LatLng(shop.latitude, shop.longitude);
		/*var image = contextPath + "/resources/fr_FR/img/storeLocator/ico-mini-1000.png";*/
		var marker = new google.maps.Marker({
	        position: myLatLng,
	        map: map,
	        /*icon: image,*/
	        title: shop.shopName
	    });
		markers = pushMarker(markers, myLatLng, shop.shopUrl);

	    google.maps.event.addListener(marker, 'click', function(marker) {
	    	window.location = markers[marker.latLng.lat()][marker.latLng.lng()].url;
	    });

	}
}

/**
 * Remplis l'objets markers avec les informations du marker
 * @param markers
 * @param latitude
 * @param longitude
 * @param shopUrl
 * @returns
 */
function pushMarker(markers, myLatLng, shopUrl){
	var latitude = myLatLng.lat();
	var longitude = myLatLng.lng();
	if (markers[latitude] == null){
		markers[latitude] = [];
	}
	markers[latitude][longitude] = {"url":shopUrl};
	return markers;
}
