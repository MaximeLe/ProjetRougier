//Visionneuse Rougier & Ple

//Au chargement de la page
$(document).ready(function(){
	init_visio(1,1,"#visio",5000);
	var globalTimer = 0;
});

//Visionneuse Infini
function init_visio(nbI,pas,el,timer)
{
	//Verification de l'existant
	if($(el).length>0 && $(el+" .item").length>nbI)
	{	
		//Clonage NbVisible
		$(el+" .scroll").append('<div class="suivTemp" style="display:none;"></div>')
		for(i=0;i<(nbI);i++)
		{
			$(el+" .suivTemp").append($(el+" .item:eq("+i+")").clone());
		}
		
		//On affecte une classe originale aux premiers elements
		$(el+" .content .item").addClass("original");
		
		//On ajoute les li manquants selon le nombre d'element originaux
		for(i=1;i<$(el+" .item.original").length;i++)
		{
			$(el+" .numero").append("<li></li>");
		}
		
		//Copie des donnees//Effacement des temps
		$(el+" .content").append($(el+" .suivTemp").html());
		$(el+" .suivTemp").remove();
		
		//Setting de la taille
		$(el+" .content").width(($(el+" .item").length*$(el+" .item").width()));
		
		//Positionnement a l'item 1
		$(el+" .content").css("left","0px")
		
		//On Bind les elements
		$(el+" .prev").bind('click',function(){visioPrev(nbI,el,pas,timer);});
		$(el+" .next").bind('click',function(){visioNext(nbI,el,pas,timer);});
		$(el+" .numero li").bind('click',function(){visioJump(this,nbI,el,pas,timer);});
		
		//On lance la fonction automatique
		globalTimer = setInterval(function(){visioNext(nbI,el,pas,timer);}, timer);
		
		//On affecte un killau mouse over et un set au mouse out
		$(el).hover(
			function(){
				//On Kill
				clearInterval(globalTimer);
				$(this).data('hover',true);
			},
			function(){
				//On Set
				globalTimer=setInterval(function(){visioNext(nbI,el,pas,timer);}, timer);
				$(this).data('hover',false);
			}
		);
	}
	else
	{
		$(el+" .prev,"+el+" .next").css("visibility","hidden");
	}
}

//Deplacement de la Visionneuse Infini
function visioPrev(nbI,el,pas,timer,jump)
{
	//On enleve l'interval
	clearInterval(globalTimer);
	
	//Unbind des elements de navigation
	$(el+" .prev, "+el+" .next").unbind('click');
	$(el+" .numero li").unbind('click');
	
	//T'es au bout(YAH!) ?
	if(returnWPX($(el+" .content").css("left"))==0)
		$(el+" .content").css("left","-"+($(el+" .item").length-nbI)*$(el+" .item").width()+"px");
		
	//On doit JUMPER !
	var oldPas = pas;
	if(arguments.length==5)
	{
		pas = jump;
	}
	
	$(el+" .content").animate({left:'+='+(pas*$(el+" .item").width())},400,function(){
		pas = oldPas;
		visioPos(nbI,el,pas);
		//Remise en route de l'interval et de la nav
		if(!$(el).data("hover"))
		{
			//Kill preventif pas de double Set (clic et sort)
			clearInterval(globalTimer);
			globalTimer=setInterval(function(){visioNext(nbI,el,pas,timer);}, timer);
		}
		$(el+" .prev").bind('click',function(){visioPrev(nbI,el,pas,timer);});
		$(el+" .next").bind('click',function(){visioNext(nbI,el,pas,timer);});
		$(el+" .numero li").bind('click',function(){visioJump(this,nbI,el,pas,timer);});
	});
}

//Deplacement de la Visionneuse infini
function visioNext(nbI,el,pas,timer,jump)
{
	//On enleve l'interval
	clearInterval(globalTimer);
	
	//Unbind des elements de navigation
	$(el+" .prev, "+el+" .next").unbind('click');
	$(el+" .numero li").unbind('click');
	
	//T'es au bout(YAH!) ?
	if(returnWPX($(el+" .content").css("left"))=="-"+($(el+" .item").length-nbI)*$(el+" .item").width())
		$(el+" .content").css("left","0px");
	
	//On doit JUMPER !
	var oldPas = pas;
	if(arguments.length==5)
	{
		pas = jump;
	}
	
	$(el+" .content").animate({left:'-='+(pas*$(el+" .item").width())},400,function(){
		pas = oldPas;
		visioPos(nbI,el,pas);
		//Remise en route de l'interval et de la nav
		if(!$(el).data("hover"))
		{
			//Kill preventif pas de double Set (clic et sort)
			clearInterval(globalTimer);
			globalTimer=setInterval(function(){visioNext(nbI,el,pas,timer);}, timer);
		}
		$(el+" .prev").bind('click',function(){visioPrev(nbI,el,pas,timer);});
		$(el+" .next").bind('click',function(){visioNext(nbI,el,pas,timer);});
		$(el+" .numero li").bind('click',function(){visioJump(this,nbI,el,pas,timer);});
	});
}

//Retourne la position de l'element
function visioPos(nbI,el,pas)
{
	//Nb elements originaux
	var nbO = $(el+" .item.original").length;
	//Calcul de la position
	var pos = ((returnWPX($(el+" .content").css("left"))*-1)/(nbI*$(el+" .item").width()))+1;
	//Si on est dans les duplications
	if(pos>nbO)
		pos=pos-nbO;
	//Retourne la valeur
	$(el+" .numero li").removeClass("on");
	$(el+" .numero li:eq("+(pos-1)+")").addClass("on");
}

//Fonction de Jump
function visioJump(li,nbI,el,pas,timer)
{
	if(!$(li).hasClass("on"))
	{
		var index = $(li).index()+1;
		//Nb elements originaux
		var nbO = $(el+" .item.original").length;
		//Calcul de la position
		var pos = ((returnWPX($(el+" .content").css("left"))*-1)/(nbI*$(el+" .item").width()))+1;
		//Si on est dans les duplications
		if(pos>nbO)
			pos=pos-nbO;
			
		var ecart = index-pos;
			
		if(ecart<0)
		{
			ecart = ecart*(-1);
			visioPrev(nbI,el,pas,timer,ecart);
		}
		else
		{
			visioNext(nbI,el,pas,timer,ecart);
		}
	}
}