<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>일반회원찾기</title>

<!-- 일반회원(아이디,비밀번호) 사업자 회원 (아이디,비밀번호) -->





<%@ include file="/WEB-INF/views/common/top.jsp"%>
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
<link href="<%=request.getContextPath()%>/design/css/top.css"
	rel="stylesheet" style="text/css">
<link href="<%=request.getContextPath()%>/design/css/infoFind.css?dd=d"
	rel="stylesheet" style="text/css">
</head>
<body>
	<!--Id  -->

	<c:if test="${memRole eq 'normal'}">
		<c:if test="${category eq 'idFind' }">
			<style type="text/css">
#div_hpNumber {
	margin-top: 30px;
}
</style>


			<div class="div_container">
			<img id="login_backgorund"src="${pageContext.request.contextPath}/design/img/login_backgoround.jpg" >
				<div id="login_opacity"></div>
				<div id=logo_image>
					<a href="${pageContext.request.contextPath}"><img
						src="${pageContext.request.contextPath}/design/img/findyou_logo.png"
						width="100px" height="100px"></a>
				</div>
				<div id="div_title">일반회원 아이디 찾기</div>
				<div class="div_content">회원정보에 등록한 휴대전화로 인증</div>
		
  			
				<div id="div_number_box_id" class="card text-white bg-primary mb-3"	style="max-width: 25rem;">
						<div class="card-header">아이디 찾기</div>
					<div id="div_hpNumber_id">


						<c:if test="${sessionScope.hp eq null }">
							<input id="hp_number_id" type="tel" name="Hp" placeholder="핸드폰"
								class="form-control">
						</c:if>
						<c:if test="${sessionScope.hp ne null }">
							<input id="hp_number_id" type="tel" name="Hp" placeholder="핸드폰"
								class="form-control" value="${sessionScope.hp}">
						</c:if>
						<button class="btn btn-dark" onclick="fn_number_recevier()">인증
							번호 받기</button>
						<c:if test="${sessionScope.message ne null }">
							<div><%=session.getAttribute("message")%></div>
							<!--인증아래 나오는 메세지  -->
						</c:if>
					</div>
					<div id="div_authNumber_id">
						<span></span><span id="auth_input_id"><input type="text"
							class="form-control" id="auth_confirm_id"
							placeholder="인증번호">
							<button onclick="fn_number_confirm()" class="btn btn-dark"
								id="auth_confirm_button">인증 하기</button></span>
					</div>
					<div id="div_submit_id">
						<button type="button" id="submit_button_id"
							class="btn btn-dark">제출</button>
						<!--인증완료시 제출 버튼생성  -->
					</div>
				</div>
			</div>
	
		</c:if>
	</c:if>
	<c:if test="${memRole eq 'business'}">
		<c:if test="${category eq 'idFind' }">
			<style type="text/css">
#div_hpNumber {
	margin-top: 30px;
}
</style>
			<!-- 사업회원 아이디 -->
			<div class="div_container">
					<img id="login_backgorund"src="${pageContext.request.contextPath}/design/img/login_backgoround.jpg" >
