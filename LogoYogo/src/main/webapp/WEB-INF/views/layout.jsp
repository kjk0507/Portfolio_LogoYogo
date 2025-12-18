<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
<meta charset="UTF-8">
<title>LoGoYoGo</title>

<style>
html, body {
	height: 100%;
	margin: 0;
	font-size: 10px;
}

body {
    display: flex;
    flex-direction: column;
}

:root {
	--navi-height: 6rem;
}

#content {
	flex: 1;
    overflow: auto;	
	scroll-snap-type: y mandatory;	
	scrollbar-width: none;
	-ms-overflow-style: none;
}

#content::-webkit-scrollbar {
	display: none;
}

.section_page {
	height: 100vh;
	scroll-snap-align: start;  
	position: relative;
	overflow: hidden;
}

</style>
</head>

<body>
	<jsp:include page="/WEB-INF/views/components/navi.jsp" />

	<div id="content">
		<jsp:include page="${contentPage}" />
	</div>
	<script>
	    var ctx = "${pageContext.request.contextPath}";
	</script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/fabric.js/5.3.0/fabric.min.js" defer></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>		
</body>
</html>