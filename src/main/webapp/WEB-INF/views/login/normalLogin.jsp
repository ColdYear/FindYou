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

	<div class="div_container">
		<img id="login_backgorund"
			src="${pageContext.request.contextPath}/design/img/login_backgoround.jpg">
		<div id="login_opacity"></div>
		<div class="div_box">

			<div class="div_title">
				<a href="${pageContext.request.contextPath}"><img
					src="${pageContext.request.contextPath}/design/img/findyou_logo.png"
					width="100px" height="100px"></a>
			</div>
			<div class="div_login_title">
				<p>일반 회원 로그인</p>
			</div>
			<a href="normalLogin.wow" class="a_select_border">일반회원</a><a
				href="businessLogin.wow" class="a_select_border">사업자회원</a>
			<!-- -테두리 만들기 -->
			<form action="normalLogin.wow" method="post" id="normal_form">
				<div id="div_login_border">
					<div id="div_login_box">
						<div class="card text-white bg-primary mb-3"
							style="max-width: 20rem;">
							<div class="card-header">로그인</div>
							<div class="card-body">

								<div id="div_login_Id">
									<input placeholder="ID" type="text" class="form-control"
										id="input_id_bar" name="memId" value="${memId}">
								</div>
								<div id="div_login_Pass">
									<input placeholder="PW" type="password" class="form-control"
										id="input_pass_bar" name="memPass">
								</div>

							</div>
							
							<!--롤 부여  -->
							<div id="div_login_checkBox">
								<input id="login_save" type="checkbox" name="rememberMe" value="Y">아이디 저장
								<!-- 아직안함 -->
							</div>
						</div>
					</div>
					<div id="div_login_submit">
						<button id="login_submit" class="btn btn-lg btn-primary"
							type="button">로그인</button>
					</div>
				</div>
			</form>
			<span id="span_other_function"><a
				href="loginFind.wow?category=idFind" class="div_button">아이디 찾기</a> <a
				href="loginFind.wow?category=passFind" class="div_button">비밀번호
					찾기</a> <a href="<%=request.getContextPath()%>/join/joinStep1.wow"
				class="div_button">회원가입</a> </span>
		</div>
	</div>

</body>

<script type="text/javascript">
$('#login_submit').click(function(){
	$form = $('#normal_form');
	$.ajax({
		url:'<c:url value="/login/normalLogin.wow"/>',
		data:$form.serialize(),
		dataType:'text',
		type:'post',
		success:function(msg){
			if(msg == 'success'){
				location.href = '<%= request.getContextPath() %>/'
			}else{				
				alert(msg);
				$('#input_id_bar').val('');
				$('#input_pass_bar').val('');
				
			}
		},
		error:function(){
			alert('통신 실패');
		}
		
	});
	
});


</script>
</html>