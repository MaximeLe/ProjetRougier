<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="connect">
	<div class="print"><a href="javascript:print();"><img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/btn_print.png" width="19" height="18" alt="Imprimer" border="0"/></a></div>
	<div class="send" onclick="openModalSendFriend(${ceDisplay.catalogEntry.catalogEntryId});"><img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/btn_send.png" width="21" height="16" alt="Envoyer à un ami" border="0"/></div>
	<c:set var="urlCanonical">
		<fwk:rewrite url="${ceDisplay.urlWithoutEcId}${ceDisplay.catalogEntry.catalogEntryId}"/>
	</c:set>
	<div class="fb"><div class="fb-like" data-href="http://${urlDomaine}${urlCanonical}" data-send="false" data-width="50" data-show-faces="false" data-layout="button_count"></div></div>
	<div class="gplus"><g:plusone size="medium" annotation="none"></g:plusone></div>
</div>