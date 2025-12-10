<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>

<style type="text/css">
#navi {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 6rem;
  background: #4665d9;
  color: white;
  z-index: 1000;
  display: flex;
  align-items: center;
}

#title {
  margin-left: 2rem;
  font-size: 2.4rem;
  /*font-weight: bold;*/
}
</style>

<body>

<div id="navi">
	<span id="title" style="">Logoyogo</span>
</div>

</body>

<script src="${pageContext.request.contextPath}/resources/js/views/components/navi.js"></script>
</html>