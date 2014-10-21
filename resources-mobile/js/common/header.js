// Fonctions s'executant au chargement du header
$(document).ready(function(){
	
	// Apercu du panier
	initCartPreview();
	$('#header #email').val('votre adresse mail');
});

function deleteWordBeingSought(field){
	$(field).val("");
}


function S4() {
	   return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
	}
	function guid() {
	   return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());
	}

	
	

function initCartPreview(){
	
		if($.cookie("cart") != null && $.cookie("cart").indexOf("nb=")!= -1){
		
			var nb = $.cookie("cart").split("|")[3];
			nb = nb.replace("nb=","");
			
			$("#lien_panier_header").html("Mon panier (" + nb + ")");
			$("#receiptCountItem").html(nb);
			
		} 		
//	$.cookie("cart", $.cookie("cart").replace("chg=true","chg=false"),  {path: '/', expires: 365 });
				
} 

		
//alert($.cookie("cart").split('|')[2]);

function showPopinNewsletter(){
	Box.open({ 
		url: contextPath+"/newsletter.html?popin", 
		modal:true,
		show:function(){
			
			$("#popinNewsletter").validate({
				rules:{ email:{required:true, email:true} },
				messages:{ email:{required:$.i18n._("MSG_EMAIL_VIDE"), email:$.i18n._("MSG_EMAIL_ERR") }}
			});
			
			var expiration = new Date();
			expiration.setTime(expiration.getTime() + (30*24*60*60*1000));

			document.cookie = "popinNewsletterCookie=exist;path=/;expires="+expiration.toGMTString();
		}
	});
}

function postPopinNewsletterForm(){
	if($("#popinNewsletter").valid()){
		$.ajax({
			type: "POST",
			url: contextPath+"/newsletter.html?popin",
			data : $("#popinNewsletter").serialize(),
			dataType: "json",
			async: false,
			success : function(subscribed) {
				if(subscribed){
					Box._close();
				}
			},
			error : function(data){
				Box._close();
			}
		});		
	}
}