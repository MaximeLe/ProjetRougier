<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>

<div class="infosPlus">
	<%-- EMS catégorie niveau 1 --%>
	<div>
		${EMS_MARKETING}
	</div>
	<%-- accroche marketing --%>
	<div class="accroches">
	<c:forEach items="${ceDisplay.attributesKeys}" var="key">
		<c:if test="${ceDisplay.attributes[key].attributeBiz == 'ACCROCHE'}">
			<c:forEach items="${ceDisplay.attributes[key].attributeValues}" var="attributesValue" varStatus="status">
				<div class="accroche">${attributesValue.attributeValueDescriptions[langId].description}</div>
			</c:forEach>
		</c:if>
	</c:forEach>
	</div>
</div>