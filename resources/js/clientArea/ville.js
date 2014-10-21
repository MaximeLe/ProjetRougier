// JavaScript Document
/**
 * Gestion des villes correspondantes a un code postal
 */

// Raccourci fonctions ajax
function vila(ville, selected) {
	Ville.add(ville, selected);
}
function vilm() {
	Ville.maj();
};
function vilc() {
	Ville.clean();
};

var villeAjaxUrl = contextPath+"/retrieveCity.html";

var Ville = {
	ajaxurl: villeAjaxUrl,
	zone: null,
	ville: "",
	idcp: "cp",
	idville: "ville",
	idpays: "pays",

	load : function(zone, charge) {
		this.zone = zone;

		// Definit l'evenement change des textbox des CP
		$("input[id^=" + this.idcp + "]", zone).change( function() {
			Ville.open(this);
		});
	
		// Definit l'evenement change des selectbox des pays
		$("select[id^=" + this.idpays + "]", zone).change( function() {
			$("#" + Ville.idcp, zone).change();
					
		});
		
		// Definit l'evenement change des selectbox des villes
		$("select[id^=" + this.idville + "]", zone).change( function() {		
			
			if (this.value == "0") {
				
				$("#divsaisieville", zone).show();
				//$("#" + Ville.idville, zone).val("").focus();
				
			} else {
				$('input[id=saisieville]').val("");
				$("#divsaisieville", zone).hide();
			}
		});
		
		if (charge) {
			// on load au démarrage
			$("input[id^=" + this.idcp + "]", zone).change();
		}
	},

	// Charge les villes correspondantes au CP
	open : function(el) {		
		var cp = $("#cp").val() ;
		var id = el.id;				
		var pays = $("#" + this.idpays).val();
		var villeOriginal = "";
		if($("#villeOriginal").size() > 0) {
			villeOriginal = $("#villeOriginal").html();
		}
		var zipCodeOriginal= "";
		if($("#zipCodeOriginal").size() > 0) {
			zipCodeOriginal = $("#zipCodeOriginal").html();
		}
		
		this.ville = "";

		if (cp == "" || pays == "0") {
			$("#" + this.idville, this.zone).empty().change().attr("disabled", "disabled");
		} else {
		    var params = jQuery.param({'cp': cp, 'pays': pays});	
		    $.ajax({
	    		url: this.ajaxurl, 
	    		data: {zipCode: cp, country:pays, originalCity:villeOriginal, originalZipCode:zipCodeOriginal}, 
	    		success: function(liste){
			    	vilc();
			    	for(var i = 0; i < liste.length; i++) {
			    		if(liste[i][0] == "Other") {
			    			$("#saisieville").val(""+liste[i][1]);
			    		} else {
			    			vila(liste[i][0], liste[i][1]);	
			    		}
					}		
					vilm();
			    	$("#" + Ville.idville).change();
				}
		    });
		}
	},

	
	// Recupère les villes
	add : function(ville, selected) {
		villeKey = ville;
		if (ville == "Autre") {
			villeKey = "0";
		} 
		if(selected == 'true') {
			this.ville += "<option value=\"" + villeKey + "\" selected=\"selected\" >" + ville + "</option>";
		} else {
			this.ville += "<option value=\"" + villeKey + "\">" + ville + "</option>";
		}		
		
	},

	// Affiche le resultat
	maj : function() {
	$("#" + this.idville).removeAttr("disabled").html(this.ville);
	},
	
	clean : function() {
		this.ville = "";
	},
	
	clear : function() {
		$("#" + this.idville, this.zone).empty().change().attr("disabled", "disabled");
	}
}