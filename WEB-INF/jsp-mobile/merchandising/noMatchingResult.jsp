<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<tiles:insertDefinition name="template">

<%--<tiles:putAttribute name="title"><spring:message code="catalogue.aucunResultat"/>&nbsp;:&nbsp;${ceDisplay.catalogEntryDescription.title1}</tiles:putAttribute>--%>
<tiles:putAttribute name="title"><spring:message code="catalogue.aucunResultat"/>&nbsp;:&nbsp;${searchWord}</tiles:putAttribute>

<tiles:putAttribute name="head">
	<style type="text/css">
		#fenetre_centre {color: white;}
		#fenetre_centre a {text-decoration:none; color:#BBBBBB;}
		#fenetre_centre a:hover {text-decoration:underline;}
	</style>
	
</tiles:putAttribute>

<tiles:putAttribute name="canonical" type="string">
	http://${pageContext['request'].serverName}${requestScope['javax.servlet.forward.servlet_path']}
</tiles:putAttribute>
	
	<tiles:putAttribute name="robots">noindex</tiles:putAttribute>
	
<tiles:putAttribute name="breadcrumb">
	<span id="chemin_categories">
		<a href="/" class="lien_chemin"><spring:message code="breadcrumb.accueil"/></a> &gt;
		${searchWord}
	</span>
	<div class="retour"><a href="javascript:history.back();">Retour</a></div>
</tiles:putAttribute>	
	
<tiles:putAttribute name="content">
		
				
			${CAT_PR_AUCUN_HAUT}
		
			<!--  EMS 2 -->
			<style>
				.ems_2{float:left;width:973px;height:270px;margin-top:29px;padding-left:18px;padding-bottom:20px;background:url(${contextPath}/resources/${codeIsoLang}/img/moteur/ems_2.jpg) no-repeat #ffffff;}
				.ems_2 .bloc_article{float:left;width:188px;margin-top:19px;margin-left:19px;margin-right:30px;}
				.ems_2 .bloc_article .image{float:left;width:188px;height:136px;position:relative}
				.ems_2 .bloc_article .image .stickers{position:absolute;right:0px;top:0px;}
				.ems_2 .bloc_article .intitule{float:left;width:188px;}
				.ems_2 .bloc_article .intitule span{font-family:Arial;font-size:16px;font-weight:bold;color:#303030}
				.ems_2 .bloc_article .description{float:left;width:188px;margin-top:11px;height:42px;}
				.ems_2 .bloc_article .description span{float:left;width:188px;font-family:Arial;font-size:12px;line-height:14px;color:#777777}
				.ems_2 .bloc_article .prix{float:left;width:188px;}
				.ems_2 .bloc_article .prix .barre{float:left;font-family:Arial;font-size:14px;color:#777777;text-decoration:line-through;margin-top:3px;margin-right:10px;}
				.ems_2 .bloc_article .prix .rouge{float:left;font-family:Arial;font-size:20px;color:#e30613;font-weight:bold;}
				
				
			</style>
			<div class="ems_2">
				<c:import url="pushProduit.jsp"></c:import>
			</div>
			<!--  /EMS 2 -->
</tiles:putAttribute>
	
</tiles:insertDefinition>