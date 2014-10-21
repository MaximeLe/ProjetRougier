var i18n_dict = { 
	"connexion_perdue" 						: "Connexion perdue",
	"egal_a" 								: "égal à",
	"different_de" 							: "différent de",
	"superieur_a" 							: "supérieur à",
	"superieur_ou_egal_a" 					: "supérieur ou égal à",
	"inferieur" 							: "inférieur",
	"inferieur_ou_egal_a" 					: "inférieur ou égal à",
	"est_vide" 								: "est vide",
	"n_est_pas_vide" 						: "n'est pas vide",
	"est_parmi" 							: "est parmi",
	"n_est_pas_parmi" 						: "n'est pas parmi",
	"contient" 								: "contient",
	"ne_contient_pas" 						: "ne contient pas",
		
	// Tunnel
	"NotEmpty.customer.addressLabel"		:	"Indiquez un nom d'adresse",
	"NotEmpty.customer.firstName"			:	"Indiquez votre prénom",
	"NotEmpty.customer.lastName"			:	"Indiquez votre nom",
	"NotEmpty.customer.zipCode"				:	"Indiquez le code postal",
	"NotEmpty.customer.addressLine1"		:	"Indiquez votre adresse postale",
	"NotEmpty.customer.city"				:	"Indiquez votre ville",
	"NotEmpty.customer.phoneNumber"			:	"Indiquez votre téléphone",
	"Size.customer.zipCode"					:	"Votre code postal doit posséder au moins 4 caractères",
	"Size.customer.zipCodeBis"				:	"Votre code postal ne doit pas excéder 10 caractères",
	"Pattern.customer.phoneNumber"			:	"Le numéro de téléphone saisi est incorrect.",
	
	
	//Payment
	"NotEmpty.payment.cardType"				:	"Veuillez renseigner le type de votre carte",
	"Size.payment.cardNumber"				:	"Le numéro que vous avez indiqué est incorrect",
	"NumberFormat.payment.cardNumber"		:	"Le numéro de votre carte que vous avez indiqué est incorrect",	
	"NotEmpty.payment.expiryMonth"			:	"Veuillez renseigner le mois d'expiration de votre carte",
	"NotEmpty.payment.expiryYear"			:	"Veuillez renseigner l'année d'expiration de votre carte",
	"AssertTrue.payment.notExpiredDate"		:	"La date d'expiration est incorrecte ou dépassée.",
	"Size.payment.securityCode"				:	"Le code de sécurité que vous avez indiqué est incorrect",
	"NumberFormat.payment.securityCode"		:	"Le code de sécurité que vous avez indiqué est incorrect",

	"payment.denied"						:	"Votre paiement a été refusé.",
	"payment.error"							:	"Une erreur technique s'est produite. Nous vous invitons à renouveler votre demande ultérieurement.",
	"payment.problem"						:	"Un problème technique est survenu",
	"payment.condition"						:	"Vous devez accepter les conditions générales",

		
	//catalogEntry
	"choix_taille"							:	"Choisissez votre taille :",
	"choix_couleur"							:	"Choisissez votre coloris :",
	"prec"									:	"Précédent",
	"suiv"									:	"Suivant",
		
	//modal-modifyAddress 
	"modif_add_nom_add"						:	"Nom de l'adresse",	
	"modif_add_civilite"					:	"Civilité",
	"modif_add_civilite_1"					:	"Mr",
	"modif_add_civilite_2"					:	"Mme",
	"modif_add_civilite_3"					:	"Mlle",
	"modif_add_nom"							:	"Nom",
	"modif_add_prenom"						:	"Prénom",
	"modif_add_adresse"						:	"Adresse",
	"modif_add_complement_adresse"			:	"Complément d'adresse",
	"modif_add_code_postal"					:	"Code postal",
	"modif_add_ville"						:	"Ville",
	"modif_add_phone"						:	"Téléphone",
		
	//espace client 
	"confirmation_supp"						:	"Etes-vous sûr de vouloir supprimer ?",
	"wishlist_saisir_nom"					:   "Veuillez saisir un nom pour la nouvelle liste", 
	"error.noProductSelected"   			:   "Veuillez sélectionner un produit de la liste",
	
	//searchShop
	"error.vide"							:	"Veuillez entrer un code postal ou une ville",
	"error.incorrect"						:	"Merci de vérifier la saisie de votre Code postal",
	"error.no_found"						:	"La recherche n'a pas abouti, veuillez préciser d'avantage votre recherche",
	
	//header
	"header.panier"							:	"Mon panier ",
	"header.recherche"						:	"Rechercher",
	
	//formulaire contact
	"MSG_EMAIL_ERR"							:	"Merci de vérifier votre e-mail.",
	"MSG_PWD_ERR"							:	"Merci de vérifier votre mot de passe.",
	"MSG_EMAIL_VIDE"						:	"Merci de renseigner votre e-mail.",
	"MSG_PWD_VIDE"							:	"Merci de renseigner votre mot de passe.",
	"MSG_PWD_CONFIRM_VIDE"					:	"Merci de confirmer votre mot de passe.",
	"MSG_NOT_SAME_PWD"						:	"Merci de saisir le même mot de passe.",
	"MSG_NOM_VIDE"							:	"Merci de renseigner votre nom.",
	"MSG_NUM_CMD_VIDE"						:	"Merci de renseigner votre numéro de commande.",
	"MSG_TXT_AREA_VIDE"						:	"Merci de renseigner le champ message.",
	"MSG_TXT_AREA_MAX"						:	"Merci de renseigner moins de 255 caractères dans le champ message.",
	"MSG_AVIS_INFO"							:	"Votre avis est bien enregistré. Il sera publié après modération du webmaster.",
	"MSG_AVIS_XSS"							:	"Merci de saisir correctement votre commentaire.",
	"MSG_OLD_PWD_VIDE"						:	"Merci de renseigner le mot de passe à modifier.",
	"MSG_PWD_TROP_LONG"						:	"Merci de renseigner un mot de passe de 20 caractères maximum.",
	"MSG_PWD_TROP_COURT"					:	"Merci de renseigner un mot de passe de 6 caractères minimum.",
	"MSG_NOM_TROP_COURT"					:	"Le nom doit comporter au maximum 40 caractères.",
	"MSG_PRENOM_TROP_COURT"					:	"Le prénom doit comporter au maximum 40 caractères.",
	//formulaire de creation de compte	
	"MSG_CIVILITE_VIDE"						:	"Merci d'indiquer votre civilité.",
	"MSG_PRENOM_VIDE"						:	"Merci de renseigner votre prénom.",
	"MSG_ETUDIANT_SANS_PROMO"				:	"Merci de selectionner votre promotion.",
	"MSG_ETUDIANT_SANS_FORMATION"			:	"Merci de renseigner votre formation.",
	"MSG_ETUDIANT_SANS_ETABLISSEMENT"		:	"Merci de renseigner votre établissement.",
	"MSG_ETUDIANT_CERTIF"					:	"Merci de certifier votre déclaration.",
	"MSG_CP_ERR"							:	"Merci de vérifier votre code postal.",
	"MSG_PHONE_ERR"							:	"Merci de vérifier votre numero de fixe.",
	"MSG_MOBILE_ERR"						:	"Merci de vérifier votre numero de mobile.",
	"MSG_VILLE_VIDE"						:	"Merci de renseigner votre ville.",
	"MSG_ETABLISSEMENT_ERR"					:	"Merci de vérifier votre établissement.",
	"MSG_NOM_ERR"							:	"Merci de vérifier votre nom.",
	"MSG_PRENOM_ERR"						:	"Merci de vérifier votre prénom.",

	//formulaire modification codes d'accès
	"MSG_ANCIEN_PWD_VIDE"					:	"Merci de renseigner votre mot de passe à modifier.",
	"MSG_NOUVEAU_PWD_VIDE"					:	"Merci de renseigner votre nouveau mot de passe.",
	//fomulaire modifications informations personnelles.
	"MSG_AUCUN_CHOIX_SEGMENTATION"			:	"Merci de selectionner le profil de client qui vous correspond le mieux.",
	"MSG_TELEPHONE_ERR"						:	"Merci de vérifier la saisie de votre numéro de téléphone.",
	"MSG_ADRESSE_VIDE"						:	"Merci de renseigner votre adresse.",
	"MSG_CP_VIDE"							:	"Merci de renseigner votre code postal.",
	"MSG_CP_ERR_FP"							:	"Merci de vérifier la saisie de votre code postal.",
	"MSG_CP_ERR_CORSE"						:	"La livraison en Corse n'est pas disponible, merci de corriger.",
	"MSG_BIRTH_DATE_ERR" 					: 	"Merci de vérifier la saisie de votre date de naissance",
	//formulaire creation modification adresse
	"MSG_MODIF_FORM_ADRESSE_VIDE"			:	"Merci de nommer cette adresse.",
	"MSG_CIVILITE_VIDE"						:	"Merci d’indiquer votre civilité",
	"MSG_PHONE_VIDE"						:	"Merci de renseigner votre téléphone ou votre mobile",
	"MSG_NOM_ADDRESS_VIDE"					:	"Merci de renseigner un nom d'adresse unique",
	
	//validation panier
	"MSG_CGV"								:	"Merci d'accepter les conditions générales de ventes",
	"MSG_KDO"								:	"Votre message ne peut dépasser les 250 caractères",


	//formulaire whislit
	"MSG_WL_NOM_VIDE"						:   "Merci de nommer cette liste.",
	
	//Avis client
	"MSG_EVALUATION_ERR"					:	"Merci de renseigner votre évaluation.",
	"Empty.list.relay"		:	"Aucun point relais pour la recherche",
	"MSG_HEADER_BONJOUR"	:	"Bonjour",
	"MSG_HEADER_DECONNECTION"	:	"se déconnecter",
	"MSG_HEADER_CONNECTION"	:	"se connecter",
	"MSG_HEADER_LES_MAGASINS"	:	"Magasins",
	"MSG_HEADER_MON_MAGASIN"	:	"Mon magasin",
	"MSG_HEADER_MA_WISHLIST"	:	"Ma liste de courses",
		
	// Delivery relay numéro de téléphone
	"delivery.telObligatoire"	:	"Le numéro de téléphone est obligatoire",
	"delivery.telChiffreUniquement"	:	"Le numéro de téléphone ne doit être composé que de chiffres",
	"delivery.telLimiteChiffre"	:	"Le numéro de téléphone doit être composé d'au maximum 18 chiffres",
	"delivery.telInvalide"	:	"Le numéro de téléphone n'est pas valide, merci de le corriger"
};

$.i18n.setDictionary(
);