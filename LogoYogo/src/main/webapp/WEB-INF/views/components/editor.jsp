<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
#editor {
  display: flex;
  flex-direction: column;
  height: 100%;
}
#editor-header{
	height: 4.5rem;
	flex-shrink: 0;
	border-bottom: #dee0e6 1.5px solid;
}
#editor-content {
	display: flex;
	flex: 1;
	background: #eef0f6;
}
#editor-canvas{
	flex: 1;
	background: #eef0f6;
	overflow: auto;
	display: flex;
    justify-content: center;
    align-items: center;
}
#editor-tab{
	width: 28rem;
	background: #eef0f6;
	z-index: 10;
	transform: translateX(100%);
	transition: transform 0.3s ease;
	display: flex;
	flex-direction: column; 
    padding: 2.5rem;
    padding-top: 2rem;
    overflow-y: auto;
    overflow-x: hidden;
    background: white;
    border-left: #dee0e6 1.5px solid;
}
#editor-tab.is-open {
	transform: translateX(0%);
}
.tab-header{
	display: flex;
	width: 100%;
	flex-direction: column;
	align-items: center;
	padding-bottom: 1rem;
	border-bottom: #dee0e6 1.5px solid;
}
.tab-title{
	display: flex;
	width: 100%;
	min-height: 3rem;	
	font-size: 1.8rem;
	font-weight: 500;
}
.tab-description{
	display: flex;
	width: 100%;
	min-height: 5rem;	
	font-size: 1.4rem;
}
.tab-content{
	display: flex;
	width: 100%;
	height: auto;
	padding-top: 1rem;
    padding-bottom: 2rem;
    flex-direction: column;
    border-bottom: #dee0e6 1.5px solid;
}
.tab-content-title{
	display: flex;
	width: 100%;
	min-height: 1rem;
	font-size: 1.4rem;
	padding-top: 0.5rem;
	padding-bottom: 1rem;
	font-weight: 500;
}
.tab-content-description{
	display: flex;
	width: 100%;
	padding-bottom: 0.5rem;	
}
.shape-container {
    display: flex;
    flex-wrap: wrap;
    gap: 0.8rem;
    padding: 0.8rem;

    height: 21rem;
    overflow-y: auto;

    background: #eef0f6;
    border-radius: 0.6rem;
    align-items: flex-start;
}
.svg-btn {
    width: calc((100% - 1.6rem) / 3);
    aspect-ratio: 1 / 1;

    background: #fff;
    border-radius: 0.4rem;
    border: 1px solid #ddd;

    display: flex;
    align-items: center;
    justify-content: center;

    cursor: pointer;
    transition: background 0.2s, transform 0.1s;
}
.svg-btn:hover {
    background: #e3e6ee;
    transform: scale(1.05);
}
.svg-btn img {
    width: 70%;
    height: 70%;
    object-fit: contain;
}
#shape-size-container{
	display: flex;
	width: 100%
}
#shape-size-container input[type="range"] {
    flex: 1;
}
#shape-size-value {
    width: 6rem;
    margin-left: 10px;
}
#shape-color-picker{
	width: 36px;
	height: 36px;
	background: white;
	border-radius: 0.4rem;
	cursor: pointer;
	border: 1px solid #ccc;
}
#editor-tab-button{
	width: 8rem;
	display: flex;
    flex-direction: column; 
    align-items: center;
    background: white;;
    z-index: 20;
    border-left: #dee0e6 1.5px solid;
}
.tab-btn {
    width: 100%;
    height: 9rem;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    cursor: pointer;
    border-bottom: #dee0e6 1.5px solid;
}
.hidden{
	display: none;
}

</style>

<div id="editor">
	<div id = "editor-header"></div>
	<div id = "editor-content">
		<div id="editor-canvas">
			<canvas id="baseCanvas" width="700" height="600"></canvas>
		</div>
		<div id="editor-tab">
			<div id="editor-tab-palette">
				<div class="tab-header">
					<div class="tab-title">색상 팔레트</div>
					<div class="tab-description">모든 도형과 텍스트의 색상을 변경합니다.</div>
				</div>		
				<div class="tab-content">버튼 1 - 내용 A</div>
			</div>
			<div id="editor-tab-text">
				<div class="tab-header">
					<div class="tab-title">텍스트</div>
					<div class="tab-description">원하는 텍스트를 입력하세요<br>글꼴, 크기, 색상 등을 변경할 수 있습니다.</div>
				</div>
				<div class="tab-content">
					<div class="tab-content-title">텍스트 상자</div>			
					<div class="tab-content-description">내용</div>
				</div>
				<div class="tab-content">
					<div class="tab-content-title">글꼴</div>			
					<div class="tab-content-description">내용</div>
				</div>
				<div class="tab-content">
					<div class="tab-content-title">굵기</div>			
					<div class="tab-content-description">내용</div>
				</div>
				<div class="tab-content">
					<div class="tab-content-title">크기</div>			
					<div class="tab-content-description">내용</div>
				</div>
				<div class="tab-content">
					<div class="tab-content-title">정렬</div>			
					<div class="tab-content-description">내용</div>
				</div>
				<div class="tab-content">
					<div class="tab-content-title">색상</div>			
					<div class="tab-content-description">내용</div>
				</div>
			</div>
			<div id="editor-tab-shape">
				<div class="tab-header">
					<div class="tab-title">도형</div>
					<div class="tab-description">원하는 도형을 선택하세요.<br>크기와 색상을 변경할 수 있습니다.</div>
				</div>
				<div class="tab-content">
					<div class="tab-content-title">모양</div>			
					<div class="tab-content-description">
						<div class="shape-container"></div>
					</div>
				</div>
				<div class="tab-content">
					<div class="tab-content-title">크기</div>			
					<div class="tab-content-description">
						<div id="shape-size-container">
							<input id="shape-size-slider" type="range" min="1" max="800" value="10"/>
							<span id="shape-size-value">10</span>
						</div>
					</div>
				</div>
				<div class="tab-content">
					<div class="tab-content-title">색상</div>			
					<div class="tab-content-description">
						<div id="shape-color-container">						
							<input type="color" id="shape-color-picker" value="black"/>
						</div>
					</div>
				</div>
			</div>		
		</div>
		<div id="editor-tab-button">
			<div class="tab-btn" data-tab="btn-tap-palette">팔레트</div>
		    <div class="tab-btn" data-tab="btn-tap-text">텍스트</div>
		    <div class="tab-btn" data-tab="btn-tap-shape">도형</div>
		</div>
	</div>
</div>
<script src="${pageContext.request.contextPath}/resources/js/views/components/editor.js" defer></script>