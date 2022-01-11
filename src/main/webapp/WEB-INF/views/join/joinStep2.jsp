<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<%request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/joinStep2.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/bootstrap/bootstrap.css">

<meta charset="UTF-8">
<title>회원가입 STEP2</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/top.jsp" %>
<div class="div_container">
<img id="login_backgorund"src="${pageContext.request.contextPath}/design/img/login_backgoround.jpg" >
<div id="login_opacity"></div>

<div class="joinstep2">


<form:form action="joinStep3.wow" method="post" id="joinForm">
<div class="total_agree">


<div class="normal_joinstep2">
	<div class="agree_header">
	<c:if test="${memRole eq 'normal' }">
	<h3>회원가입 1단계(일반)</h3>
	</c:if>
		<c:if test="${memRole eq 'business' }">
	<h3>회원가입 1단계(사업자)</h3>
	</c:if>
	</div>
	
	<div class="normal agree">
	<div class="title_agree">
		<label>
		  파유(Find You) 이용약관 동의
			<span class="required">(필수)</span>
			
			<input type="checkbox" name="agreeYn" class="normal agree_check form-check-input" id="" value="Y"/>동의
		</label>
		<div class="panel_body1">		
		<h3 class="test_title">여러분을 환영합니다.</h3>
	     <p class="test_text">
네이버 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 네이버 서비스의 이용과 관련하여 네이버 서비스를 제공하는 네이버 주식회사(이하 ‘네이버’)와 이를 이용하는 네이버 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 네이버 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
네이버 서비스를 이용하시거나 네이버 서비스 회원으로 가입하실 경우 여러분은 본 약관 및 관련 운영 정책을 확인하거나 동의하게 되므로, 잠시 시간을 내시어 주의 깊게 살펴봐 주시기 바랍니다.
다양한 네이버 서비스를 즐겨보세요.
네이버는 www.naver.com을 비롯한 네이버 도메인의 웹사이트 및 응용프로그램(어플리케이션, 앱)을 통해 정보 검색, 다른 이용자와의 커뮤니케이션, 콘텐츠 제공, 상품 쇼핑 등 여러분의 생활에 편리함을 더할 수 있는 다양한 서비스를 제공하고 있습니다.
여러분은 PC, 휴대폰 등 인터넷 이용이 가능한 각종 단말기를 통해 각양각색의 네이버 서비스를 자유롭게 이용하실 수 있으며, 개별 서비스들의 구체적인 내용은 각 서비스 상의 안내, 공지사항, 네이버 웹고객센터(이하 ‘고객센터’) 도움말 등에서 쉽게 확인하실 수 있습니다.
네이버는 기본적으로 여러분 모두에게 동일한 내용의 서비스를 제공합니다. 다만, '청소년보호법' 등 관련 법령이나 기타 개별 서비스 제공에서의 특별한 필요에 의해서 연령 또는 일정한 등급을 기준으로 이용자를 구분하여 제공하는 서비스의 내용, 이용 시간, 이용 횟수 등을 다르게 하는 등 일부 이용을 제한하는 경우가 있습니다. 자세한 내용은 역시 각 서비스 상의 안내, 공지사항, 고객센터 도움말 등에서 확인하실 수 있습니다.
		 </p>
		</div>
	</div>
	<div class="privacy_agree">
		<label>
		 개인정보 수집 및 이용 동의
		 <span class="required">(필수)</span>
		<input type="checkbox" name="privacyYn" class="normal agree_check form-check-input" value="Y"/>동의
		</label>
		<div class="panel_body2">
		<p class="test_text">
