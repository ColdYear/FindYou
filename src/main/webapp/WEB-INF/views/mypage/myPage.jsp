<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%request.setCharacterEncoding("utf-8"); %>

<meta charset="UTF-8">
<link href="<%= request.getContextPath()%>/design/bootstrap/bootstrap.css" rel="stylesheet" style="text/css">
<link href="<%= request.getContextPath()%>/design/bootstrap/bootstrap.min.css" rel="stylesheet" style="text/css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/myPage.css">

<title>마이페이지</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/top.jsp"%>
<div id="div_background">
<button class="btn btn-danger" id="close_background">닫기</button>
</div>
	<c:if test="${user.userName ==null}">
		<div class="alert alert-warning">해당 멤버를 찾을 수 없습니다</div>
		<a href="memberList.jsp" class="btn btn-default btn-sm"> <span
			class="glyphicon glyphicon-list" aria-hidden="true"></span> &nbsp;목록
		</a>
	</c:if>

	<c:if test="${user.userName !=null }">
		<div id="div_container">

			<div class="total_background" id="total_background">

				<div id="mypage_info">
					<div class="mem_info">


						<div class="my_info_top">
						<div class="blackList" onclick="fn_blackList()">필독 : 주의요망 회원이란?</div>
							<h1 class="titleOfMyPage">개인 정보</h1>
							

						</div>

						<div class="my_info">

							<div class="my_image">
								<img
									src="${pageContext.request.contextPath}/design/img/${gender}.png"
									width="100px" height="100px" align="left">
							</div>
							
							<div class="my_name">
								- 이름 : ${member.memName }<br>
								<button class="btn btn-secondary" id="my_info_revise"
									onclick="location.href='<%=request.getContextPath()%>/mypage/${member.memRole}MyPage.wow'">개인정보
									수정</button>
								- 주소 : ${member.memRoadAddr} ${member.memDetailedAddr}<br>
								- 휴대전화 : ${member.memHp }<br> - 이메일 : ${member.memEmail }<br>
								- 나의 평균 평점 : ${score} <br>
							</div>

							<div class="revise_button">
								<img src="<%=request.getContextPath()%>/design/img/newMessage.png" width="30px" height="30px" id="newMessage">
								<button class="btn btn-secondary" id="list"
									onclick="location.href='<%=request.getContextPath()%>/message/messageList.wow'">
									쪽지함 확인 <br>

								</button>
							</div>
						</div>
					</div>
				</div>
				
				<div id="mypage_played">
					<div class="mem_played">
						<div class="my_played">


							<div class="my_played_top">
								<h2 class="titleOfMyPage">활동 기록</h2>
							</div>
							<div class="my_played_more"></div>


							<div class="my_played_list"
								style="overflow: scroll; width: 100%; height: 475px; padding: 10px;">
								<div id="my_played_list_title">
									<span class="btn btn-dark" id="divTitle_top">제목</span> <span
										id="underline"></span>
								</div>
								<!-- 노말보드에서 작성자 + 타이틀 + -->

								<div class="my_played_list_all">
									<c:if
										test="${titleList.size() eq 0 && participationList.size() eq 0}">
										<span class="divTitle">활동내역이 없습니다.</span>
									</c:if>

									<form action="<%=request.getContextPath()%>/myPage/evaluateYN"
										method="post" id="evaluateYN">
										<input type="hidden" name="memberScoreTester"
											value="${sessionScope.user.userId}">
										<c:if test="${titleList.size() ne 0 }">
											<c:forEach begin="0" end="${titleList.size()-1 }" var="i">
												<span class="divTitle">${titleList.get(i) }</span>

												<button class="btn btn-info buttonplay" id="playlist_button">바로가기</button>
												<span> <c:if test="${gender ne 'criminal'}">
														<button type="button" class="btn btn-danger"
															id="playlist_button2">평가하기</button>
														<br>
													</c:if> <input type="hidden" name="normalBoardNum"
													value="${partList.get(i) }">
												</span>
											</c:forEach>
										</c:if>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="div_make_club">
					<table>
						<colgroup>
							<col width="80%">
							<col>
						</colgroup>
						<tbody>
							
						</tbody>
					</table>
				</div>
			</div>
			
			
			
			
		</div>

	</c:if>
	
	<!-- 내가 만든 모임 리스트 -->
	<c:if test="${normalBoardList.size() ne 0 }">
		<div class="myPage_record_list">
		
			<div class="myPage_record_list01_title">
			<div class="line"></div><span>내가 만든 모임</span>
			</div>
			<div class="myPage_record_list01">
				<div class="div_list" style="overflow: scroll; width: 100%; height: 475px; padding: 10px;">
						<table class="myPage_record_list_table">
							<tr>
									<td class="table_1"><span>제목</span></td>
									<td class="table_2"></td>
									<td class="table_3"></td>
							</tr>
								
								<c:forEach begin="0" end="${normalBoardList.size() -1}" var="i">
							<tr>
									<td class="table_td1"><span class="meeting_title">${normalBoardList.get(i).normalBoardTitle}</span></td>
									<td class="table_td2"><button id="meeting_title_button" class="meeting_title_button btn btn-info" data-index="${normalBoardList.get(i).normalBoardIndex}">바로가기</button></td>
									<td class="table_td3"><button class="meeting_title_list btn btn-warning" data-index="${normalBoardList.get(i).normalBoardIndex}">참여목록</button></td>
							</tr>
								</c:forEach>
						</table>
					</div>
			</div>		
		</div>
	</c:if>
	<!-- 내가 만든 모임 리스트 끝-->
	
	

	
	<div class="modal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">평가하기</h5>
					<button type="button" id="close_button" class="btn-close"
						data-bs-dismiss="modal" aria-label="Close">
						<span aria-hidden="true"></span>
					</button>
				</div>
				<form action="<%=request.getContextPath()%>/myPage/insertScore"
					method="post" id="score_form">
					<input type="hidden" name="memberScoreTester"
						value="${sessionScope.user.userId}">
					<div class="modal-body"></div>
				</form>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="finished_button">평가완료</button>
				</div>
			</div>
		</div>
	</div>
	
	<div id="div_modal"  class="toast show" role="alert" aria-live="assertive" aria-atomic="true" style="max-width: 700px; max-height: 600px; background-color: gainsboro;">
	  <div id="div_blank"></div>
	  <div class="toast-header">
	    <strong class="me-auto">참여인원 목록</strong>
	    <small></small>
	    <button id="list_close_button" type="button" class="btn-close ms-2 mb-1" data-bs-dismiss="toast" aria-label="Close">
	      <span aria-hidden="true"></span>
	    </button>
	  </div>
	  <div class="toast-body">
	    <!-- 참여목록 리스트 -->

	  </div>
	</div>
	


