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
		<c:choose>
			<c:when test="${regionId != null}">
				http://${pageContext['request'].serverName}<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=${regionId}" />
			</c:when>
			<c:otherwise>
				http://${pageContext['request'].serverName}<fwk:rewrite url="/searchShop.html" />
			</c:otherwise>
		</c:choose>
	</tiles:putAttribute>
	<tiles:putAttribute name="title">
		<c:choose>
			<c:when test="${empty nomRegion}">
				<spring:message code="shop.title"/>
			</c:when>
			<c:otherwise>
				${nomRegion}&nbsp;<spring:message code="shop.region.title"/>
			</c:otherwise>
		</c:choose>
	</tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="shop.description"/></tiles:putAttribute>
	
	<tiles:putAttribute name="breadcrumb">
		<a href="/"><spring:message code="breadcrumb.accueil"/></a>&nbsp;&gt;&nbsp;<span class="lien_chemin">Magasins</span>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
	
	<!--  EMS -->
	<style type="text/css">
	#emsMagBanniere {width:990px;height:80px;background:url("${contextPath}/resources/${codeIsoLang}/img/clientArea/emsNewsletter_bg.jpg") no-repeat;margin-bottom:10px;}
	#emsMagBanniere h1 {float:left;width:138px;margin:24px 0 0 43px;font-size:34px;color:#fff;text-align:center;line-height:26px;}
	#emsMagBanniere p {float:left;width:400px;margin:14px 0 0 133px;font-size:14px;line-height:17px;color:#777777;}
	</style>

		${MAG_BANIERE}
	
	<!--  fin EMS -->
	
	<div id="content" class="storeLocator">
		<div id="contenu" class="searchShop">
		<form:form commandName="searchShop" method="post" action="${contextPath}/searchShop.html">
			<div class="clear hidden">
				
				<!-- Partie gauche -->
				<div class="floatLeft">
					<div class="cadregris moyen">
						<div class="barretitre"><h2><span><spring:message code="shop.localisezMagasinMenu"/></span></h2></div>
						<div class="ligne">
							<div id="localisez_mag">
								<label class="txt mb5"><spring:message code="shop.indiquezVille"/></label>
								<input type="hidden" name="isButtonActive" id="isButtonActive" />
								<div class="ville_recherchee">
									<form:input id="cityGoogle" path="cityGoogle"  maxlength="50"/>
									<div id="submitSearchInput" class="submitSearch center" >
										
										<input type="image" src="${contextPath}/resources/${codeIsoLang}/img/common/btnNewsOk.png" value="OK">
									</div>
								</div>
								<div id="inputError" class="error"></div>
								<div >						
								
								<input type="hidden" id="tabLongitude" name="tabLongitude"/>
								<input type="hidden" id="tabLattitude" name="tabLattitude" />
								<form:hidden id="lattitude" path="latitude"/>
								<form:hidden id="longitude" path="longitude"/>

								<div class="clear"></div>
							</div>
							<div id="submitSearch"></div>
						</div>
					</div>
					
						
					<div class="cadregris moyen">
					
						<div class="barretitre"><h2><span><spring:message code="shop.localisezMagasinCarte"/></span></h2></div>
						<div class="ligne" id="carte_france">
							<div class="alignCenter" id="carteFlash">
								<img src="${mediaPath}/storeLocator/regions-france.jpg" width="486" height="531" border="0" usemap="#regions" />
								<map name="regions" id="regions">
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=23" />" alt="R&eacute;gion PICARDIE" title="R&eacute;gion PICARDIE" coords="238,70,236,76,238,80,235,81,235,86,242,98,239,112,241,117,237,122,237,130,252,131,256,134,262,129,266,136,288,140,289,135,297,149,306,145,306,135,311,135,307,126,319,123,324,108,330,102,331,92,325,94,322,89,313,93,305,90,299,95,292,88,279,87,270,85,270,79,258,79,254,71,246,74,238,68,238,70" />
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=13" />" alt="R&eacute;gion HAUTE-NORMANDIE" title="R&eacute;gion HAUTE-NORMANDIE" coords="206,111,190,108,193,100,200,94,210,93,221,89,233,84,238,80,235,87,240,92,242,100,239,113,241,117,236,124,237,131,231,137,227,149,213,152,206,140,199,138,198,126,195,113,206,111,204,111,206,111" />
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=4" />" alt="R&eacute;gion BASSE NORMANDIE" title="R&eacute;gion BASSE NORMANDIE" coords="205,177,208,169,215,167,212,156,214,153,208,138,200,139,198,138,199,132,195,111,184,116,148,111,147,102,151,97,148,94,143,93,138,95,131,94,127,91,123,94,128,98,126,102,132,116,133,131,130,143,135,149,131,151,134,157,140,152,147,155,154,155,154,158,172,154,180,159,179,164,194,161,196,166,194,172,204,177,205,177" />
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=8" />" alt="R&eacute;gion CHAMPAGNE ARDENNE" title="R&eacute;gion CHAMPAGNE ARDENNE" coords="299,149,302,162,297,167,296,176,301,179,300,185,304,185,310,200,320,198,325,203,341,191,350,202,353,207,352,210,364,216,371,211,374,215,375,206,381,199,375,190,378,180,368,180,369,174,353,164,348,155,355,152,356,144,351,141,359,114,364,116,369,116,357,101,351,102,351,83,339,91,331,92,330,100,321,124,306,127,312,135,306,136,307,144,300,149,299,149" />
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=18" />" alt="R&eacute;gion LORRAINE" title="R&eacute;gion LORRAINE" coords="382,115,389,122,398,116,403,120,407,119,416,134,423,130,432,136,442,132,446,134,444,145,435,148,427,144,422,147,427,154,431,154,437,157,427,167,428,178,430,182,425,184,426,193,416,206,409,197,407,205,402,199,393,201,393,195,381,200,376,191,379,179,368,180,369,174,353,163,349,155,354,153,358,145,354,141,352,140,360,115,369,116,379,114,382,115" />
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=1" />" alt="R&eacute;gion ALSACE" title="R&eacute;gion ALSACE" coords="418,207,424,213,423,217,427,219,430,228,436,224,446,216,442,209,449,197,447,192,460,156,467,152,470,144,447,139,445,145,436,148,428,143,422,146,427,155,432,155,437,157,427,168,431,181,426,184,426,193,417,205,418,207" />
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=14" />" alt="R&eacute;gion ILE-DE-FRANCE" title="R&eacute;gion ILE-DE-FRANCE" coords="229,149,232,150,232,160,238,165,242,171,247,177,257,175,261,181,279,186,282,177,295,175,297,167,304,163,298,149,290,134,289,142,275,139,265,138,264,131,255,134,251,130,240,130,236,130,228,141,228,149,229,149" />
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=2" />" alt="R&eacute;gion AQUITAINE" title="R&eacute;gion AQUITAINE" coords="139,458,140,447,145,448,146,442,154,435,156,429,153,427,152,421,152,418,141,420,146,415,144,403,155,399,157,404,160,397,168,399,173,395,179,401,186,394,192,394,196,387,190,379,198,379,195,373,200,370,200,367,207,367,206,363,210,356,215,348,214,339,207,335,211,331,212,319,207,323,199,312,189,309,182,311,180,321,172,323,175,329,164,334,161,341,153,334,145,334,146,326,139,324,139,339,135,324,128,316,128,311,122,312,122,322,116,356,121,354,124,360,114,360,104,408,83,423,84,427,91,427,91,431,97,429,99,431,94,441,101,442,104,439,108,445,114,446,123,449,126,457,139,458,139,458" />
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=20" />" alt="R&eacute;gion MIDI-PYRENEES" title="R&eacute;gion MIDI-PYRENEES" coords="139,458,147,464,159,464,162,469,165,465,176,467,176,460,188,462,194,468,202,466,203,472,212,471,215,473,213,479,217,480,231,472,230,468,224,469,220,465,226,456,227,450,215,443,216,435,223,437,223,433,226,435,234,433,237,438,240,433,249,437,256,434,252,427,258,421,260,426,270,422,275,414,279,417,283,412,283,407,289,404,280,402,284,395,274,392,276,379,271,369,270,363,267,364,265,358,262,356,251,369,239,371,236,365,241,358,236,358,236,354,214,352,207,365,208,368,200,369,195,373,199,380,188,381,195,388,193,394,187,394,179,402,173,397,168,400,163,397,157,402,155,398,144,402,146,415,143,418,153,416,155,427,158,427,151,440,145,444,147,451,140,447,138,458,139,458" />
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=16" />" alt="R&eacute;gion LANGUEDOC-ROUSSILLON" title="R&eacute;gion LANGUEDOC-ROUSSILLON" coords="272,369,276,360,279,353,284,353,289,360,288,364,292,365,294,359,298,359,299,363,309,365,308,381,311,386,311,388,320,392,321,388,328,388,328,392,339,390,337,396,343,406,340,411,333,415,333,426,325,425,326,430,319,431,318,435,313,433,310,428,298,437,291,441,283,446,274,446,270,454,268,464,267,475,274,484,272,488,261,486,255,489,248,487,244,496,233,484,223,489,217,482,219,482,230,474,230,467,225,469,220,466,224,461,227,451,216,444,215,437,215,433,222,437,224,433,228,435,232,435,237,439,242,432,249,436,255,435,252,426,258,421,260,427,271,421,273,414,280,417,283,413,283,408,289,406,280,402,285,396,274,392,278,382,272,370,272,369" />
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=25" />" alt="R&eacute;gion PROVENCE ALPES COTE-DAZUR" title="R&eacute;gion PROVENCE ALPES COTE-DAZUR" coords="340,390,343,392,355,389,351,396,358,395,364,400,369,397,373,397,373,392,368,391,363,387,366,381,371,382,375,381,374,378,370,376,369,371,377,371,384,363,394,362,402,365,401,359,397,356,394,353,395,348,400,354,408,349,420,362,427,362,427,369,421,375,418,382,421,385,419,391,429,399,438,400,446,400,451,398,454,405,448,409,447,418,444,421,433,423,427,435,422,433,418,441,412,441,409,445,413,446,411,450,409,452,402,451,399,455,389,451,391,458,384,455,382,459,374,455,372,451,367,449,357,450,359,443,357,440,346,442,342,436,337,437,334,442,327,438,321,436,322,431,327,430,326,426,334,425,334,416,345,406,338,395,339,391,340,390" />
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=26" />" alt="R&eacute;gion RHONE ALPES" title="R&eacute;gion RHONE ALPES" coords="368,284,375,289,392,276,395,283,394,289,389,290,391,296,398,289,397,286,404,280,420,280,422,285,423,289,420,290,425,302,426,308,418,311,418,317,425,321,425,330,433,330,430,338,431,347,425,346,421,346,417,350,411,348,410,350,400,355,395,348,393,354,400,359,402,365,395,364,391,362,382,364,379,372,368,371,375,380,373,384,367,382,366,387,372,392,373,396,368,399,365,400,357,393,352,396,358,388,344,394,340,392,327,393,327,387,322,387,319,392,312,387,309,382,309,375,309,366,309,361,319,357,321,351,326,347,328,338,323,335,319,336,317,331,306,334,307,326,303,317,300,309,300,300,307,298,308,288,317,291,325,289,331,284,340,287,347,270,359,273,363,279,357,281,364,285,370,284,420,227,368,284" />
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=6" />" alt="R&eacute;gion BRETAGNE" title="R&eacute;gion BRETAGNE" coords="94,205,101,203,104,195,112,197,117,191,121,191,128,188,133,192,139,186,139,182,144,182,146,176,142,172,140,169,144,167,147,155,142,151,136,158,130,154,130,147,124,149,122,144,116,145,117,149,112,146,109,149,109,144,108,142,98,144,94,149,81,133,83,129,81,127,71,130,66,129,56,139,53,132,52,139,45,137,40,136,34,138,32,133,17,139,19,145,16,145,19,149,34,148,33,155,28,156,25,152,21,153,24,160,28,160,32,163,27,167,16,165,23,172,25,181,33,183,37,179,44,179,44,184,53,186,60,190,63,188,69,192,68,200,69,204,72,206,73,197,82,197,79,200,76,200,83,205,93,205,94,205" />
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=10" />" alt="R&eacute;gion FRANCHE COMTE" title="R&eacute;gion FRANCHE COMTE" coords="361,273,361,265,356,260,361,256,358,252,361,246,363,240,367,234,367,227,364,225,371,219,367,216,371,211,374,216,375,205,382,200,395,194,394,200,404,198,409,206,409,196,416,206,426,214,423,218,428,221,429,223,422,225,418,226,428,229,427,232,405,252,404,259,396,261,394,272,393,279,376,291,369,285,364,287,358,282,361,280,360,273,362,264,355,259,365,255,358,252,361,273" />
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=5" />" alt="R&eacute;gion BOURGOGNE" title="R&eacute;gion BOURGOGNE" coords="347,270,360,273,362,268,362,264,358,261,363,257,360,252,360,246,364,239,369,227,363,225,371,220,365,216,351,213,350,203,341,191,324,200,320,197,310,197,306,184,300,184,302,177,293,177,284,177,278,184,282,197,277,208,282,214,276,217,274,225,280,228,278,241,278,249,281,251,280,260,292,265,300,258,305,269,312,275,307,283,309,287,320,291,332,284,340,288,349,269,360,274,347,270" />
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=3" />" alt="R&eacute;gion AUVERGNE" title="R&eacute;gion AUVERGNE" coords="281,256,261,261,258,272,247,273,252,286,259,290,262,294,260,304,252,305,255,309,255,312,257,318,256,328,247,335,241,346,237,353,237,358,241,359,237,368,240,373,244,372,252,370,262,357,267,363,270,365,274,367,279,358,286,353,290,359,290,366,292,366,298,358,302,364,307,364,310,362,318,358,324,350,328,339,323,335,317,331,307,334,309,325,303,315,303,307,302,304,312,297,309,287,315,282,309,285,308,283,312,275,308,270,303,263,301,259,293,264,287,263,280,261,279,258,281,256" />
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=17" />" alt="R&eacute;gion LIMOUSIN" title="R&eacute;gion LIMOUSIN" coords="190,309,200,298,194,288,203,275,211,273,221,273,242,274,249,274,254,284,255,288,260,290,263,294,262,302,256,307,252,307,256,313,258,319,257,330,251,332,246,334,242,342,239,349,236,354,212,352,215,344,213,340,207,335,212,329,212,320,208,321,200,315,190,310,190,309" />
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=22" />" alt="R&eacute;gion PAYS-DE-LA-LOIRE" title="R&eacute;gion PAYS-DE-LA-LOIRE" coords="91,206,89,211,87,215,94,218,101,218,102,215,107,216,115,219,105,219,101,220,101,224,107,229,101,236,98,236,107,247,110,255,112,259,126,269,137,269,148,272,151,269,148,262,150,255,150,249,144,247,140,241,138,234,132,229,148,232,159,230,174,233,181,230,177,222,182,219,183,204,200,204,201,196,207,193,210,185,212,182,208,173,205,177,196,172,198,166,194,160,181,164,179,159,173,155,155,159,152,156,148,154,145,167,139,170,146,175,145,183,139,180,133,193,126,187,123,191,117,191,111,197,106,194,102,203,92,205,91,206" />
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=21" />" alt="R&eacute;gion NORD-PAS-DE-CALAIS" title="R&eacute;gion NORD-PAS-DE-CALAIS" coords="240,68,243,50,244,44,255,39,267,36,274,34,279,47,287,55,292,49,296,47,300,57,302,64,308,64,313,73,328,75,330,92,326,94,322,89,312,94,305,90,301,95,290,87,278,87,271,85,271,81,261,78,257,71,256,71,249,75,240,69,240,68" />
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=7" />" alt="R&eacute;gion CENTRE" title="R&eacute;gion CENTRE" coords="260,273,260,263,272,257,279,257,282,252,278,247,278,238,278,234,280,230,277,224,274,224,276,218,283,215,279,208,280,204,283,197,280,188,275,185,267,183,261,181,257,177,250,177,244,177,243,170,237,165,234,161,231,152,224,152,224,148,215,152,213,152,207,157,213,157,216,167,207,171,212,183,208,183,208,190,202,194,198,198,201,203,184,205,182,215,181,220,177,223,178,227,181,232,185,234,185,240,193,238,201,249,209,250,206,260,212,269,214,275,232,274,252,274,262,272,260,273" />
									   <area shape="poly" href="<fwk:rewrite url="/searchShop.html?getShopForGoogleMap&regionId=24" />" alt="R&eacute;gion POITOU-CHARENTES" title="R&eacute;gion POITOU-CHARENTES" coords="130,269,127,274,131,283,128,287,132,291,124,299,117,294,108,292,111,300,119,301,122,309,129,311,137,321,140,326,147,326,148,330,146,333,155,334,163,342,165,333,176,330,172,325,181,323,181,313,193,308,200,297,195,288,207,274,214,274,208,262,211,252,202,248,194,236,184,242,186,232,181,231,175,230,174,233,157,229,149,233,135,230,144,246,149,251,149,257,152,269,148,273,141,269,130,270,127,274,132,281,130,285,132,292,126,298,112,292,108,291,113,300,116,301,121,304,130,269" />
								</map>
							</div>
						</div>
					</div>
				</div>
			</div>
				<!-- Partie droite -->
				<c:if test="${empty magasins}">
					<div class="floatRight">
						<div class="cadregris moyen" id="mapSearch">
							<div class="barretitre"><h2><span><spring:message code="shop.visualisezEmplacement"/></span></h2></div>
							<div class="ligne">
								<div id="directionDuration"></div>
								<div class="dCarte" id="map_canvas">
									<div class="googleMapsDiv">
										<span><spring:message code="shop.choisirRegion"/></span>
									</div>
								</div>
							</div>
						</div>
						
					
						<!--<c:if test="${not empty shopList || noShop != null}">-->
							<div class="cadregris moyen" id="resultSearch">
								<div class="barretitre"><h1><span>
									<c:choose>
										<c:when test="${empty nomRegion}">
											<spring:message code="shop.resultatRecherche"/>
										</c:when>
										<c:otherwise>
											<spring:message code="shop.region.resultatRecherche"/>&nbsp;${nomRegion} :
										</c:otherwise>
									</c:choose>
								</span></h1></div>
								<c:choose>
									<c:when test="${noShop == null}">
										<div class="ligne resultShopList">
											<table>
											<c:forEach items="${shopList}" var="shop" varStatus="status">
												<tr class="rowShop${status.index%2}">
													<td class="row1">
														<div class="resultShopSearch">
															<a href="${shop.shopUrl}">${shop.name} - ${shop.city}</a>
														</div>
													</td>
													<td class="row2">
														<div class="toShopDetails">
															<a href="${shop.shopUrl}"><spring:message code="shop.detailsMagasin"/></a>
														</div>
													</td>
												</tr>
											</c:forEach>
											</table>
										</div>
									</c:when>
									<c:otherwise>
										<div class="ligne error alignCenter"><spring:message code="shop.aucunMagasin"/></div>
									</c:otherwise>
								</c:choose>
							</div>
						<!--</c:if>-->
					</div>
				</c:if>
			</div>
		</form:form>
		</div>
	</div>
</tiles:putAttribute>
	
<tiles:putAttribute name="moreJS">
	<script type="text/javascript" src="${contextPath}/resources/js/common/swfobject2.js"></script>
	<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/storeLocator/searchShop.js" ></script>
	<script>
		var shopListForGoogleMaps =$.parseJSON('${googleShop}');
		var originLatitude = "${searchShop.latitude}";
		var originLongitude = "${searchShop.longitude}";
	</script>
</tiles:putAttribute>
</tiles:insertDefinition>
<div class="centerPage">
${MAG_FOOTER}
</div>