$(document).ready(function(){
	
	initCart();
	$('.panier .ensemble').hide();
	
	// Désactivation des bouton - si la quantité est égale à 1
	$('.bouton_moins').each(function(index) {
		var parent = $(this).parent().parent().parent();
		quantiteElement=parent.find(':input[name="selectQuantity"]');
		var quantity = quantiteElement.val();
		
		if(quantity == 1) 
		{
			// Préférable de mettre une opacité à 0 plutôt qu'un hide pour garder la taille du bouton et éviter
			// de casser le design
			$(this).css('opacity','0');
			$(this).css('cursor','default');
		}
		else 
		{
			$(this).css('opacity','1');
		}
	});
	
	// Vérification si le calque contenant les articles doit être ouvert dans la jsp du panier
	var deployerDetailArticle = window.location.hash;
	if(deployerDetailArticle.indexOf("#show" )!= -1) {
		var id = deployerDetailArticle.replace('#show=','');
		$("#"+id).addClass('ouvert');
		$('.panier #ensemble_'+id).show();
	}
	
});

function initCart() {

	$('.panier .developpement a').click(function(){
		if ($(this).attr('class')=="ouvert"){
			$(this).removeClass('ouvert');
			$('.panier #ensemble_'+$(this).context.id).hide();
		}else{
			$(this).addClass('ouvert');
			$('.panier #ensemble_'+$(this).context.id).show();
		}
	});

	
	
	$(".papier_cadeau").click(function(){
		Box.open({ url: contextPath + "/papier.html", modal:true});
	});
	
	
	$(".cartLines").each(function(){
		$(this).data("skuId",$(".data",this).text());
		$(".data",this).remove();
	});
	$(".giftLines").each(function(){
		var data = $(".data",this).text().split("_");
		$(this).data("giftId",data[0]);
		$(this).data("operationId",data[1]);
		$(".data",this).remove();
	});
	$(".cartLines input").change(function() {
		updateQuantityCartItem($(this));
	});
	$(".cartLines .corbeille").click(function() {
		deleteCartItem($(this));
	});
	$("#chooseGift").submit(function(){return false;});
	$("#chooseGift input").click(function() {
		addGift(this);
	});
	$(".giftLines .corbeille").click(function() {
		deleteGiftItem(c);
	});
	
	$(".bouton_plus").click(function(){
		var parent = $(this).parent().parent().parent();
		quantiteElement=parent.find(':input[name="selectQuantity"]');
		var quantity = quantiteElement.val();
		quantity++;
		quantiteElement.val(quantity);
		updateQuantityCartItem(quantiteElement);
	});
	$(".bouton_moins").click(function(){
		// Si le bouton - est affiché (opacité ==1), et donc qu'on peut retirer de la quantité
		if($(this).css('opacity')=='1')
		{
			var parent = $(this).parent().parent().parent();
			quantiteElement=parent.find(':input[name="selectQuantity"]');
			var quantity = quantiteElement.val();
			quantity--;
			quantiteElement.val(quantity);
			updateQuantityCartItem(quantiteElement);
		}
	});

	$("#emballageCheck").click(function(){
		if( $(this).is(':checked') ){
			$("#emballage").submit();
		}else{
			window.location.href = contextPath + "/cart.html?skuDeleteId=" + $(this).val();
		}
	});
	
	if($("#emballageCheck").is(':checked')){
		$("#messageCadeau").focus();
	}
	
	$("#messageCadeau").blur(function(){
		$.post(contextPath + "/cart.html","messageCadeau="+$(this).val())
	});
	
	$(".bt_suivant").click(function(){
		if( $("#cgv").is(':checked') ){
			window.location.href = contextPath+"/cart.html?action=validate";
		}else{
			$("#error_cgv").text($.i18n._("MSG_CGV"));
			$("#error_cgv").css("display","block");
		}
		return false;
	});
	
	$(".identification").click(function(){
		if( $("#cgv").is(':checked') ){
			Box.open({url:'/VAD/login.html?request=/cart.html%3faction%3dvalidate&ajax=true', modal:true})
		}else{
			$("#error_cgv").text($.i18n._("MSG_CGV"));
			$("#error_cgv").css("display","block");
		}
		return false;
	});
	$("#cgv").click(function(){
		//$("#error_cgv").text("");

	});
}

function limitMessageGift(maxLength){
	var message = $("#messageCadeau").val();
	if(message != null && message.length >= maxLength){
		message = message.substring(0, maxLength);
		$("#messageCadeau").val(message);
		$("#error_msg_kdo").text($.i18n._("MSG_KDO"));
		$("#error_msg_kdo").css("display","block");
	}else{
		$("#error_msg_kdo").css("display","none");		
	}
}

function updateQuantityCartItem(element){
	var parent = element.parent().parent().parent();
	var skuId = parent.find(':input[name="skuIdLine"]').val();
	// Si c'est un article, on doit laisser ouvert le calque (contenant tous les articles) après rafraichissement de la page
	var ensemble = element.context.parentNode.parentNode.parentNode.parentNode.id.replace('ensemble_','');
	
	if($.isNumeric(element.val())){
		window.location.href = contextPath + "/cart.html?skuId=" + skuId + "&quantity=" + element.val() + "#show=" + ensemble;		
	}else{
		window.location.href = contextPath + "/cart.html";
	}
}

function deleteCartItem(element){
	var parent = element.parent();
	var skuId = parent.find(':input[name="skuIdLine"]').val();
	// Si c'est un article, on doit laisser ouvert le calque (contenant tous les articles) après rafraichissement de la page
	var ensemble = element.context.parentNode.parentNode.parentNode.id.replace('ensemble_','');
	// Si on a un ensemble d'articles
	if(ensemble!=null && ensemble!='')
		window.location.href = contextPath + "/cart.html?skuDeleteId=" + skuId + "#show=" + ensemble;
	// Si on a un produit
	else
		window.location.href = contextPath + "/cart.html?skuDeleteId=" + skuId;
}

function addGift(element){
	var giftId = $("#"+element.name+" option:selected").val();
	var operationId = element.name.split('_')[1];
	window.location.href = contextPath + "/cart.html?operationId="+ operationId +"&giftId=" + giftId;
}

function deleteGiftItem(element){
	var parent = element.parent();
	var gift_op = parent.find(':input[name="giftId"]').val();
	var giftId = gift_op.split('_')[0];
	var operationId = gift_op.split('_')[1];
	window.location.href = contextPath + "/cart.html?operationId="+ operationId +"&giftDeleteId=" + giftId;
}

function showModalUpdateQuantityImpossible(message){
	Box.open({ 
		url: contextPath+"/modalUpdateQuantitePanier.html", 
		modal:true,
		show:function(){
			$(".messageErreur").html("<br />"+message);
			$(".grey_box").click(function(){
				window.location.href = contextPath + "/cart.html";
			});
			$("div[class *= '_close']", this.el).click(function(){
				window.location.href = contextPath + "/cart.html";
			});
		}
	});
}