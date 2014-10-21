<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<ul>
	<c:forEach items="${ceDisplay.catalogEntry.schemaBiz.schemaNodes}" var="schemaNode">
		<c:if test="${schemaNode.wording == 'Descriptif'}">
			<c:forEach items="${schemaNode.schemaAttributeNodes}" var="schemaAttributeNode">
	<li><span class="bold">${schemaAttributeNode.attribute.attributeDescriptions[langId].description} :</span>&nbsp;
				<c:forEach items="${ceDisplay.attributesKeys}" var="key">
						<c:if test="${schemaAttributeNode.attribute.attributeBiz == ceDisplay.attributes[key].attributeBiz}">
							<c:forEach items="${ceDisplay.attributes[key].attributeValues}" var="attributesValue" varStatus="status">
								<c:choose>
									<c:when test="${not status.last}">
										${attributesValue.attributeValueDescriptions[langId].description},&nbsp;
									</c:when>
									<c:otherwise>
										${attributesValue.attributeValueDescriptions[langId].description}.
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:if>
				</c:forEach>
	</li>
			</c:forEach>
		</c:if>
	</c:forEach>
</ul>