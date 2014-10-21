<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>


<!-- **************************************
	***************************************
	remplacer class="panier"
	et effectuer le design avec les nouvelles classes
	Actuellement les class sont celle de "panier" ex : "ligne titre", "cadregris petit"
	***************************************
	***************************************
 -->

<tiles:insertDefinition name="template">

<tiles:putAttribute name="title">${productName}</tiles:putAttribute>
<tiles:putAttribute name="breadcrumb"><span id="chemin_categories"><a href="/" class="lien_chemin">Accueil</a></span></tiles:putAttribute>

<tiles:putAttribute name="head">
	<script type="text/javascript">
		$(document).ready(
			function (){
			    $('#fiche_navbas a').removeClass();
			    $('#fiche_navbas a').attr("class", "fiche_onglet");
			    var context = '${affichage}';
			    if (context == ''){
			    	context = 'allReview';
			    }
			    $('#'+context).addClass("fiche_selected");
			}
		);
	</script>
	<style type="text/css">
		.blockTab {
			background-color:#FFFFFF;
			
			clear:both;
			margin:10px 15px;
		}
		.barTab {
			font-weight: bold;
			color:#FE8300;
			
			width:100%;
			height:34px;
			background-image:url("${contextPath}/resources/${codeIsoLang}/img/StarterStore/Fichemenu_normal.jpg");
			background-repeat:repeat-x;
		}
		
		
		.barTab ul {
			overflow:hidden;
		}
		.barTab li {
			float:left;
			width:155px;
			height:34px;
			background-image:url("${contextPath}/resources/${codeIsoLang}/img/StarterStore/Menuprincipal_separation.jpg");
			background-repeat:no-repeat;
			background-position:right;
			text-align:center;
		}
		.barTab span {
			display:block;
			margin:0 2px 0 0;
			padding:0 10px;
			height:34px;
			line-height:32px;
			text-decoration:none;
			font-weight:bold;
			background-color:#FFFFFF;
			color:#FE8300;
		}
		.barTab span:hover {
			background-image:none;
			background-color:#FFFFFF;
		}
		.pContentTab {
			padding: 20px 100px;
		}
		
		#fiche_navbas li {
			width: 155px;
		}
		
		#generalStats {
			padding: 0px 10px;
		}
		.stats {
			clear:both;
			padding: 10px;
		}
		.stats div {
			float:left;
		}
		.titleStats {
			text-align: left;
			font-weight: bold;
			width: 200px;
		}
		
		#paging {
			float: right;
		}
	</style>