<div id="login_opacity"></div>
				<div id=logo_image>
					<a href="${pageContext.request.contextPath}"><img
						src="${pageContext.request.contextPath}/design/img/findyou_logo.png"
						width="100px" height="100px"></a>
				</div>
				<div id="div_title">사업자회원 아이디 찾기 </div>
				<div class="div_content">회원정보에 등록한 휴대전화로 인증</div>
				<div id="div_number_box_id" class="card text-white bg-primary mb-3"
					style="max-width: 25rem;">
						<div class="card-header">아이디 찾기</div>
					<div id="div_hpNumber_id">


						<c:if test="${sessionScope.hp eq null }">
							<input id="hp_number_id" type="tel" name="Hp" placeholder="핸드폰"
								class="form-control">
						</c:if>
						<c:if test="${sessionScope.hp ne null }">
							<input id="hp_number_id" type="tel" name="Hp" placeholder="핸드폰"
								class="form-control" value="${sessionScope.hp}">
						</c:if>
						<button class="btn btn-dark" onclick="fn_number_recevier()">인증
							번호 받기</button>
						<c:if test="${sessionScope.message ne null }">
							<div><%=session.getAttribute("message")%></div>
							<!--인증아래 나오는 메세지  -->
						</c:if>
					</div>
					<div id="div_authNumber_id">
						<span></span><span id="auth_input_id"><input type="text"
							class="form-control" id="auth_confirm_id"
							placeholder="인증번호">
							<button onclick="fn_number_confirm()" class="btn btn-dark"
								id="auth_confirm_button">인증 하기</button></span>
					</div>
					<div id="div_submit_id">
						<button type="button" id="submit_button_id"
							class="btn btn-dark">제출</button>
						<!--인증완료시 제출 버튼생성  -->
					</div>
				</div>
			</div>
		</c:if>
	</c:if>

	<!--Pass  -->
	<c:if test="${memRole eq 'normal'}">
		<c:if test="${category eq 'passFind' }">
			<style type="text/css">
#div_hpNumber_id {
	margin-top: 30px;
}
</style>
			<div class="div_container">
					<img id="login_backgorund"src="${pageContext.request.contextPath}/design/img/login_backgoround.jpg" >
<div id="login_opacity"></div>
				<div id=logo_image>
					<a href="${pageContext.request.contextPath}"><img
						src="${pageContext.request.contextPath}/design/img/findyou_logo.png"
						width="100px" height="100px"></a>
				</div>
				<div id="div_title">일반회원 비밀번호 찾기</div>
				<div class="div_content">회원정보에 등록한 휴대전화로 인증</div>
				<div id="div_number_box_pass"
					class="card text-white bg-primary mb-3">
					<div class="card-header">비밀번호 찾기</div>
					<c:if test="${sessionScope.hp eq null&& sessionScope.Id eq null }">
						<div id="div_idInput">
							<input type='text' id="id_input_bar" class="form-control" placeholder="아이디">
						</div>
						<div id="div_hpNumber">
							<input id="hp_number" type="tel" name="Hp" placeholder="핸드폰" class="form-control">
							<button id="hp_reciver" class="btn btn-dark"
								onclick="fn_number_recevier()">인증 번호 받기</button>
							<c:if test="${sessionScope.message ne null }">
								<div><%=session.getAttribute("message")%></div>
							</c:if>
						</div>
					</c:if>
					<c:if test="${sessionScope.hp ne null&& sessionScope.Id ne null }">
						<div id="div_idInput">
							<input type='text' id="id_input_bar" placeholder="아이디" class="form-control"
								value="${sessionScope.Id }">
						</div>
						<div id="div_hpNumber">
							<input id="hp_number" type="tel" value="${sessionScope.hp }"
								placeholder="휴대폰" name="Hp" class="form-control">
							<button id="hp_reciver" class="btn btn-dark"
								onclick="fn_number_recevier()">인증 번호 받기</button>
						</div>
					</c:if>
					<div id="div_authNumber">
						<span></span><span id="auth_input"><input id="auth_confirm"
							placeholder="인증번호" type="text" class="form-control">
							<button class="btn btn-dark " id="auth_button"
								onclick="fn_number_confirm()">인증 하기</button></span>
					</div>
					<div>
						<div id="div_submit">
						<button type="button" id="submit_button" class="btn btn-dark"
							>제출</button>
							</div>
					</div>
				</div>
			</div>
		</c:if>
	</c:if>
	<c:if test="${memRole eq 'business'}">
		<c:if test="${category eq 'passFind' }">
			<div class="div_container">
					<img id="login_backgorund"src="${pageContext.request.contextPath}/design/img/login_backgoround.jpg" >
