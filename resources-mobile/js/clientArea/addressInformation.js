//Au chargement de la page // Initialisation des scripts
$(document).ready(function(){
	
	
	init_student();
	init_validator();
	
	$("#customerDisplayBean").submit(function(){
		if($("#customerDisplayBean").valid()){
			return true;
		}
		else {
			return false;
		}
	});
	
	// Btn valid le formulaire code acces nouvelle adresse email
	$("#customerDisplayBean").validate({
		rules: {
			civility: { 	
				required: true
			},
			lastName: {
				required: true,
				maxlength: 40
			},
			firstName: {
				required: true,
				maxlength: 40
			},
			dayOfBirth:{ verif_birthDate: true},
			monthOfBirth:{ verif_birthDate: true},
			yearOfBirth:{ verif_birthDate: true},
			
			addressLine1: {
				required: true,
				maxlength: 40
			},
			zipCode: {
				required: true,
				postalcode: true
			},
			city: {
				required: true,
				regex:  /^[A-Z ]*/
			},
			countryId: {
				required: true
			},
			
			//phone:{
			//	required:true,
			//	regex: /^[0-9\+ ]*$/		
			//},
			//mobile:{
			//	regex: /^[0-9\+ ]*$/
			//},
			
			phone:{ 
				required:function(){
					return $("#portable").val()=='';
				}, 
				phone:"required phone",  
				maxlength:18
			},
			portable:{ 
				phone:"required phone",  
				maxlength:18 
			},
			
			promotion:{
				required:function(){
					if($('#typeClientId option:selected').val() == '12' && $('#promotion option:selected').val() == '0')
						{return true;}
					else{return false;}
				},
				min: function(){if($('#typeClientId option:selected').val() == '12')
					{return 1;}
					else{return 0;}
				}
			},
			etablissement:{
				required:function(){
					return $('#typeClientId option:selected').val() == '12' ? true: false
				}
			},
			formation:{
					required:function(){
						return $('#typeClientId option:selected').val() == '12' ? true: false
					}
			},
			isValidStudent:{
				required:function(){
					return $('#typeClientId option:selected').val() == '12' ? true: false
				}
			}
		
		},
		messages: {	
			civility: {
				required: $.i18n._("MSG_CIVILITE_VIDE")
			},
			lastName: {
				required: $.i18n._("MSG_NOM_VIDE"),
				maxlength : $.i18n._("MSG_NOM_TROP_COURT")
			},
			firstName: {
				required: $.i18n._("MSG_PRENOM_VIDE"),
				maxlength : $.i18n._("MSG_PRENOM_TROP_COURT")
			},
			addressLine1: {
				required: $.i18n._("MSG_ADRESSE_VIDE")
			},
			zipCode: {
				required:	$.i18n._("MSG_CP_VIDE"),
				postalcode:	$.i18n._("error.incorrect")
			},
			city: {
				required: $.i18n._("MSG_VILLE_VIDE"),
				regex :"Le nom de ville n'est pas correct."
			},
			countryId: {
				required:"Pays obligatoire."
			},
			//phone:{
			//	required: "Merci de vérifier la saisie de votre numéro de téléphone.",
			//	regex:	"Merci de vérifier la saisie de votre numéro de téléphone."
			//},
			//mobile:{
			//	regex:	"Merci de vérifier la saisie de votre numéro de portable."
			//},
			phone:{required: $.i18n._("MSG_PHONE_VIDE"), maxlength: $.i18n._("MSG_TELEPHONE_ERR")},
			portable:{required: $.i18n._("MSG_PHONE_VIDE"), maxlength: $.i18n._("MSG_TELEPHONE_ERR")},
			
			
			
			promotion:{
				required: $.i18n._("MSG_ETUDIANT_SANS_PROMO"),
				min: ""
				},
			etablissement:{
					required: $.i18n._("MSG_ETUDIANT_SANS_ETABLISSEMENT")
				},
			formation:{
					required: $.i18n._("MSG_ETUDIANT_SANS_FORMATION")
			},
			isValidStudent:{
				required: $.i18n._("MSG_ETUDIANT_CERTIF")
			}
			
		},
        errorPlacement: function (error, element) {
        	if ( element.attr("id") == "dayOfBirth") {
        		error.prependTo( element.parent().next().next().next().next().next());
        	}
        	else if ( element.attr("id") == "monthOfBirth") {
        		error.prependTo( element.parent().next().next().next().next());
        	}
            else {
                   error.insertAfter( element );
            }  
        }
	});
	
	$("#je_valide").click(function(){
		if($("#customerDisplayBean").valid()){
			var firstname = $("#prenom").val();
			var lastname = $("#nom").val();
			updateCustomerCookie(firstname, lastname);
			$('#customerDisplayBean').submit();
		}
		return false;
	});
	
})

