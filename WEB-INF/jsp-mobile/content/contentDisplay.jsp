<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<tiles:insertDefinition name="mobile-templateMenu">
	
	<tiles:putAttribute name="title">
		${meta.title} - Rougier & Plé
	</tiles:putAttribute>
	<tiles:putAttribute name="description">
		${meta.description}
	</tiles:putAttribute>
	
	<tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}${requestScope['javax.servlet.forward.servlet_path']}
	</tiles:putAttribute>
	
	
	<tiles:putAttribute name="breadcrumb">
		<div id="breadcrumb" itemprop="breadcrumb">
			<a href="/">Accueil</a>
			<c:forEach items="${breadcrumb}" var="item"  varStatus="statut">
				<c:if test="${statut.last}">
					 &nbsp;> <span>${item.title}</span>
				</c:if>
				<c:if test="${!statut.last}">
					<a href="${item.urlRewrite}"  class="lien_chemin">${item.title}</a>
				</c:if>
			</c:forEach>
		</div>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="ems">&nbsp; </tiles:putAttribute>
	
	<tiles:putAttribute name="head">
		<style type="text/css">
			h4 {
				color: white;
			}
			h4, h5 {
				font-weight: bold;
			}
			h5 {
				color: #bbbbbb;
			}
			ul.quiSommeNous li {
				list-style-type: disc;
			}
			#afficheContenu {
				margin:0 0 0 210px;
			}
			#menuContent {
				position : absolute;
				padding : 10px 0px 0px 20px;
			}
		</style>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="menu">&nbsp; </tiles:putAttribute>

	<tiles:putAttribute name="content">
			${html}
	</tiles:putAttribute>
	
	<tiles:putAttribute name="moreJS">
		<script src="${contextPath}/resources-mobile/js/merchandising/catalogEntry.js" type="text/javascript"></script>
	</tiles:putAttribute>
	
</tiles:insertDefinition>