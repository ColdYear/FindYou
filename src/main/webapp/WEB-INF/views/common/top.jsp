<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%request.setCharacterEncoding("utf-8"); %>

<meta charset="UTF-8">
<title>Insert title here</title>


</head>
<%@include file="/WEB-INF/inc/header.jsp"%>
<link rel="stylesheet"
	href="<%= request.getContextPath() %>/design/css/top.css">
<body>



	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
		<div class="container-fluid">
			<div class="div_top_project_name_img">
				<a href="<%=request.getContextPath()%>/">
				<img
					src="${pageContext.request.contextPath}/design/img/findyou_logo.png"
					width="30px" height="30px">
					</a>
			</div>
			<a class="navbar-brand" href="<%=request.getContextPath()%>/">Find You</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarColor01"
				aria-controls="navbarColor01" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarColor01">
				<ul class="navbar-nav me-auto">
					<li class="nav-item"><a class="nav-link active"
						href="<%=request.getContextPath()%>/normalBoard/normalBoardList.wow">일반모임
						
					</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="<%=request.getContextPath()%>/businessBoard/businessBoardList.wow">사업체모임</a>
					</li>
					<li class="nav-item"><a class="nav-link active"
						href="#" onclick="move_find()">주변친구</a>
					</li>
					<li class="nav-item"><a href="#" class="nav-link active" onclick="move_rec()">모임추천</a>
					</li> 
					<li class="nav-item"><a class="nav-link active"
						href="<%=request.getContextPath()%>/managerBoard/noticeBoardList.wow?userRole=${user.userRole}">공지사항</a>
					</li>
					<c:if test="${user eq null }">
						<li class="nav-item"><a class="nav-link active"
							href="<%=request.getContextPath()%>/login/normalLogin.wow">로그인</a>
						</li>
					</c:if>
					<c:if test="${user ne null }">
						<li class="nav-item dropdown">
							<a id="nav_toggle"
							class="nav-link dropdown-toggle active " data-bs-toggle="dropdown"
							onclick="fn_toggle_show()" role="button" aria-haspopup="true"
							aria-expanded="true">${user.userName }</a>
							<div class="dropdown-menu">
								<a class="dropdown-item" href="<%=request.getContextPath()%>/mypage/myPage.wow?userId=${user.userId}">마이페이지</a>
								 <a class="dropdown-item" href="#" id="btn_logout">로그아웃</a>
								
								 	<a class="dropdown-item" href="<%=request.getContextPath()%>/manager/manager.wow">관리자페이지</a>
							</div>
					</li>

					</c:if>
				</ul>
			</div>



		</div>
	</nav>




</body>
<script>
function fn_toggle_show() {
	var toggle = "<a id='nav_toggle' class='nav-link dropdown-toggle show active' data-bs-toggle='dropdown' onclick='fn_toggle_close()' role='button' aria-haspopup='true' aria-expanded='true'>${user.userName }</a>";
	toggle +=" <div class='dropdown-menu show' data-bs-popper='none'>";
	toggle +=	"<a class='dropdown-item' href='<c:url value="/mypage/myPage.wow?userId=${user.userId}"/>'>마이페이지</a>";
    toggle +="<a class='dropdown-item' href='#' id='btn_logout'>로그아웃</a>";
    var role = '${sessionScope.user.userRole}';
    if(role == 'manager'){    	
    	toggle +="<a class='dropdown-item' href='<%=request.getContextPath()%>/manager/manager.wow'>관리자페이지</a>";  
    }
    toggle +="</div>";
	$("#nav_toggle").remove();
	$(".dropdown-menu").remove();
	$(".dropdown-item").remove();
	 $(".dropdown").append(toggle);
}

$(document).on("click", '#btn_logout', function(){
	if(confirm('로그아웃 하시겠습니까?')){
		location.href="<%=request.getContextPath()%>/login/logout.wow";
	}else{
		return;
	}
});


function fn_toggle_close() {
	var toggle = "<a id='nav_toggle' class='nav-link dropdown-toggle active' data-bs-toggle='dropdown' onclick='fn_toggle_show()' role='button' aria-haspopup='true' aria-expanded='true'>${user.userName }</a>";
		$("#nav_toggle").remove();
		$(".dropdown-menu").remove();
		$(".dropdown-item").remove();
		$(".dropdown").append(toggle);
	}
	
	let id = '${sessionScope.user.userId}';
	
	function move_rec(){
		if(id == "" || id == "null" || id == null || id == "undefined"){
			alert("로그인 후 이용가능합니다.");
			return;
		} 
		location.href="<%=request.getContextPath()%>/recommendHobby/recommendSelect.wow";
	}
	
	function move_find(){
		if(id == "" || id == "null" || id == null || id == "undefined"){
			alert("로그인 후 이용가능합니다.");
			return;
		} 
		location.href="<%=request.getContextPath()%>/findFriend/findFriend.wow";
	}
	
</script>
<style type="text/css">
a {
	text-decoration: none
}
</style>


</html>