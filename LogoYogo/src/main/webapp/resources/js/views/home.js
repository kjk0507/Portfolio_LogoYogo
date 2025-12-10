
alert("home.js 실행됨");


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
        console.log("요청 성공");
    },
    error: function (err) {
        console.log("요청 실패", err);
    }
});