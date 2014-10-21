$(document).ready(function() {

	showFirstLayers();
	
	$('#formulaire .ligne .clear .colonne_intitule input').click(function(){
		selectPaymentType(this);
		$('#formulaire .ligne .clear .colonne_intitule').removeClass('bold');
		$(this).parent().addClass("bold");
	});
	
	
	var elements = $('input[type=radio][name=paymentType]:checked');
	if(elements != null && elements.length>0){
		selectPaymentType(elements[0]);	
	}
	
	$("#CB").trigger("click");

});





function showFirstLayers(){
	$('#layers>div').hide();
}


function selectPaymentType(typeInput){

	var id = typeInput.value;
	
	
	if(id.indexOf("typeCB") >= 0){
		document.getElementById("hiddenInstancePayment").value = id.replace("typeCB" ,"");
		id = 'typeCB';
		
	}
	
	if(id.indexOf("typePayExterne") >= 0){		
		document.getElementById("hiddenInstancePayment").value = id.replace("typePayExterne" ,"");		
		id = "typePaymentExterne"+ id.replace("typePayExterne" ,"");
	}
	
	
	
    $('#layers>div').hide();
    $('#'+id).show();
    return false;
}






// ** gestion du switch des cases pour le numéro de carte **
function changeToOtherInput(input,event, nb){
	changeInput(input,event, nb, 4, 4, "numberPart");
}


function validPaymentExterne(idForm, instancePaymentId, transactionBiz){
	
	var acceptCondition = 'acceptCondition'+ idForm;
	
	var isAccept = true;//$('#'+acceptCondition).is(':checked'); 
	
	
	if(isAccept=='true' || isAccept == true ){
	$.ajax( {
		type : "GET",
		url : contextPath + "/ajax/saveOrder.html",
		dataType : "json",
		data: {"instancePaymentId" : instancePaymentId, "transactionBiz" : transactionBiz},
		cache: false,
		success : function(res) {			
			if(res==true || res == 'true'){
				$("#"+idForm).submit();
			}
			else{
				alert($.i18n._("payment.problem"));
			}
		}
	});
	}
	else{
		alert($.i18n._("payment.condition"));
	}
	
}


function changeInput(input,event, nb, nbCase, maxLength, id){
	value = input.value;
	numId = 0;
	// si on est en fin de case
	if (value.length>=(maxLength-1) && event.keyCode!=8) {
		checkEndInput(value, event, nb, nbCase, maxLength, id);
	} else if (value.length<=1 && event.keyCode==8) {
		// si on est en debut de case et que l'on supprime, on se déplace sur la précédente
		numId = nb-1;
		if (numId ==0)
			numId = 1;
		newFocus(id, numId);
	}
}

function checkEndInput(value, event, nb, nbCase, maxLength, id){
	numId = nb+1;
	if (numId == (nbCase+1)){
		numId = nbCase;
	}
	if (value.length==maxLength){
		// si la case actuel est déjà pleine, on rempli la suivante avant de se déplacer
		// seulement si elle ne contient pas de taille limite ou qu'elle n'est pas déjà remplie
		nextInput = $("#"+id+numId);
		maxLengthNextInput = nextInput.attr("maxlength");
		nextInputVal = nextInput.val();
		if (maxLengthNextInput == null || maxLengthNextInput > nextInputVal.length){
			$("#"+id+numId).val(nextInputVal + String.fromCharCode(event.charCode));
		}
	}
	newFocus(id, numId);
}

function newFocus(inputId, numId){
	newId = inputId+numId;
	$("#"+newId).focus();
}
// ** gestion du switch des cases pour le numéro de carte **

function showModalAnnulationPaiement(){
	Box.open({ 
		url: contextPath + "/annulationPaiement.html", 
		modal:true,
		show:function(){
			$(document).ready(function() {	
				//Passe le cookie à reloadable false, pour éviter de reloader en arrivant une nouvelle fois en page paiement
				$.cookie('reloadable', 'false', { expires: 30, path: '/'});
				$(".grey_box").click(function(){
					window.location.replace(contextPath+"/cart.html");
				});
				$("div[class *= '_close']", this.el).click(function(){
					window.location.replace(contextPath+"/cart.html");
				});
			});
		}	
	});
}