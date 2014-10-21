$(document).ready(function() {
	
	//Google map
	initialize();
  				 
});

var map = null;

function initialize() {
	var myLatlng = new google.maps.LatLng(latitude, longitude);
    var myOptions = {
      zoom: Number(zoomValue),
      center: myLatlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    
    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
    var image = contextPath + "/resources/fr_FR/img/storeLocator/ico-mini-"+signBiz+".png";
    var beachMarker = new google.maps.Marker({
    	position: myLatlng,
        map: map,
        icon: image
    });
}


/**
 * Génère l'itinaire entre le magasin et l'adresse demandée.
 */
function calcRoute() {
	if($('#startCity').val() != ''){
		initialize();
		var directionsService = new google.maps.DirectionsService();
		var directionsDisplay = new google.maps.DirectionsRenderer();
		directionsDisplay.setMap(map);
		
		var myLatLng = new google.maps.LatLng(latitude, longitude);
		var request = {
				origin: $('#startCity').val(),
				destination: myLatLng,
				travelMode: google.maps.TravelMode.DRIVING
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
}

function ajaxSaveDefaultShop(){
	if($('input[id="ajaxSaveDefaultShop"]').is(":checked")){
		$.ajax({
			type:"POST",
			url: contextPath+"/ajax/shop.html?action=setShop",
			data:{
				"shopId": shopId
			},
			dataType: 'json',
			cache:false,
			success:function(){
				renderMenu();
				/*alert("Bien enregistré !");*/
			},
			error:function(message){
				alert("Erreur lors de l'enregistrement du magasin préféré");
			}
		});
	}else{
		$.ajax({
			type:"POST",
			url: contextPath+"/ajax/shop.html?action=resetShop",
			dataType: 'json',
			cache:false,
			success:function(){
				renderMenu();
//				alert("Ce n'est plus votre magasin préféré !");
			},
			error:function(message){
				alert("Vous n'êtes pas connecté");
			}
		});
	}
}