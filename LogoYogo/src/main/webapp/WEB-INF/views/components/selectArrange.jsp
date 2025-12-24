<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style type="text/css">
#selectArrange-header {
	background: #eef0f6;
	height: 18rem;
}
#selectArrange-title {
	font-size: 3rem;	
	font-weight: 500;
	text-align: center;
	padding-top: 3rem;
}
#selectArrange-description {
	font-size: 2rem;
	text-align: center;
	padding-top: 2rem;
}
#selectArrange-content {
	display: flex;
    background: #eef0f6;
    
    height: calc(100vh - 30rem);
    overflow-y: auto;
}
#selectArrange-container {
    display: flex;
    gap: 3rem;

    width: 100%;
    height: 88%;
    overflow-y: auto;
    
    padding-left: 20rem;
    padding-right: 20rem;
}
#selectArrange-container::-webkit-scrollbar {
	display: none;
}
.selectArrange-pos {
	width: auto;
	cursor: pointer;
	flex:1;
}
.selectArrange-pos img {
    width: 100%;
    object-fit: contain;
   	border: 1px solid #ccc;
}
#select-footer {
    position: fixed;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 10rem;
    
    background: #ffffff;
    border-top: 1px solid #ddd;

    display: flex;
    justify-content: center;
    align-items: center;

    z-index: 100;
}
#passEditor {
	width: 20%;
	height: 50%;
    background: rgb(161, 118, 255);;
    border-radius: 0.4rem;
	cursor: pointer;
	border: 1px solid #ccc;
	
	display: flex;
    justify-content: center;
    align-items: center;
    
    font-size: 2rem;
    color: white;
}
#passEditor:hover {
    background: rgb(141, 98, 235);
    box-shadow: 0 4px 10px rgba(0,0,0,0.15);
}
</style>
<div id="selectArrange-header">
	<div id="selectArrange-title">배치를 선택하세요</div>
	<div id="selectArrange-description">로고의 텍스트와 도형를 어떻게 배치할지 선택합니다. 선택한 위치는 에디터에서 수정할 수 있습니다.</div>
</div>
<div id="selectArrange-content">
	<div id="selectArrange-container">
		<div class="selectArrange-pos" data-pos="pos0">
			<img src="resources/images/position/pos0.png"/>
		</div>
		<div class="selectArrange-pos" data-pos="pos1">
			<img src="resources/images/position/pos1.png"/>
		</div>
		<div class="selectArrange-pos" data-pos="pos2">
			<img src="resources/images/position/pos2.png"/>
		</div>
	</div>
</div>
<div id="select-footer">
	<div id="passEditor">빈 캔버스에서 직접 로고 만들기</div>
</div>

<script src="${pageContext.request.contextPath}/resources/js/views/components/selectArrange.js"></script>