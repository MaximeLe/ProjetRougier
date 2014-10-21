<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<div class="zVisu">
	<div class="visuel">
		<c:if test="${!empty ceDisplay.catalogEntrySticker}">
		<div class="stickers">
			<c:forEach items="${ceDisplay.catalogEntrySticker}" var="sticker">
				<img src="${mediaPath}${sticker.stickerDescriptions[langId].picture1}" border="0" alt=""/><br/>
			</c:forEach>
		</div>
		</c:if>
		<div class="zoom"><img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/btn_zoom.png" width="62" height="23" alt="Zoom" border="0"/></div>
		<c:choose>
			<c:when test="${!empty ceDisplay.catalogEntry.pictures['360']}">
				<div class='spritespin'></div>
				<img src="${catalogPath}/${ceDisplay.catalogEntryImage[0].path}" width="388" height="388" border="0" alt="${ceDisplay.catalogEntryDescription.title1}" style="cursor: pointer;" itemprop="image"/>
			</c:when>
			<c:otherwise>
				<img src="${catalogPath}/${ceDisplay.catalogEntryImage[0].path}" width="388" height="388" border="0" alt="${ceDisplay.catalogEntryDescription.title1}" style="cursor: pointer;" itemprop="image"/>
			</c:otherwise>
		</c:choose>	
	</div>
	
	<ul>
	<c:set var="i" value="0" />
	<c:forEach items="${ceDisplay.miniature}" var="miniature" end="${ceDisplay.nbMiniatureMax}" varStatus="status">
		<c:if test="${!empty miniature}"><li><img id="miniature${i}" onClick="determineImageCourante(${i});" src="${catalogPath}/${miniature.path}" width="88" height="88" border="0" alt="${ceDisplay.catalogEntryDescription.title1}" /></li></c:if>
		<c:set var="i" value="${i+1}" />
	</c:forEach>
	<c:if test="${!empty ceDisplay.catalogEntry.pictures['360']}">
		<li><img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/v360.png" width="88" height="88" alt="Vue 360" border="0" class="v360"/></li>
	</c:if>
	<c:if test="${!empty videoId}">
		<li><img src="${contextPath}/resources/${codeIsoLang}/img/merchandising/vVideo.png" width="88" height="88" alt="Vidéo" border="0" class="vVideo" onclick="openModalYoutube('${videoId}');"/></li>
	</c:if>
	</ul>
	<div id="chargementImagesZoom" style="display:none;"></div>
</div>

<tiles:putAttribute name="moreJS">
		<script src="${contextPath}/resources/js/merchandising/merchandising.js" type="text/javascript"></script>
</tiles:putAttribute>