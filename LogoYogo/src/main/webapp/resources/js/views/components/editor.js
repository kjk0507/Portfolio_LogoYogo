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

// --------------------------- 팔레트 색상 --------------------------- //
var colorPalettes = [
	["#EEEBDD", "#ce1212", "#810000", "#1b1717"],
	["#f8ede3", "#bdd2b6", "#a2b29f", "#798777"],
	["#f7f3e9", "#a3d2ca", "#5eaaa8", "#f05945"],
	["#5f939a", "#d8ac9c", "#eac8af", "#1b2021"],
	["#f3f4ed", "#536162", "#424642", "#c06014"],
	["#2b2e4a", "#e84545", "#903749", "#53354a"],
	["#9e9d89", "#e4d3cf", "#e2bcb7", "#b67162"],
	["#f39189", "#bb8082", "#6e7582", "#046582"],
	/*
	["#f0e4d7", "#f5c0c0", "#ff7171", "#9fd8df"],
	["#440a67", "#93329e", "#b4aee8", "#ffe3fe"],
	["#e4fbff", "#b8b5ff", "#7868e6", "#edeef7"],
	["#ffab73", "#ffd384", "#fff9b0", "#ffaec0"],
	["#e40017", "#f4c983", "#5b6d5b", "#484018"],
	["#ffcb91", "#ffefa1", "#94ebcd", "#6ddccf"],
	["#f4f9f9", "#ccf2f4", "#a4ebf3", "#aaaaaa"],
	["#f4f9f9", "#f1d1d0", "#fbaccc", "#f875aa"],
	["#ff9292", "#ffb4b4", "#ffdcdc", "#ffe8e8"],
	["#fcd1d1", "#ece2e1", "#d3e0dc", "#aee1e1"],
	["#f6f6f6", "#c7ffd8", "#98ded9", "#161d6f"],
	["#493323", "#91684a", "#eaac7f", "#ffdf91"],
	["#62959c", "#c19277", "#e1bc91", "#e3d0b9"],
	["#a6f0c6", "#a98b98", "#4e3d53", "#0f1123"],
	["#ec4646", "#663f3f", "#51c2d5", "#bbf1fa"],
	["#dddddd", "#222831", "#30475e", "#f05454"]
	 */
];

// ---------------------------  에디터 캔버스 관련 --------------------------- //
// 캔버스 관련
var canvas = new fabric.Canvas('baseCanvas', {
	backgroundColor: '#ffffff'
});

//canvas.setBackgroundColor('#a0d8f1', () => {
//   canvas.renderAll();
//});

var activeShape = null;
var activeText = null;

canvas.on('selection:created', canvaseSelect);
canvas.on('selection:updated', canvaseSelect);
canvas.on('selection:cleared', clearCanvaseSelect);
canvas.on('object:scaling', canvasObjectResize);
canvas.on('object:modified', canvasObjectResize);

// 히스토리 관련 //
canvas.on('object:added', saveHistory);
canvas.on('object:modified', saveHistory);
canvas.on('object:removed', saveHistory);

function canvaseSelect(e){
	var obj = e.selected[0];

    activeShape = null;
    activeText = null;

	// 텍스트 박스인 경우
    if (obj.type === 'textbox') {
        activeText = obj;
    } 
    else {
		// 텍스트 박스가 아닌경우
        activeShape = obj;
    }
	
	updateSizeEditor(obj);
	updateColorEditor(obj);
}

function clearCanvaseSelect(){
	activeShape = null;
	activeText = null;
}

function canvasObjectResize(e) {
    var obj = e.target;
    if (!obj) return;
	updateSizeEditor(obj);
}

// --------------------------- 에디터 헤더 관련 --------------------------- //
var undoStack = [];
var redoStack = [];
var MAX_HISTORY = 50;
var isRestoring = false;

// 히스토리 저장
function saveHistory() {
	console.log("save:", undoStack.length);
	console.log("redo stack:", redoStack.length);
	
	if (isRestoring) return;

    redoStack = [];
    undoStack.push(JSON.stringify(canvas.toJSON()));

    if (undoStack.length > MAX_HISTORY) {
        undoStack.shift();
    }    
	
    updateUndoRedoUI();
}

