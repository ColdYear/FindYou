<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/joinStep1.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/bootstrap/bootstrap.css">
<meta charset="UTF-8">
<title>회원가입 STEP1</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/top.jsp" %>

<div class="div_container ">
<img id="login_backgorund"src="${pageContext.request.contextPath}/design/img/login_backgoround.jpg" >
<div id="login_opacity"></div>
	<div class="div_container_01">

		<div class="div_joinstep_top">
			<div class="div_joinstep_top_text">
				<h2>회원가입 유형 선택하기</h2>
			</div>
		</div>
		<div class="div_joinstep">
		
				<div class="div_joinstep_1 btn btn-success">
					<div class="div_joinstep_normal ">
					<h3>일반회원</h3>
					 <a><img src="${pageContext.request.contextPath}/design/img/child-solid.svg" width="300px" height="250px" onclick="location.href='<%=request.getContextPath()%>/join/joinStep2.wow?memRole=normal'"></a>
					
					</div>
				</div>
				<div class="div_joinstep_2 btn btn-success">
					<div class="div_joinstep_business">
					<h3>사업자회원</h3>
					 <a><img src="${pageContext.request.contextPath}/design/img/user-tie-solid.svg" width="300px" height="250px" onclick="location.href='<%=request.getContextPath()%>/join/joinStep2.wow?memRole=business'"></a>
					</div>
				</div>
		
		</div>
	</div>
</div>
</body>
</html>