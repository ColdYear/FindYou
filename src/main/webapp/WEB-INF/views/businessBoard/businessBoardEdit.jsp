<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<% request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/businessBoardEdit.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/bootstrap/bootstrap.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/top.jsp" %>
	<div class="div_title">
		<h1>
			사업자 게시판 수정
		</h1>
	</div>

<div class="div_container">
<form action="businessBoardModify.wow" method="post" enctype="multipart/form-data">
		<input type="hidden" name="b2bBoardIndex" value="${getBoard.b2bBoardIndex}"> 
		<input type="hidden" name="b2bBoardTemplate" value="${getBoard.b2bBoardTemplate}">
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
						<input type="text" name="b2bBoardTitle" class="form-control form-control-lg" value="${getBoard.b2bBoardTitle}">
					</td>
				</tr>
				<tr>
					<td>
						첨부파일 <button class="btn btn-primary" type="button" id="attach_insert">추가</button>
					</td>
					<td class="file_area">

							<c:forEach items="${attachVO}" var="attach">
								<input name="file_area_attach_atchNo" type="hidden" value="${attach.atchNo }">
											<div class="file_area_name_button">
												<a> ${attach.atchOriginalName}</a>
												<button class="file_delete_button btn btn-primary botton_position" name="file_delete_button" type="button">삭제</button>
											</div>
										</c:forEach>

		
					</td>
				</tr>
				<tr>
					<td>
						카테고리
					</td>
					<td>
					<div class="div_select">	
            			<c:if test="${getBoard.b2bBoardTemplate eq 'DC00'}">	
	    	            	<select name="b2bBoardCategory" class="form-select">
	       	           	 <c:forEach items="${codeList}" var="code">
	           	        	 <option value="${code.commCd}" ${getBoard.b2bBoardCategory eq code.commCd ? "selected='selected'" : ""}>${code.commNm}</option>
	              	    	 </c:forEach>
	               		</select>
             			 </c:if>
             			<c:if test="${getBoard.b2bBoardTemplate eq 'CB00' }">
 			              <select name="b2bBoardCategory" class="form-select">
	                  	  	<c:forEach items="${codeList}" var="code">
	                    		<option value="${code.commCd}">${code.commNm}</option>
	                    		</c:forEach>
	                		</select>
             			</c:if>
             	
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
                        <option value="${i}" ${getBoard.b2bBoardDeadlineNumber eq i  ? "selected='selected'" : ""}>${i}</option>
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
							<input type="text" id="sample4_postcode" name="b2bBoardZip" value="${getBoard.b2bBoardZip}" class="form-control form-control-lg" style="max-width:300px;" placeholder="우편번호">
							<button class="btn btn-danger" onclick="sample4_execDaumPostcode()" type="button">우편번호 찾기</button>
						</div>
							<input id="sample4_roadAddress" class="form-control form-control-lg" type="text" name="b2bBoardRoadAddress" value="${getBoard.b2bBoardRoadAddress}" style="max-width:500px;" placeholder="도로명주소">
							<input type="text" name="b2bBoardDetailedAddr" value="${getBoard.b2bBoardDetailedAddr}" class="form-control form-control-lg" style="max-width:500px;" placeholder="상세주소">
					</td>
				</tr>
				<tr>
					<td>
						시간
					</td>
					<td>
						<div class="div_date_content">날짜	<input type="date" name="b2bBoardDate" value="${getBoard.b2bBoardDate}"  class="form-control form-control-lg" style="max-width:300px;"></div>
						<div class="div_date_content">시간
							<select name="b2bBoardHour" class="form-select" style="max-width:300px;">
								<option value="">시간을 선택하세요.
			                    <c:forEach begin="0" end="24" var="i">
			                        <option value="${i}" ${getBoard.b2bBoardHour eq i  ? "selected='selected'" : ""}>${i}시</option>
			                    </c:forEach>
			                 </option>
							</select>
                	</div>
					</td>
				</tr>
				<tr>
						<td>
							비용
						</td>
						<td>
							<input type="text" name="b2bBoardCost" value="${getBoard.b2bBoardCost}" class="form-control form-control-lg" >
						</td>
				</tr>
				<tr>
						<td>
							소개글
						</td>
						<td>
							<textarea class="form-control text_content" id="exampleTextarea" name="b2bBoardContent" value="${getBoard.b2bBoardContent}" >${getBoard.b2bBoardContent}</textarea>
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

	//첨부파일 추가 눌렀을 때 
	$("#attach_insert").click(function(){
		$(".file_area").append('<div class="div_file_area">'
									+ '<div><input type="file" name="boFiles" id="formFile" class="form-control"></div>'
									+ '<div><button class="btn btn-primary" type="button" id="attach_delete">삭제</button></div>'
									+ '</div>');
	});
	
	//첨부파일 삭제를 눌렀을 때 
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
	

$('.file_delete_button').on('click', function(){
		 //삭제하고 싶은 파일 이름과 버튼 안보이게하기
		var fileName = $(this).prev();
		fileName.hide();
		$(this).hide();
		var aTag = fileName.parent().html();
		var atchDelNo = $('input[name="file_area_attach_atchNo"]').val();	
		$('.file_area').append('<input type="hidden" name="atchDelNo" value="'+atchDelNo+'">');
});

</script>
</html>