</tiles:putAttribute>
<tiles:putAttribute name="content">
	<div id="content" class="panier">
		<!-- Début du content -->
		<div class="contentStart"></div>
		
		<!-- Contenu -->
		<div id="contenu" xmlns:v="http://rdf.data-vocabulary.org/#" typeof="v:Review-aggregate">
			<h1 property="v:itemreviewed">${productName}</h1>
			<div class="clear hidden">
				<!-- Partie gauche -->
				<div class="floatLeft">
					<div class="cadregris grand">
						<div class="barretitre"><span>Statistiques globales</span></div>
						<div class="ligne">
							<div id="generalStats"><img src="${contextPath}/resources/${codeIsoLang}/img/review/class=${classId}subClass=${subClassId}objectInstance=${objectInstanceId}.jpg" height=350 />
							<div class="stats">
								<div class="titleStats">Moyenne des notes générales</div>
								<div>
									<c:forEach begin="1" end="5" var="nb">
										<c:choose>
											<c:when test="${nb <= generalAvg}">
												<img src="${contextPath}/resources/${codeIsoLang}/img/StarterStore/Grande_etoile_orange.png" alt="" />
											</c:when>
											<c:otherwise>
												<img src="${contextPath}/resources/${codeIsoLang}/img/StarterStore/Grande_etoile_grise.png" alt="" />
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</div>
							</div>
							<div class="stats">
								<div class="titleStats">&nbsp;</div>
								<div>
									<span rel="v:Rating">
										<span property="v:average"><fmt:formatNumber value="${generalAvg}" type="number" maxFractionDigits="2"/></span> / <span property="v:best">5</span>
									</span>
								</div>
							</div>
							<div class="stats">
								<div class="titleStats">Nombre des avis notés</div>
								<div>
									<span property="v:votes">${count}</span><span property="v:count" style="display: none">${count}</span>
								</div>
							</div>
							<div class="stats">
								<div class="titleStats">Nombre d'avis</div>
								<div>
									${reviewCount}
								</div>
							</div>
							<br/>
						</div>
						</div>
					</div>
					
					<div class="cadregris grand">
						<div class="barretitre"><span>Tris</span></div>
						<div class="ligne">
							<p class="pContentTab" style="float:right;">
								<a href="${baseUrl}${urlView}&finderType=date">
								Tri par date</a>
							</p>
							<p class="pContentTab">
								<a href="${baseUrl}${urlView}&finderType=random">
								5 Avis aléatoires</a>
							</p>
						</div>
					</div>
					
					
					<div class="cadregris grand">
						<div id="fiche_navbas" class="barretitre">
							<span><a href="${baseUrl}${paramFinderType}" class="fiche_selected" style="line-height:12pt;" id="allReview">Affichage complet des avis</a></span>
							<span><a href="${baseUrl}${paramFinderType}&view=reco" class="fiche_onglet" style="line-height:12pt;" id="reco">Affichage des recommendations</a></span>
							<span><a href="${baseUrl}${paramFinderType}&view=commentAndRating" class="fiche_onglet" style="line-height:12pt;" id="commentAndRating">Affichage des commentaires et notes</a></span>
							<span><a href="#" onclick="window.open('?action=displayFormReview&classId=${classId}&objectInstanceId=${objectInstanceId}&subClassId=${subClassId}&langueId=${langueId}','Preview','menubar=no, status=no, scrollbars=yes, menubar=no, width=820, height=600');" class="fiche_onglet">Saisir un avis</a></span>
						</div>
						<!-- ********************************************************************** -->
						<div id="additionalInformation"  class="ligne">
							<div id="review">
								<c:forEach items="${reviews}" var="review">
									<c:if test="${(affichage == null) || (affichage == 'reco' && (!empty review.generalRating.value)) || (affichage == 'commentAndRating' && (!empty review.recommendations))}">
									<div class="ligne2">
										<div class="avis_auteur">
											Commentaire de :<br /><span class="gras">${review.pseudonym}</span> (${review.email})<br />
											<c:if test="${(!empty review.generalRating.value) && affichage != 'reco'}">
												<c:forEach begin="1" end="5" var="nb">
													<c:choose>
														<c:when test="${nb <= review.generalRating.value}">
															<img src="${contextPath}/resources/${codeIsoLang}/img/StarterStore/Grande_etoile_orange.png" width="17" alt="" />
														</c:when>
														<c:otherwise>
															<img src="${contextPath}/resources/${codeIsoLang}/img/StarterStore/Grande_etoile_grise.png" width="17" alt="" />
														</c:otherwise>
													</c:choose>
												</c:forEach>
											</c:if>
										</div>
										<div class="avis_commentaire">
											<c:if test="${affichage != 'reco'}">
												<c:if test="${(!empty review.ratingAndCommentCouple)}">
													<div class="avis_separation">
														<c:forEach items="${review.ratingAndCommentCouple}" var="r">
															<p class="gauche2"><strong>${r.criterion.criterionDescription.text}</strong> :
																<c:if test="${!r.criterion.recoUsage && (!empty r.rating.value)}">
																		<c:forEach begin="1" end="5" var="nb">
																			<c:choose>
																				<c:when test="${nb <= r.rating.value}">
																					<img src="${contextPath}/resources/${codeIsoLang}/img/StarterStore/Etoile_orange.png" width="13" alt="" />
																				</c:when>
																				<c:otherwise>
																					<img src="${contextPath}/resources/${codeIsoLang}/img/StarterStore/Etoile_grise.png" width="13" alt="" />
																				</c:otherwise>
																			</c:choose>
																		</c:forEach>
																</c:if>
																${r.comment.text}
															</p>
														</c:forEach>
													</div>
												</c:if>
												<span class="avis_titre2">${review.title}</span>
												<span class="gras">Commentaire général :</span><br />
												${review.generalComment.text}<br /><br />
											</c:if>
											<c:if test="${(!empty review.recommendations) && (affichage != 'commentAndRating')}">
												<span class="gras">Recommandations :</span><br />
												<c:forEach items="${review.recommendations}" var="reco">
													${reco.criterion.criterionDescription.text} : <i>${reco.optionOrNoteDescription.text}</i><br/>
												</c:forEach>
											</c:if>
										</div>
									</div>
									</c:if>
								</c:forEach>
							</div>
							<div id="paging">
								<c:if test="${!empty nbPages}">
									Page <c:forEach var="i" begin="1" end="${nbPages}">
										<a href="${baseUrl}${urlView}&finderType=date&page=${i}">${i}</a>
									</c:forEach>
								</c:if>
							</div>
							<a href="#" onclick="window.open('?action=displayFormReview&classId=${classId}&objectInstanceId=${objectInstanceId}&subClassId=${subClassId}&langueId=${langueId}','Preview','menubar=no, status=no, scrollbars=yes, menubar=no, width=820, height=600');"><img src="${contextPath}/resources/${codeIsoLang}/img/review/addReviewButton.JPG" /></a>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</tiles:putAttribute>
	
</tiles:insertDefinition>
