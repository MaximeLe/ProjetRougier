<%@ page trimDirectiveWhitespaces="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
	<head>
		<title>${productName}</title>
		
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		
		<meta name="description" content="" />
		<link rel="canonical" href="http://${pageContext['request'].serverName}${requestScope['javax.servlet.forward.servlet_path']}" />
		<link rel="shortcut icon" type="images/x-icon" href="" />
		<link href="${contextPath}/resources/${codeIsoLang}/css/StarterStore.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/${codeIsoLang}/css/StarterStore_.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var contextPath = '${contextPath}';
			var codeIsoLang = '${codeIsoLang}';
		</script>
		<script src="${contextPath}/resources/js/jquery/jquery.i18n.js" type="text/javascript"></script>
		<script src="${contextPath}/resources/js/dictionary/dictionary_${codeIsoLang}.js" type="text/javascript"></script>
		<script src="${contextPath}/resources/js/common/header.js" type="text/javascript"></script>
		<style type="text/css">
			.blockTab {
				background-color:#FFFFFF;
				
				clear:both;
				margin:10px 15px;
				width: 790px;
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
	</head>


<body onunload="window.opener.location.reload()" id="avis_body">

	<div id="fenetre_haut2">
		<div id="chemin">
			<span id="chemin_categories">
				<a href="/" class="lien_chemin">Accueil</a>
			</span>
		</div>
	</div>	
	
	<div id="avis_bande">
		<p class="gauche"><h1>${review.title}</h1></p>
		<a href="#" onclick="window.close();window.opener.location.reload()" class="droite"><img src="${contextPath}/resources/${codeIsoLang}/img/StarterStore/Avis_fermer.png" alt="Fermer" title="Fermer" /></a>
	</div>
		
	<div>
		
		

		<div class="blockTab">
			<div class="barTab">
				<ul>
					<li><span>${review.title}</span></li>
				</ul>
			</div>
			<!-- ********************************************************************** -->
			<div id="additionalInformation">
				<div id="review">
					<div class="ligne2">
						<div class="avis_auteur">
							Commentaire de :<br /><span class="gras">${review.pseudonym}</span> (${review.email})<br />
							<c:if test="${!empty review.generalRating.value}">
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
							<c:if test="${!empty review.ratingAndCommentCouple}">
								<div class="avis_separation">
									<c:forEach items="${review.ratingAndCommentCouple}" var="r">
										<p class="gauche2"><strong>${r.criterion.criterionDescription.text}</strong> :
											<c:if test="${!r.criterion.recoUsage && !empty r.rating.value}">
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
							<c:if test="${!empty review.recommendations}">
								<span class="gras">Recommandations :</span><br />
								<c:forEach items="${review.recommendations}" var="reco">
									${reco.criterion.criterionDescription.text} : <i>${reco.optionOrNoteDescription.text}</i><br/>
								</c:forEach>
							</c:if>
						</div>
					</div>
				</div>
				<div id="paging">
					<c:if test="${!empty nbPages}">
						Page <c:forEach var="i" begin="1" end="${nbPages}">
							<a href="?action=displayReviews&classId=${classId}&objectInstanceId=${objectInstanceId}&subClassId=${subClassId}&langueId=${langueId}&finderType=date&page=${i}">${i}</a>
						</c:forEach>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

