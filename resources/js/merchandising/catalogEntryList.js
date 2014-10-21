//Au chargement de la page
$(document).ready(function(){
	//Menu Cat
	init_menuCat();
	loadAPartirDe();
	loadLabelSticker();
	/**
	 *  Lors de la validation du formulaire de CadeauxSearchPage.
	 */
	$("#valide").click(function(){
		var param = "";
		var urlFilter = "";
		$("select").each(function(){
			var tmpParam = addFilter2(this,this.name);
			if(tmpParam!=""){
				if(this.name=="categoryId"){
					param+=hasParam(urlFilter)+tmpParam;
					urlFilter += param;
				}else{
					param+=hasParam(urlFilter)+"f="+tmpParam;
					urlFilter += param;
				}
			}
		});
		location.href = window.location.pathname+param;
	});
});


//Gestion du menu Catégorie
function init_menuCat()
{
	if(isExist("#menu .cat"))
	{
		//On masque les entrées
//		$("#menu .cat ul").hide();
		
		$("#menu .cat > li").click(function(e){
			//On verifie si ce n'est pas une cat sans enfant
			if(!isExist($(e.delegateTarget).children("a")))
			{
				//Si on a cliqué sur le meme li
				if($(e.delegateTarget).hasClass("on"))
				{$("#menu .cat > li").removeClass("on").children("ul").slideUp(200);}
				//Si on a cliqué sur un li différent
				else
				{
					$("#menu .cat > li").removeClass("on").children("ul").slideUp(200);
					$(e.delegateTarget).addClass("on").children("ul").slideDown(200);
				}
			}
		});
	}
}

function hasParam(hasParam){
	if (hasParam.indexOf('?') == -1)
		return '?';
	else 
		return '&';	
}



function addAFilter(filtre, field) {
	if (filtre != "") {
		if (filtre.checked) {
			location.href = urlFilter+hasParam(urlFilter)+"f="+field+":"+(filtre.name);			
		} else {
			var paramUrl = urlFilter;
			paramUrl = paramUrl.replace("f="+field+":"+(filtre.name), "");
			paramUrl = paramUrl.replace("&&", "&");
			paramUrl = paramUrl.replace("?&", "?");
			paramUrl = paramUrl.replace(".html&", ".html?");
			var last = paramUrl.charAt(paramUrl.length-1);
			if (last == "?" || last == "&"){
				paramUrl = paramUrl.substring(0, paramUrl.length-1);
			}
			location.href = paramUrl;
		}
	}
}

function addFilter2(filtre, field) {	
	if (filtre != "") {
		if ($("#"+filtre.id + " option:selected").val()!="0") {
			if(field=="categoryId"){
				var result=field+"="+($("#"+filtre.id + " option:selected").val());
			}else{
				var result=field+":"+($("#"+filtre.id + " option:selected").val());
			}
			return result;					
		}
		else{
			return "";
		}
	}
}



function order(fieldOrder){
	var redirect = urlSort;
	if (fieldOrder.value != ""){
		redirect += hasParam(urlSort)+"sort="+fieldOrder.value;
	}
	location.href = redirect;
}



function addNavigationContext(anchor){
	var href= $(anchor).attr("href");
	if (href.indexOf("#") == -1){
		$(anchor).attr("href", href+ "#"+paramNavigationContext);
	}
}

function loadAPartirDe(){
	$(".aPartirDe").each(function(){
		var ceId = $(this).attr('id');
		if($.isNumeric(ceId)){
			$.ajax({
				type: "POST",
				url: contextPath+"/ajax/catalogEntryList.html?aPartirDe&ceId="+ceId,
				cache : true,
				async: true,
				success : function(boolean) {
					if(boolean || boolean == true || boolean == 'true')
//						$("#zoneP .produit .infos .prix #"+ceId).html('<span class="aPartirDe">A partir de : </span>');
						$("#zoneP .produit .infos .prix #"+ceId).text('A partir de : ');
				}
			});		
		}
	});
}

function loadLabelSticker(){
	$(".stickers .flag img").each(function(){
		var ceIdAndUrl = $(this).attr("id").split("_");
		var ceId = ceIdAndUrl[0];
		var url = ceIdAndUrl[1];
		
		if($.isNumeric(ceId) && url != null){
			$.ajax({
				type: "POST",
				url: contextPath+"/ajax/catalogEntryList.html?getLabelSticker&ceId="+ceId+"&url="+url,
				cache : true,
				async: true,
				success : function(label) {
					$("img[id='"+ceId+"_"+url+"']").attr("alt", label);
					$("img[id='"+ceId+"_"+url+"']").removeAttr("onmouseover");
				}
			});	
		}		
	});
	
}