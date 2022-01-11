<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<% request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/normalBoardForm.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/bootstrap/bootstrap.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/top.jsp" %>
	<div class="div_title" style="margin-top:100px !important;">
		<h1>
			모임 게시판 등록
		</h1>
	</div>
	
<div class="div_container">
<form:form action="normalBoardRegist.wow" method="post" modelAttribute="normalBoardVO" enctype="multipart/form-data">
	<input type="hidden" name="normalBoardTemplate" value="${normalBoardTemplate}">
	<c:if test="${empty normalBoardTemplate}">	
		<input type="hidden" name="normalBoardTemplate" value="${normalBoardVO.normalBoardTemplate}">
	</c:if>
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
						<form:input path="normalBoardTitle" class="form-control form-control-lg" placeholder="모임 제목"/>
						<span class="span_error"><form:errors path="normalBoardTitle"/></span>
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
						<c:if test="${normalBoardTemplate eq 'HB00' || normalBoardVO.normalBoardTemplate eq 'HB00'}">
							<form:select path="normalBoardCategory" class="form-select">
								<form:options items="${hobbyList}" itemLabel="commNm" itemValue="commCd"/>
							</form:select>
						</c:if>
						
						<c:if test="${normalBoardTemplate eq 'CB00' || normalBoardVO.normalBoardTemplate eq 'CB00'}">
							<form:select path="normalBoardCategory" class="form-select">
								<form:options items="${clubList}" itemLabel="commNm" itemValue="commCd"/>
							</form:select>
						</c:if>
							
						<c:if test="${normalBoardTemplate eq 'FD00' || normalBoardVO.normalBoardTemplate eq 'FD00'}">
							<form:select path="normalBoardCategory" class="form-select">
								<form:options items="${foodList}" itemLabel="commNm" itemValue="commCd"/>
							</form:select>
						</c:if>
						<span class="span_error"><form:errors path="normalBoardCategory"/></span>
                	</div>
					</td>
				</tr>
				 <tr>
					<td>
						모집인원
					</td>
					<td>
					<div class="div_select">
					<form:select path="normalBoardDeadlineNumber" class="form-select">
							<form:option value="">모집인원(본인포함)을 선택하세요</form:option>
							<c:forEach begin="0" end="10" var="i">
								<form:option value="${i}">${i}</form:option>
							</c:forEach>
					</form:select>
					<span class="span_error"><form:errors path="normalBoardDeadlineNumber"/></span>
                </div>
					</td>
				</tr> 
			 	<tr>
					<td>
						장소
					</td>
					<td>
						<div class="div_zip">
							<form:input path="normalBoardZip" id="sample4_postcode" class="form-control form-control-lg" placeholder="우편번호"/>
							<button class="btn btn-danger" onclick="sample4_execDaumPostcode()" type="button">우편번호 찾기</button>
						</div>
							<form:input path="normalBoardRoadAddress" id="sample4_roadAddress" class="form-control form-control-lg" style="max-width:500px;" placeholder="도로명주소"/>
							<span class="span_error"><form:errors path="normalBoardRoadAddress"/></span>
							<form:input path="normalBoardDetailedAddr" class="form-control form-control-lg" style="max-width:500px;" placeholder="상세주소"/>
							<span class="span_error"><form:errors path="normalBoardDetailedAddr"/></span>
					</td>
				</tr>
				<tr>
					<td>
						시간
					</td>
					<td>
						<div class="div_date_content">날짜
							
							<input type="date" name="normalBoardDate" class="form-control form-control-lg" value="${normalBoardVO.normalBoardDate}">
							<span class="span_error"><form:errors path="normalBoardDate"/></span>
						</div>
						<div class="div_date_content">시간
						<form:select path="normalBoardHour" class="form-select" style="max-width:300px;">
						<form:option value="">시간을 선택하세요</form:option>
						<c:forEach begin="0" end="24" var="i">
							<form:option value="${i}">${i}시</form:option>
						</c:forEach>
						</form:select>
						<span class="span_error"><form:errors path="normalBoardHour"/></span>
                		</div>
					</td>
				</tr>
				<c:if test="${normalBoardTemplate eq 'FD00' }">
					<tr>
						<td>
							음식
						</td>
						<td>
							<form:input path="normalBoardFood" class="form-control form-control-lg" placeholder="음식이름을 적어주세요"/>
							<span class="span_error"><form:errors path="normalBoardFood"/></span>
						</td>
					</tr>
				</c:if>
				<tr>
						<td>
							비용
						</td>
						<td>
							<form:input path="normalBoardCost" class="form-control form-control-lg" placeholder="비용 혹은 예상비용"/>
							<span class="span_error"><form:errors path="normalBoardCost"/></span>
						</td>
				</tr>
				<tr>
						<td>
							소개글
						</td>
						<td>
							<form:textarea path="normalBoardContent" class="form-control" id="exampleTextarea" placeholder="모임 상세 소개글" style="width:496px !important;"/>
							<span class="span_error"><form:errors path="normalBoardContent"/></span>
						</td>
				</tr>
			</tbody>
		</table>
		<button class="btn btn-lg btn-primary div_btn" type="submit">등록</button>
		<button class="btn btn-lg btn-primary div_btn" type="button" onclick="location.href='normalBoardList.wow'">취소</button>
</form:form>

</div>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f614523cd5dababea1d0a27b38ee9d9a&libraries=services"></script>
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
					
	            	  Promise.resolve(data).then(o => {
	                      const { address } = data;

	                      return new Promise((resolve, reject) => {
	                          const geocoder = new daum.maps.services.Geocoder();

	                          geocoder.addressSearch(address, (result, status) =>{
	                              if(status === daum.maps.services.Status.OK){
	                                  const { x, y } = result[0];
	                                 	console.log(result[0]);
	                                  	
	                                   var roadAddr = data.roadAddress; // 도로명 주소 변수

						                // 우편번호와 주소 정보를 해당 필드에 넣는다.
						                $("#sample4_postcode").val(data.zonecode);
						                $("#sample4_roadAddress").val(roadAddr);
	                                  	
										  resolve({ lat: y, lon: x })


							           
	                              }else{
	                                  reject();
	                              }
	                          });
	                      })
	                  }).then(result => {
	                      // 위, 경도 결과 값
	                      console.log(result);
	                  });

	                 
					
	            } //oncomplete
	        }).open();
	    }
	 
	

</script>
</html>