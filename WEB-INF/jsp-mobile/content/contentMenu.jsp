<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:forEach items="${menuItem}" var="item">
	<li><a href="${item.urlRewrite}" class="lien_chemin" >${item.title}</a>
		<c:if test="${!empty (item.menuItems)}">
			<ul class="quiSommeNous" style="margin-left: 10px;margin-top: 0px;" >
				<c:set var="menuItem" value="${item.menuItems}" scope="request" />
				<c:import url="contentMenu.jsp"/>
			</ul>
		</c:if>
	</li>
</c:forEach>