<%@ page trimDirectiveWhitespaces="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@page import="com.pictime.fwk.web.schema.RubriqueType"%>

<tiles:insertDefinition name="mobile-template">
	
	<tiles:putAttribute name="title"><spring:message code="sitemap.title"/></tiles:putAttribute>
	<tiles:putAttribute name="description"><spring:message code="sitemap.description"/></tiles:putAttribute>
	
	<tiles:putAttribute name="canonical" type="string">
		http://${pageContext['request'].serverName}${requestScope['javax.servlet.forward.servlet_path']}
	</tiles:putAttribute>
	
	<tiles:putAttribute name="head">
		<style type="text/css">
			#fenetre_centre ul, #fenetre_centre li {
				padding-left: 10px;
			}
			h2 a {
				color: inherit;
				text-decoration : none;
			}
			h2 a:hover {
				text-decoration : underline;
			}
			#fenetre_centre {
				min-height:500px;
			}
		</style>
	</tiles:putAttribute>
	

	<tiles:putAttribute name="content">
	<div id="content" class="panier">
		<!-- Début du content -->
		<div class="contentStart"></div>
		
		<!-- Contenu -->
		<div id="contenu">
				<div id="plan_du_site">
			<div class="clear hidden">
				<!-- Partie gauche -->
				<div class="floatLeft">
					<div class="cadregris grand">

						<div class="ligne">
				     		<h1>Plan du site</h1>
				       		<ul id="liste_univers_1" style="">
				       		<c:forEach items="${html.sitemapPublication.publication}" var="publication">
								<li>
									<h2><a href="${publication.href}">${publication.titre}</a></h2>
						       		<ul>
						       		<c:forEach items="${publication.rubrique}" var="rubrique">
										<li class="rubrique">
											<a class="lien_footer" href="${rubrique.href}">${rubrique.titre}</a>
								       		<ul>
								       		<c:forEach items="${rubrique.rubrique}" var="rubriqueNiv2">
												<li class="rubrique">
													<a class="lien_footer" href="${rubriqueNiv2.href}">${rubriqueNiv2.titre}</a>
										       		<ul>
										       		<c:forEach items="${rubriqueNiv2.rubrique}" var="rubriqueNiv3">
														<li class="rubrique">
															<a class="lien_footer" href="${rubriqueNiv3.href}">${rubriqueNiv3.titre}</a>
												       		<ul>
												       		<c:forEach items="${rubriqueNiv3.rubrique}" var="rubriqueNiv4">
																<li class="rubrique">
																	<a class="lien_footer" href="${rubriqueNiv4.href}">${rubriqueNiv4.titre}</a>
														       		<ul>
														       		<c:forEach items="${rubriqueNiv4.rubrique}" var="rubriqueNiv5">
																		<li class="rubrique">
																			<a class="lien_footer" href="${rubriqueNiv5.href}">${rubriqueNiv5.titre}</a>
																			<ul>
																       		<c:forEach items="${rubriqueNiv5.article}" var="article">
																				<li class="article">
																					<a class="lien_footer" href="${article.href}">${article.titre}</a>
																				</li>
																			</c:forEach>
																			</ul>
																		</li>
																	</c:forEach>
																	</ul><ul>
														       		<c:forEach items="${rubriqueNiv4.article}" var="article">
																		<li class="article">
																			<a class="lien_footer" href="${article.href}">${article.titre}</a>
																		</li>
																	</c:forEach>
																	</ul>
																</li>
															</c:forEach>
															</ul><ul>
												       		<c:forEach items="${rubriqueNiv3.article}" var="article">
																<li class="article">
																	<a class="lien_footer" href="${article.href}">${article.titre}</a>
																</li>
															</c:forEach>
															</ul>
														</li>
													</c:forEach>
													</ul><ul>
										       		<c:forEach items="${rubriqueNiv2.article}" var="article">
														<li class="article">
															<a class="lien_footer" href="${article.href}">${article.titre}</a>
														</li>
													</c:forEach>
													</ul>
												</li>
											</c:forEach>
											</ul><ul>
								       		<c:forEach items="${rubrique.article}" var="article">
												<li class="article">
													<a class="lien_footer" href="${article.href}">${article.titre}</a>
												</li>
											</c:forEach>
											</ul>
										</li>
									</c:forEach>
									</ul>
								</li>
							</c:forEach>
							</ul>
				       		<ul id="liste_univers_2" >
				       		<c:forEach items="${html.sitemapCatalog.catalog}" var="catalog">
								<li>
									<h2>${catalog.titre}</h2>
						       		<ul>
						       		<c:forEach items="${catalog.categorie}" var="categorie">
										<li class="second">
											<a class="lien_footer" href="${categorie.href}">${categorie.titre}</a>
								       		<ul>
								       		<c:forEach items="${categorie.categorie}" var="categorieNiv2">
												<li>
													<a class="lien_footer" href="${categorieNiv2.href}">${categorieNiv2.titre}</a>
												</li>
											</c:forEach>
											</ul>
										</li>
									</c:forEach>
									</ul>
								</li>
							</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
			</div>
		</div>
	</div>
	</tiles:putAttribute>
	
</tiles:insertDefinition>