// 실행취소
document.getElementById('canvas-undo').addEventListener('click', () => {
	console.log("undo:", undoStack.length);
	
    if (undoStack.length <= 1) return;

    isRestoring = true;

    redoStack.push(undoStack.pop());
    var prev = undoStack[undoStack.length - 1];

    canvas.loadFromJSON(prev, () => {
        canvas.renderAll();
        isRestoring = false;
        updateUndoRedoUI();
    });

});

// 다시실행
document.getElementById('canvas-redo').addEventListener('click', () => {
    if (!redoStack.length) return;

    isRestoring = true;

    const next = redoStack.pop();
    undoStack.push(next);

    canvas.loadFromJSON(next, () => {
        canvas.renderAll();
        isRestoring = false;
        updateUndoRedoUI();
    });
});

function updateUndoRedoUI() {
    toggleDisabled('canvas-undo', undoStack.length <= 1);
    toggleDisabled('canvas-redo', redoStack.length < 1);
}

function toggleDisabled(id, disabled) {
    var el = document.getElementById(id);
    el.classList.toggle('disabled', disabled);
}

// 미리보기
var previewBtn = document.getElementById('canvas-preview');
var overlay = document.getElementById('preview-overlay');
var closeBtn = document.getElementById('preview-close');

document.getElementById('canvas-preview').addEventListener('click', openPreview);

function openPreview() {
    var overlay = document.getElementById('preview-overlay');
    overlay.classList.remove('hidden');

    var previewCanvas1 = new fabric.Canvas('preview-canvas1', {
        selection: false
    });
	var previewCanvas2 = new fabric.Canvas('preview-canvas2', {
        selection: false
    });
	var previewCanvas3 = new fabric.Canvas('preview-canvas3', {
        selection: false
    });
	
	previewCanvas1.setWidth(70);
    previewCanvas1.setHeight(60);	
	previewCanvas2.setWidth(70);
    previewCanvas2.setHeight(70);	
	previewCanvas3.setWidth(190);
    previewCanvas3.setHeight(180);
	
	previewCanvas1.wrapperEl.classList.add('preview-canvas-container');
	previewCanvas2.wrapperEl.classList.add('preview-canvas-container');
	previewCanvas3.wrapperEl.classList.add('preview-canvas-container');

	loadPreviewCanvasFit(previewCanvas1, canvas);
	loadPreviewCanvasFit(previewCanvas2, canvas);
	loadPreviewCanvasFit(previewCanvas3, canvas);
}

function loadPreviewCanvasFit(previewCanvas, sourceCanvas) {
    previewCanvas.loadFromJSON(sourceCanvas.toJSON(), () => {
        var previewW = previewCanvas.getWidth();
        var previewH = previewCanvas.getHeight();

        var sourceW = sourceCanvas.getWidth();
        var sourceH = sourceCanvas.getHeight();

        var zoom = Math.min(
            previewW / sourceW,
            previewH / sourceH
        );

        previewCanvas.setZoom(zoom);

        var contentW = sourceW * zoom;
        var contentH = sourceH * zoom;

        var panX = (previewW - contentW) / 2;
        var panY = (previewH - contentH) / 2;

        previewCanvas.absolutePan({
            x: -panX,
            y: -panY
        });

        previewCanvas.requestRenderAll();
    });
}

closeBtn.addEventListener('click', () => {
    overlay.classList.add('hidden');
});

overlay.addEventListener('click', e => {
    if (e.target === overlay) overlay.classList.add('hidden');
});

// 캔버스 저장
document.getElementById('canvas-save').addEventListener('click', () => {
    const dataURL = canvas.toDataURL({
        format: 'png',
        quality: 1
    });

    const a = document.createElement('a');
    a.href = dataURL;
    a.download = 'Logo.png';
    a.click();
});

// ---------------------------  에디터 팔레트 버튼 --------------------------- //
var paletteContainer = document.getElementById('palette-container');