<div id="login_opacity"></div>
				<div id=logo_image>
					<a href="${pageContext.request.contextPath}"><img
						src="${pageContext.request.contextPath}/design/img/findyou_logo.png"
						width="100px" height="100px"></a>
				</div>
				<div id="div_title">사업자회원 비밀번호 찾기</div>
				<div class="div_content">회원정보에 등록한 휴대전화로 인증</div>
				<div id="div_number_box_pass"
					class="card text-white bg-primary mb-3">
							<div class="card-header">비밀번호 찾기</div>
					<c:if test="${sessionScope.hp eq null&& sessionScope.Id eq null }">
						<div id="div_idInput">
							<input type='text' id="id_input_bar" class="form-control" placeholder="아이디" class="form-control">
						</div>
						<div id="div_hpNumber">
							<input id="hp_number" type="tel" name="Hp" class="form-control" placeholder="핸드폰" class="form-control">
							<button id="hp_reciver" class="btn btn-dark"
								onclick="fn_number_recevier()">인증 번호 받기</button>
							<c:if test="${sessionScope.message ne null }">
								<div><%=session.getAttribute("message")%></div>
							</c:if>
						</div>
					</c:if>
					<c:if test="${sessionScope.hp ne null&& sessionScope.Id ne null }">
						<div id="div_idInput">
							<input type='text' id="id_input_bar"  placeholder="아이디" class="form-control"
								value="${sessionScope.Id }">
						</div>
						<div id="div_hpNumber">
							<input id="hp_number" type="tel" value="${sessionScope.hp }" class="form-control"
								placeholder="휴대폰" name="Hp">
							<button id="hp_reciver" class="btn btn-dark"
								onclick="fn_number_recevier()">인증 번호 받기</button>
						</div>
					</c:if>
					<div id="div_authNumber">
						<span></span><span id="auth_input"><input id="auth_confirm"
							placeholder="인증번호" type="text" class="form-control" >
							<button class="btn btn-dark " id="auth_button"
								onclick="fn_number_confirm()">인증 하기</button></span>
					</div>
					<div>
							<div id="div_submit">
						<button type="button" id="submit_button" class="btn btn-dark"
							>제출</button>
							</div>
					</div>
				</div>
			</div>
		</c:if>
	</c:if>
	<c:if test="${category eq 'idFind' }">
			
<div id="modal_id_background" class="modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content" id="modal_id_container">
      <div class="modal-header">
        <h5 class="modal-title">아이디 찾기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="fn_modal_close()" aria-label="Close">
          <span aria-hidden="true"></span>
        </button>
      </div>

      <div class="modal-body">
       	<div>
					<span id="modal_id"></span>
				</div>
      </div>
      <div class="modal-footer">
      	<button id="check" class="btn btn-primary" onclick="fn_modal_login_move()">Login</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="fn_modal_close()">Close</button>
      </div>
   
    </div>
  </div>
</div>
		
		
		
		
	</c:if>


	
			
	
				
				
			
		
	


	<c:if test="${category eq 'passFind' }">
<div id="modal_pass_background" class="modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content" id="modal_pass_container">
      <div class="modal-header">
        <h5 class="modal-title">비밀번호 변경</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="fn_modal_close()" aria-label="Close">
          <span aria-hidden="true"></span>
        </button>
      </div>
    			
      <div class="modal-body">
       	
       	<input id="hidden_hp"type="hidden" name="memHp" value="${sessionScope.hp}">
					<div>
						변경 비밀번호 <input name="memPass" id="pass" type="password">
					</div>
					<div>
						비밀번호 확인<input id="pass_check" type="password">
					</div>
      </div>
      <div class="modal-footer">
      	<button id="check" class="btn btn-primary" onclick="fn_check()">Save changes</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="fn_modal_close()">Close</button>
      </div>
     
    </div>
  </div>
</div>

	</c:if>







