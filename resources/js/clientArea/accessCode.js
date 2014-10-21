//Au chargement de la page 
$(document).ready(function(){
	
	// Btn valid le formulaire code acces nouvelle adresse email
	$("#form_modification_email").validate({
		rules: {
			nouvelEmail: {
				required: true,
				email: true,
				maxlength:70,
				minlength:6
			}
		},
		messages: {	
			nouvelEmail: {
				required:	$.i18n._("MSG_EMAIL_VIDE"),
				email:	$.i18n._("MSG_EMAIL_ERR")
			}
		}
	});
	$("#valider").click(function(){
		if($("#form_modification_email").valid()){
			$('#form_modification_email').submit();
		}
		return false;
	});
	
	
	
	
	
	
	// Btn valid le formulaire code acces nouveau mdp
	$("#form_modification_mdp").validate({
		rules: {
			mdpActuel: {
				required: true,
				minlength:6,
				maxlength:20
			},
			nouveauMdp: {
				required: true,
				minlength:6,
				maxlength:20
			},
			confirmationNouveauMdp: {
				required: true,
				equalTo: "#nouveauMdp"
			}
		},
		messages: {	
			mdpActuel: {
				required:  $.i18n._("MSG_OLD_PWD_VIDE"),
				minlength: $.i18n._("MSG_PWD_TROP_COURT"),
				maxlength: $.i18n._("MSG_PWD_TROP_LONG")
			},
			nouveauMdp: {
				required:  $.i18n._("MSG_PWD_VIDE"),
				minlength: $.i18n._("MSG_PWD_TROP_COURT"),
				maxlength: $.i18n._("MSG_PWD_TROP_LONG")
			},
			confirmationNouveauMdp: {
				required:  $.i18n._("MSG_PWD_CONFIRM_VIDE"),
				equalTo:   $.i18n._("MSG_NOT_SAME_PWD"),
				minlength: $.i18n._("MSG_PWD_TROP_COURT"),
				maxlength: $.i18n._("MSG_PWD_TROP_LONG")

			}
		}
	});
	
	$("#je_valide").click(function(){
		if($("#form_modification_mdp").valid()){
			$('#form_modification_mdp').submit();
		}
		return false;
	});

});

