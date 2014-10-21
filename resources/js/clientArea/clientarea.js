//Au chargement de la page 
$(document).ready(function(){
	
	// Btn valid le formulaire code acces nouvelle adresse email
	$("#form_modification_email").validate({
		rules: {
			nouvelEmail: {
				required: true,
				email: true,
				maxlength:70,
				"regex":/^[a-zA-Z0-9][\\w\\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\\w\\.-]*[a-zA-Z0-9]\\.[a-zA-Z][a-zA-Z\\.]*[a-zA-Z]$/
			}
		},
		messages: {	
			nouvelEmail: {
				required:"Email obligatoire.",
				"regex":"Le format du mail n'est pas correct, veuillez le ressaisir."
			}
		}
	});
	$("#valider").click(function(){
		if($("#form_modification_email").valid()){
			$('#form_modification_email').submit();
		}
		return false;
	});
	
	
	
	
	
	


});

