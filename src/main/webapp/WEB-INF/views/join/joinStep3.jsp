<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath()%>/design/css/joinStep3.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/bootstrap/bootstrap.css">
<meta charset="UTF-8">
<title>회원가입 STEP3</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/top.jsp" %>
<img src="${pageContext.request.contextPath}/design/img/why.png" width="30px" height="30px" onclick="open_info()" id="why">
<div id="div_hpInfo"><button id="close_hpInfo" class="btn btn-danger">닫기</button></div>
<div class="div_container">
<img id="login_backgorund"src="${pageContext.request.contextPath}/design/img/login_backgoround.jpg" >
<div id="login_opacity"></div>

	<div class="div_box">
	<form id ="pagePass" action="<%=request.getContextPath()%>/join/${member.memRole}JoinForm.wow?memRole=${member.memRole}" method="post">
	
	
		<h2>본인인증</h2>
			
		<!-- NAME -->
	<div class="div_center">	
	
	
		<div class="div_flex">
			<div class="div_left form-group" style="max-width:150px;">이름</div>
			<div class="div_right box name">
				<input type="text" class="form-control" maxlength="20" name="memName" value="${sessionScope.memName }">
			</div>
		</div>
		
			<div class="div_flex">
			
			<div class="div_left form-group" style="max-width:150px;">성별</div>
			<div class="div_right box sex">
	<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
	  <input type="radio" class="btn-check" name="memGender" id="btnradio1" autocomplete="off" value='남' ${sessionScope.memGender eq '남'?'checked':'' }>
	  <label class="btn btn-outline-primary" for="btnradio1">남성</label>
	  <input type="radio" class="btn-check" name="memGender" id="btnradio2" autocomplete="off" value='여' ${sessionScope.memGender eq '여'?'checked':'' }>
	  <label class="btn btn-outline-primary" for="btnradio2">여성</label>
	</div>
			</div>
			
		</div>
		
	
		<div class="div_flex">
			
			<div class="div_left form-group" style="max-width:150px;">이메일</div>
			<div class="div_right box email">
				<input type="text"  class="form-control" maxlength="20" name=memEmail value="${sessionScope.memEmail }">
			</div>
			
		</div>
		<!-- PHONE NUMBER -->
		<div class="div_flex">
		<div class="div_left form-group" style="max-width:150px;">휴대전화</div>
		<div class="div_right box Hp">
				<input type="text" class="form-control" maxlength="20" name="memHp" value="${sessionScope.memHp }" >
			
		</div>
			<input type="button" class="btn btn-primary" value="번호 인증 받기" onclick="fn_number_recevier()" id="receive_button">
		</div>
		
		
			
		
		<div class="div_flex" id="auth_line">
			<div class="div_left form-group" style="max-width:150px;">인증번호</div>
			<div class="div_right box number">
					<input type="text" class="int form-control" maxlength="20" value="${sessionScope.auth_reconF }" id="hp_number">
			</div>
			<button type="button" class="btn btn-primary" id="button_number" onclick="fn_auth_co()">인증 확인</button>
		</div>
	</div>
		
		
	<div class="div_button">
		<%-- <c:if test="${sessionScope.Sucess ne null }" > --%>
	
		<button type="button" class="btn btn-primary"  onclick="fn_check_input()" id="button_move">다음</button>
	
	    <%-- </c:if> --%>
	    
	    
	    <%-- <c:if test="${sessionScope.Sucess eq null }">
		<button type="button" class="btn btn-primary" onclick="fn_checkhe()" id="button_move">다음</button>
	    </c:if> --%>
	</div>
	    
	    
	    
	    
	    </form>
	 
	</div>
</div>
<script type="text/javascript">

let auth_num;

