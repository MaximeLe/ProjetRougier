<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<div id="bloc_relay">

<input type="hidden" name="delivery" value="relay"/>
<div class="separation"></div>
<div class="cadregris grand">
<div class="barretitre"><span>Mon point relais</span></div>
							
								<div class="ligne">
								<div id="point_relais">
								<div class="floatLeft">
										<div class="bloc">
												<c:set var="phone">
													<c:choose>
														<c:when test="${not empty telephoneRelayModifie}">
															${telephoneRelayModifie}
														</c:when>
														<c:otherwise>
															${telephoneRelay}
														</c:otherwise>
													</c:choose>
												</c:set>
												<!-- <span class="bold"><spring:message code="modifAdresse.telephone"/>* : </span><input type="text" name="phone" id="phone" class="input_petit"  value="${phone }" /> -->
												<span class="bold"><spring:message code="modifAdresse.telephone"/> : </span><input type="text" name="phone" id="phoneDeliveryRelay" class="input_petit"  value="${phone }" />
												<span class="error" id="phoneError"></span>
											</div>
										<div class="bloc">
											<span class="bold">Trouvez un autre point relais par code postal</span> <span class="erreur">*</span><br />
											<div class="recherche_relais">
												<label for="cpRelais"></label>
												<input type="text" name="cpRelay" id="cpRelay" class="input_petit"  value="${relayPoint.zipCode }" />
												<input onclick="javascript:clickSearchRelay(${param.serviceTransportId});return false" id="searchRelay" name="searchRelay" type="image" src="${contextPath}/resources/fr_FR/img/clientArea/btn_ok.png" value="ok" />
											</div>
											
										</div>
										<div id="bloc_search_relay" name="bloc_search_relay" class="bloc">
											<span class="bold">Points relais trouv&eacute;s *</span>
											<p><select name="selectRelay" id="selectRelay" class="multiple_grand" multiple="true"><option></option></select></p>
										</div>
									</div>
									<div class="floatRight">
										<c:if test="${not empty relayPoint }">
											<span class="bold">${relayPoint.name}</span><br />
											${relayPoint.address1}
											<c:if test="${relayPoint.address1 !=null && relayPoint.address1 != ''}">
												<br /> 
											</c:if>
											${relayPoint.zipCode} ${relayPoint.city}
											${relayPoint.locationHint}
											<br /><br />
											<span class="bold">Horaires d'ouverture :</span><br />
											<table class="horaires">
												<c:forEach items="${openingHours}" var="openingHours">
													<tr>
														<th class="titre">${weekMap[openingHours.dayId]}:</th>
														<td>
																${openingHours.openingHoursAM}  ${openingHours.closingHoursAM}
																${openingHours.openingHoursPM}  ${openingHours.closingHoursPM}
														</td>
													</tr>
												</c:forEach>
											
											</table>
											<br/>
												
											<c:if test="${relayPoint.photoUrl!=null }">
												<div class="espace"><img src="${relayPoint.photoUrl}" style="max-width:300px;"/></div>
											</c:if>
										</c:if>
									</div>
									
									
								</div>
								</div>
					</div>
					</div>