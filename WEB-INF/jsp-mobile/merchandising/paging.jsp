<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:choose>
	<c:when test="${facetContext.page != 1}"><a href="${urlRewritePage}1" class="nav pD"></a></c:when>
</c:choose>
<c:choose>
	<c:when test="${facetContext.page-1 >= 1}"><a href="${urlRewritePage}${facetContext.page-1}" class="nav pP"></a></c:when>
</c:choose>
<c:choose>
	<c:when test="${facetResult.totalPage <= 5}">
		<c:forEach var="page" begin="1" end="${facetResult.totalPage}" varStatus="pageS">
			<c:choose>
<%-- 				<c:when test="${facetContext.page == page}"><a href="${urlRewritePage}${page}" class="num on">${page}</a></c:when> --%>
				<c:when test="${facetContext.page == page}"><a class="num on">${page}</a></c:when>
				<c:otherwise><a href="${urlRewritePage}${page}" class="num">${page}</a></c:otherwise>
			</c:choose>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${facetContext.page <= 2}">
				<c:forEach var="page" begin="1" end="5" varStatus="pageS">
					<c:choose>
<%-- 						<c:when test="${facetContext.page == page}"><a href="${urlRewritePage}${page}" class="num on">${page}</a></c:when> --%>
						<c:when test="${facetContext.page == page}"><a class="num on">${page}</a></c:when>
						<c:otherwise><a href="${urlRewritePage}${page}" class="num">${page}</a></c:otherwise>
					</c:choose>
				</c:forEach>
			</c:when>
			<c:when test="${facetContext.page >= facetResult.totalPage-2}">
				<c:forEach var="page" begin="${facetResult.totalPage-4}" end="${facetResult.totalPage}" varStatus="pageS">
					<c:choose>
<%-- 						<c:when test="${facetContext.page == page}"><a href="${urlRewritePage}${page}" class="num on">${page}</a></c:when> --%>
						<c:when test="${facetContext.page == page}"><a class="num on">${page}</a></c:when>
						<c:otherwise><a href="${urlRewritePage}${page}" class="num">${page}</a></c:otherwise>
					</c:choose>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<c:forEach var="page" begin="${facetContext.page-2}" end="${facetContext.page+2}" varStatus="pageS">
					<c:choose>
<%-- 						<c:when test="${facetContext.page == page}"><a href="${urlRewritePage}${page}" class="num on">${page}</a></c:when> --%>
						<c:when test="${facetContext.page == page}"><a class="num on">${page}</a></c:when>
						<c:otherwise><a href="${urlRewritePage}${page}" class="num">${page}</a></c:otherwise>
					</c:choose>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${facetContext.page+1 <= facetResult.totalPage}"><a href="${urlRewritePage}${facetContext.page+1}" class="nav pS"></a></c:when>
</c:choose>
<c:choose>
	<c:when test="${facetContext.page != facetResult.totalPage}"><a href="${urlRewritePage}${facetResult.totalPage}" class="nav pF"></a></c:when>
</c:choose>