개인정보보호법에 따라 네이버에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 
이용목적, 개인정보의 보유 및 이용기간, 동의 거부권 및 동의 거부 시 불이익에 관한 사항을 안내 드리오니 
자세히 읽은 후 동의하여 주시기 바랍니다. <br>
<br>
1. 수집하는 개인정보
이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등 대부분의 네이버 서비스를 회원과 동일하게 이용할 수 있습니다. 이용자가 메일, 캘린더, 카페, 블로그 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, 네이버는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.
회원가입 시점에 네이버가 이용자로부터 수집하는 개인정보는 아래와 같습니다.<br>
- 회원 가입 시에 ‘아이디, 비밀번호, 이름, 생년월일, 성별, 휴대전화번호’를 필수항목으로 수집합니다. 
만약 이용자가 입력하는 생년월일이 만14세 미만 아동일 경우에는 법정대리인 정보(법정대리인의 이름, 생년월일, 성별, 중복가입확인정보(DI), 휴대전화번호)를 추가로 수집합니다. 그리고 선택항목으로 이메일 주소를 수집합니다.
<br>
- 단체아이디로 회원가입 시 단체아이디, 비밀번호, 단체이름, 이메일주소, 휴대전화번호를 필수항목으로 수집합니다. 그리고 단체 대표자명을 선택항목으로 수집합니다.
		</p>
		</div>
	</div>
	
	<div class="local_agree">
		<label>
			위치정보 이용약관 동의
		<span class="required">(선택)</span>
		<input type="checkbox" name="eventYn" class="normal agree_checkYn form-check-input" value="Y"/>동의
		</label>
		<div class="panel_body3">
		<p class="test_text">
		위치정보 이용약관에 동의하시면, 위치를 활용한 광고 정보 수신 등을 포함하는 네이버 위치기반 서비스를 이용할 수 있습니다.
제 1 조 (목적)
이 약관은 네이버 주식회사 (이하 “회사”)가 제공하는 위치정보사업 또는 위치기반서비스사업과 관련하여 회사와 개인위치정보주체와의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.
<br>
제 2 조 (약관 외 준칙)
이 약관에 명시되지 않은 사항은 위치정보의 보호 및 이용 등에 관한 법률, 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 전기통신기본법, 전기통신사업법 등 관계법령과 회사의 이용약관 및 개인정보처리방침, 회사가 별도로 정한 지침 등에 의합니다.
<br>
제 3 조 (서비스 내용 및 요금)
①회사는 직접 위치정보를 수집하거나 위치정보사업자인 이동통신사로부터 위치정보를 전달받아 아래와 같은 위치기반서비스를 제공합니다.
<br>
1.Geo Tagging 서비스: 게시물에 포함된 개인위치정보주체 또는 이동성 있는 기기의 위치정보가 게시물과 함께 저장됩니다.
		</p>
		</div>
		
	</div>
	
	<h2 style="font-size:18px !important; margin-top:30px">파유(Find You) 이용약관, 개인정보 수집 및 이용, 위치정보 이용약관(선택)에 모두 동의합니다.

	<input type="checkbox" name="all_agreeYn" id="check_all" class="form-check-input" value="Y"/>동의
	</h2>
	<input type="button" class="btn btn-primary" value="다음" onclick="nextGo()">

	
	
	</div>
</div>


</div><!-- total agree -->

</form:form>
</div>

</div>

<script type="text/javascript">


//약관 동의 후 페이지 이동 
function nextGo(){
	 if ($(".agree_check:checked").length == 2){
		 $("#joinForm").submit();
	 } else if ($(".agree_check:checked").length == 1 || 0){
		 alert("필수약관은 동의가 필요합니다!!!!!!!!");
		 return ;
	 
	  }else if ($(".agree_check:checked").length == 0){
			 alert("필수약관은 동의가 필요합니다!");
			 return ;
	  }
  }

//체크박스 전체 선택
$(".total_agree").on("click", "#check_all", function () {
    $(this).parents(".total_agree").find('input').prop("checked", $(this).is(":checked"));
});
 

$(".agree_check").click(function(){
	
if($(".agree_check:checked").length + $(".agree_checkYn:checked").length == 3){
	$("[name=all_agreeYn").prop('checked', true)
	
}else {
	$("[name=all_agreeYn").prop('checked', false)
}
	
	

	});
	
$(".agree_checkYn").click(function(){
	
if($(".agree_check:checked").length + $(".agree_checkYn:checked").length == 3){
	$("[name=all_agreeYn").prop('checked', true)
	
}else {
	$("[name=all_agreeYn").prop('checked', false)
}
	
	

	});
</script>

</body>
</html>