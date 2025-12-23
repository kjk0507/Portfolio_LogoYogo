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
#palette-container {
    display: flex;
    flex-direction: column;
    gap: 0.8rem;
    width: 100%
}
.palette-btn {
    display: flex;
    gap: 0.4rem;
    padding: 0.4rem;
    border-radius: 0.6rem;
    cursor: pointer;

    background: #fff;
    border: 1px solid #ddd;

    transition:
        transform 0.1s ease,
        box-shadow 0.1s ease,
        background 0.1s ease;
}
.palette-btn:hover {
    background: #f0f2f7;
    box-shadow: inset 0 0 0 1px #ccc;
}
.palette-btn:active {
    transform: scale(0.97);
    box-shadow: inset 0 2px 4px rgba(0,0,0,0.15);
}
.palette-color {
    width: 28px;
    height: 28px;
    border-radius: 0.4rem;
    border: 1px solid rgba(0,0,0,0.1);
    pointer-events: none;
    flex: auto;
}
.palette-btn.is-active {
    outline: 2px solid #4a6cf7;
    background: #eef2ff;
}
#text-input-box,
#add-text-btn,
#text-font-box {
	width: 100%;
	height: 3rem;
	border-radius: 0.4rem;
    cursor: pointer;
    border: 1px solid #ccc;
}
#text-input-box{
	margin-bottom: 1rem;
	cursor: text; 
	padding-left: 0.8rem; 
	font-weight:500;
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

    background: #ffffff;
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
#text-input-container{
	display: flex;
	flex-direction: column;
	width: 100%;
}
#text-font-container{
	display: flex;
	flex-direction: column;
	width: 100%;
}
#text-font-select{
	width: 100%;
    height: 3rem;
    border-radius: 0.4rem;
    border: 1px solid #ccc;
    font-weight: 500;
    padding-left: 0.5rem;
}
#shape-size-container,
#text-weight-container,
#text-size-container {
	display: flex;
	width: 100%
}
#shape-size-container input[type="range"],
#text-weight-container input[type="range"],
#text-size-container input[type="range"] {
    flex: 1;
}
#shape-size-value,
#text-weight-value,
#text-size-value {
    width: 6rem;
    margin-left: 10px;
}
#text-aline-container button {
	width: 36px;
	height: 36px;
	background: white;
	border-radius: 0.4rem;
	cursor: pointer;
	border: 1px solid #ccc;
	margin-right: 1rem;
}

#shape-color-picker,
#text-color-picker {
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
				<div class="tab-content">
					<div class="tab-content-title">텍스트 상자</div>								
					<div class="tab-content-description">
						<div id="palette-container"></div>
					</div>
				</div>
			</div>
			<div id="editor-tab-text">
				<div class="tab-header">
					<div class="tab-title">텍스트</div>
					<div class="tab-description">원하는 텍스트를 입력하세요<br>글꼴, 크기, 색상 등을 변경할 수 있습니다.</div>
				</div>
				<div class="tab-content">
					<div class="tab-content-title">텍스트 상자</div>								
					<div class="tab-content-description">
						<div id="text-input-container">
							<input id="text-input-box" type="text" placeholder="내용을 입력하세요."/>
							<div id="add-text-btn"></div>
						</div>
					</div>
				</div>
				<div class="tab-content">
					<div class="tab-content-title">글꼴</div>			
					<div class="tab-content-description">
						<div id="text-font-container">
							<select id="text-font-select">
					            <option value="NanumGothic" style="font-family: NanumGothic; font-weight: 500;">나눔 고딕</option>
					            <option value="NanumMyeongjo" style="font-family: NanumMyeongjo; font-weight: 500;">나눔 명조</option>
					            <option value="NanumPen" style="font-family: NanumPen; font-weight: 500;">나눔 펜</option>
					        </select>
						</div>
					</div>
				</div>
				<div class="tab-content">
					<div class="tab-content-title">굵기</div>			
					<div class="tab-content-description">
						<div id="text-weight-container">
							<input id="text-weight-slider" type="range" min="1" max="1000" value="10"/>
							<span id="text-weight-value">10</span>
						</div>
					</div>
				</div>
				<div class="tab-content">
					<div class="tab-content-title">크기</div>			
					<div class="tab-content-description">
						<div id="text-size-container">
							<input id="text-size-slider" type="range" min="1" max="1000" value="10"/>
							<span id="text-size-value">10</span>
						</div>
					</div>
				</div>
				<div class="tab-content">
					<div class="tab-content-title">정렬</div>	
					<div class="tab-content-description">
						<div id="text-aline-container">
							<button id="text-aline-left"></button>
							<button id="text-aline-center"></button>
							<button id="text-aline-right"></button>
						</div>
					</div>
				</div>
				<div class="tab-content">
					<div class="tab-content-title">색상</div>			
					<div class="tab-content-description">
						<div id="text-color-container">						
							<input type="color" id="text-color-picker" value="black"/>
						</div>
					</div>
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
							<input id="shape-size-slider" type="range" min="1" max="1000" value="10"/>
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
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/views/components/editor.js" defer></script>