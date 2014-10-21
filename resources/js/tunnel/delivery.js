$(window).load(function() {
	
	// Vérification de la présence du numéro de téléphone lors de la livraison relais
	if(getStepPageName()=="deliveryRelay.html")
	{
		
		
		// Sinon on active
		/* else
		{
			$(".bt_suivant_submit_delivery").click(function(){
				$('#shippingFormHome').removeAttr("onsubmit");
				$('#shippingFormHome').submit();
			});
		} */
		
		$("input#phoneDeliveryRelay").keyup(function(event){ 
			
			var telephone= $(this).val(); 
		    var estNumerique = !isNaN($("input#phoneDeliveryRelay").val());
		    var longueur = $("input#phoneDeliveryRelay").val().length;
		    
			if( !estNumerique || longueur>18) { 
				if(!estNumerique) $("#phoneError").text($.i18n._("delivery.telChiffreUniquement"));
				else if(longueur>18) $("#phoneError").text($.i18n._("delivery.telLimiteChiffre"));
				else $("#phoneError").text($.i18n._("delivery.telInvalide"));
				$("#deliveryType #bloc_home .boutonsbas .floatLeft").html('<input value="Etape suivante" class="bt_suivant_submit_delivery_off" disabled="disabled"/>');
			} 
			else {
				$("#phoneError").html(''); 
				$("#deliveryType #bloc_home .boutonsbas .floatLeft").html('<input type="submit" value="Etape suivante" class="bt_suivant_submit_delivery" />');

				$(".bt_suivant_submit_delivery").bind('click', function(){
					$('.bt_suivant_submit_delivery').attr("disabled","disabled");
					$('#shippingFormHome').removeAttr("onsubmit");
					$('#shippingFormHome').submit();
				});
			}
			
		});
	}
});

String.prototype.startsWith = function(str) 
{return (this.match("^"+str)==str)}

var ModeDeliveryShopId = 2;
var ModeDeliveryHomeId = 1;
var ModeDeliveryRelayId = 3;

var imageLoading= contextPath+"/resources/"+codeIsoLang+"/img/common/ajax_loading.gif";



/**
 * active la touche entrée pour le choix de code postal
 */
function activateEnterKey(){
	$("#cpRelay").keyup(function(event) {
		if(event.keyCode == 13){
			clickSearchRelay();
		}
	});
}

function clickSearchShop(){
	//ATTENTION LE COUNTRY ID EST EN DURE 
	
	
	var serviceTransportId= document.getElementById("serviceTransportId").value;	
	var zipCode= document.getElementById("cp").value;
	
	var url = contextPath+"/ajax/deliveryShop.html?serviceTransportId="+serviceTransportId+"&zipCode="+zipCode+"&countryId=1&action=chgShop";
	
	$("#bloc_search_shop").empty().html('<img src="'+ imageLoading +'" />'); 
	
	
	$.ajax( {
		type : "GET",
		url : url,
		dataType : "json",
		cache: false,
		success : function(shops) {
			if(shops != null) {
				var htmlShops = new EJS({url: contextPath+'/resources/js/tunnel/ejs/foundShop.txt'}).render(shops);
				$("#bloc_search_shop").html(htmlShops);
			}
		}
	});
	

}





function changeSelectionShop(){
	

$("#selectShop").click(function(){
	
	var serviceTransportId= document.getElementById("serviceTransportId").value;

	if($(this).attr("value")!=null && $(this).attr("value")!=''){
		
	var blockSearchShopHtml = $("#bloc_search_shop").html();
	var zipCode= document.getElementById("cp").value;	
	var valueSelected=$(this).attr("value");
	
	//Faire appel a ajaxMagasin + appel foundShop.txt
	var url = contextPath+"/ajax/deliveryShop.html?serviceTransportId="+serviceTransportId+"&shopId="+$(this).attr("value");
	$("#bloc_shop").empty().html('<img src="'+ imageLoading +'" />'); 
	
	$.ajax( {
		type : "GET",
		url : url,
		dataType : "json",
		cache: false,
		success : function(shop) {
			if(shop != null) {
				var html = new EJS({url: contextPath+'/resources/js/tunnel/ejs/deliveryShop.txt'}).render(shop);
				$("#bloc_shop").html(html);						
			}	
			
			$("#bloc_search_shop").html(blockSearchShopHtml);	
			document.getElementById("cp").value = zipCode;
					
			$("#selectShop").val(valueSelected);
		}
	});
	
	}
});
}

