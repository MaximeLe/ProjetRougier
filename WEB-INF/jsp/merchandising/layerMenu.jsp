<%@ page trimDirectiveWhitespaces="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.pictime.com/tags/core"  prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!-- Navigation -->
<div id="navigation">
	<ul>
	<li id="navacc"><a href="/"><img src="${contextPath}/resources/${codeIsoLang}/img/common/ico_accueil.gif" alt="Accueil" /></a></li>
	<li id="navEntry_0">
		<span class="title">Beaux-Arts</span>
		<div class="sousNav">
			<div class="content">
				<div class="zonehaut">
					<div class="zoneimg"><img alt="Beaux-Arts" src="/library/layer/menu_item_0.png"></div>
					<div class="zonecategories">${LAYER_LISTE_SOUS_CATEGORIES_0}</div>
					<div class="fdbg7">
						<div class="zone7">${LAYER_ZONE_7_0}</div>
						<div class="zone8">${LAYER_ZONE_8_0}</div>
					</div>
				</div>
				<div class="zonepush">${LAYER_PUSH_PRODUIT_0}</div>			
			</div>
		</div>
	</li>
	<li id="navEntry_1">
		<span class="title">Arts-Graphiques</span>
		<div class="sousNav">
			<div class="content">
				<div class="zonehaut">
					<div class="zoneimg"><img alt="Arts-Graphiques" src="/library/layer/menu_item_1.png"></div>
					<div class="zonecategories">${LAYER_LISTE_SOUS_CATEGORIES_1}</div>
					<div class="fdbg7">
						<div class="zone7">${LAYER_ZONE_7_1}</div>
						<div class="zone8">${LAYER_ZONE_8_1}</div>
					</div>
				</div>
				<div class="zonepush">${LAYER_PUSH_PRODUIT_1}</div>						
			</div>
		</div>
	</li>
	<li id="navEntry_2">
		<span class="title">Papeterie</span>
		<div class="sousNav">
			<div class="content">
				<div class="zonehaut">
					<div class="zoneimg"><img alt="Papeterie" src="/library/layer/menu_item_2.png"></div>
					<div class="zonecategories">${LAYER_LISTE_SOUS_CATEGORIES_2}</div>
					<div class="fdbg7">
						<div class="zone7">${LAYER_ZONE_7_2}</div>
						<div class="zone8">${LAYER_ZONE_8_2}</div>
					</div>
				</div>	
				<div class="zonepush">${LAYER_PUSH_PRODUIT_2}</div>			
			</div>
		</div>
	</li>
	<li id="navEntry_3">
		<span class="title">Loisirs Cr&eacute;atifs</span>
		<div class="sousNav">
			<div class="content">
				<div class="zonehaut">
					<div class="zoneimg"><img alt="Loisirs Créatifs" src="/library/layer/menu_item_3.png"></div>
					<div class="zonecategories">${LAYER_LISTE_SOUS_CATEGORIES_3}</div>
					<div class="fdbg7">
						<div class="zone7">${LAYER_ZONE_7_3}</div>
						<div class="zone8">${LAYER_ZONE_8_3}</div>
					</div>
				</div>
				<div class="zonepush">${LAYER_PUSH_PRODUIT_3}</div>		
			</div>
		</div>
	</li>
	<li id="navEntry_4">
		<span class="title">Artisanat d'art</span>
		<div class="sousNav">
			<div class="content">
				<div class="zonehaut">
					<div class="zoneimg"><img alt="Artisanat d'art" src="/library/layer/menu_item_4.png"></div>
					<div class="zonecategories">${LAYER_LISTE_SOUS_CATEGORIES_4}</div>
					<div class="fdbg7">
						<div class="zone7">${LAYER_ZONE_7_4}</div>
						<div class="zone8">${LAYER_ZONE_8_4}</div>
					</div>
				</div>	
				<div class="zonepush">${LAYER_PUSH_PRODUIT_4}</div>							
			</div>
		</div>
	</li>
	<li id="navEntry_5">
		<span class="title">Enfant</span>
		<div class="sousNav">
			<div class="content">
				<div class="zonehaut">
					<div class="zoneimg"><img alt="Enfant" src="/library/layer/menu_item_5.png"></div>
					<div class="zonecategories">${LAYER_LISTE_SOUS_CATEGORIES_5}</div>
					<div class="fdbg7">
						<div class="zone7">${LAYER_ZONE_7_5}</div>
						<div class="zone8">${LAYER_ZONE_8_5}</div>
					</div>
				</div>
				<div class="zonepush">${LAYER_PUSH_PRODUIT_5}</div>
			</div>
		</div>
	</li>
	${MENU_HEADER_DROIT}
	</ul>
</div>
<!-- EMS bandeau menu -->
<div id="ems bandeau" >${EMS_BANDEAU_MENU}</div>