function fn_check_input() {
	var name = $("input[name=memName]");
	var email = $("input[name=memEmail]");
	var hp = $("input[name=memHp]");
	var input_auth = $("#hp_number").val();
	
	var nameCheck = /^[가-힣]{2,4}$/;
	if(!nameCheck.test(name.val())){
		alert("이름을 입력해주세요!");
		name.focus();
		return ;
	}
	
	
	var genderCheck = $('input:radio[name=memGender]').is(':checked');
	if(!genderCheck){
		alert("성별을 선택해주세요!");
		return;
	}
	
	var emailCheck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	if(!emailCheck.test(email.val())){
		alert("이메일형식이 올바르지 않습니다!");
		email.focus();
		return ;
	}
	var hpCheck = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	if(!hpCheck.test(hp.val())){
		alert("휴대전화 번호를 올바르게 입력해주세요!");
		hp.focus();
		return ;
	}
	
	if(!$("*").hasClass("authClear")){
		alert("휴대폰 번호 인증을 해주세요!");
		return;
	}
	
	if(!$("*").hasClass("authNumberClear")){
		alert("인증이 완료되지 않았습니다.");
		return;
	}
	
	$("#pagePass").submit();
}

$('#why').click(function(){
	$('#div_hpInfo').show();
});


$('#close_hpInfo').click(function(){
	$('#div_hpInfo').hide();
});


$(document).ready(function () {
  	$('#div_hpInfo').hide();
	
	
	$("input[name=memName]").val('');
	$("input[name=memEmail]").val('');
	$("input[name=memHp]").val('');
	$("input[name=memGender]").prop('checked',false);
	$("#hp_number").val('');
	
	$('#auth_line').hide();
    $(document).on("submit", "form", function(event){
        // disable warning
        $(window).off('onbeforeunload');
    });
});

function fn_checkhe(){
	alert("인증키 확인해요");
}

function fn_number_recevier() { 
	
	if(confirm('번호인증받기 클릭 시, 사기 전과를 조회합니다. 진행하시겠습니까?')){
		let Hp = $("input[name=memHp]").val();
		$.ajax({
			url : "receiveAuthNumber.wow",
			type : "POST",
			data : {
				"Hp" : Hp,
			}, //파라미터
			dataType:"json",
			success : function(map) {
				 if(map.hp == '불가능'){
					alert('해당 번호로는 회원가입 하실 수 없습니다.');
					location.reload();
					return;
				}else{
					$('#auth_line').show();
					alert('정상적으로 인증이 완료되었습니다.');
					auth_num = map.auth;
					$("input[name=memHp]" ).prop('readonly', true);
					$("input[name=memHp]").addClass('authClear');
				}
					alert('인증완료! 문자메시지를 전송하였습니다.');
				
				$('#auth_line').show();
				auth_num = map.auth;
				$("input[name=memHp]" ).prop('readonly', true);
				$("input[name=memHp]").addClass('authClear');
			},
			error : function(err) {
				alert('통신오류');			
			}
		});
	}
	
}
let Sucess=null;
let check ="check";
function fn_auth_co() {
	
	//입력값들 다시 저장을 위해 
	var name = $("input[name=memName]");
	var email = $("input[name=memEmail]");
	var hp = $("input[name=memHp]");
	var gender = $("input[name=memGender]");
	let memName =name.val();
	let memEmail =email.val();
	let memHp =hp.val();
	let auth_reconF = $("#hp_number").val();
 	let memGender = gender.val();
	
	$.ajax({
		url : "joinAuthcheck.wow",
		type : "POST",
		data : {
			"auth_reconF" : auth_reconF
			,"memName" :memName
			,"memEmail" : memEmail
			,"memHp" : memHp
			,"memGender":memGender
		}, //파라미터
		dataType:'text',
		success : function(data) {	
<%-- 		if(<%=session.getAttribute("re_check")%> ==null){
			location.reload();
			} --%>
			alert(data);
			if(data == "인증실패"){
				$("#hp_number").val('');
				alert("인증번호가 올바르지 않습니다.");
				return;
			}
			
			$("#hp_number" ).prop('readonly', true);
			$("#hp_number").addClass("authNumberClear");
		},
		error : function(err) {
			alert("인증실패");
		}
	});
}

if(<%=session.getAttribute("re_check")%> !=null) {
	window.onbeforeunload = function(e){
	    if(e != null && e != undefined){
	    	$.ajax({
				url : "removeSession.wow",
				type : "POST",
				success : function() {	
			
			},
			error : function(err) {
			
				alert(err);
			}
		});
	    }
	};

	}
			







	

</script>
	
	


</body>
</html>