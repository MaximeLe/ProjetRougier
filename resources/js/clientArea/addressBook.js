
function addOrModifyAddress(addressId, addressType){
//	window.location = contextPath+"/addOrModifyAddress.html?addressId="+addressId+"&addressType="+addressType;
	Box.open({
		modal: true,
		url: contextPath+"/addOrModifyAddress.html?addressId="+addressId+"&addressType="+addressType,
		show:function(){
        	$(document).ready(function() {
        		
        		//var ZIPCODE_INF_CORSE = 20000;
        		//var ZIPCODE_SUP_CORSE = 20999;
        		
        		$.validator.addMethod("phone",function(value,element)
        				{
        				return /^[0-9\+]{0,18}$/i.test(value); 
        				},$.i18n._("MSG_TELEPHONE_ERR"));
        		$.validator.addMethod("cp",function(value,element)
        				{
        				return /^[0-9]{4,10}$/i.test(value); 
        				},$.i18n._("MSG_CP_ERR_FP"));
        		
        		// Si il s'agit de l'ajout ou de la modification d'une adresse de livraison,
        		// on verifie que celle-ci n'est pas une adresse Corse
        		/*if(addressType=="shipping")
        		{
        			$.validator.addMethod("cp",function(value,element)
            				{
            				return value<ZIPCODE_INF_CORSE || value>ZIPCODE_SUP_CORSE; 
            				},$.i18n._("MSG_CP_ERR_CORSE"));
        		}*/
        		//
        		
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
		        				url: contextPath+"/addOrModifyAddress.html",
		        				data : $("#address").serialize(),
		        				dataType: "json",
		        				async: false,
		        				success : function(data, textStatus, jqXHR) {
		        					//Box.maj(res);
		        					window.location.replace(contextPath+"/addressBook.html");
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

function addNewAddress() {
//	window.location = contextPath+"/addOrModifyAddress.html?addressType=shipping";
	Box.open({
		modal: true,
		url: contextPath+"/addOrModifyAddress.html?addressType=shipping",
		show:function(){
        	$(document).ready(function() {
        		
        		//var ZIPCODE_INF_CORSE = 20000;
        		//var ZIPCODE_SUP_CORSE = 20999;
        		
        		$.validator.addMethod("phone",function(value,element)
        				{
        				return /^[0-9\+]{0,18}$/i.test(value); 
        				},$.i18n._("MSG_TELEPHONE_ERR"));
        		
        		$.validator.addMethod("cp",function(value,element)
        				{
        				return /^[0-9]{4,10}$/i.test(value); 
        				},$.i18n._("MSG_CP_ERR_FP"));
        		
        		// Si il s'agit de l'ajout ou de la modification d'une adresse de livraison,
        		// on verifie que celle-ci n'est pas une adresse Corse
    			//$.validator.addMethod("cp",function(value,element)
        		//		{
        		//		return value<ZIPCODE_INF_CORSE || value>ZIPCODE_SUP_CORSE; 
        		//		},$.i18n._("MSG_CP_ERR_CORSE"));
        		
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
	        				url: contextPath+"/addOrModifyAddress.html",
	        				data : $("#address").serialize(),
	        				dataType: "json",
	        				async: false,
	        				success : function(data, textStatus, jqXHR) {
	        					window.location.replace(contextPath+"/addressBook.html");
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

function defaultAddress(addressId){
	window.location = contextPath + "/addressBook.html?addressId="+addressId+"&action=defaultAddress";
}

function deleteAddress(addressId){
	window.location = contextPath+"/addressBook.html?addressId="+addressId+"&action=deleteAddress";
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
				}, phone:"required phone",  maxlength:18
			},
			mobile:{ phone:"required phone",  maxlength:18 }
			

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
			phone:{required: $.i18n._("MSG_PHONE_VIDE"), maxlength: $.i18n._("MSG_TELEPHONE_ERR")},
			mobile:{required: $.i18n._("MSG_PHONE_VIDE"), maxlength: $.i18n._("MSG_TELEPHONE_ERR")}
		}
		,
		errorPlacement: function(error, element) {
			//Placement spécifique pour la civilité
			if(element.attr("name")=="codeCivilityId")
//				TODO placer correctement le message erreur
//				element.parent(".radios").after(error);
				element.parent(".civilite").after(error);
			else
				element.after(error);
	   }
	});
	
	

}