function renderPalettes() {
    var container = document.getElementById('palette-container');
    container.innerHTML = '';

    colorPalettes.forEach(palette => {
        var btn = document.createElement('div');
        btn.className = 'palette-btn';

        palette.forEach(color => {
            var box = document.createElement('div');
            box.className = 'palette-color';
            box.style.backgroundColor = color;
            btn.appendChild(box);
        });

        btn.addEventListener('click', () => {
			setActivePalette(btn)
            applyRandomPaletteColor(palette);
        });

        container.appendChild(btn);
    });	
}

function applyRandomPaletteColor(palette) {
    var randomColor = palette[Math.floor(Math.random() * palette.length)];

    canvas.setBackgroundColor(randomColor, canvas.renderAll.bind(canvas));

    canvas.getObjects().forEach(obj => {
		randomColor = palette[Math.floor(Math.random() * palette.length)];
        if (obj.type === 'textbox' || obj.type === 'text') {
            obj.set('fill', randomColor);
        } else if (obj.fill) {
            obj.set('fill', randomColor);
        }
    });

    canvas.requestRenderAll();	

	saveHistory();
}

function setActivePalette(btn) {
    document
        .querySelectorAll('.palette-btn')
        .forEach(b => b.classList.remove('is-active'));

    btn.classList.add('is-active');
}

renderPalettes();

// ---------------------------  에디터 텍스트 버튼 --------------------------- //
var textInput = document.getElementById('text-input-box');
var textSizeSlider = document.getElementById('text-size-slider');
var textSizeValue = document.getElementById('text-size-value');
var textWeightSlider = document.getElementById('text-weight-slider');
var textWeightValue = document.getElementById('text-weight-value');
var textFontSelect = document.getElementById('text-font-select');
var textAlineLeft = document.getElementById('text-aline-left');
var textAlineCenter = document.getElementById('text-aline-center');
var textAlineRight = document.getElementById('text-aline-right');
var textPicker = document.getElementById('text-color-picker');

// 폰트 로드
document.fonts.load("16px NanumGothic");
document.fonts.load("16px NanumMyeongjo");
document.fonts.load("16px NanumPen");

// 텍스트 박스 추가
function addTextBox() {
	var tempText = "텍스트 박스";
	
	if(textInput.value != ""){
		tempText = textInput.value
	}
	
	var textbox = new fabric.Textbox(tempText, {
        left: 100,
        top: 100,
        width: 300,
        fontFamily: 'NanumGothic',
        fontSize: 32,
        fill: '#000000'
    });
	
	textFontSelect.value = 'NanumGothic';

    canvas.add(textbox);
    canvas.setActiveObject(textbox);
    canvas.requestRenderAll();
}

document.getElementById('add-text-btn').addEventListener('click', addTextBox);

textInput.addEventListener('input', () => {
    if (!activeText) return;
    activeText.text = textInput.value;
    canvas.requestRenderAll();
});

function getFontLabel(font) {
    switch (font) {
        case 'NanumGothic': return '나눔 고딕';
        case 'NanumMyeongjo': return '나눔 명조';
        case 'NanumPen': return '나눔 펜';
        default: return font;
    }
}

textFontSelect.addEventListener('change', () => {
    if (!activeText || activeText.type !== 'textbox') return;

    var font = textFontSelect.value;

    activeText.set('fontFamily', font);
    canvas.requestRenderAll();
});

textFontSelect.addEventListener('change', () => {
    if (!activeText) return;

    saveHistory();
});

// 에디터 텍스트 굵기 수정 시 캔버스 텍스트 수정
textWeightSlider.addEventListener('input', () => {
    if (!activeText) return;

	var weight = Number(textWeightSlider.value);

	activeText.set('fontWeight', weight);
	textWeightValue.textContent = weight;
	canvas.requestRenderAll();
});

textWeightSlider.addEventListener('change', () => {
    if (!activeText) return;

    saveHistory();
});

// 에디터 텍스트 크기 수정 시 캔버스 텍스트 수정
textSizeSlider.addEventListener('input', () => {	
    if (!activeText) return;	

    var targetDiagonal = Number(textSizeSlider.value);
    var currentDiagonal = getDiagonalLength(activeText);

    var scaleRatio = targetDiagonal / currentDiagonal;

    activeText.scaleX *= scaleRatio;
    activeText.scaleY *= scaleRatio;

    textSizeValue.textContent = targetDiagonal;
    canvas.requestRenderAll();
});

