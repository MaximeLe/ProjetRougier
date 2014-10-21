<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<tiles:insertDefinition name="template">
	<tiles:putAttribute name="canonical">
		http://${pageContext['request'].serverName}${shop.shopUrl}
	</tiles:putAttribute>
	<tiles:putAttribute name="title"><spring:message code="shop.detail.startTitle"/>&nbsp;${shop.name}&nbsp;-&nbsp;${fn:substring(shop.zipCode, 0, 2)}&nbsp;${shop.city}&nbsp;<spring:message code="shop.detail.title"/></tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="shop.detail.descriptionStart"/>&nbsp;${shop.city}&nbsp;<spring:message code="shop.detail.description"/></tiles:putAttribute>

	<tiles:putAttribute name="breadcrumb">
		<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt;&nbsp;<a href="/magasins.r.html"><span class="lien_chemin">Magasins</span></a>&nbsp;&gt;&nbsp;<span class="lien_chemin">${shop.name}</span>
	</tiles:putAttribute>

	<tiles:putAttribute name="content">
	<div id="content" class="storeLocator" itemscope itemtype="http://schema.org/Store">
		${emsSousMenu }
			<div class="clear hidden">
				<!-- Partie gauche -->
				<div class="floatLeft">
					<div class="cadregris moyen">
						<c:if test="${((context.instanceType) == 'STORE_PREVIEW') && (context.siteEditMode)}">
							<span style="margin-left: 5px;">
								<a href="/StoreManager/secure/MAG/modifierPropDescriptionMagasin.htm?siteId=${shop.shopId}&lg=${langId}" title="<spring:message code="shop.modifierMagasin"/>" target="storeManager"><img src="${contextPath}/resources/${codeIsoLang}/img/common/modifyBlack.png" style="border: 0px;"/></a>
							</span>
						</c:if>
						
						<div class="boutique">
							
							<div class="image">
								<img itemprop="image" src="${contextPath}/resources/${codeIsoLang}/img/storeLocator/ico-${shop.signBiz}.png" width="125" height="38" alt="rougier&plé" />
							</div>
