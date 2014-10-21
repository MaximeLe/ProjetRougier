<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.pictime.com/tags/core" prefix="fwk" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
	<head>
		<title></title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		
		<!-- meta -->
		<!-- favicon -->
		<!-- common css -->
		<!-- common js -->

		<tiles:insertAttribute name="head" />		
	</head>
	<body>
		<div style="width: 100%;border: solid 1px red;">
			<tiles:insertAttribute name="header"/>
		</div>
		<div style="width: 25%;border: solid 1px red;float: left;height: 500px;">
			<tiles:insertAttribute name="leftNavigation"/>
		</div>
		<div style="width: 74%;border: solid 1px red;float: left;height: 500px;">
			<tiles:insertAttribute name="body"/>
		</div>
		<div style="width: 100%;border: solid 1px red;clear: both;">
			<fwk:cache key="ContentDisplay:storeId=${param.storeId}">
				<c:import url="/ContentDisplay.html?action=getPageContent&categoryId=5&langId=1"></c:import>
			</fwk:cache>
		</div>
	</body>
</html>