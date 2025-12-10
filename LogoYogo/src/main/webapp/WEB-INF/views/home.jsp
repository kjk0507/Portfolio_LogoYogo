<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!
</h1>

<P>  The time on the server is ${serverTime}. </P>

<%= application.getMajorVersion() %>.<%= application.getMinorVersion() %>
<script>
    var ctx = "${pageContext.request.contextPath}";
    
    console.log("ctx :" +  ctx);
</script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/views/home.js"></script>
</body>

</html>

