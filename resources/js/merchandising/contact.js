//Au chargement de la page 
$(document).ready(function(){
	
	$('#info_num_com').css('display','none');

	
	$('#typeDemande ').change(function(){
	if($("#typeDemande option:selected").attr('value')==9){
		$('.lienNewsLetter').css('display','none');
		$('#info_num_com').css('display','none');
		$('#info_message').css('display','none');
	}else{
		$('#info_message').css('display','block');
		$('#info_num_com').css('display','block');
		$('.lienNewsLetter').css('display','none');
		if($("#typeDemande option:selected").attr('value')==3){
			$('#info_num_com').css('display','block');
		}else{
			$('#info_num_com').css('display','none');
		}
		
	}
});
	// Btn Envoyer du formulaire contact
	$("#contactFormId").validate({
		rules: {
			civility: {
				required: true
			},
			nom: {
				required: true
			},
			prenom: {
				required: true
			},
			email: {
				required: true,
				email: true
			},
			numeroCommande:{
				required:function(){return $("#numeroCommande").is(":visible");}
			},
			texteContact:{
				required:function(){return $("#texteContact").is(":visible");}
			}
		},
		messages: {			
			civility: {
				required: $.i18n._("MSG_CIVILITE_VIDE")
			},
			nom:{
				required: $.i18n._("MSG_NOM_VIDE")
			},
			prenom:{
				required: $.i18n._("MSG_PRENOM_VIDE")
			},
			email:{
				required: $.i18n._("MSG_EMAIL_VIDE"),
				email: 	  $.i18n._("MSG_EMAIL_ERR"),
				"regex":  $.i18n._("MSG_EMAIL_ERR")
			},
			numeroCommande:{
				required:$.i18n._("MSG_NUM_CMD_VIDE")
			},
			texteContact:{
				required:$.i18n._("MSG_TXT_AREA_VIDE")
			}
		},
		errorPlacement: function(error, element) {
		    if ( element.is("#melle") ) {
		        element.nextAll('div').html(error);
		    } else {
		        error.insertAfter( element );
		    }
		}
	});

});


function displayModalContact() {
	Box.open({
		modal: true,
		url: contextPath+"/contact.html",
		show:function(){
        	$(document).ready(function() {
				if($("#pays").val() != 0) {			
		  			Ville.load($("#address"), true);  			
				} else {
					Ville.load($("#address"), false);
					Ville.clear();			
				}
			});
		}
	});
};
function checkForm() {
	if($("#contactFormId").valid()){
		$(".formulaire_contact .envoyer").hide();
		$("#divErreurEnvoiFormulaire").hide();
		$.ajax({
			type:"POST",
			url:contextPath+"/ajax/contact.html",
			data: $("#contactFormId").serialize(),
			dataType: 'json',
			cache:false,
			async:false,
			success:function(){
				Box.open({
					modal: true,
					url: contextPath+"/modalContact.html?type="+$("#typeDemande option:selected").attr('value'),
					close:function(){
						window.location.href="/";
					}
				});
			},
			error:function(){
				$("#divErreurEnvoiFormulaire").show();
			}
		});
	}
	return false;
}
