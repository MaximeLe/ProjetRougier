<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div id="modal">
	<div class="btn_close"></div>
	<div class="content wishList">
		<div class="titre"><spring:message code="wishList.vosListes"/></div>
		<div class="addToWishList">
			<c:choose>
				<c:when test="${!(empty wishesList)}">
					<form>
						<c:forEach var="customerWishedList" items="${wishesList}">
							<div class="wishlistNameContainer">
								<c:if test="${newWishListId == customerWishedList.wishListId}">
									<input type="checkBox" name="wishListIds" value="${customerWishedList.wishListId}" checked/>
								</c:if>
								<c:if test="${newWishListId != customerWishedList.wishListId}">
									<input type="checkBox" name="wishListIds" value="${customerWishedList.wishListId}"/>
								</c:if>
								<label for=""><span class="gras">${customerWishedList.wishListName} :</span> ${fn:length(customerWishedList.products)} <spring:message code="wishList.articles"/></label>
							</div>
						</c:forEach>
						<div class="clear"></div>
						<c:set var="text"><spring:message code="wishList.boutonAjouter"/></c:set>
						<fwk:genericButton text="${text}" firstSpanClass="Org_small" onClick="openAddToWishList()" buttonType="button"/>
					</form>
				</c:when>
				<c:otherwise><spring:message code="wishList.aucuneListe"/></c:otherwise>
			</c:choose>
		</div>
		<div class="rouge"><span>${error}</span></div>
		<div class="titre"><spring:message code="wishList.creerNouvelle"/></div>
		<div class="newWishList">
			<form>
				<label for="wishListName"><spring:message code="wishList.nomListe"/></label>
				<input type="text" name="wishListName" id="wishListName"/>
				<c:set var="text"><spring:message code="wishList.boutonCreer"/></c:set>
				<fwk:genericButton text="${text}" firstSpanClass="Org_small" onClick="openAddWishList()" buttonType="button" />
			</form>
		</div>
	</div>
</div>