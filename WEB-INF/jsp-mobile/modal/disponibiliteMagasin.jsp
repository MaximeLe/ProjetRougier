<%@ page trimDirectiveWhitespaces="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.pictime.com/tags/core"   prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div id="modal">
	<div class="btn_close"></div>
	<form id="form_avis">
		<div class="content review">
			<div class="titre">Veuillez sélectionner un magasin* pour connaître la disponibilité du produit</div>
			<select id="listeDispoMagasin">
			</select>
			
			<div id="informationsDispoMagasin" style="margin:20px 0 20px 4px">
				<p id="nomMagasin" style="margin:0; font-size:12px; font-height:14px; color:#000; text-align:justify; font-weight:bold"></p>
				<p id="adresse1Magasin" style="margin:0; font-size:12px; padding-top:3px; color:#000; text-align:justify;"></p>
				<p id="adresse2Magasin" style="margin:0; font-size:12px; padding-top:3px; color:#000; text-align:justify;"></p>
				<p id="adresse3Magasin" style="margin:0; font-size:12px; padding-top:3px; color:#000; text-align:justify;"></p>
				<p id="villeMagasin" style="margin:0; font-size:12px; padding-top:3px; color:#000; text-align:justify;"></p>
				<%-- p id="telMagasin" style="margin:0; font-size:12px; padding-top:3px; color:#000; text-align:justify; font-weight:bold"></p --%>
			</div>
			
			<%-- Affichage du choix du magasin préféré si l'utilisateur est connecté --%>
			<c:if test="${customerConnected}">
				<div style="float:left; display:inline-block; width:450px;padding-top:5px">
					<input style="float:left; display:block; margin-left:5px;" type="checkbox" id="disponibiliteDefaultShop" checked="checked">
					<label style="float:none; display:inline; width:300px; height:22px; margin-left:3px;font-size:12px;color:#303030" for="disponibiliteDefaultShop"><spring:message code="shop.definirMagasin"/>&nbsp;<spring:message code="shop.definirMagasinPrefere"/></label>
				</div>
			</c:if>
			
			<div class="floatRight" style="margin:20px 0;">
				<input style="margin-right:10px;" type="image" src="${contextPath}/resources/${codeIsoLang}/img/common/btn_valider.png" name="submit" id="validerMagasin"/>
				<input onclick="Box._close();" type="image" src="${contextPath}/resources/${codeIsoLang}/img/clientArea/btn_retour.png" name="cancel" id="annulerMagasin"/>
			</div>
			
			${EMS_DISPONIBILITE_MAGASIN}
			
			<span style="display:block; font-size:10px; line-height:12px; color:#777; text-align:justify; margin-top:10px;">* service actuellement disponible dans 9 magasins sur un réseau de 50 points de vente</span>
			
			<div class="messageRetour clear floatRight"></div>
		</div>
	</form>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		
		var listeMagasins = $.parseJSON('${shopListJson}');
		
		// Initialisation de la liste des magasins
		$('#listeDispoMagasin').html(function() {
			
			var liste = null;
			
			for(var i=0; i<listeMagasins.length; i++) {
				var siteBiz = listeMagasins[i].siteBiz;
				var siteBizRattachement = getCookieValue("RougierMagasinRattachement");
				if(siteBiz == siteBizRattachement) {
					liste += '<option selected="selected">'+listeMagasins[i].zipCode+' - '+listeMagasins[i].shopNameBiz+' - '+listeMagasins[i].city+'</option>';
				}
				else {
					liste += '<option>'+listeMagasins[i].zipCode+' - '+listeMagasins[i].shopNameBiz+' - '+listeMagasins[i].city+'</option>';
				}
			}
			
			return liste;
		});
		
		// Affichage des informations du magasin selectionné
		var indexRattachement = $("#listeDispoMagasin option:selected").prevAll().size();
		changeDisplayShopDisponibiliteMagasin(listeMagasins, indexRattachement);

		$('#listeDispoMagasin').change(function() {
			changeDisplayShopDisponibiliteMagasin(listeMagasins,this.selectedIndex);
		});
		
		$('#validerMagasin').click(function() {
			var index = $("#listeDispoMagasin option:selected").prevAll().size();
			validateShopDisponibiliteMagasin(listeMagasins,index);
			
			// Si le client a choisi de définir son magasin de rattachement comme magasin préféré
			if($('input[id="disponibiliteDefaultShop"]').is(":checked")){
				$.ajax({
					type:"POST",
					url: contextPath+"/ajax/shop.html?action=setShop",
					async: false,
					data:{
						"shopId": listeMagasins[index].siteId
					},
					dataType: 'json',
					cache:false,
					success:function(){},
					error:function(message){
						alert("Erreur lors de l'enregistrement du magasin préféré");
					}
				});
			}
		});
	});
</script>
