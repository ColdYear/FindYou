<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<% request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/businessBoardForm.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/bootstrap/bootstrap.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/top.jsp" %>
	<div class="div_title">
		<h1>
			사업자 게시판 등록
		</h1>
	</div>
	
<div class="div_container">
<form action="businessBoardRegist.wow" method="post" enctype="multipart/form-data">

        <input type="hidden" name="b2bBoardWriter" value="${sessionScope.user.userId}">
		<table>
			<colgroup>
				<col width="25%">
				<col width="75%">
			</colgroup>
			<tbody>
				<tr>
					<td>
						제목
					</td>
					<td>
						<input type="text" name="b2bBoardTitle" class="form-control form-control-lg" placeholder="모임 제목">
					</td>
				</tr>
				<tr>
					<td>
						첨부파일 <button class="btn btn-primary" type="button" id="attach_insert">추가</button>
					</td>
					<td class="file_area">
						<div class="div_file_area">
							<input type="file" name="boFiles" id="formFile" class="form-control">
							<button class="btn btn-primary" type="button" id="attach_delete">삭제</button>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						카테고리
					</td>
					<td>
					<div class="div_select">	
            			<c:if test="${b2bBoardTemplate eq 'DC00'}">	
	    	            	<select name="b2bBoardCategory" class="form-select">
	       	           	 <c:forEach items="${codeList}" var="code">
	           	        	 <option value="${code.commCd}">${code.commNm}</option>
	              	    	 </c:forEach>
	               		</select>
             			 </c:if>
             			<c:if test="${b2bBoardTemplate eq 'CB00' }">
 			              <select name="b2bBoardCategory" class="form-select">
	                  	  	<c:forEach items="${codeList}" var="code">
	                    		<option value="${code.commCd}">${code.commNm}</option>
	                    		</c:forEach>
	                		</select>
             			</c:if>
             	<input type="hidden" name="b2bBoardTemplate" value="${b2bBoardTemplate}">
          </div>
					</td>
				</tr>
				<tr>
					<td>
						모집인원
					</td>
					<td>
					<div class="div_select">
					<select name="b2bBoardDeadlineNumber" class="form-select">
						<option value="">모집인원(본인포함)</option>
                    <c:forEach begin="1" end="10" var="i">
                        <option value="${i}">${i}</option>
                    </c:forEach>
                </select>
                </div>
					</td>
				</tr>
				<tr>
					<td>
						장소
					</td>
					<td>
						<div class="div_zip">
							<input type="text" id="sample4_postcode" name="b2bBoardZip" class="form-control form-control-lg" style="max-width:300px;" placeholder="우편번호">
							<button class="btn btn-danger" onclick="sample4_execDaumPostcode()" type="button">우편번호 찾기</button>
						</div>
							<input id="sample4_roadAddress" class="form-control form-control-lg" type="text" name="b2bBoardRoadAddress" style="max-width:500px;" placeholder="도로명주소">
							<input type="text" name="b2bBoardDetailedAddr" class="form-control form-control-lg" style="max-width:500px;" placeholder="상세주소">
					</td>
				</tr>
				<tr>
					<td>
						시간
					</td>
					<td>
						<div class="div_date_content">날짜	<input type="date" name="b2bBoardDate" class="form-control form-control-lg" style="max-width:300px;"></div>
						<div class="div_date_content">시간
						<select name="b2bBoardHour" class="form-select" style="max-width:300px;">
						<option value="">시간을 선택하세요.</option>
	                    <c:forEach begin="0" end="24" var="i">
	                        <option value="${i}">${i}시</option>
	                    </c:forEach>
                		</select>
                		</div>
					</td>
				</tr>
				<tr>
						<td>
							비용
						</td>
						<td>
							<input type="text" name="b2bBoardCost" class="form-control form-control-lg" placeholder="비용 혹은 예상비용">
						</td>
				</tr>
				<tr>
						<td>
							소개글
						</td>
						<td>
							<textarea class="form-control text_content" id="exampleTextarea" name="b2bBoardContent" placeholder="모임 상세 소개글"></textarea>
						</td>
				</tr>
			</tbody>
		</table>
		<button class="btn btn-lg btn-primary div_btn" type="submit">등록</button>
		<button class="btn btn-lg btn-primary div_btn" type="button" onclick="location.href='businessBoardList.wow'">취소</button>
 </form>  
</div>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	$("#attach_insert").click(function(){
		$(".file_area").append('<div class="div_file_area">'
									+ '<input type="file" name="boFiles" id="formFile" class="form-control">'
									+ '<button class="btn btn-primary" type="button" id="attach_delete">삭제</button>'
									+ '</div>');
	});
	
	$(document).on("click", "#attach_delete", function(){
		$(this).closest('div').remove();
	});

	
	 function sample4_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수

	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample4_postcode').value = data.zonecode;
	                document.getElementById("sample4_roadAddress").value = roadAddr;
	                

	            }
	        }).open();
	    }
	 

	

</script>
</html>