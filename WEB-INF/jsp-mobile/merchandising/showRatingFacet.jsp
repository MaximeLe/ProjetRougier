<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>


<fmt:parseNumber var="ratingDecimal" value="${rating}" type="number" pattern="#,##0.00"/>
<c:set var="ratingPageProduct" value="" />
<c:if test="${!empty ratingInPageProduct}">
	<c:set var="ratingPageProduct" value="_fpg" />
</c:if>

<c:set var="maxRating" value="5"/>

<c:if test="${!empty noMaxRating}">
	<c:set var="maxRating" value="${ratingDecimal}"/>
	<c:if test="${ratingDecimal < 0.001 }">
<%-- 		<img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/ico_star${ratingPageProduct}_off.png" border="0" alt=" "/> --%>
		<img src="${contextPath}/resources-mobile/${codeIsoLang}/img/merchandising/starE.png" width="12" height="11" alt="" border="0"/>
	</c:if>
</c:if>

<c:forEach begin="1" end="${maxRating}" var="nb">
	<c:set var="ratingPicType" value="F" />
	<c:if test="${nb > ratingDecimal}">
		<c:set var="ratingPicType" value="E" />
		<c:if test="${nb-0.5 <= ratingDecimal}">
			<c:set var="ratingPicType" value="M" />
		</c:if>
	</c:if>
	<c:set var="ratingPicture">
<%-- 		<img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/ico_star${ratingPageProduct}_${ratingPicType}.png" border="0" alt=" "/> --%>
		<img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/star${ratingPicType}.png" width="12" height="11" alt="" border="0"/>
	</c:set>
	<c:choose>
		<c:when test="${!empty betweenLi}">
			<li>${ratingPicture}</li>
		</c:when>
		<c:otherwise>${ratingPicture}</c:otherwise>
	</c:choose>
</c:forEach>