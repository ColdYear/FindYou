<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<%request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/businessBoardTemplate.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/bootstrap/bootstrap.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/top.jsp" %>

<form action="businessBoardForm.wow" >
	<input type="hidden" name="b2bBoardTemplate">
</form>

<div class="div_container">
    <div class="div_template_top">
        <div class="div_template_top_text">
            <h2>일일체험 / 봉사 선택</h2>
        </div>
        <div class="div_template_top_list_bt">
        <a href='businessBoardList.wow'" class="card-link">목록</a>
        </div>
    </div>
    <div class="div_template">
        <div class="div_template_1">
            <h3>일일체험</h3>
            <a><img name="DC00" src="${pageContext.request.contextPath}/design/img/onedayclass.png" width="300px" height="300px"></a>
        </div>
        <div class="div_template_2">
            <h3>봉사</h3>
            <a><img name="CB00" src="${pageContext.request.contextPath}/design/img/00221.png" width="300px" height="300px"></a>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
	$('.div_template_1').click(function(){
		var category_name = $('.div_template_1 img').attr('name');
		$("input[name='b2bBoardTemplate']").val(category_name);
		$("form").submit();
	});
	
	$('.div_template_2').click(function(){
		var category_name = $('.div_template_2 img').attr('name');
		$("input[name='b2bBoardTemplate']").val(category_name);
		$("form").submit();
	});
	
</script>
	

</html>