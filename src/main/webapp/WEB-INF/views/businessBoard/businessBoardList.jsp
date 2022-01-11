<!DOCTYPE html>
<html>
<head>
<% request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<% request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath()%>/design/css/businessBoardList.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/bootstrap/bootstrap.css">
<link >
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/top.jsp" %>
<%-- ${businessBoardList} --%>
<div class="div_container">
	<div class="div_title">
		
	</div>
	<div class="div_body">
		<form action="businessBoardList.wow" name="businessBoardSearch" method="post" id="main_form">
		<div class="div_search">
            <div class="div_search_border">
            	<div class="form-group">
     		  <select name="businessBoardSearchType" class="form-select">
            	  <option value="TOTAL">전체</option>
                <option value="DC00" ${searchVO.businessBoardSearchType eq "DC00" ? "selected='selected'" : "" }>일일체험</option>
                <option value="CB00" ${searchVO.businessBoardSearchType eq "CB00" ? "selected='selected'" : "" } >봉사</option>
                
            </select>
          	</div>	
          		<div class="form-group">          		
	            	<div class="input-group mb-3 form-floating">            	
	            		<input class="form-control" type="text" name="businessBoardSearchWord" id="floatingInput" value="${searchVO.businessBoardSearchWord}">
	            		<label for="floatingInput">검색어를 입력하세요</label>
		            	<button class="btn btn-primary" type="submit" id="search_button">검색</button>
	            	</div>
          		</div>
            </div>
		</div>
		
		<div class="div_content">
			<div class="div_category_order">
				<h1>
					<c:if test="${searchVO.businessBoardSearchType == 'DC00'}">일일체험 카테고리</c:if>
					<c:if test="${searchVO.businessBoardSearchType == 'CB00'}">봉사 카테고리</c:if>
					<c:if test="${searchVO.businessBoardSearchCategory == 'b2bBoardHit'}">조회순</c:if>
					<c:if test="${searchVO.businessBoardSearchCategory == 'b2bBoardRegDate'}">최신순</c:if>
				</h1> 
				<div class="form-group">
                <select name="businessBoardSearchCategory" class="form-select" id="select_order">
                    <option value="b2bBoardRegDate" ${searchVO.businessBoardSearchCategory eq "b2bBoardRegDate" ? "selected='selected'" : "" }>최신순</option>
                    <option value="b2bBoardHit" ${searchVO.businessBoardSearchCategory eq "b2bBoardHit" ? "selected='selected'" : "" }>조회순</option>
                </select>
                </div>
                
               <button id="b2b_regist_button" formaction="businessBoardTemplate.wow" class="btn btn-danger">글 등록</button>
			</div>
			
 			<div class="div_list">
				<c:if test="${businessBoardList.size() eq 0}">
					해당 목록은 존재하지 않습니다.
				</c:if>
				<c:if test="${businessBoardList.size() ne 0 }">
				
				<c:forEach begin="0"  end="${businessBoardList.size()-1}" var="i">
					<input name="input_index" type="hidden" value="${businessBoardList.get(i).b2bBoardIndex}">
 					<div class="div_list_content">
 						<div class="div_list_header" style="background-color:${businessBoardList.get(i).b2bColor} !important;">
 							${businessBoardList.get(i).b2bBoardTitle}
 						</div>
                        <div class="div_list_content_img">
                        		<img src="<%=request.getContextPath()%>/images/business/${attach.get(i).atchFileName}" width="300px" height="300px">
                        </div>
                        <div class="div_list_content_write" style="background-color:${businessBoardList.get(i).b2bColor} !important;">
                            <ul>
                               	<li>상호명 : ${businessBoardList.get(i).b2bCompanyName }</li>
                                <li>조회수 : ${businessBoardList.get(i).b2bBoardHit}</li>
                                <li>등록일 : ${businessBoardList.get(i).b2bBoardRegDate}</li>
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
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>

<script type="text/javascript">

//사업자만 글등록 보이게 
$(document).ready(function(){
	$('#b2b_regist_button').hide();
	var sessionRole = '${sessionScope.user.userRole}';
	var business = 'business';
	if(sessionRole == business){
		$('#b2b_regist_button').show();
	}
});






/* let searchType = "CB00" ;
let searchWord = "봉사"; */
let businessBoardSearchType = $('select[name=businessBoardSearchType]');
let businessBoardSearchWord = $('input[name=businessBoardSearchWord]');
	
//게시물 클릭할 때 
$(".div_list_content").click(function(){
	var sessionId = '${sessionScope.user.userId}';
	//로그인 안되있으면 로그인 페이지로 이동.
	if(sessionId == ""){
		alert("로그인 후 이용 가능합니다.");
		return;
	}else{
	//로그인 되었을 때 해당 게시물로 이동
		$val = $(this).prev().val();
		location.href='businessBoardView.wow?b2bBoardIndex='+ $val;
		$.ajax({
			url:'<c:url value="/businessBoard/increseBusinessBoardHit.wow"/>',
			type:'post',
			data:{'b2bBoardIndex':$val}
		});
	}
});

//글등록 눌렀을때
$('#b2b_regist_button').on('click', function(e){
	e.preventDefault();
	var sessionId = '${sessionScope.user.userId}';
	
	//로그인 안되있으면 로그인 페이지로 이동.
	if(sessionId == ""){
		alert("로그인 후 이용 가능합니다.");
		location.href="../login/login.wow?memRole=normal";
	}else{
	//로그인 되어있으면 템플릿 선택
		location.href="../businessBoard/businessBoardTemplate.wow"

	}
	
});
	
	
	
	$("select[name=b2bBoardOrderType]").change(function(){
		$("#main_form").submit();
	});
	
	
	$(document).on("click", "#search_button", function(){
		//검색버튼을 눌렀을 때
		$("#main_form").submit();
		searchType = $('select[name=businessBoardSearchType]').val();
		searchWord = $('input[name=businessBoardSearchWord]').val();

	});
	
	
	$("input[name=b2bBoardSearchWord]").focus(function(){
		$(this).val('');
	});
	
	
	//select 값이 바뀌면 조회나 최신순으로
	$("select[name=businessBoardSearchCategory]").change(function(){
/* 		$('input[name=businessBoardSearchWord]').val(searchWord);
		$('select[name=businessBoardSearchType]').val(searchType); */
		$("#main_form").submit();


	});
	
	
	
</script>

</html>