</body>
<script type="text/javascript">
	$(document).ready(function() {

		$("#modal_id_background").hide();
		$("#modal_pass_background").hide();

	});
	let check = "ch";
	
	function fn_modal_login_move(){
		location.href='login.wow?memRole=normal';
		return;
	}
	
	function fn_number_recevier(e) {
		 if('<%=request.getAttribute("category")%>' == 'passFind'){
			 alert("ddd");
		var Role = "<c:out value='${memRole}'/>";
		var Id = $("#id_input_bar").val();
		 var Hp = $("#hp_number").val();
		
		 }
		 else{
			 alert("dd")
			 var Role = "<c:out value='${memRole}'/>";
			var Id = $("#id_input_bar_id").val();
			var	 Hp = $("#hp_number_id").val();
			
		 }
		$.ajax({
			url : "infoFind.wow",
			type : "POST",
			data : {
				"Id" : Id,
				"Hp" : Hp,
				"memRole" : Role
			}, //파라미터
			success : function(data) {
				if (<%=session.getAttribute("re_check")%>== null) {
					location.reload();
				}
			},
			error : function(err) {
			alert(err);
			}
		});
	}

	//세션 삭제를 위해 만듬 
	//세션이 생성 새로고침 이후 적용 하며 다른페이지,새로고침시 세션을 삭제
 	if (<%=session.getAttribute("re_check")%>	!= null) {
		window.onbeforeunload = function(e) {
			if (e != null && e != undefined) {
				$.ajax({
					url : "removeSession.wow",
					type : "POST",
					success : function() {
						location.reload();
					},
					error : function(err) {

						alert(err);
					}
				});
			}
		};
	}

	let count = 1;
	function fn_modal_close() {
		$("#modal_id_background").hide();
		$("#modal_pass_background").hide();
	}
	function fn_number_confirm() {
		
	
		 if('<%=request.getAttribute("category")%>' =='passFind'){
			 
		var auth = $("#auth_confirm").val();
		 }
		 else{
			var auth = $("#auth_confirm_id").val();
		 }
		
		$.ajax({
					url : "confirm.wow",
					type : "POST",
					data : {
						"Auth" : auth,
						"Count" : count
					}, //파라미터
					success : function(data,sussce) {
						alert(sussce);
					
						if(sussce !=null){
							$("#hp_number").text('${sessionScope.hp}');
							$("#auth_confirm").text(
									'${sessionScope.auth_reconfirm}');
							$("#submit_button").show();
							let str = "";
							 if('<%=request.getAttribute("category")%>' =='passFind'){
								str += "<button type='button' id='submit_button'class='btn btn-dark'	onclick='fn_modify_modal()'>제출</button>";
							 }
							 else{
								str += "<button type='button' id='submit_button_id'	class='btn btn-dark'	onclick='fn_modify_modal()'>제출</button>";
						    	}
							 if('<%=request.getAttribute("category")%>' =='passFind'){
								
								 $("#div_submit *").remove();
								$("#div_submit").append(str);
							 }else{
								 $("#div_submit_id *").remove();
									$("#div_submit_id").append(str);						 
							 }
							$("#modal_id").text(' 현재 아이디는 ${sessionScope.Id}입니다. 로그인 창으로 돌아가시기 바랍니다. ');
							alert("인증이 완료되었습니다.");
						}
						},
					error : function(err) {
						alert("인증키 입력이 " + count + "회 잘못되었습니다.");
						if (count == 5) {
							alert("5회 실패 하였습니다. 홈 화면으로 이동합니다.");
							let url = '/findYou/'
							location.replace(url);
							count = 0;

						}
						count += 1;
					}
				});
	}

	function fn_modify_modal() {
		$("#modal_pass_background").show();
		$("#modal_id_background").show();
	}

	function fn_check() {

		let pass = $("#pass").val();
		let hidden_hp =$("#hidden_hp").val();
		let pass_check = $("#pass_check").val();
		if (pass == pass_check) {
			$.ajax({
				url : "loginModify.wow",
				type : "POST",
				data :{ "memPass" : pass,
						"memHp":hidden_hp},
				success : function() {
					location.href='login.wow?memRole=normal'; 
				},
				error : function() {
			
				}
			});
			
		} else {
			alert("체크 실패");
		}
	}
	

</script>
</html>