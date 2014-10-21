function printReturnDemand(returnDemandId){
	window.open(contextPath + "/printRecapReturnDemand.html?returnDemandId=" + returnDemandId + "&action=print","Fitre","menubar=no, status=no, scrollbars=yes, menubar=no, width=800, height=600");
}

function save(returnDemandId){
	window.open(contextPath + "/printRecapReturnDemand.html?returnDemandId=" + returnDemandId + "&action=save","Fitre","menubar=no, status=no, scrollbars=yes, menubar=no, width=800, height=600");
}


$(document).ready(function() {
	$("#imprimer").click(function(){
		$('#imprimer').hide();
		window.print();
	});
});

