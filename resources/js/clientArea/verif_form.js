var ValidatorMessage = {
	// class ou ID du span créée qui contiendra les erreurs (class par défaut)
	spanError : "erreur",
	// messages d'erreurs par defaut (si rien n'est entré dans les message personalisés)
	vide	  : $.i18n._("signup.error.vide_def"),
	regex	  : $.i18n._("signup.error.regex_def"),
	cdp		  : $.i18n._("signup.error.cdp_def"),
	vide	  : $.i18n._("signup.error.vide_def"),
	mdp		  : $.i18n._("signup.error.mdp_def"),
	size	  : $.i18n._("signup.error.size_def"),
	conf_mdp  : $.i18n._("signup.error.conf_mdp_def"),
	email	  : $.i18n._("signup.error.email_def"),
	radio	  : $.i18n._("signup.error.radio_def"),
	init 	  : function(parameters){
		$.extend(this, parameters);
		return this;
	}
};


minMdp = 6;
maxMdp = 12;

var Validator = {
	radio	 : [],
	email	 : [],
	mdp		 : [],
	cdp		 : [],
	champs	 : [],
	champs_no_ob : [],
	msg		 : null,
	isValid	 : true,
	options	 : null,
	valid	 : function(p) {
		$("."+this.spanError).remove();
		$.extend(this, p);
		
		//verif : input type radio
		for (i = 0; i < this.radio.length; i++) {
			var error = "";
			error = this.verif_notEmpty(this.radio[i]);
			if (error == ""){
				error = this.verif_radio(this.radio[i]);
			}
			this.showError(this.radio[i], error, this.msg.radio);
		}
		
		//verif : champs (text, nom, prenom, adresse etc...)
		for (i = 0; i < this.champs.length; i++) {
			var error = "";
			error = this.verif_notEmpty(this.champs[i]);
			if (error == ""){
				error = this.verif_regex(this.champs[i],"^[a-zA-Z0-9\-\ ]+$");
			}
			this.showError(this.champs[i], error, this.msg.champs);
		}
		
		//verif : champs non obligatoire
		for (i = 0; i < this.champs_no_ob.length; i++) {
			var error = "";
			error = this.verif_regex(this.champs_no_ob[i],"^[a-zA-Z0-9\-\ ]*$");
			this.showError(this.champs_no_ob[i], error, this.msg.champs_no_ob);
		}
		
		//verif : email
		for (i = 0; i < this.email.length; i++) {
			var error = "";
			error = this.verif_notEmpty(this.email[i]);
			if (error == ""){
				error = this.verif_regex(this.email[i],"^\\w+[\\+\\.\\w-]*@([\\w-]+\\.)*\\w+[\\w-]*\\.([a-z]{2,4}|\\d+)$");
			}
			this.showError(this.email[i], error, this.msg.email);
		}
		
		//verif :  mot de passe / confimation de mot de passe
		for (i = 0; i < this.mdp.length; i++) {
			var error = "";
			var field = this.mdp[i];
			if ($.isArray(this.mdp[i])) {
				error = this.verif_conf_mdp(this.mdp[i][0], this.mdp[i][1]);
				field = this.mdp[i][0];
				this.showError(field, error, "");
			}
			if (error == ""){
				error = this.verif_notEmpty(field);
			}
			if (error == ""){
				error = this.verif_regex(field, "^[a-zA-Z0-9]+$");
			}
			if (error == ""){
				error = this.verif_size(field, minMdp, maxMdp);
			}
			if (!$.isArray(this.mdp[i])) {
				this.showError(field, error, this.msg["mdp"]);
			}
		}
		
		//verif :  code postal
		for (i = 0; i < this.cdp.length; i++) {
			var error = "";
			error = this.verif_notEmpty(this.cdp[i]);
			if (error == ""){
			error =	this.verif_regex(this.cdp[i], "^[a-zA-Z0-9]{4,10}$");
			}
			this.showError(this.cdp[i], error, this.msg["cdp"]);
		}
	
		this.validator();
	},
	
	//methode générique ------------------------------------
	
	verif_radio : function(cible) {
		var error = "";
		elt = $(cible);
		if ($(elt+":checked").val() == null){
			this.isValid = false;
				error = this.msg.radio;
		}
		return error;
	},
	
	verif_notEmpty : function(cible) {
		var error = "";
		elt = $(cible).val();
		if (elt == "") {
			this.isValid = false;
			error =  this.msg.vide;
		}
		return error;
	},

	verif_regex : function(cible, regex) {
		var error = "";
		elt = $(cible).val();
		var patternElt = new RegExp(regex, "g");
		if (!patternElt.test(elt)) {
			this.isValid = false;
			error = (this.msg.regex).replace("$1",regex);
		}
		return error;
	},

	verif_size : function(cible, min, max) {
		var error = "";
		elt = $(cible).val();
		if (elt.length < min || elt.length > max) {
			this.isValid = false;
			error = (this.msg.size).replace("$1",min);
			error = (error).replace("$2",max);
		}
		return error;
	},
	
	verif_conf_mdp : function(cible, verif) {
		var error = "";
		elt = $(cible).val();
		eltVerif = $(verif).val();
		if (elt != eltVerif){
			this.isValid = false;
				error =  this.msg.conf_mdp;
		}
		return error;
	},
	
	showError : function(cible, error, msg){
		if (error != ""){
			if (msg){
				$(cible+":last").after('<span class="'+this.spanError+'">'+msg+'</span>');
			}else {
				$(cible+":last").after('<span class='+this.spanError+'>'+error+'</span>');
			}
		}
	},
	
	validator : function() {
		if (this.isValid) {
			$(this.btn_valid).attr("disabled","disabled");
			$(this.IdForm).submit();
		} else {
			// pas d'envois 
		}
	}
	
};