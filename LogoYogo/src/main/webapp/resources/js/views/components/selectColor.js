document.querySelectorAll('.item-color-inner').forEach(item => {
    item.addEventListener('click', () => {
        var color = window.getComputedStyle(item).backgroundColor;

        var selectData = getSelectData();
        selectData.color = color;

        setSelectData(selectData);
		
		$("#content").load("/selectArrange.do", function () {
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