textSizeSlider.addEventListener('change', () => {
    if (!activeText) return;

    saveHistory();
});

// 에디터 텍스트 정렬
textAlineLeft.addEventListener('click', () => {
    setTextAlign('left');
});
textAlineCenter.addEventListener('click', () => {
    setTextAlign('center');
});
textAlineRight.addEventListener('click', () => {
    setTextAlign('right');
});

function setTextAlign(align) {
    if (!activeText) return;
    activeText.set('textAlign', align);
    canvas.requestRenderAll();
	
	saveHistory();
}

textPicker.addEventListener('input', () => {
    if (!activeText) return;

    activeText.set('fill', textPicker.value);

    canvas.requestRenderAll();
});

textPicker.addEventListener('change', () => {
    if (!activeText) return;

    saveHistory();
});

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
var shapeSizeSlider = document.getElementById('shape-size-slider');
var shapeSizeValue = document.getElementById('shape-size-value');
var shapePicker = document.getElementById('shape-color-picker');

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

shapeSizeSlider.addEventListener('change', () => {
    if (!activeText) return;

    saveHistory();
});

shapePicker.addEventListener('input', () => {
    if (!activeShape) return;

    activeShape.set('fill', shapePicker.value);

    canvas.requestRenderAll();
});

shapePicker.addEventListener('change', () => {
    if (!activeShape) return;

    saveHistory();
});


// 공통 부분
// 캔버스 도형 수정 시 에디터 도형 크기 수정
function updateSizeEditor(obj) {
	var diagonal = getDiagonalLength(obj);	
	
	if (obj.type === 'textbox') {
        activeText = obj;
		
		textInput.value = obj.text;
		
		//var font = obj.fontFamily || 'NanumGothic';
		
		textSizeSlider.value = diagonal;
	    textSizeValue.textContent = diagonal;
		
		var weight = obj.fontWeight || 400;	
		if(weight == 'normal'){
			weight = 400;
		}	
	    textWeightSlider.value = weight;
	    textWeightValue.textContent = weight;
    } 
    else {
		// 텍스트 박스가 아닌경우
        activeShape = obj;		
		shapeSizeSlider.value = diagonal;
	    shapeSizeValue.textContent = diagonal;
		
    }
}

// 대각선 계산
function getDiagonalLength(obj) {
    var w = obj.getScaledWidth();
    var h = obj.getScaledHeight();
    return Math.round(Math.sqrt(w * w + h * h));
}

// 에디터 색상 수정
function updateColorEditor(obj) {
    var fill = obj.fill || '#000000';
    var hexColor = rgbToHex(fill);
	
	if (obj.type === 'textbox') {
        textPicker.value = hexColor;
    } 
    else {
		// 텍스트 박스가 아닌경우
        shapePicker.value = hexColor;
    }	    
}

function rgbToHex(color) {
    if (!color) return '#000000';
    if (color.startsWith('#')) return color;

    var rgb = color.match(/\d+/g);
    return '#' + rgb.map(x => {
        var hex = parseInt(x).toString(16);
        return hex.length === 1 ? '0' + hex : hex;
    }).join('');
}

// delete 눌렀을 때 오브젝트 삭제
document.addEventListener('keydown', (e) => {
    if (e.key !== 'Delete') return;

    if (['INPUT', 'TEXTAREA'].includes(document.activeElement.tagName)) return;

    var objs = canvas.getActiveObjects();
    if (!objs.length) return;

    objs.forEach(obj => {
        if (!obj.isEditing) canvas.remove(obj);
    });

    canvas.discardActiveObject();
    canvas.requestRenderAll();
});

// --------------------------- 초기 실행 --------------------------- //
// 초기 버튼 비활성화
closeTab();
hideAllTab();
getDiagramSvgs();
// 맨 처음 캔버스 값 저장
saveHistory();
// 초기 버튼 활성화
if(!activeTab){
	var firstBtn = document.querySelector('#editor-tab-button .tab-btn')		
	
	if (firstBtn) {
		openTab(firstBtn.dataset.tab);
	}
}

