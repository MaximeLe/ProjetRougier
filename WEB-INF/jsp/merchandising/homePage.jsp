<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<tiles:insertDefinition name="template">
	<tiles:putAttribute name="canonical">
		http://www.rougier-ple.fr
	</tiles:putAttribute>
	<tiles:putAttribute name="title"><c:if test="${isSolde}"><spring:message code="common.soldes"/></c:if><spring:message code="catalogue.homePageTitle"/></tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="catalogue.homePageDescription"/></tiles:putAttribute>
	<tiles:putAttribute name="webmasterTools"><meta name="google-site-verification" content="5UZLGIStZS9BRjs1mCLpMfVBGjzBZ-pG4-zGz1---0o" /></tiles:putAttribute>
	<tiles:putAttribute name="head">
		<style type="text/css">
		#breadcrumb {display:none;}
		</style>
		<link href="http://${pageContext['request'].serverName}${contextPath}/resources/${codeIsoLang}/img/common/logo.png" rel="image_src" />
		<c:forEach items="${IMG_FACEBOOK}" var="image">
			<link href="http://${pageContext['request'].serverName}${image}" rel="image_src" />
		</c:forEach>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<!-- Contenu -->
		<div id="content" class="homePage">
			<!-- Visionneuse Jquery -->
			<div id="visio">
				<div class="prev"><img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/visioPrev.png" width="17" height="28" alt="" border="0"/></div>
				<div class="scroll">
					<div class="content">
						${HP_PRINCIPAL}
					</div>
					<ul class="numero">
						<li class="on"></li>
					</ul>
				</div>
				<div class="next"><img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/visioNext.png" width="17" height="28" alt="" border="0"/></div>
			</div>
			

			
			<!-- 3 EMS Bas -->
			<div class="emsBas">
				${HP_BAS_GAUCHE}
			</div>
			
			<div class="emsBas">
				${HP_BAS_CENTRE}
			</div>
			
			<div class="emsBas last">
				${HP_BAS_DROIT}
			</div>
			
			<!-- Marques -->
			<div class="marques">
				${HP_BANDEAU_BAS}
			</div>
			<div class="seoHP">
				${HP_SEO_BAS}
			</div>
		</div>
		<!-- Fin Contenu -->
	</tiles:putAttribute>
	
	<tiles:putAttribute name="moreJS">
		<script src="${contextPath}/resources/js/merchandising/catalogEntry.js" type="text/javascript"></script>
		<script src="${contextPath}/resources/js/merchandising/visio.js" type="text/javascript"></script>
		<c:if test="${isTagMetafiliationActivated }">
			<script type="text/javascript" src="http://img.metaffiliation.com/u/11/p33385.js?zone=accueil"></script>
		</c:if>
	</tiles:putAttribute>
</tiles:insertDefinition>