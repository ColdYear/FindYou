<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<%request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/noticeBoardView.css">
<link href="<%= request.getContextPath()%>/design/bootstrap/bootstrap.css" rel="stylesheet" style="text/css">
<link href="<%= request.getContextPath()%>/design/bootstrap/bootstrap.min.css" rel="stylesheet" style="text/css">
<meta charset="UTF-8">
<title>공지사항</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/top.jsp" %>

<div class="div_container">
<div class="div_notice_text">
        <h1 class="title_main"></h1>
        <a><img src="${pageContext.request.contextPath}/design/img/noticebanner.png" width="80%" height="300px"></a>
    </div>

<div class="total_button">
<c:if test="${user.userRole =='manager' }">

<button class="btn btn-danger delete_button" onclick="fn_delete()">삭제</button>
<button class="btn btn-danger regist_button" onclick="location.href='<%=request.getContextPath()%>/managerBoard/noticeBoardEdit.wow?noticeBoardIndex=${notice.noticeBoardIndex }'">수정</button>
</c:if>
</div>
<input type="hidden" name="noticeBoardIndex" value="${notice.noticeBoardIndex }">

<div class="total_box">

<div class="text_title">제목</div>
<div class="text_content">내용</div>
<div class="text_box" style="width:100%; height:100%; overflow:auto">


<div class="form-control notice_title" id="noticeBoardTitle" style="max-width:800px !important">
${notice.noticeBoardTitle }
</div>

<div class="form-control notice_content" id="noticeBoardContent">
</div>
</div>

</div>




</div>
</body>

<script type="text/javascript">
function fn_delete(){

			if(confirm("삭제하시겠습니까?")){
				alert("삭제완료");
			
			location.href="<%=request.getContextPath()%>/noticeBoard/noticeBoardDelete.wow?noticeBoardIndex=${notice.noticeBoardIndex }";
		
			}else{
				alert("취소하셨습니다.");
			}
		}


$(document).ready(function(){
	$.ajax({
		url:"<c:url value='/notice/noticeContent'/>",
		type:'post',
		data:{'noticeBoardIndex':'${notice.noticeBoardIndex}'},
		dataType:'text',
		success:function(text){
			text = text.replaceAll('\r\n', '<br>');
			$('#noticeBoardContent').html(text);
		},
		error:function(){
			alert("통신실패");
		}
	});
});	


</script>
</html>