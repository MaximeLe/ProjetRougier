/**
 * si l'on est connecté, récupére les information de l'utilisateur
 */
if (connected == 'true'){
	window.location = contextPath+"/signup.html?"+referer+"authentify";
}


//Au chargement de la page // Initialisation des scripts
$(document).ready(function(){
	initLogin()

	
});

function initLogin(){
	var message ="Le format du numéro de téléphone saisie est incorrect";
	$("#loginForm input[type=image]").click(function(){
		if($("#loginForm").valid())
		{
			$("#loginForm").submit();
		}
		return false;
	});

	$("#customerAccountForm input[type=image]").click(function(){

		if($("#customerAccountForm").valid())
		{
			$("#customerAccountForm").submit();
		}
		return false;
	});
	//Oublie de mot de passe
	$("#forgotPassword").click(function(){
		openModalForgotPassword(document.getElementById("adresse_mail").value); 
	});
	//Creation de compte
	$("#accountCreation").click(function(){
		ajaxCallToFindCustomerByEmail();
	});
	
	//Affichage ou non du formulaire complet
	if($("#adresse_email").val()=='')
		$("#maskedForm").hide();
	else
		$("#accountCreation").hide();
	
	//Initialisation Etudiant
	init_student();
	//validation du formulaire d identification
	$("#loginForm").validate({
		rules: {
			login: {
				required: true,
				email: true
			},
			password: {
				required: true,
				minlength: "6",
				maxlength: "20"
			}
		},
		messages: {
			password: {
				required:  $.i18n._("MSG_PWD_VIDE"),
				minlength: $.i18n._("MSG_PWD_ERR"),
				maxlength: $.i18n._("MSG_PWD_ERR")
			}, 
			login: {
				required: $.i18n._("MSG_EMAIL_VIDE"),
				email:  $.i18n._("MSG_EMAIL_ERR")
			}
		}
	});
	
	//surcharge du submit pour gerer l'appui sur Entree
	$("#customerAccountForm").submit(function(event){
		if(!$('#maskedForm').is(":visible")) {
			event.preventDefault();
			ajaxCallToFindCustomerByEmail();
		}
	});
	
	//validation du formulaire de creation de compte
	$("#customerAccountForm").validate({
		focusCleanup: true,
		rules: {
			mail: {
				required: true,
				email: true
			},
			"login.password": {
				required: true,
				minlength: "6",
				maxlength: "20"
			},
			"login.confirmPassword": {
				required: true,
				minlength: "6",
				maxlength: "20",
				equalTo: "#creationCompte_mot_de_passe"
				
			},
			civility:{
				required :true
			},
			lastName:{
				required: true
			},
			firstName:{
				required: true
			},
			addressLine1:{
				required:true
			},
			zipCode:{
				required:true,
				postalcode: true
			},
			city:{
				required:true
			},
			otherCity:{
				required:function(){return $("#saisieville").is(":visible");}
			},
			phone:{
				phoneControl:true,
				phoneSyntaxeControl:true
			},
			mobile:{
				phoneControl:true,
				phoneSyntaxeControl:true	
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
			mail: {
				required: $.i18n._("MSG_EMAIL_VIDE"),
				email:    $.i18n._("MSG_EMAIL_ERR")
			},
			"login.password": {
				required:  $.i18n._("MSG_PWD_VIDE"),
				minlength: $.i18n._("MSG_PWD_TROP_COURT"),
				maxlength: $.i18n._("MSG_PWD_TROP_LONG")
			}, 
			"login.confirmPassword": {
				required:  $.i18n._("MSG_PWD_CONFIRM_VIDE"),
				equalTo:   $.i18n._("MSG_NOT_SAME_PWD"),
				minlength: $.i18n._("MSG_PWD_TROP_COURT"),
				maxlength: $.i18n._("MSG_PWD_TROP_LONG")
			},
			civility:{
				required :$.i18n._("MSG_CIVILITE_VIDE")
			},
			lastName:{
				required: $.i18n._("MSG_NOM_VIDE")
			},
			firstName:{
				required: $.i18n._("MSG_PRENOM_VIDE")
			},
			addressLine1:{
				required: $.i18n._("MSG_ADRESSE_VIDE")
			},
			zipCode:{
				required: $.i18n._("MSG_CP_VIDE"),
				postalcode: $.i18n._("MSG_CP_ERR")
			},
			city:{
				required:$.i18n._("MSG_VILLE_VIDE")
			},
			otherCity:{
				required:$.i18n._("MSG_VILLE_VIDE")
			},
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
		errorPlacement: function(error, element) {
			//Placement spécifique pour la civilité
			if(element.attr("name")=="civility")
				element.parent(".civ").after(error);
			else
				element.after(error);
		   }
	});
	
	if($("#errorLogin").text()!=""){
		$("#customerAccountForm #adresse_email").val($("#loginForm #adresse_mail").val());
	}
}


jQuery.validator.addMethod("phoneControl", function (value,element) {
	var phone = $('#phone').val();
	var mobile = $('#mobile').val();
	
	if(!phone && !mobile) {
		return false;
	}
	$('#phone').next('.error').hide();
	$('#mobile').next('.error').hide();
	
	document.getElementById("phone").value = $('#phone').val().replace(/\s+/g, "");
	document.getElementById("mobile").value = $('#mobile').val().replace(/\s+/g, "");
	
	return true;

}, "Merci de remplir l'un des deux champs téléphone");

jQuery.validator.addMethod("phoneSyntaxeControl", function (value, element) {
	return controlPhoneSyntaxe(value);
}, "Le format du numéro de téléphone saisie est incorrect ou vide");

function controlPhoneSyntaxe(phone_number){
	if(!phone_number) {
		return true;
	}

	phone_number = phone_number.replace(/\s+/g, "");
	var nb_occur = phone_number.match(/[+]{0,1}[1-9]{0,2}[0-9]{7,10}/);
	if(nb_occur) {
		return true;
	}
	return false;
}

//Fonction gérant l'etat étudiant
function init_student()
{
	if(isExist("#typeClientId"))
	{
		//On cache
		$("#student").hide();
		
		//On associe au changement
		$("#typeClientId").change(function(){
			if($(this).val()==12)
				$("#student").slideDown(200);
			else
				$("#student").slideUp(200);
		});
	}
}


/*fonction d'ouverture de la modal de mot de passe perdu*/
function openModalForgotPassword(login){
	Box.open({ 
		url: contextPath+"/ajax/modalForgotPassword.html?login="+login, 
		modal:true,
		show: function(){
			//validation du formulaire mot de passe oublié
			$("#forgotPasswordForm").validate({
				rules:{
					login:{
						required:true,
						email:true
					}
				},
				messages:{
					login:{
						required:	$.i18n._("MSG_EMAIL_VIDE"),
						email: $.i18n._("MSG_EMAIL_ERR")
					}
				}
			});
			$("#forgotPasswordForm").submit(function() {
				if($("#forgotPasswordForm").valid() ){
					postModal();
					return false;
				}
				else return false;
			});
			$("#modal").center();
		}
	});
}


function postModal(){
	$.ajax({
		type: "POST",
		url: contextPath + "/ajax/modalForgotPassword.html",
		dataType: "html",
		async: false,
		data: {"login" : document.getElementById('forgotPasswordLogin').value},
		success : function(res) {
			$("#adresse_mail").val(document.getElementById('forgotPasswordLogin').value);
			Box.maj(res);
		}
	});	
}

/**
 * Fonction Ajax
 * Permet de recupèrer un customer en base par son email
 * Mis à jour du formulaire de création de compte
 */
function ajaxCallToFindCustomerByEmail(){
	var email = $('#adresse_email').val();
	$.ajax({
		type:"POST",
		url:contextPath+"/signup.html?action=getCustomerByEmail",
		data:{
			"email": email
		},
		dataType: 'json',
		cache:false,
		success:function(customer){
			setInputsForCreateAccount(customer);
		}
	});
}


/**
 * Fonction qui remplie les champs du formulaire de création de compte
 * En entrée le Customer
 */
function setInputsForCreateAccount(customer){
	if(customer.civility == 1){
		$('input[id="m"]').attr("checked", "checked");		
	}else if(customer.civility == 2){
		$('input[id="mme"]').attr("checked", "checked");		
	}else if(customer.civility == 3){
		$('input[id="melle"]').attr("checked", "checked");		
	}
	
	$('#customerId').val(customer.customerId);
	$('#nom').val(customer.lastName);
	$('#prenom').val(customer.firstName);
	$('#adresse').val(customer.addressLine1);
	$('#complement_adresse1').val(customer.addressLine2);
	$('#phone').val(customer.phone);
	$('#mobile').val(customer.mobile);
	$('#cp').val(customer.zipCode);
	if(customer.countryId != null){
		$('#pays').val(customer.countryId);		
	}else{
		//On set la France par défaut
		$('#pays').val(1);	
	}
	
	if($("#pays").val() != 0) {			
			Ville.load($("#customerAccountForm"), true);  			
	} else {
		Ville.load($("#customerAccountForm"), false);
		Ville.clear();			
	}
	
	$("#accountCreation").hide().next("#maskedForm").slideDown(200);
	$("#modal").animate({top:"-=250px"},200);
}

function loginAjax(){
	$.ajax({
		type:"POST",
		url:contextPath+"/login.html?action=validate&"+$("#loginForm").serialize(),
		dataType: 'script',
		cache:false
	});
}

function signupAjax(){
	$.ajax({
		type:"POST",
		url:contextPath+"/signup.html?"+$("#customerAccountForm").serialize(),
		dataType: 'script',
		cache:false
	});
}