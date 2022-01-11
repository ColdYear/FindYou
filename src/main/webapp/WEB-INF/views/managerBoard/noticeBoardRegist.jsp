<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<%request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/noticeBoardRegist.css">
<link href="<%= request.getContextPath()%>/design/bootstrap/bootstrap.css" rel="stylesheet" style="text/css">
<link href="<%= request.getContextPath()%>/design/bootstrap/bootstrap.min.css" rel="stylesheet" style="text/css">
<meta charset="UTF-8">
<title>공지사항</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/top.jsp"%>

	<form id="noticeBoardRegist"
		action="<%=request.getContextPath()%>/managerBoard/noticeRegistDB.wow"
		method="post">
		<div class="div_container">
			<div class="div_notice_text">
				<h1 class="title_main"></h1>
				<a><img
					src="${pageContext.request.contextPath}/design/img/noticebanner.png"
					width="80%" height="300px"></a>
			</div>
			<div class="total_box">

				<div class="text_box"
					style="width: 100%; height: 100%; overflow: auto">

					<input type="hidden" name="noticeBoardWriter"
						value="${sessionScope.user.userId }"> <input type="text"
						class="form-control notice_title" name="noticeBoardTitle"
						placeholder="제목을 입력해주세요" style="max-width: 800px !important">
					
					<textarea name="noticeBoardContent" placeholder="내용을 입력해주세요" class="form-control notice_content"></textarea> 
				</div>
			</div>



			<div class="total_button">
				<button type="button" class="btn btn-danger cancel_button">취소</button>
				<button type="button" onclick="fn_submit()" class="btn btn-danger regist_button">등록</button>
			</div>
		</div>
	</form>
</body>
<script type="text/javascript">
	$(".cancel_button").click(function(){
		location.href="<%= request.getContextPath() %>/managerBoard/noticeBoardList.wow";
	});
	
	function fn_submit(){
		let content = $('textarea[name=noticeBoardContent]');
		content_val = content.val();
		content_val = content_val.replace('/(\n|\r\n)/g','<br>');
		content.val(content_val);
		$('#noticeBoardRegist').submit();
	}
</script>
</html>