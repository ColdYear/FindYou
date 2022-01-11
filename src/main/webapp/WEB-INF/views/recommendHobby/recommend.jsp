<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/common/top.jsp" %>
<link href="<%=request.getContextPath() %>/design/css/top.css" rel="stylesheet" style="text/css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/recommend.css">
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
<title>취미 선택</title>

</head>
<body>
<div class="div_container">
<div id=logo_image>
<a href="<%=request.getContextPath()%>"><img src="${pageContext.request.contextPath}/design/img/a0066.jpg" width="100px" height="100px"></a>
</div>

<div><button onclick="location='recommendSelect.wow'">취미 추천 방식1(조건)</button>
<button onclick="location='recommendSelect.wow'">취미 추천방식2(Ai) 추후 업데이트 예정</button></div>

</div>
</body>
</html>