<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<% request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath()%>/design/css/normalBoardList.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/bootstrap/bootstrap.css">
<link >
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/top.jsp" %>
<div class="div_container">
	<div class="div_title">
		<h1 class="text-success"> </h1>
	</div>
	<div class="div_body">
		<form action="normalBoardList.wow" method="post" id="main_form">
		<div class="div_search">
            <div class="div_search_border">
            	<div class="form-group">
     		  <select name="normalBoardSearchType" class="form-select">
            	  <option value="TOTAL">전체</option>
                <option value="HOBBY" ${normalBoardSearchVO.normalBoardSearchType eq "HOBBY" ? "selected":"" }>취미</option>
                <option value="FOOD" ${normalBoardSearchVO.normalBoardSearchType eq "FOOD" ? "selected":"" }>식사모임</option>
                <option value="CLUB" ${normalBoardSearchVO.normalBoardSearchType eq "CLUB" ? "selected":"" }>봉사</option>
            </select>
          	</div>	
          		<div class="form-group">          		
	            	<div class="input-group mb-3 form-floating">            	
	            		<input class="form-control" type="text" name="normalBoardSearchWord" id="floatingInput" value="${normalBoardSearchVO.normalBoardSearchWord }">
	            		<label for="floatingInput">검색어를 입력하세요</label>
		            	<button class="btn btn-primary" type="button" id="search_button">검색</button>
	            	</div>
          		</div>
            </div>
		</div>
		
		<div class="div_content">
			<div class="div_category_order">
				<h1>
					<c:if test="${normalBoardSearchVO.normalBoardSearchType == 'HOBBY'}">취미 카테고리</c:if>
					<c:if test="${normalBoardSearchVO.normalBoardSearchType == 'FOOD'}">식사모임 카테고리</c:if>
					<c:if test="${normalBoardSearchVO.normalBoardSearchType == 'CLUB'}">봉사 카테고리</c:if>
					<c:if test="${normalBoardSearchVO.normalBoardOrderType == 'HIT'}">조회순</c:if>
					<c:if test="${normalBoardSearchVO.normalBoardOrderType == 'DAY'}">최신순</c:if>
					<c:if test="${normalBoardSearchVO.normalBoardOrderType == 'SCORE'}">평점순</c:if>
				</h1>
				<div class="form-group">
                <select name="normalBoardOrderType" class="form-select" id="select_order">
                    <option value="HIT" ${normalBoardSearchVO.normalBoardOrderType eq "HIT" ? "selected":"" }>조회순</option>
                    <option value="DAY" ${normalBoardSearchVO.normalBoardOrderType eq "DAY" ? "selected":"" }>최신순</option>
                    <option value="SCORE" ${normalBoardSearchVO.normalBoardOrderType eq "SCORE" ?"selected":"" }>평점순</option>
                </select>
                </div>
               <c:if test="${sessionScope.user.userRole eq 'normal'}">
              	 <button formaction="normalBoardTemplate.wow" class="btn btn-danger">글 등록</button>
               </c:if>
			</div>
			
			<div class="div_list">
				<c:if test="${normalList.size() eq 0}">
					해당 목록은 존재하지 않습니다.
				</c:if>
				<c:if test="${normalList.size() ne 0 }">
				
				<c:forEach begin="0"  end="${normalList.size()-1}" var="i">
					<input name="input_index" type="hidden" value="${normalList.get(i).normalBoardIndex}">
 					<div class="div_list_content">
 						<div class="div_list_header" style="background-color:${normalList.get(i).normalBoardColor}">
 							${normalList.get(i).normalBoardTitle}
 						</div>
                        <div class="div_list_content_img">
                        		<img src="<%=request.getContextPath()%>/images/normal/${attachList.get(i).atchFileName}" width="300px" height="300px">
                        </div>
                        <div class="div_list_content_write" style="background-color:${normalList.get(i).normalBoardColor}">
                            <ul>
                               	<li>작성자 : ${normalList.get(i).normalBoardWriter }</li>
                                <li>조회수 : ${normalList.get(i).normalBoardHit}</li>
                                <li>등록일 : ${normalList.get(i).normalBoardRegDate}</li>
                            </ul>
                        </div>
                  </div>
                 
				</c:forEach>
				</c:if>
			</div>
			
		</div>
		</form>
	</div>
</div>	
</body>

<script type="text/javascript">
	$(".div_list_content").click(function(){
		$val = $(this).prev().val();
		
		let id = '${sessionScope.user.userId}';
		
		if(id == "" || id == "null" || id == null || id == "undefined"){
			alert("로그인 후 이용가능합니다.");
			return;
		} 
		
		location.href='normalBoardView.wow?normalBoardIndex='+ $val;
		
		$.ajax({
			url:'<c:url value="/normalBoard/increaseNormalBoardHit" />',
			type:'post',
			data:{'normalBoardIndex':$val}
		});
	});
	
	$("select[name=normalBoardOrderType]").change(function(){
		$("#main_form").submit();
	});
	
	
	$(document).on("click", "#search_button", function(){
		$("#main_form").submit();
	});
	
	
	$("input[name=normalBoardSearchWord]").focus(function(){
		$(this).val('');
	});
</script>

</html>
















