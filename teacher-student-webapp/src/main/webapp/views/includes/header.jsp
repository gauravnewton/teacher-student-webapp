<%@ page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<meta charset="utf-8">
	  	<meta name="viewport" content="width=device-width, initial-scale=1">
		<% String pageTitle = (String) request.getAttribute("pageTitle"); %>
		<title><%= pageTitle %></title>
		<link rel="icon" href="<c:url value="/assets/images/favicon.jpg" />" type="image/x-icon"/>
		<link rel="stylesheet" href="<c:url value="/assets/bootstrap/css/bootstrap.min.css" />" />
		<link rel="stylesheet" href="<c:url value="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />" />
		<link rel="stylesheet" href="<c:url value="/assets/main.css" />" />
		<link rel="stylesheet" href="<c:url value="/assets/HoldOn/css/HoldOn.css" />" />
		<link rel="stylesheet" href="<c:url value="/assets/confirm/css/confirm.css" />" />
		<link rel="stylesheet" href="<c:url value="/assets/notify/css/notify.css" />" />
		<link rel="stylesheet" href="<c:url value="/assets/dataTable/css/dataTable.bootstrap.css" />" />
		<link rel="stylesheet" href="<c:url value="/assets/dataTable/css/responsive.bootstrap.min.css" />" />
		
	</head>
	<body>
	