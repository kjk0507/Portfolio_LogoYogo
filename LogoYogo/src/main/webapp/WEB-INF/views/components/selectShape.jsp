<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style type="text/css">
#selectShape-header {
	background: #eef0f6;
	height: 18rem;
}
#selectShape-title {
	font-size: 3rem;	
	font-weight: 500;
	text-align: center;
	padding-top: 3rem;
}
#selectSahpe-description {
	font-size: 2rem;
	text-align: center;
	padding-top: 2rem;
}
#selectShape-content {
	display: flex;
    background: #eef0f6;
    
    height: calc(100vh - 30rem);
    overflow-y: auto;
}
#selectShape-container {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: 3rem;

    width: 100%;
    height: 88%;
    overflow-y: auto;
    
    padding-left: 20rem;
    padding-right: 20rem;
}
#selectShape-container::-webkit-scrollbar {
	display: none;
}
.svg-select-btn {
    width: auto;
    max-width: 20rem;
    aspect-ratio: 1 / 1;

    background: #ffffff;
    border-radius: 0.4rem;
    border: 1px solid #ddd;

    display: flex;
    align-items: center;
    justify-content: center;

    cursor: pointer;
    transition: background 0.2s, transform 0.1s;
}
.svg-select-btn:hover {
    background: #e3e6ee;
    transform: scale(1.05);
}
.svg-select-btn img {
    width: 70%;
    height: 70%;
    object-fit: contain;
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
<div id="selectShape-header">
	<div id="selectShape-title">도형을 선택하세요</div>
	<div id="selectSahpe-description">로고에 사용할 도형을 선택합니다. 선택한 도형은 에디터에서 수정할 수 있습니다.</div>
</div>
<div id="selectShape-content">
	<div id="selectShape-container"></div>
</div>
<div id="select-footer">
	<div id="passEditor">빈 캔버스에서 직접 로고 만들기</div>
</div>

<script src="${pageContext.request.contextPath}/resources/js/views/components/selectShape.js"></script>