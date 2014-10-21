<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:if test="${not empty foireTechnique}">
	<c:set var="iteration" value="0" />
	<c:forEach items="${foireTechnique}" var="foire">
		<c:choose>
			<c:when test="${iteration == fn:length(foireTechnique)-1}">
				${foire}
				<c:set var="iteration" value="${iteration+1}" />
			</c:when>
			<c:otherwise>
				${foire}<br /><br />
				<c:set var="iteration" value="${iteration+1}" />
			</c:otherwise>
		</c:choose>
	</c:forEach>
</c:if>