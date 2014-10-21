<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="devise"><c:choose><c:when test="${storeId==2}">&#36;</c:when><c:otherwise>&euro;</c:otherwise></c:choose></c:set>

<c:if test="${fn:length(cart.cartLines) > 0}">
	<div class="floatRight">
		<div class="cadregris petit">
			<div class="barretitre"><span><spring:message code="receipt.maCommande"/></span></div>
			<div id="mini_cart" name="mini_cart" class="ligne">
				<div class="ligne">
					<p class="floatLeft"><spring:message code="receipt.panier"/> (<span id="receiptCountItem"></span> <spring:message code="receipt.articles"/>)</p>
					<p class="floatRight bold alignRight"><fwk:priceFormater price="${cart.subTotal - cart.sumOfCartDiscount - cart.sumOfItemDiscount}" format="$1${devise}$2"/></p>
				</div>
				<div class="ligne">
					<p class="floatLeft">
					<%-- c:set var="giftCounter" value="0"/>
					<c:forEach items="${cart.cartGiftsLines}" var="giftItem">
						<c:if test="${giftItem.state != 'DELETED_UNIQUE_AND_FREE'}">
							<c:set var="giftCounter" value="${giftCounter + 1}"/>
						</c:if>
					</c:forEach --%>
					<spring:message code="receipt.fraisDePort"/>
					<br/>
					<c:if test="${(cart.shippingFee.sumOfDiscount != 0)}">
						<spring:message code="receipt.remise"/>
					</c:if>
					</p>
					<p class="floatRight bold alignRight">
					<%-- c:if test="${giftCounter > 0}">
						<c:choose>
							<c:when test="${cart.sumOfCartGift >= 0.01}">
								<fwk:priceFormater price="${cart.sumOfCartGift}" format="$1${devise}$2"/>
							</c:when>
							<c:otherwise>
								<spring:message code="receipt.offert"/>
							</c:otherwise>
						</c:choose>
						<br/>
					</c:if --%>
					+<fwk:priceFormater price="${cart.shippingFee.fee}" format="$1${devise}$2"/>
					<br/>
					<c:if test="${(cart.shippingFee.sumOfDiscount != 0)}">
						- <fwk:priceFormater price="${cart.shippingFee.sumOfDiscount}" format="$1${devise}$2"/>
					</c:if>
					</p>
				</div>
				<div class="ligne separe">
					<p class="floatLeft">
						<span class="titre"><spring:message code="receipt.totalARegler"/></span>
					</p>
					<p class="floatRight bold alignRight">
						<span class="titre"><fwk:priceFormater price="${cart.total}" format="$1${devise}$2"/></span>
					</p>
					
				</div>
			</div>
		</div>
		<div class="cadregris petit">
			<div class="barretitre"><span><spring:message code="receipt.monAdresseFacturation"/></span></div>
			<div class="adresse_fact">
				<div class="ligne">
					${cart.addressBilling.firstName}&nbsp;${cart.addressBilling.lastName} <br />
					<c:if test="${!empty cart.addressBilling.addressLine1}">
					${cart.addressBilling.addressLine1}<br />
					</c:if>
					<c:if test="${!empty cart.addressBilling.addressLine2}">
					${cart.addressBilling.addressLine2}<br />
					</c:if>
					<c:if test="${!empty cart.addressBilling.addressLine3}">
					${cart.addressBilling.addressLine3}<br />
					</c:if>
					<c:if test="${!empty cart.addressBilling.addressLine4}">
					${cart.addressBilling.addressLine4}<br />
					</c:if>
					<c:if test="${!empty cart.addressBilling.complementInfo}">
					${cart.addressBilling.complementInfo}<br />
					</c:if>
					${cart.addressBilling.zipCode} - ${cart.addressBilling.city}<br/>
					${cart.addressBilling.country}
					
				</div>
				
				<div class="ligne">
					<a href="#" id="modifBillingAdres" class="modifBillingAdress" onClick="addOrModifyAddress('${cart.addressBilling.addressId}','billing');"><span>Modifier</span></a>
				</div>
			</div>
		</div>
	</div>
</c:if>