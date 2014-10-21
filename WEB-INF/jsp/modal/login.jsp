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
	<div class="login">
		<c:import url="../clientarea/importLoginForm.jsp"/>
	</div>
</div>
<script type="text/javascript" src="${contextPath}/resources/js/clientArea/ville.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/clientArea/login.js"></script>
<script type="text/javascript">initLogin();</script>