</body>
<script type="text/javascript">

function fn_blackList(){
	$("#div_background").show();
	
}

//활동 내역 전역변수
var boardNumbers = '${partList}';
console.log(boardNumbers);
 $(document).ready(function(){
	 
	 //참여목록 모달창 안보이게.
$('#div_modal').hide();
$('#div_background').hide();	 
	 var $form = $('#evaluateYN');
	 
	$.ajax({
		url:'<c:url value="/myPage/evaluateYN"/>',
		dataType:'json',
		type:'post',
		async:false,
		data:$form.serialize(),
		success:function(map){
			settingNormalPartList(map);
			if(map.checkRead == true){
				$('#newMessage').hide();
			}else{
				$('#newMessage').show();
			}
			
		},
		error:function(){
			alert('통신실패');	
		}
	});
}); 


 
 $(document).on("click", "#close_background", function(){
	 
	$("#div_background").hide();
 });
 


//평가하기 누르기
$(document).on("click", "#playlist_button2", function(){
	var $boardNum = $(this).siblings('input').val();
	$.ajax({
		url:'<c:url value="/myPage/evaluate"/>',
		dataType:'json',
		type:'post',
		data:{"normalBoardNum":$boardNum, "normalBoardId":"${sessionScope.user.userId}"},
		success:function(map){
			var str = '';
			str += '<div class="modal_id">';
			str += '<input type="hidden" name="memberScoreBoardNumber" value="'+ $boardNum +'">';
			$.each(map.list, function(index, element){				
				str += '<div class="div_id_list">';
				str += '<input type="hidden" name="memberScoreId" value='+ element.normalPartId +'>'
				str += '<span class="normalPartId">';
				str += element.normalPartId;
				str += '</span>';
				str += '<span class="normalPartScore">'
				str += '<select class="form-select" name="memberScore" style="max-width:150px !important; width:150px !important">';
				str += '<option value="0">점수 선택</option>';
				for(var i=1; i<=5; i++){					
					str += '<option value = '+ i +'>'+ i +'점</option>';
				}
				str += '</select>';
				str += '</span>'
				str += '</div>';
			});
			str += '</div>';
			$('.modal-body').html(str);
			if(map.length == 0){
				str += '<div id="length_zero">참여한 사람이 존재하지 않습니다.</div>';
				$('.modal-body').html(str);
			}
			$(".modal").show();
			
		},
		error:function(){
			alert('통신실패');
		}
	});
	
	
	
	
	
});

//실제로 평가하기
$(document).on("click", "#finished_button", function(){
	var formData = $("#score_form");
	$.ajax({
		url:"<c:url value='/myPage/insertScore'/>",
		data:formData.serialize(),
		type:"post",
		dataType:"text",
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		success:function(map){
			alert(map);
			$(".modal").hide();
			
			afterEvaluate();
		},
		error:function(){
			alert("통신 오류1");
		}
	});
});


$(document).on("click", "#close_button", function(){
	$(".modal").hide();
});



function afterEvaluate(){
	$.ajax({
		url:"<c:url value='/myPage/evaluateYN'/>",
		data:{"normalBoardNum":boardNumbers, "memberScoreTester":'${sessionScope.user.userId}'},
		type:"post",
		dataType:"json",
		success:function(map){
			settingNormalPartList(map);
		},
		error:function(){
			alert("통신 오류2");
		}
	});
}


