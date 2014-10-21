<%@ page trimDirectiveWhitespaces="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.pictime.com/tags/core"   prefix="fwk"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div id="modal">
	<div class="btn_close"></div>
	<form id="form_avis" name="formReview">
		<input type="hidden" name="objectInstanceId" value="${objectInstanceId}" />
		<input type="hidden" name="classId" value="${classId}" />
		<input type="hidden" name="subClassId" value="${subClassId}" />
		<input type="hidden" name="langueId" value="${langueId}" />
		<input type="hidden" name="generalCommentCriterionId" value="${generalCommentCriterion.id}" />
		
		<input type="hidden" name="ceId" value="${objectInstanceId}" />
		<input type="hidden" name="langId" value="${langueId}" />
		
		<div class="content review">
			<div class="titre">Donnez votre avis sur ce produit</div>
			<!-- Obsolete : <input type="text" name="title" id="titre" /> -->
			<label for="pseudo">Votre Pseudo :</label><input type="text" name="pseudonym" id="pseudo" value="${nom}"/>
			<div class="clear"></div>
			<label for="email">Votre e-mail * :</label><input type="text" name="email" id="email" value="${email}"/> 
			<div class="clear"></div>
			<p class="infomail">* <spring:message code="review.messageSecuriteEmail"/></p>
			<label for="note">Votre note :</label>
			<ul class="note">
				<c:forEach items="${generalRatingCriterions.optionOrNotes}" var="grc">
					<li>${grc.id};${grc.optionOrNoteDescription.text}</li>
				</c:forEach>
			</ul>
			<div class="noteTxt">(<span>0</span>/5)</div>
			<input type="hidden" name="generalRating" id="note" value="null"/>
				
			<label class="grand" for="commentaire">Votre commentaire :</label>
			<textarea name="comment" id="commentaire" cols="30" rows="5"></textarea>
				
			<c:forEach items="${recoCriterions}" var="recoCriterion">
			<label class="grand">${recoCriterion.criterionDescription.text}<input type="hidden" name="recoCriterions" value="${recoCriterion.id}" /> :</label>
			<div class="clear"></div>		
			<c:forEach items="${recoCriterion.optionOrNotes}" var="optionOrNote">
				<c:if test="${!empty optionOrNote.optionOrNoteDescription.text}">
					<input type="checkbox" name="recommendation" value="${optionOrNote.id}" id="recommendation_${recoCriterion.id}_${optionOrNote.id}"/>
					<label class="check" for="recommendation_${recoCriterion.id}_${optionOrNote.id}">${optionOrNote.optionOrNoteDescription.text}</label>
				</c:if>
			</c:forEach>
					
			</c:forEach>
			<input type="image" src="${contextPath}/resources/${codeIsoLang}/img/common/btn_valider.png" name="submit" class="clear floatRight" value="Valider" id="input"/>
			<div class="messageRetour clear floatRight"></div>
		</div>
	</form>
</div>
