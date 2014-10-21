<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<c:forEach items="${values}" var="catFille">
	<li id="cat_${catFille.id}">
		<c:set var="urlRewriteCat">
			<fwk:rewrite url="${baseUrlWithoutCategoryId}&categoryId=${catFille.id}" paramUnRewrited="${paramRewriteCategory}" />
		</c:set>
		<c:choose>
			<c:when test="${catFille.selected}">
				<a href="${urlRewriteCat}" class="bold">${catFille.value}</a>
				<c:if test="${!empty (catFille.childs)}">
					<ul>
						<c:set var="values" value="${catFille.childs}" scope="request" />
						<c:import url="menuCategory.jsp"/>
					</ul>
				</c:if>
			</c:when>
			<c:otherwise>
				<a href="${urlRewriteCat}">${catFille.value}</a>
			</c:otherwise>
		</c:choose>
	</li>
</c:forEach>