//활동내역 세팅
function settingNormalPartList(map){
	//평가하기 버튼 삭제 여부
	titleList = map.titleList;
	partList = map.partList;
	boolList = map.boolList;
	console.log(map.length);
	//만약 이미 평가가 완료되었다면 평가하기 버튼 없애기
	var str = "";
	for(var i=0; i<map.length; i++){
		  str += ' <span class="divTitle">'+ titleList[i] +'</span>';

		  str += ' <span>';
		  str += ' <button class="btn btn-info buttonplay" id="playlist_button">바로가기</button>';
		  
		  if('${gender}' != 'criminal'){			  
			  if(boolList[i] == 'false'){				  
			  	str += ' <button type="button" class="btn btn-danger" id="playlist_button2">평가하기</button><br>';
			  }
		  }
		  str += ' <input type="hidden" name="normalBoardNum" value="'+ partList[i] +'">';
		  str += ' </span>';
	} // for
	
	if(map.length == undefined){
		str = '<div>참여한 활동내역이 없습니다.</div>';
	}
		$('.my_played_list_all').html(str);
}

$(document).on("click", "#playlist_button", function(){
	var boardNum = $(this).siblings('input').val();
	location.href = "/normalBoard/normalBoardView.wow?normalBoardIndex="+boardNum; 
});

//내가 만든 모임 게시글로 이동
$(document).on("click", "#meeting_title_button", function(){
	 var index= $(this).data('index');
	location.href = "/normalBoard/normalBoardView.wow?normalBoardIndex="+index;
});

var normalPartBoardIndex;
var PartBoardIndex;
//참여목록 클릭했을 때 
$(document).on("click", ".meeting_title_list", function(){

	$('#div_modal').show();
	
	//클릭했을 때 화면 정중앙에 뜰 수 있도록 
	var maskHeight = $(document).height();
	var maskWidth = $(window).width();
	var div = $("#div_modal");
	$("#div_modal").css({'width':maskWidth, 'height':maskHeight});
	$("#div_modal").css('top',Math.max(0, (($(window).height() - div.outerHeight()) / 2) + $(window).scrollTop()) + "px");
	$("#div_modal").css("left", Math.max(0, (($(window).width() - div.outerWidth()) / 2) + $(window).scrollLeft()) + "px");
	
	 PartBoardIndex = $(this).data('index');

	normalPartBoardIndex={"normalPartBoardIndex":PartBoardIndex};

	fn_get_list();	
	
});

function fn_get_list(){
	$.ajax({
		url : "<c:url value='/myPage/ParticipationList.wow'/>"
		,type : "post"
		,dataType : "JSON"
		,data : normalPartBoardIndex
		,success : function(map){
			fn_setting(map);
			var str ="<input type='hidden' name='normalPartBoardIndex' value='"+ PartBoardIndex +"'>";
			$('#div_blank').html(str);
		}	
	});		
}


function fn_setting(map){
	var str="";
	str+='<table style="width:100%" class="font_size">';
	str+='<tr>';
	str+='<td>';
	str+='<b></b>';
	str+='</td>';
	str+='<td>';
	str+='<b>아이디</b>';
	str+='</td>';
	str+='<td>';
	str+='<b>이름</b>';
	str+='</td>';
	str+='<td>';
	str+='</td>';
	str+='</tr>';
		$.each(map.partVO, function(i, element){
			str+='<tr>';
			str+='<td>';
			str+='<img src="${pageContext.request.contextPath}/design/img/'+element.gender+'" width="40px" height="40px">';
			str+='</td>';
			str+='<td id="find_id">';
			str+='<div class="div_join_view"><span>'+element.normalPartId +'</span>';
			str+='</td>';
			str+='<td>';
			str+='<span>'+element.normalPartName +'</span>';

			str+='</td>';
			str+='<td>';

			if(map.count == 0){
				str+='<span id="span_blank"></span>';
			}else{
				if(element.gender =="criminal.png"){
					str+='<button class="member_leave_button btn btn-danger" style="position:relative; left:40px; margin-right:10px" data-index="'+element.normalPartBoardNumber+'">내보내기</button></div>';
				}
			}
			str+='</td>';
			str+='</tr>';
		});
		str+='</table>';
	$(".toast-body").html(str);
}

//블랙리스트 내보내기
$(document).on("click", ".member_leave_button", function(){
	
	if(confirm("해당 회원을 내보내시겠습니까?")){
		//블랙리스트 아이디
		var normalPartId = $(this).parent().prev().prev().text();
		//게시글 번호 
		var normalPartBoardNumber = $(this).data('index');
	
	 	var boardNumBlackId = {"normalPartId":normalPartId, "normalPartBoardNumber":normalPartBoardNumber};
		
		$.ajax({
			url : "<c:url value='/myPage/blackOut.wow'/>"
			,type : "post"
			,data : boardNumBlackId
			,success : function(map){
				alert("성공");
				fn_get_list();
			}
		
		});
	}
});



//참여목록 x / 닫기창 누를 때
$('#list_close_button').on('click', function(){
	$('#div_modal').hide();
});




</script>
</html>