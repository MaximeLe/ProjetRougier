<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<c:forEach items="${ceDisplay.attributesKeys}" var="key">
	<c:if test="${ceDisplay.attributes[key].attributeBiz == 'PRECAUTION'}">
		<c:forEach items="${ceDisplay.attributes[key].attributeValues}" var="attributesValue">
			<tr>
				<td class="visu"><img src="${mediaPath}/pictogrammes/${attributesValue.attributeValueBiz}.jpg" width="33" height="33" alt="${attributesValue.attributeValueDescriptions[langId].description}" border="0"></td>
				<td class="txt">${attributesValue.attributeValueDescriptions[langId].description}</td>
			</tr>
			</c:forEach>
	</c:if>
	<%-- Attribut lourd encombrant --%>
	<c:if test="${ceDisplay.attributes[key].attributeBiz == 'LOURD_ENCOMBRANT'}">
			<c:if test="${ceDisplay.attributes[key].attributeValues[0].attributeValueBiz == 'LOURD_ENCOMBRANT_1' }">
				<tr>
					<td class="visu"><img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/picto_colis.png" width="38" height="35" alt="" border="0"/></td>
					<td class="fdp">Frais de port additionnels<br/><a href="/livraison.r.html" target="_blank">En savoir +</a></td>
				</tr>
			</c:if>
	</c:if>
</c:forEach>