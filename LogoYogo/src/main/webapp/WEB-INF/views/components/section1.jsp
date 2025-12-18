<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style type="text/css">
#section1 {
	background: #4665d9;
}

.container3 {
    width: 65rem;
    position: absolute;
    display: flex;
    justify-content: center;
    align-items: center;

    transform: rotate(45deg);
    z-index: 1;
    bottom: -10rem;
    left: -40rem;

    &:before {
	    width: 100%;
	    height: 100%;
	    padding-bottom: 100%;
	    background: linear-gradient(
	      90deg,
	      rgba(67, 94, 212, 1) 0%,
	      rgba(52, 78, 207, 1) 100%
	    );
	    content: "";
	    position: absolute;
    }
}

.container4 {
	position: absolute;
	display: flex;
	justify-content: center;
	align-items: center;
	top: 50rem;
	right: -10vw;
	
	transform: rotate(58deg);
	
	&:before {
		width: 50rem;
		height: 90rem;
		padding-bottom: 100%;
		border-radius: 18rem;
		
		background: linear-gradient(
		  180deg,
		  rgba(65, 89, 202, 1) 9%,
		  rgba(52, 78, 207, 1) 60%
		);
		
		background: #1d243a;
		
		opacity: 0.7;
		
		content: "";
		position: absolute;
	}
}

</style>
<div id="section1" class="section_page">
	<div class="container">
        <div class="title">
          LOGO는 어디서?
          <br />
          LOGOYOGO에서!
        </div>
        <div class="subtitle">
          과제, 프로젝트에 쓸 로고가 필요한가요? 누구나 3분이면 간단히 만들 수
          있습니다. 아래 로고를 입력하고 지금 바로 시작해보세요.
        </div>
        <div class="landing1-button-container">
          <input
            class="input-logoname"
            placeholder="로고를 입력하세요"
            onChange={handleLogoName}
            onKeyPress={enter}
          ></input>
          <button class="btn-logoname-confirm" onClick={logoname}>
            시작하기
          </button>
        </div>
        <button
          class="btn-search-template"
        >
          다른 사용자의 템플릿 둘러보기
        </button>
      </div>
      <div class="container2"></div>
      <div class="container3"></div>
      <div class="container4"></div>
</div>
<script src="${pageContext.request.contextPath}/resources/js/views/components/section1.js"></script>