// --------------------------- 기본 설정 --------------------------- //
// tab 관련
var activeTab = null;
var tab = document.getElementById('editor-tab');
var tabBtn = document.querySelectorAll('#editor-tab-button .tab-btn');

var tabPalette = document.getElementById('editor-tab-palette');
var tabText = document.getElementById('editor-tab-text');
var tabShape = document.getElementById('editor-tab-shape');

tabBtn.forEach(btn => {
	btn.addEventListener('click', () => {
		var tabName = btn.dataset.tab;
		console.log("tabname : " + tabName);

		if (activeTab == tabName) {
			closeTab();
		} else {
			openTab(tabName);
		}
	});
});

// 모든 탭 숨기기
function hideAllTab(){
	tabPalette.classList.add('hidden');
	tabText.classList.add('hidden');
	tabShape.classList.add('hidden');	
}

// 탭 보여주기
function showSelectTab(tabName){
	hideAllTab();
	switch (tabName) {
  		case "btn-tap-palette":			
			tabPalette.classList.remove('hidden');
    		break;
		case "btn-tap-text":
			tabText.classList.remove('hidden');
			break;
		case "btn-tap-shape":
			tabShape.classList.remove('hidden');	
			break;
	}
}

function openTab(tabName) {
	if (activeTab == tabName) return;

	//tab.innerHTML = tabRenderers[tabName]();
	tab.classList.add('is-open');
	activeTab = tabName;
	showSelectTab(tabName);
}

function closeTab() {
	tab.classList.remove('is-open');

	tab.addEventListener('transitionend', function handler() {
		//tab.innerHTML = '';
		activeTab = null;
		tab.removeEventListener('transitionend', handler);
	});
}

// 캔버스 관련
var canvas = new fabric.Canvas('baseCanvas', {
	backgroundColor: '#f0f0f0'
});

canvas.setBackgroundColor('#a0d8f1', () => {
    canvas.renderAll();
});

// ---------------------------  에디터 팔레트 버튼 --------------------------- //

// ---------------------------  에디터 텍스트 버튼 --------------------------- //

// ---------------------------  에디터 도형 버튼 --------------------------- //
// 도형 로드
function getDiagramSvgs(){
	fetch(ctx + '/getDiagramSvgs')
	    .then(res => res.json())
	    .then(svgs => {
	        svgs.forEach((path, idx) => {
	            var btn = document.createElement('button');
	            btn.className = 'svg-btn';
	            btn.title = 'SVG ' + (idx + 1);
	
	            var img = document.createElement('img');
	            img.src = path;
	            btn.appendChild(img);
	
				var content = document.querySelector('.shape-container');
	            content.appendChild(btn);
	
	            btn.addEventListener('click', () => {
	                fabric.loadSVGFromURL(path, (objects, options) => {
	                    var obj = fabric.util.groupSVGElements(objects, options);
	
	                    obj.set({
	                        left: canvas.width / 2 - (obj.width * obj.scaleX) / 2,
	                        top: canvas.height / 2 - (obj.height * obj.scaleY) / 2,
	                        selectable: true
	                    });
	
	                    canvas.add(obj);
	                    canvas.setActiveObject(obj);
	                    canvas.renderAll();
	                });
	            });
	        });
	    });	
}

// 도형 설정
var activeShape = null;

canvas.on('selection:created', selectShape);
canvas.on('selection:updated', selectShape);
canvas.on('selection:cleared', clearSelectShape);

var shapeSizeSlider = document.getElementById('shape-size-slider');
var shapeSizeValue = document.getElementById('shape-size-value');

var picker = document.getElementById('shape-color-picker');

function selectShape(e) {
    activeShape = e.selected[0];
    updateSizeEditor(activeShape);
	updateColorEditor(activeShape);
}

function clearSelectShape() {
    activeShape = null;
}

// 에디터 도형 크기 수정 시 캔버스 도형 수정
shapeSizeSlider.addEventListener('input', () => {
    if (!activeShape) return;

    var targetDiagonal = Number(shapeSizeSlider.value);
    var currentDiagonal = getDiagonalLength(activeShape);

    var scaleRatio = targetDiagonal / currentDiagonal;

    activeShape.scaleX *= scaleRatio;
    activeShape.scaleY *= scaleRatio;

    shapeSizeValue.textContent = targetDiagonal;
    canvas.requestRenderAll();
});

// 캔버스 도형 크기 수정 시 에디터 수정
canvas.on('object:scaling', onObjectResize);
canvas.on('object:modified', onObjectResize);

function onObjectResize(e) {
    if (!activeShape) return;
    if (e.target !== activeShape) return;

    updateSizeEditor(activeShape);
}

function updateSizeEditor(obj) {
	var diagonal = getDiagonalLength(obj);
    shapeSizeSlider.value = diagonal;
    shapeSizeValue.textContent = diagonal;
}

// 대각선 계산
function getDiagonalLength(obj) {
    var w = obj.getScaledWidth();
    var h = obj.getScaledHeight();
    return Math.round(Math.sqrt(w * w + h * h));
}

// 에디터 도형 색상 수정
function updateColorEditor(obj) {
    var fill = obj.fill || '#000000';
    var hexColor = rgbToHex(fill);

    picker.value = hexColor;
}

picker.addEventListener('input', () => {
    if (!activeShape) return;

    activeShape.set('fill', picker.value);

    canvas.requestRenderAll();
});

function rgbToHex(color) {
    if (!color) return '#000000';
    if (color.startsWith('#')) return color;

    var rgb = color.match(/\d+/g);
    return '#' + rgb.map(x => {
        var hex = parseInt(x).toString(16);
        return hex.length === 1 ? '0' + hex : hex;
    }).join('');
}

// --------------------------- 초기 실행 --------------------------- //
// 초기 버튼 비활성화
closeTab();
hideAllTab();
getDiagramSvgs();
// 초기 버튼 활성화
if(!activeTab){
	var firstBtn = document.querySelector('#editor-tab-button .tab-btn')		
	
	if (firstBtn) {
		openTab(firstBtn.dataset.tab);
	}
}

