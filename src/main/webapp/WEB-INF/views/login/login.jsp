<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/common/top.jsp" %>

<link href="<%= request.getContextPath() %>/design/css/top.css" rel="stylesheet" style="text/css">
<link href="<%= request.getContextPath() %>/design/css/login.css?d" rel="stylesheet" style="text/css">
<link
	href="<%=request.getContextPath()%>/design/bootstrap/_bootswatch.scss"
	rel="stylesheet" style="text/css">
<link
	href="<%=request.getContextPath()%>/design/bootstrap/_variables.scss"
	rel="stylesheet" style="text/css">
<link
	href="<%=request.getContextPath()%>/design/bootstrap/bootstrap.css"
	rel="stylesheet" style="text/css">
<link
	href="<%=request.getContextPath()%>/design/bootstrap/bootstrap.min.css"
	rel="stylesheet" style="text/css">
<body>

<meta charset="UTF-8">
<title>Member Login</title>
</head>
<body>

<c:if test="${memRole eq 'normal' }">
<div class="div_container">
<img id="login_backgorund"src="${pageContext.request.contextPath}/design/img/login_backgoround.jpg" >
<div id="login_opacity"></div>
<div class="div_box">

	<div class="div_title"><a href="${pageContext.request.contextPath}"><img src="${pageContext.request.contextPath}/design/img/findyou_logo.png" width="100px" height="100px" ></a></div>
	<div class="div_login_title"><p> 일반 회원 로그인</p> </div>	
	<a href="login.wow?memRole=normal" class="a_select_border">일반회원</a><a href="login.wow?memRole=business"class="a_select_border"   >사업자회원</a>  <!-- -테두리 만들기 --> 
	<form action="login.wow" method="post" id="normal_form">
<div id="div_login_border">
<div id="div_login_box">
<div class="card text-white bg-primary mb-3" style="max-width: 20rem;">
  <div class="card-header">로그인</div>
  <div class="card-body">

   <div id="div_login_Id"><input placeholder="ID" type="text"class="form-control" id="input_id_bar"  name="memId"></div>
	<div id="div_login_Pass"><input placeholder="PW" type="password" class="form-control"id="input_pass_bar" name="memPass"></div>

  </div>
  <input type="hidden" name="memRole" value="normal"><!--롤 부여  -->
<div id="div_login_checkBox"> <input id="login_save"type="checkbox">아이디 저장  <!-- 아직안함 -->
</div>
</div>
</div>
<div id="div_login_submit"><button  id="login_submit" class="btn btn-lg btn-primary" onclick="normal_btn()" >로그인</button> </div> 
</div>
</form>
<span id="span_other_function"><a href="loginFind.wow?category=idFind" class="div_button">아이디 찾기</a>
<a href="loginFind.wow?category=passFind" class="div_button">비밀번호 찾기</a>
<a href="<%=request.getContextPath()%>/join/joinStep1.wow" class="div_button">회원가입</a> </span>
</div>
</div>
</c:if>
<c:if test="${memRole eq 'business'}">
<div class="div_container">
<img id="login_backgorund"src="${pageContext.request.contextPath}/design/img/login_backgoround.jpg" >
<div id="login_opacity"></div>
<div class="div_box">
	<div class="div_title"><a href="${pageContext.request.contextPath}"><img src="${pageContext.request.contextPath}/design/img/findyou_logo.png" width="100px" height="100px" ></a></div>
	<div class="div_login_title"><p> 사업자 회원 로그인</p> </div>	
	<a href="login.wow?memRole=normal" class="a_select_border">일반회원</a><a href="login.wow?memRole=business"class="a_select_border"   >사업자회원</a>  <!-- -테두리 만들기 --> 

<form action="login.wow" method="post" id="business_form">
<div id="div_login_border">
<div id="div_login_box">

<div class="card text-white bg-primary mb-3" style="max-width: 20rem;">
  <div class="card-header">로그인</div>
  <div class="card-body">

 <div id="div_login_Id"><input placeholder="ID" type="text" id="input_id_bar" class="form-control"  name="memId"></div>
<div id="div_login_Pass"><input placeholder="PW" type="password" id="input_pass_bar" class="form-control"  name="memPass"></div>
</div>
<input type="hidden" name="memRole" value="business"><!--롤 부여  -->
<div id="div_login_checkBox"> <input type="checkbox">아이디 저장
</div>
</div>
</div>
<div id="div_login_submit"><button  class="btn btn-lg btn-primary" onclick="business_btn()">로그인</button> </div> 
</div>
</form>
<span id="span_other_function"><a href="loginFind.wow?category=idFind" class="div_button">아이디 찾기</a>
<a href="loginFind.wow?category=passFind" class="div_button">비밀번호 찾기</a>
<a href="<%=request.getContextPath()%>/join/joinStep1.wow" class="div_button">회원가입</a> </span>
</div>
</div>
</c:if>

</body>

<script type="text/javascript">
$(function(){ 
	var id = getCookie("Cookie_mail"); 
	if(id){ 
		$("#input_id_bar").val(id); 
		
		$("#saveBtn").attr("checked", true);
	}
	
}); 


function normal_btn()
{ 
	var id = $("#input_id_bar").val(); 
	var idChk = $("#login_save").is(":checked"); 
	
	if(id == ""){
		$("#mail").focus(); 
		alert('아이디를 입력해주세요.');
		return false; 
	}
	else if(idChk)
	{ 
		setCookie("Cookie_mail", id, 7);
	}else{
			deleteCookie("Cookie_mail");
	} 
	$("#login_submit").submit();
	
	var msg = "<%= request.getParameter("msg") %>";
	if(msg != "null"){
		console.log("msg = " + msg);
		alert(msg);
	}
};


function business_btn()
{ 
	var id = $("#input_id_bar").val(); 
	var idChk = $("#login_save").is(":checked"); 
	
	if(id == ""){
		$("#mail").focus(); 
		alert('아이디를 입력해주세요.');
		return false; 
	}
	else if(idChk)
	{ 
		setCookie("Cookie_mail", id, 7);
	}else{
			deleteCookie("Cookie_mail");
	} 
	$("#login_submit").submit();
	
	
	var msg = "<%= request.getParameter("msg") %>";
	if(msg != "null"){
		console.log("msg = " + msg);
		alert(msg);
	}
};

function setCookie(cookieName, value, exdays){ 
		var exdate = new Date(); exdate.setDate(exdate.getDate() + exdays); 
		var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
		document.cookie = cookieName + "=" + cookieValue; 

}
	
function getCookie(cookieName) { cookieName = cookieName + '=';
	var cookieData = document.cookie; 
	var start = cookieData.indexOf(cookieName);
	var cookieValue = ''; 
	if(start != -1){ start += cookieName.length; 
		var end = cookieData.indexOf(';', start);
		if(end == -1)end = cookieData.length; cookieValue = cookieData.substring(start, end);
	} 
	return unescape(cookieValue); 
} 
	
function deleteCookie(cookieName){ 
	var expireDate = new Date(); expireDate.setDate(expireDate.getDate() - 1); 
	document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString(); 
}




</script>
</html>