<!-- 							<div class="photo"> -->
<%-- 								<img itemprop="image" src="${contextPath}/resources/${codeIsoLang}/img/storeLocator/photo_magasin.jpg" width="443" height="250" alt="" /> --%>
<!-- 							</div> -->
							<div class="adresse" >
								<h1><span class="bold" itemprop="name">${shop.name}</span></h1>
								<div class="dAdresse" itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
									<c:if test="${not empty shop.address1}">
										<span itemprop="streetAddress">${shop.address1}</span><br/>
									</c:if>
									<c:if test="${not empty shop.address2}">
										${shop.address2}<br/>
									</c:if>
									<c:if test="${not empty shop.address3}">
										${shop.address3}<br/>
									</c:if>
									<span itemprop="postalCode"><c:out value="${shop.zipCode}"/></span> 
									<span itemprop="addressLocality"><c:out value="${shop.city}"/></span>
								</div>
								<div itemprop="geo" itemscope itemtype="http://schema.org/GeoCoordinates" class="displayNone">
									<span itemprop="latitude">${shop.latitude}</span>
									<span itemprop="longitude">${shop.longitude}</span>
								</div>
								<span itemprop="url" class="displayNone">${shop.shopUrl}</span>
							</div>
							<c:if test="${not empty shop.phone1 || not empty shop.mail || not empty shop.animatorName}">
								<div class="telephone">
								<c:if test="${not empty shop.phone1}">
									<spring:message code="shop.telephone"/><span class="bold" itemprop="telephone">${shop.phone1}</span><br/>
								</c:if>
								<c:if test="${not empty shop.phone2}">
									<spring:message code="shop.telephone2"/><span class="bold" itemprop="faxNumber">${shop.phone2}</span><br/>
								</c:if>
								<c:if test="${not empty shop.mail}">
									<spring:message code="shop.email"/><span class="bold" itemprop="email">${shop.mail}</span>
								</c:if>
								</div>
							</c:if>
						</div>
						
							
						<c:if test="${connecte == true}">
							<div class="preference">
								<c:choose>
									<c:when test="${defaultShopId == shop.shopId}">
										<input type="checkbox" id="ajaxSaveDefaultShop" onclick="ajaxSaveDefaultShop();" checked="checked">
										<label for="ajaxSaveDefaultShop"><spring:message code="shop.definirMagasin"/><img src="${contextPath}/resources/${codeIsoLang}/img/storeLocator/mag_prefere.png" width="13" height="15" alt="" /><spring:message code="shop.definirMagasinPrefere"/></label>
									</c:when>
									<c:otherwise>
										<input type="checkbox" id="ajaxSaveDefaultShop" onclick="ajaxSaveDefaultShop();">
										<label for="ajaxSaveDefaultShop"><spring:message code="shop.definirMagasin"/><img src="${contextPath}/resources/${codeIsoLang}/img/storeLocator/mag_prefere.png" width="13" height="15" alt="" /><spring:message code="shop.definirMagasinPrefere"/></label>
									</c:otherwise>
								</c:choose>
							</div>
						</c:if>
						
						
						
						
					</div>
					<c:if test="${not empty shop.description}">
						<div class="cadregris moyen">
							<div class="barretitre"><span><spring:message code="shop.presentation"/></span></div>
							<div class="ligne">
									<span itemprop="description">${shop.description}</span>
							</div>
						</div>
					</c:if>
					<div class="cadregris moyen">
						<c:if test="${not empty shop.hours}">
							<div class="barretitre"><h2><span><spring:message code="shop.horairesMagasin"/></span></h2></div>
							<div id="bloc_horaires" class="ligne">
								<table cellpadding="0" cellspacing="0" class="tHoraires">
									<c:forEach items="${shop.hours}" var="hour" varStatus="compteur_ligne" >
										<c:choose>
											<c:when test="${fn:toLowerCase(hour.day) == 'lundi'}">											
												<c:set var="dayWeek" value="Mo"/>
											</c:when>
											<c:when test="${fn:toLowerCase(hour.day) == 'mardi'}">											
												<c:set var="dayWeek" value="Tu"/>
											</c:when>
											<c:when test="${fn:toLowerCase(hour.day) == 'mercredi'}">											
												<c:set var="dayWeek" value="We"/>
											</c:when>
											<c:when test="${fn:toLowerCase(hour.day) == 'jeudi'}">											
												<c:set var="dayWeek" value="Th"/>
											</c:when>
											<c:when test="${fn:toLowerCase(hour.day) == 'vendredi'}">											
												<c:set var="dayWeek" value="Fr"/>
											</c:when>
											<c:when test="${fn:toLowerCase(hour.day) == 'samedi'}">											
												<c:set var="dayWeek" value="Sa"/>
											</c:when>
											<c:when test="${fn:toLowerCase(hour.day) == 'dimanche'}">											
												<c:set var="dayWeek" value="Su"/>
											</c:when>
											<c:otherwise>										
												<c:set var="dayWeek" value="${fn:substring(hour.day, 0, 2)}"/>
											</c:otherwise>
										</c:choose>
										<c:if test="${compteur_ligne.count%2==0}">
											<c:if test="${! empty hour.closingHourAM}">
												<tr class="pair" itemprop="openingHours" content="${dayWeek}&nbsp;${hour.openingHourAM}-${hour.closingHourAM},&nbsp;${dayWeek}&nbsp;${hour.openingHourPM}-${hour.closingHourPM}">
													<td class="day">${hour.day} :</td>
													<td class="openingHours">${hour.openingHourAM}&nbsp;-&nbsp;</td>
														<td class="closingHours">${hour.closingHourAM}</td>
														<td class="openingHours">${hour.openingHourPM}<c:if test="${! empty hour.openingHourPM}">&nbsp;-&nbsp;</c:if></td>
													<td class="closingHours">${hour.closingHourPM}</td>
												</tr>
											</c:if>
											<c:if test="${empty hour.closingHourAM}">
												<tr class="pair" itemprop="openingHours" content="${dayWeek}&nbsp;${hour.openingHourAM}-${hour.closingHourPM}">
													<td class="day">${hour.day} :</td>
													<td class="openingHours">${hour.openingHourAM}&nbsp;-&nbsp;</td>
														<td class="closingHours">${hour.closingHourPM}</td>
														<td class="openingHours"></td>
													<td class="closingHours"></td>
												</tr>
											</c:if>
										</c:if>
										<c:if test="${compteur_ligne.count%2!=0}">
											<c:if test="${! empty hour.closingHourAM}">
												<tr class="impair" itemprop="openingHours" content="${dayWeek}&nbsp;${hour.openingHourAM}-${hour.closingHourAM},&nbsp;${dayWeek}&nbsp;${hour.openingHourPM}-${hour.closingHourPM}">
													<td class="day">${hour.day} :</td>
													<td class="openingHours">${hour.openingHourAM}&nbsp;-&nbsp;</td>
														<td class="closingHours">${hour.closingHourAM}</td>
														<td class="openingHours">${hour.openingHourPM}<c:if test="${! empty hour.openingHourPM}">&nbsp;-&nbsp;</c:if></td>
													<td class="closingHours">${hour.closingHourPM}</td>
												</tr>
											</c:if>
											<c:if test="${empty hour.closingHourAM}">
												<tr class="impair" itemprop="openingHours" content="${dayWeek}&nbsp;${hour.openingHourAM}-${hour.closingHourPM}">
													<td class="day">${hour.day} :</td>
													<td class="openingHours">${hour.openingHourAM}&nbsp;-&nbsp;</td>
														<td class="closingHours">${hour.closingHourPM}</td>
														<td class="openingHours"></td>
													<td class="closingHours"></td>
												</tr>
											</c:if>
										</c:if>
									</c:forEach>

								</table>
								<c:if test="${not empty shop.comment}">
									<div class="desc">
										<span itemprop="description">${shop.comment}</span>
									</div>
								</c:if>
						
							</div>
						</c:if>
					</div>
					<div class="clear hidden"><a id="autre_magasin" href="${searchShopUrl}"><spring:message code="shop.chercherAutreMagasin"/></a></div>
					
				</div>

				<!-- Partie droite -->
				<div class="floatRight">
					<c:if test="${not empty shop.longitude && not empty shop.latitude}">
					<div class="cadregris moyen">
						<div class="barretitre"><h2><span><spring:message code="shop.visualisezEmplacement"/></span></h2></div>
						<div class="ligne">
							<div class="dCarte" id="map_canvas" style="height: 252px;width:100%;">
							</div>
						</div>
					</div>
					</c:if>
					

					
					<div class="cadregris moyen">
						<div class="barretitre"><h2><span><spring:message code="shop.calculerVotreItineraire"/></span></h2></div>
						<div class="ligne">
							<div id="directionDuration"></div>
							<div class="calcul_iti">
								<input type="text" id="startCity" value="Rentrez ici votre lieu de départ" onfocus="if($(this).val()=='Rentrez ici votre lieu de départ'){$(this).val('');}" maxlength="255"/> 
								<button type="button" id="bouton_calculer" onclick="calcRoute();">
									<spring:message code="shop.calculer"/>
								</button>
							</div>
						</div>
					</div>
				</div>

				
				<c:if test="${ems}">
					<div class="cadregris moyen">
						<div class="barretitre"><span><spring:message code="shop.ems"/></span></div>
						<div class="ligne">
							<div class="dEms clear">${ems}</div>
						</div>
					</div>
				</c:if>
				<div class="zone_ems">
					<div class="ems">
