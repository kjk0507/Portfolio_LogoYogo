$(document).on("click", ".nav-link", function (e) {
    e.preventDefault();

    var url = $(this).data("url");

    $("#content").load(url, function () {
        window.scrollTo(0, 0);
    });
});

/*
function adjustNaviWidth() {
  var hasScroll =
    document.documentElement.scrollHeight >
    document.documentElement.clientHeight;

  var navi = document.getElementById("navi");

  if (hasScroll) {
    navi.style.right = "17px"; // 윈도우 기본 스크롤바 폭
  } else {
    navi.style.right = "0";
  }
}

window.addEventListener("load", adjustNaviWidth);
window.addEventListener("resize", adjustNaviWidth);
 */