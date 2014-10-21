function printOrder(orderId){
	window.open(contextPath + "/printOrder.html?orderId="+orderId,"Fitre","menubar=no, status=no, scrollbars=yes, menubar=no, width=800, height=600");
}
$(document).ready(function() {
	$("#pi_facture_pop").click(function(){
		$('#pi_facture_pop').hide();
		window.print();
	});
});