<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style type="text/css">
#navi {
	flex-shrink: 0; 
	height: 6rem;
	background: #4665d9;
	color: white;
	z-index: 1000;  
}

#title {
	margin-left: 2rem;
	font-size: 2.4rem;
	display: flex;
	align-items: center;
	/*font-weight: bold;*/
}
</style>

<div id="navi">
	<span id="title" style="">Logoyogo
	<a href="#" data-url="/mainPage.do" class="nav-link">메인</a>
	<a href="#" data-url="/section1.do" class="nav-link">Section1</a>
	<a href="#" data-url="/section2.do" class="nav-link">Section2</a>
	<a href="#" data-url="/editor.do" class="nav-link">editor</a>
	</span>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/views/components/navi.js"></script>