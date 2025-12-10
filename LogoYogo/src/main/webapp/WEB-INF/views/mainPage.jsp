<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 
<title>Insert title here</title>
 -->
</head>
<style type="text/css">
html, body {
  width: 100%;
  height: 100%;
  margin: 0;
}

#mainpage {
  padding-top: 60px;
  width: 100%;
  height: 100%;
  position: relative;
  overflow-x: hidden;
  overflow-y: auto;
}
</style>
<body>
	<div id="mainpage">
      <jsp:include page="/WEB-INF/views/components/navi.jsp" />
      <jsp:include page="/WEB-INF/views/components/section1.jsp" />
      <jsp:include page="/WEB-INF/views/components/section2.jsp" />
    </div>
</body>
</html>