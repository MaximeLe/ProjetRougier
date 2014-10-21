//Au chargement de la page 
$(document).ready(function(){
	
	// Btn valid le formulaire newsletter
	$("#newsletterSelect").validate({
		rules: {
			email: {
				required: true,
				email: true
			},
			nom:{maxlength: 32},
			prenom:{maxlength: 32},
			etablissement:{maxlength: 32}
		},
		messages: {			
			
			email:
			{
				required:$.i18n._("MSG_EMAIL_VIDE"),
				email: $.i18n._("MSG_EMAIL_ERR")
			},
			nom:{
				maxlength:$.i18n._("MSG_NOM_ERR")
			},
			prenom:{
				maxlength:$.i18n._("MSG_PRENOM_ERR")

			},
			etablissement:{
				maxlength:$.i18n._("MSG_ETABLISSEMENT_ERR")

			}
			
		}
	});
	$("#btnValiderFormNewsLetter").click(function(){
		if($("#newsletterSelect").valid()){
			$('#newsletterSelect').submit();
			showMessage();
		}
		return false;
	});
	

});

function hideMessage(){
	if($('#inscriptionReussie1').css("display") != "none"){
		$('#inscriptionReussie1').css("display", "none");
	}
	if($('#mailMalForme').css("display") != "none"){
		$('#mailMalForme').css("display", "none");	
	}
	if($('#inscriptionReussie2').css("display") != "none"){
		$('#inscriptionReussie2').css("display", "none");
	}
}

function showMessage(){
	$('#inscriptionReussie2').css("display", "block");
}