function clickSearchRelay(serviceTransportId){
	var zipCode=$("#cpRelay").val();
	$("#bloc_search_relay").empty().html('<img src="'+ imageLoading +'" />'); 
	var url = contextPath+"/tunnel/deliveryRelay.html?serviceTransportId="+serviceTransportId+"&zipCode="+zipCode+"&action=chgRelay";
	
	$.ajax( {
		type : "GET",
		url : url,
		dataType : "json",
		cache: false,
		success : function(relays) {
			if(relays!=null && relays != "") {
				var htmlRelays = new EJS({url: contextPath+'/resources/js/tunnel/ejs/foundRelay.txt'}).render(relays);
				$("#bloc_search_relay").html(htmlRelays);	
				$("#bloc_search_relay").show();
			}else{
				$("#bloc_search_relay").empty().html('<span class="error">'+$.i18n._('Empty.list.relay')+'</span>'); 
				$("#point_relais .floatRight").empty(); 
			}
		},
		error: function(){
			$("#bloc_search_relay").empty().html(''); 
		}
	});
	
}



function changeSelectionRelay(){
	

	$("#selectRelay").click(function(){
	var serviceTransportId= document.getElementById("serviceTransportId").value;
//	if($("#phone").attr("value")==null || $("#phone").attr("value")==''){
//		$("#phoneError").text($.i18n._('NotEmpty.customer.phoneNumber'))
//	}else{
		if($(this).attr("value")!=null && $(this).attr("value")!=''){
			
			var blockSearchRelayHtml = $("#bloc_search_relay").html();
			var zipCode= document.getElementById("cpRelay").value;	
			var valueSelected=$(this).attr("value");	
			
			//Faire appel a ajaxMagasin + appel foundShop.txt
			
			var url = contextPath+"/tunnel/deliveryRelay.html?serviceTransportId="+serviceTransportId+"&relayBiz="+$(this).attr("value")+"&phone="+$("#phoneDeliveryRelay").attr("value");
			window.location.href = url;
		}
//	}
});
}


/*fonction de controle de saisie du formulaire d'adresse dans la modale*/
function validationShippingForm() {
	$("#defaultAdress").validate({
		rules: {
			wording: {
				required: true,
				maxlength: 32
			},
			firstName: {
				required: true,
				maxlength: 32
			},
			lastName: {
				required: true,
				maxlength: 32
			},
			addressLine1:{
				required: true,
				maxlength: 32
			},
			zipCode : {
				required: true,
				minlength: 4,
				maxlength: 5
			},
			city: {
				required: true,
				maxlength: 255
			},
			phone : {
				required: false
			}
		},
		messages: {
			wording: $.i18n._('NotEmpty.customer.addressLabel'),
			firstName: $.i18n._('NotEmpty.customer.firstName'),
			lastName: $.i18n._('NotEmpty.customer.lastName'),
			addressLine1: $.i18n._('NotEmpty.customer.addressLine1'),
			zipCode: {
				required: $.i18n._('NotEmpty.customer.zipCode'),
				minlength: $.i18n._('Size.customer.zipCode'),
				maxlength: $.i18n._('Size.customer.zipCodeBis')
			},
			city: $.i18n._('NotEmpty.customer.city'),
			phone :  {
				required: $.i18n._('NotEmpty.customer.phoneNumber')
				
			}
		}
	});
}


$(document).ready(function() {
	//Permet de charger en ajax les elements au chargement de la page
	//$("input[name='modeDelivery']:checked").click();

	$("#shippingFormHome").attr("onsubmit", "return false;");

	// TODO SYLVAIN PROBLEME DE BOUTON
	//	$(".bt_suivant_submit_delivery").attr("disabled", "true");
	
	/*  $(".bt_suivant_submit_delivery").click(function(){
		$('#shippingFormHome').removeAttr("onsubmit");
		$('#shippingFormHome').submit();
	}); */
	
	$(".bt_suivant_submit_delivery").bind('click', function(e){
		
//		$('.bt_suivant_submit_delivery').attr("disabled","disabled");
		
		e.preventDefault();
		
		// Si le bouton n'a pas déjà été cliqué
		if (!$(this).data('isClicked')) {
	        var link = $(this);
	        
	        $('#shippingFormHome').removeAttr("onsubmit");
			$('#shippingFormHome').submit();
			
			// On défini que le bouton a été cliqué pour éviter qu'il ne soit cliqué encore une fois
			link.data('isClicked', true);
	        setTimeout(function() {
	        link.removeData('isClicked')
	        }, 10000);
		}
	});
	
	$("#searchRelay").click();
	
	if($("#bloc_search_relay").html()==''){
		$("#bloc_search_relay").hide();
	}
	
});


