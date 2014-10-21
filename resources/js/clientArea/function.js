$(document).ready(function(){
	var error = $.trim($('.error_page').html());
	if( error == undefined || error == ""){
		$('.error_page').hide();
	}else{
		$('.error_page').show();
	}
});
