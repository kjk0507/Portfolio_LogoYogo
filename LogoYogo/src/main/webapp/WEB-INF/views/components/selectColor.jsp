<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style type="text/css">
#selectColor-header {
	background: #eef0f6;
	height: 18rem;
}
#selectColor-title {
	font-size: 3rem;	
	font-weight: 500;
	text-align: center;
	padding-top: 3rem;
}
#selectColor-description {
	font-size: 2rem;
	text-align: center;
	padding-top: 2rem;
}
#selectColor-content {
	display: flex;
    background: #eef0f6;
    
    height: calc(100vh - 30rem);
    overflow-y: auto;
}
#selectColor-container {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: 3rem;

    width: 100%;
    height: 88%;
    overflow-y: auto;
    
    padding-left: 20rem;
    padding-right: 20rem;
}
#selectColor-container::-webkit-scrollbar {
	display: none;
}
.selectColor-item-color {
	display: flex;
	flex-direction: column;
	height: 100%;
}
.item-color-inner {
	width: 100%;
	cursor: pointer;
	box-sizing: border-box;
	transition: box-shadow 0.15s ease;
	flex: 1;
}
.item-color-inner:hover {
    border: 2px solid #333;
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
<div id="selectColor-header">
	<div id="selectColor-title">색상을 선택하세요</div>
	<div id="selectColor-description">로고의 글자와 도형 색상을 선택합니다. 선택한 색상은 에디터에서 수정할 수 있습니다.</div>
</div>
<div id="selectColor-content">
	<div id="selectColor-container">
		<div class="selectColor-item-color">
			 <div class="item-color-inner" style="background: rgb(255, 130, 130);"></div>
			 <div class="item-color-inner" style="background: rgb(255, 110, 110);"></div>
			 <div class="item-color-inner" style="background: rgb(255, 90, 90);"></div>
			 <div class="item-color-inner" style="background: rgb(255, 70, 70);"></div>
			 <div class="item-color-inner" style="background: rgb(255, 0, 0);"></div>
		</div>
		<div class="selectColor-item-color">
			 <div class="item-color-inner" style="background: rgb(255, 195, 65);"></div>
			 <div class="item-color-inner" style="background: rgb(255, 185, 55);"></div>
			 <div class="item-color-inner" style="background: rgb(255, 170, 40);"></div>
			 <div class="item-color-inner" style="background: rgb(255, 150, 20);"></div>
			 <div class="item-color-inner" style="background: rgb(255, 130, 0);"></div>
		</div>
		<div class="selectColor-item-color">
			 <div class="item-color-inner" style="background: rgb(255, 254, 171);"></div>
			 <div class="item-color-inner" style="background: rgb(255, 254, 145);"></div>
			 <div class="item-color-inner" style="background: rgb(255, 253, 100);"></div>
			 <div class="item-color-inner" style="background: rgb(255, 230, 80);"></div>
			 <div class="item-color-inner" style="background: rgb(255, 220, 60);"></div>
		</div>
		<div class="selectColor-item-color">
			 <div class="item-color-inner" style="background: rgb(125, 244, 178);"></div>
			 <div class="item-color-inner" style="background: rgb(115, 234, 168);"></div>
			 <div class="item-color-inner" style="background: rgb(100, 219, 153);"></div>
			 <div class="item-color-inner" style="background: rgb(80, 199, 133);"></div>
			 <div class="item-color-inner" style="background: rgb(60, 179, 113);"></div>
		</div>
		<div class="selectColor-item-color">
			 <div class="item-color-inner" style="background: rgb(80, 200, 255);"></div>
			 <div class="item-color-inner" style="background: rgb(60, 180, 255);"></div>
			 <div class="item-color-inner" style="background: rgb(40, 160, 255);"></div>
			 <div class="item-color-inner" style="background: rgb(20, 140, 255);"></div>
			 <div class="item-color-inner" style="background: rgb(0, 120, 255);"></div>
		</div>
		<div class="selectColor-item-color">
			 <div class="item-color-inner" style="background: rgb(208, 80, 208);"></div>
			 <div class="item-color-inner" style="background: rgb(188, 60, 188);"></div>
			 <div class="item-color-inner" style="background: rgb(168, 40, 168);"></div>
			 <div class="item-color-inner" style="background: rgb(148, 20, 148);"></div>
			 <div class="item-color-inner" style="background: rgb(128, 0, 128);"></div>
		</div>
		<div class="selectColor-item-color">
			 <div class="item-color-inner" style="background: rgb(255, 157, 255);"></div>
			 <div class="item-color-inner" style="background: rgb(248, 142, 244);"></div>
			 <div class="item-color-inner" style="background: rgb(238, 132, 234);"></div>
			 <div class="item-color-inner" style="background: rgb(228, 122, 224);"></div>
			 <div class="item-color-inner" style="background: rgb(218, 112, 214);"></div>
		</div>
	</div>
</div>
<div id="select-footer">
	<div id="passEditor">빈 캔버스에서 직접 로고 만들기</div>
</div>

<script src="${pageContext.request.contextPath}/resources/js/views/components/selectColor.js"></script>