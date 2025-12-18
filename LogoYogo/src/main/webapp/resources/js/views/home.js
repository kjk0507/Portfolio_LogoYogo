
// alert("home.js 실행됨");


/*
setTimeout(() => {
    location.href = ctx + "/main";
}, 10000);
*/

console.log("home");

$.ajax({
    type: "POST",
    url: "test.do",
    data: {
        id: "test"
    },
    success: function (res) {
        console.log("요청 성공", res);
    },
    error: function (err) {
        console.log("요청 실패", err);
    }
});


fetch(ctx + '/getDiagramSvgs')
	.then(res => res.json())
	.then(svgs => {
		svgs.forEach(path => {
		    var img = document.createElement('img');
		    img.src = path;
		    img.style.width = '50px';
		    document.getElementById('imgList').appendChild(img);
	  	});
});