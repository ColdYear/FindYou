<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<%request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/noticeBoardEdit.css">
<link href="<%= request.getContextPath()%>/design/bootstrap/bootstrap.css" rel="stylesheet" style="text/css">
<link href="<%= request.getContextPath()%>/design/bootstrap/bootstrap.min.css" rel="stylesheet" style="text/css">
<meta charset="UTF-8">
<title>공지사항</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/top.jsp" %>


<div class="div_notice_text">
        <h1 class="title_main"></h1>
        <a><img src="${pageContext.request.contextPath}/design/img/noticebanner.png" width="80%" height="300px"></a>
    </div>

<form id="editPass" action="<%= request.getContextPath() %>/noticeBoard/noticeBoardModify.wow" method="post">
<div class="total_box">

<div class="text_box" style="width:100%; height:100%;">


<div class="notice_title" id="noticeBoardTitle" style="max-width:800px !important">
<input type="hidden" name="noticeBoardIndex" value="${notice.noticeBoardIndex }">
<input class="form-control" type="text" class="boardTitle" name="noticeBoardTitle" id="noticeBoardTitle" value="${notice.noticeBoardTitle}">
</div>
<div class="notice_content" id="noticeBoardContent">
<textarea class="form-control" name="noticeBoardContent" id="noticeBoardContent">${notice.noticeBoardContent}</textarea>
</div>
</div>

</div>



<div class="total_button">
<button type="button" class="btn btn-danger cancel_button" onclick="location.href='<%=request.getContextPath()%>/managerBoard/noticeBoardList.wow?userRole=${user.userRole}'">취소</button><button type="submit" class="btn btn-danger edit_button">확인</button>
</div>
</form>
</body>
</html>