/*Ouverture de la modal modifier l'adresse de livraison*/
$("#modifDeliveryAdress").click(function(){
	openModalAddress(null, 1); 
});

	
/*Ouverture de la modal modifier l'adresse de facturatop,*/
$("#modifBillingAdress").click(function(){
	openModalAddress(null, 2); 
});
	
	/*fonction d'ouverture de la modal d'adresse*/
	function openModalAddress(addressId, addressTypeId){
		Box.open({ 
			url: contextPath+"/ajax/modalModifyAddress.html?addressTypeId="+addressTypeId+"&adId="+addressId, 
			modal:true,
			show: function(){
				validationShippingForm();
			}
		});
	}
	
	/*fonction de mise a jour de l'adresse lors du changement d'adresse dans la modale*/
	function reloadModalAddress(addressId, addressTypeId){
		$.getJSON(contextPath+"/ajax/modalModifyAddress.html?addressTypeId="+addressTypeId+"&action=data&adId="+addressId, function(data) {
			if(data != null) {
				var html = new EJS({url: contextPath+'/resources/js/tunnel/ejs/changeAddress.txt'}).render(data);	
				$("#contentAddress").html(html);				
			}			
		});
	}
	
	/*change le mode de livraison */
	function changeModeLivraison(serviceTransportId,codeService)
	{	
		var url = contextPath+"/tunnel/delivery.html?action=changeDelivery&codeService="+codeService+"&serviceTransportId=" +serviceTransportId ;
		window.location.href = url;
	}
	//calque d'ajout adresse
	function addNewAddress() {
		Box.open({
			modal: true,
			url: contextPath+"/addOrModifyAddress.html?addressType=shipping&origine=delivery",
			show:function(){
	        	$(document).ready(function() {
	        		
	        		$.validator.addMethod("phone",function(value,element)
	        				{
	        				return /^[0-9\+]{0,18}$/i.test(value); 
	        				},$.i18n._("MSG_TELEPHONE_ERR"));
	        		
	        		$.validator.addMethod("cp",function(value,element)
	        				{
	        				return /^[0-9]{4,10}$/i.test(value); 
	        				},$.i18n._("MSG_CP_ERR_FP"));
	        		
					if($("#pays").val() != 0) {			
			  			Ville.load($("#address"), true);  			
					} else {
						Ville.load($("#address"), false);
						Ville.clear();			
					}
				});
	        	init_form_adress();
	        	$("#address").submit(function(){
	        		if($("#address").valid()){
	        			if(checkNameExist()=="true"){
		        			$.ajax({
		        				type: "POST",
		        				url: contextPath+"/addOrModifyAddress.html?addressType=shipping&origine=delivery",
		        				data : $("#address").serialize(),
		        				dataType: "json",
		        				async: false,
		        				success : function(data, textStatus, jqXHR) {
		        					window.location.replace(contextPath+"/tunnel/delivery.html");
		        				},
		        				error : function(jqXHR, textStatus, errorThrown){
		        					alert("error: " +  textStatus +" / "+ errorThrown);
		        					Box.close();
		        				}
		        			});
	        			}else{
	        				$("#wording").after("<label for=\"wording\" generated=\"true\" class=\"error\">"+$.i18n._("MSG_NOM_ADDRESS_VIDE")+"</label>");
	        			}
	        			return false;
	        		}	
	        		return false;
	        	});
			}
		});
	}
	

	function checkNameExist(){
		if($("#wording").is(":visible")){
			var result = false;
			$.ajax({
				type: "GET",
				url: contextPath+"/ajax/checkAddressNameExist.html",
				dataType: "html",
				data : "addressName="+$("#wording").val()+"&addressId="+$("#addressId").val(),
				async: false,
				success : function(data, textStatus, jqXHR) {
					result= data;
				},
				error : function(jqXHR, textStatus, errorThrown){
					result= false;
				}
			});
			return result;
		}else{
			return "true";
		}
	}
	
	function addOrModifyAddress(addressId, addressType){
		Box.open({
			modal: true,
			url: contextPath+"/addOrModifyAddress.html?addressId="+addressId+"&addressType="+addressType+"&origine=delivery",
			show:function(){
	        	$(document).ready(function() {
	        		
	        		$.validator.addMethod("phone",function(value,element)
	        				{
	        				return /^[0-9\+]{0,18}$/i.test(value); 
	        				},$.i18n._("MSG_TELEPHONE_ERR"));
	        		$.validator.addMethod("cp",function(value,element)
	        				{
	        				return /^[0-9]{4,10}$/i.test(value); 
	        				},$.i18n._("MSG_CP_ERR_FP"));
	        		
					if($("#pays").val() != 0) {			
			  			Ville.load($("#address"), true);  			
					} else {
						Ville.load($("#address"), false);
						Ville.clear();			
					}
					init_form_adress();
		        	$("#address").submit(function(){
		        		if($("#address").valid()){
		        			if(checkNameExist()=="true"){
			        			$.ajax({
			        				type: "POST",
			        				url: contextPath+"/addOrModifyAddress.html?origine=delivery&addressType="+addressType,
			        				data : $("#address").serialize(),
			        				dataType: "json",
			        				async: false,
			        				success : function(data, textStatus, jqXHR) {
			        					window.location.replace(contextPath+"/tunnel/delivery.html");
			        				},
			        				error : function(jqXHR, textStatus, errorThrown){
			        					alert("error: " +  textStatus +" / "+ errorThrown);
			        					Box.close();
			        				}
			        			});
		        			}else{
		        				$("#wording").after("<label for=\"wording\" generated=\"true\" class=\"error\">"+$.i18n._("MSG_NOM_ADDRESS_VIDE")+"</label>");
		        			}
		        			return false;
		        		}
		        			
		        		return false;
		        	});
				});
			}	
		});
	}
	function init_form_adress(){
		//form validation
		$("#address").validate({
			rules: {
				wording:{ 
					required: true,
					maxlength: 40
				},
				codeCivilityId:{ required: true },
				company:{ required: false,maxlength: 40 },
				firstName:{ required: true,maxlength: 40  },
				lastName:{ required: true,maxlength: 40  },
				addressLine1:{ required: true,maxlength: 40  },
				addressLine2:{ required: false,maxlength: 40  },
				addressLine3:{ required: false,maxlength: 40  },
				zipCode:{ required: true,cp:"required cp"},
				city:{ required: true,maxlength: 40 },
				otherCity:{ 
					required: function(){
						return $("#ville option:selected").text()=='Autre';
					},
					maxlength: 40
				},
				phone:{ required:function(){
						return $("#mobile").val()=='';
					}, phone:"required phone",maxlength: 18},
				mobile:{ phone:"required phone",maxlength: 18}
				

			},
			messages: {
				wording:{ required: $.i18n._("MSG_NOM_ADDRESS_VIDE")},
				codeCivilityId:{ required: $.i18n._("MSG_CIVILITE_VIDE") },
				lastName:{ required: $.i18n._("MSG_NOM_VIDE") },
				firstName:{ required: $.i18n._("MSG_PRENOM_VIDE") },
				addressLine1:{ required: $.i18n._("MSG_ADRESSE_VIDE") },
				zipCode:{ required: $.i18n._("MSG_CP_VIDE") },
				city:{ required: $.i18n._("MSG_VILLE_VIDE") },
				otherCity:{ required: $.i18n._("MSG_VILLE_VIDE") },
				phone:{required: $.i18n._("MSG_PHONE_VIDE"),maxlength: $.i18n._("MSG_TELEPHONE_ERR")},
				mobile:{required: $.i18n._("MSG_PHONE_VIDE"),maxlength: $.i18n._("MSG_TELEPHONE_ERR")}
			}
			,
			errorPlacement: function(error, element) {
				//Placement spécifique pour la civilité
				if(element.attr("name")=="codeCivilityId")
//					TODO placer correctement le message erreur
//					element.parent(".radios").after(error);
					element.after(error);
				else
					element.after(error);
		   }
		});
		
		

	}
	function reloadModeLivraison(adressId,serviceTransportId)
	{
		var url = contextPath+"/tunnel/delivery.html?action=changeAdressModeDelivery&serviceTransportId=" +serviceTransportId+"&addressId="+adressId ;
		window.location.href = url;
	}
	
	function getStepPageName()
	{
		var url = window.location.pathname;
		var pageName = url.substring(url.lastIndexOf('/') +1);
		return pageName;
	}
	
