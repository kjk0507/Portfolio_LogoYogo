document.querySelectorAll('.selectArrange-pos').forEach(item => {
    item.addEventListener('click', () => {
		var pos = item.dataset.pos;
		
        var selectData = getSelectData();
        selectData.pos = pos;

        setSelectData(selectData);
		
		console.log("pos :"+ pos);
		$("#content").load("/editor.do", function () {
	        window.scrollTo(0, 0);
	    });
    });
});

document.getElementById('passEditor').addEventListener('click', e => {
	e.preventDefault();	
	sessionStorage.removeItem(setSelectData);
	$("#content").load("/editor.do", function () {
        window.scrollTo(0, 0);
    });
})

function getSelectData() {
    return JSON.parse(sessionStorage.getItem('selectData')) || {};
}

function setSelectData(data) {
    sessionStorage.setItem('selectData', JSON.stringify(data));
}