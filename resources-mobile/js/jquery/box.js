/* Gestion de la black_box */
var Box = {
	el: null,		// box actuel
	// Config par defaut
	init:{
		html: null, 	// html de la box
		modal: false,	// modal true / false
		relative: false,	// taille relative true / false
		beforeDim: null, 	// fonction a executer avant Dimensionnement
		show: null, 	// fonction a executer avant affichage
		afterShow: null, 	// fonction a executer apres affichage
		close: null, 	// fonction a executer a la fermeture de box
		top: 0,			// top css de la box
		left: 0,		// left css de la box
		url: null,		// Url de chargement du contenu
		urldata: null	// Paramètre de Url du contenu
	},

	// Charge la box
	open: function(p){
		//Verification d'une occurence / Si oui suppression
	
		if(this.el != null && this.el.length != 0){Box._close(p); return false;}
		$.extend(this, this.init, p);
		
		
		if(this.url != null){
			$.ajax({
				type: "GET",
				url: this.url,
				data: this.urldata,
				cache: false,
				//async: false,
				success: function(data){
					if($.trim(data).indexOf('<div')!=-1){
						Box.html = data;
						Box.load();
					}else{
						eval($.trim(data));
					}
				}
			});
		}else{
			Box.load();	
		}
		
		if (!this.modal) {
			// Raccourci clavier (Echap pour quitter)
			$(document).one("keydown", function (e) {
				if(e.which == 27) {
					Box._close();    
					return false;
				}
			});
		}
		
		if(this.modal){
			if($(".grey_box").length != 0){$(".grey_box").remove();}
			$('<div class="grey_box" style="filter: alpha(opacity=30);"></div>').prependTo("body").css({width: '100%', height: $(document).height()});
//			$(".grey_box").click(function(){Box._close();});
		}
	},
	
	
	// Montrer la box
	load: function(){
		// Ajoute la box a la page
		this.el = $(this.html).prependTo("body");
		
		// Execute fonction beforeDim si existente avant calcul des dimensions
		if(this.beforeDim){
			this.beforeDim();
		}
		// Execute fonction de taille relative avant affichage
		if(this.relative){
			// modif balise img si hauteur d'ecran < 730px (Rougier)
			if($(window).height() < 730){
				var nuwidth = $(window).height()-60;
				$('#modal .zoom').attr("width",nuwidth);
				$('#modal .zoom').attr("height",nuwidth);
			}
			
		}

		// Positionne la box au centre si non definit
		if(this.top == 0 && this.left == 0) {
			this.top = $(window).scrollTop() + ($(window).height()/2) - (this.el.innerHeight()/2);
			if (this.top<15) this.top=15;
			this.left = ($(window).width()/2) - (this.el.innerWidth()/2);
		}
		else {
			this.top = $(window).scrollTop() + ($(window).height()/2) - (this.el.innerHeight()/2) + this.top;
			this.left = ($(window).width()/2) - (this.el.innerWidth()/2) - this.left;
		}
		this.el.css({top: Box.top +"px", left: Box.left +"px"});
		
		this.events();
		
		//Apparition de la blackbox
		if(this.modal){
			
			// On fade le fond, puis on fade la modale
		
			$('.grey_box').fadeIn("fast", function(){
			
				Box.el.fadeIn("fast", function(){
				//Execution de la fonction afterShowE
					
					Box.afterShowE();
				
			});});
			
		
		}else{
			this.el.show();
		}
	},
	
	// Definit les evenements
	events: function(){
		// Definit le click de fermeture
		$("*[class *= '_close']", this.el).click(function(){
			Box._close(); return false;
		});
		
		// Execute fonction show si existente avant affichage
		if(this.show){
			this.show();
		}
	},
	
	// Fonction après affichage
	afterShowE : function(){
		if(this.afterShow){
			this.afterShow();
		}
	},
	
	// Mise a jour total de la box
	maj: function(data){
		if(this.el != null){
			this.el.html($(data).html());
			this.events();
		}
	},
	
	// Fermeture de la box
	_close: function(reload){
		
		if(Box.el != null){
			if(this.modal) {
				this.el.fadeOut("fast", function(){
					
					$(".grey_box").fadeOut("fast",	function(){
					
						$(".grey_box").remove(); 
						if(Box.el != null) {Box.el.remove();}
						Box.el = null;
						if(Box.close){Box.close();}
						if(reload != null){
							Box.open(reload);
						}
					});
				});
			}else{
				if(Box.el != null) {Box.el.remove();}
				Box.el = null;
				if(Box.close){Box.close();}
				if(reload != null){
					Box.open(reload);
				}
			}
		}
	}
}