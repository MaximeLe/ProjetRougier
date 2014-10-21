var i18n_dict = { 
	"connexion_perdue" 		: "Connexion lost",
	"egal_a" 				: "equal to",
	"different_de" 			: "different from",
	"superieur_a" 			: "supperior to",
	"superieur_ou_egal_a" 	: "supperior or equal to",
	"inferieur" 			: "inferior",
	"inferieur_ou_egal_a" 	: "inferior or equal to",
	"est_vide" 				: "is empty",
	"n_est_pas_vide" 		: "is not empty",
	"est_parmi" 			: "is among",
	"n_est_pas_parmi" 		: "is not among",
	"contient" 				: "contains",
	"ne_contient_pas" 		: "doesn't contain",
		
	// Tunnel
	"NotEmpty.customer.addressLabel"					:	"Indicate an address name",
	"NotEmpty.customer.firstName"						:	"Indicate your first first name",
	"NotEmpty.customer.lastName"						:	"Indicate your name",
	"NotEmpty.customer.zipCode"							:	"Indicate the zip code",
	"NotEmpty.customer.addressLine1"					:	"Indicate your mailing address",
	"NotEmpty.customer.city"							:	"Indicate your city",
	"NotEmpty.customer.phoneNumber"						:	"Indicate your telephone",
	"Size.customer.zipCode"								:	"Your zip code must be must possess at least 4 characters",
	"Size.customer.zipCodeBis"							:	"Your zip code doesn't exceed 10 characters",
	"Pattern.customer.phoneNumber"						:	"The phone number entered is incorrect.",
	
	
	//Payment
	"NotEmpty.payment.cardType"				:	"please ask the type of card",
	"Size.payment.cardNumber"				:	"The card number you entry is incorrect",
	"NumberFormat.payment.cardNumber"		:	"the number that you specified is incorrect",	
	"NotEmpty.payment.expiryMonth"			:	"please inform the month of card expiration",
	"NotEmpty.payment.expiryYear"			:	"please inform the year of card expiration",
	"AssertTrue.payment.notExpiredDate"		:	"the expiration date is incorect or exceeded.",
	"Size.payment.securityCode"				:	"The ssecurity code that you specified is incorrect",
	"NumberFormat.payment.securityCode"		:	"The security code that you specify is incorrect",

	"payment.denied"	:	"Your payment was refused",
	"payment.error"		:	"A technical error has occurred. Please take a moment to renew your request later.",
	"payment.problem"	:	"A technical problem has occurred",
	"payment.condition"	:	"You must accept the general conditions",

		
	//Wishlist
	"choix_taille"	:	"Choose your size :",
	"choix_couleur"	:	"Choose your color :",
	"prec"			:	"previous",
	"suiv"			:	"next",

	//Modification adresse de livraison 
	"modif_add_nom_add"				:	"Adress name",	
	"modif_add_civilite"			:	"Civility",
	"modif_add_civilite_1"			:	"Mr",
	"modif_add_civilite_2"			:	"Mrs",
	"modif_add_civilite_3"			:	"Miss",
	"modif_add_nom"					:	"Name",
	"modif_add_prenom"				:	"First name",
	"modif_add_adresse"				:	"Address",
	"modif_add_complement_adresse"	:	"Further adress",
	"modif_add_code_postal"			:	"Zip code",
	"modif_add_ville"				:	"City",
	"modif_add_phone"				:	"Telephone",
	
		
	//espace client 
	"confirmation_supp"				:	"Are you sure you want to delete?",
		
	//searchShop
	"error.vide"					:	"Please enter a zip code or city",
	"error.incorrect"				:	"Invalid zip code",
	"error.no_found"				:	"The research has not accomplished, make further narrow your search",
		
	//header
	"header.panier"			:	"Mon panier "
};

$.i18n.setDictionary(i18n_dict);