<!-- 						<style> -->
<%-- 							.storeLocator .ems_1{float:left;width:990px;background: url("${contextPath}/resources/${codeIsoLang}/img/storeLocator/ems_1.jpg") no-repeat;}  --%>
<!-- 							.storeLocator .ems_1 a{float:right;margin-right:30px;margin-top:100px;padding-bottom:22px;} -->
<!-- 						</style> -->
<!-- 						<div class="ems_1"> -->
<%-- 							<a href="#"><img src="${contextPath}/resources/${codeIsoLang}/img/storeLocator/je_decouvre_l_actu_de_ce_magasin.png" width="222" height="26" alt="Je découvre l'actu de ce magasin" /></a> --%>
<!-- 						</div> -->
						${emsHaut}
					</div> 
					<div class="ems">
<!-- 						<style> -->
<%-- 							.storeLocator .ems_2{float:left;width:990px;background: url("${contextPath}/resources/${codeIsoLang}/img/storeLocator/ems_2.jpg") no-repeat;}  --%>
<!-- 							.storeLocator .ems_2 a{float:right;margin-right:25px;margin-top:95px;padding-bottom:32px;}  -->
<!-- 						</style> -->
<!-- 						<div class="ems_2"> -->
<%-- 							<a href="#"><img src="${contextPath}/resources/${codeIsoLang}/img/storeLocator/btn_jen_profite.png" width="179" height="39" alt="J'en profite" /></a> --%>
<!-- 						</div>  -->
						${emsBas}
					</div>
				</div>

			

			
<!-- 			 <div class="clear hidden"><a href="${searchShopUrl}" class="searchShopLink"><spring:message code="shop.rechercherAutresMagasins"/></a></div>  -->
		</div>
	</div>
</tiles:putAttribute>
	
<tiles:putAttribute name="moreJS">
	<script type="text/javascript">
	var contextPath = '${contextPath}';
	var codeIsoLang = '${codeIsoLang}';
	var longitude = "${shop.longitude}";
	var latitude = "${shop.latitude}";
	var zoomValue = '${shop.zoom}';
	var shopId = '${shop.shopId}';
	var signBiz = '${shop.signBiz}';
	</script>
	<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
	<script src="${contextPath}/resources/js/storeLocator/shop.js?${versionJs}" type="text/javascript"></script>
</tiles:putAttribute>
</tiles:insertDefinition>