<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/common/top.jsp" %>
<link href="<%= request.getContextPath() %>/design/css/top.css" rel="stylesheet" style="text/css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/loginFind.css">
<link
	href="<%=request.getContextPath()%>/design/bootstrap/bootstrap.css"
	rel="stylesheet" style="text/css">
<link
	href="<%=request.getContextPath()%>/design/bootstrap/bootstrap.min.css"
	rel="stylesheet" style="text/css">
<title>Insert title here</title>
</head>
<body>
<c:if test="${category eq 'idFind' }">
<div class="div_container">
<img id="login_backgorund"src="${pageContext.request.contextPath}/design/img/login_backgoround.jpg" >
<div id="login_opacity"></div>
<div id=div_logo_image>
<a href="${pageContext.request.contextPath}"><img src="${pageContext.request.contextPath}/design/img/findyou_logo.png" width="100px" height="100px"></a>

</div>   
<div class="div_title"> 아이디 찾기 </div>
<div class="div_content"> 회원 유형을 선택 후 인증해주세요.</div>

<div id="div_box">
<!--memRole 노말은 일반 비지니스는 사업자   -->
<div class=" btn btn-primary div_member_box"><button onclick="location.href='infoFind.wow?memRole=normal&&category=idFind' "> <p class="card-text">일반 회원</p></button></div>
<div class="btn btn-primary div_member_box"><button onclick="location.href='infoFind.wow?memRole=business&&category=idFind' "> <p class="card-text">사업자 회원</p></button></div>
</div>
</div>

</c:if>
<c:if test="${category eq 'passFind' }">
<div class="div_container">
<img id="login_backgorund"src="${pageContext.request.contextPath}/design/img/login_backgoround.jpg" >
<div id="login_opacity"></div>
<div id=div_logo_image>
<a href="${pageContext.request.contextPath}"><img src="${pageContext.request.contextPath}/design/img/findyou_logo.png" width="100px" height="100px"></a>
</div>
<div class="div_title"> 비밀번호 찾기 </div>
<div class="div_content"> 회원 유형을 선택 후 인증해주세요.</div>
<div id="div_box">
<!--memRole 노말은 일반 비지니스는 사업자   -->
<div class="btn btn-primary div_member_box"><button onclick="location.href='infoFind.wow?memRole=normal&&category=passFind' ">일반 회원</button></div>
<div class="btn btn-primary div_member_box"><button onclick="location.href='infoFind.wow?memRole=business&&category=passFind' ">사업자 회원</button></div>
</div>
</div>
</c:if>
</body>
</html>