$("#whereFindNum").click(function(){
	openModalWhereFindNum(); 
});

/*fonction d'ouverture de la modal de mot de passe perdu*/
function openModalWhereFindNum(){
	Box.open({ 
		url: contextPath + "/addressInformation.html?whereIsMyCardNumber",
		modal:true
	});
}

//Fonction gérant l'etat étudiant
function init_student(){
	if(isExist("#typeClientId"))	{
		//On cache
		if($("#typeClientId").val() != 12){
			$("#student").hide();			
		}
		//On associe au changement
		$("#typeClientId").change(function(){
			if($(this).val()==12)
				$("#student").slideDown(200);
			else
				$("#student").slideUp(200);
		});		
	}
}


function init_validator(){
	
	jQuery.validator.addMethod("postalcode", function(postalcode, element) {
		return this.optional(element) || postalcode.match(/^[0-9]{4,10}$/i);
	}, $.i18n._("MSG_ZIPCODE_FORMAT"));
	
	jQuery.validator.addMethod('regex', function(value, element, param) {
	    return this.optional(element) || value.match(param);
	},'This value doesn\'t match the acceptable pattern.');
	
	jQuery.validator.addMethod("verif_birthDate",
			function(verif_birthDate, element) {
	  			var verif_group = true;
				var jour = $("#dayOfBirth").val();
				var mois = $("#monthOfBirth").val();
				var annee = $("#yearOfBirth").val();
				
				if((jour != "" && jour != "JJ") || (mois != "" && mois != "MM") || (annee != "" && annee != "")){
					var birthDay = jour + "/" + mois + "/" + annee;
					verif_group = birthDay.match(/^\d\d?\/\d\d?\/\d\d\d\d$/) != null;
					
					if(verif_group==true && annee > 1900){
						if(mois >= 1 && mois <= 12){
							//cas mois(id impair): Jan:1, Mars:3, Mai:5 ou (id pair): Juil:7, Août:8, Oct:10, Dec:12
							if((mois %2 == 1 && mois <= 7 ) || (mois % 2 == 0 && mois >= 8)){
								if(jour < 1 || jour > 31){verif_group = false;}
								else{/*TODO METHOD*/}
							}
							else{ //cas des mois: Avril, Juin, Sept., Nov.
								if(mois==4 || mois==6 || mois==9 || mois==11 ){
									if(jour >30){verif_group = false;}
									else{/*TODO METHOD*/}
								}
								else{ // Une annee bissextile: il y a un 29 Fevrier.
									if(annee % 4 == 0 && (annee % 100 != 0 || annee % 400 == 0)){
										if(jour >29){verif_group = false;
										}
										else{/*TODO METHOD*/}
									}
									else{//Sinon: 28 Fevrier
										if(jour >28){verif_group = false;}
										else{/*TODO METHOD*/}
									}
								}
							}
						}
						else{verif_group = false;}
					}
					else{verif_group = false;}
				}
				else
					{verif_group = false;}
				return verif_group;
	}, $.i18n._("MSG_BIRTH_DATE_ERR"));
}

