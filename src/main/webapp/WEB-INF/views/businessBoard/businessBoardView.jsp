<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>

<%request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/businessBoardView.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/bootstrap/bootstrap.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="backgroundColor">
<%@ include file="/WEB-INF/views/common/top.jsp" %>
<%-- ${replyList } --%>
  
	<div class="div_container">
		
	        <div class="div_board_title">
	            <p>${getBoard.b2bBoardTitle}</p>
	        </div>
	        <div class="div_add_line">
		        <div class="div_board_img">
		        		<div class="div_attach_image">
								<c:forEach items="${attachList}" var="attachList" varStatus="st">        	
									<img id="atch_img_${st.count}"  src="${pageContext.request.contextPath}/images/business/${attachList}" width="795px" height="602px"> 
	        				</c:forEach>
						</div>
						<button type="button" id="btn_prev">&lt;</button>
	       			<button type="button" id="btn_next">&gt;</button>
		            <div class="div_user_info">
		            		<c:if test="${fn:contains(getMember.memGender, '남')}">
			      			   	  <img src="${pageContext.request.contextPath}/design/img/man.png" width="50x" height="50px">
			      			</c:if> 	
			      			<c:if test="${fn:contains(getMember.memGender, '여')}">
			      			   	  <img src="${pageContext.request.contextPath}/design/img/woman.png" width="50x" height="50px">
			      			</c:if>   
			              <span>&nbsp;&nbsp;&nbsp;&nbsp;${getBoard.b2bCompanyName}&nbsp;&nbsp;&nbsp;&nbsp;</span>
		            </div>
		        </div>
		        <div class="div_board_write_content">
		        	<div class="div_content">
		         	<table class="div_content_table01">
		                <tr>
		                    <td class="div_content_table_td"><b>장소</b> : ${getBoard.b2bBoardRoadAddress} </td>
		                </tr>
		                <tr>
		                    <td class="div_content_table_td"><b>기간</b> : ${getBoard.b2bBoardDate} / ${getBoard.b2bBoardHour}  시</td>
		                </tr>
		                <tr>
		                    <td class="div_content_table_td" id="div_content_table_td_count"><b>모집인원</b> : <span>${count}</span>명 / ${getBoard.b2bBoardDeadlineNumber} 명</td>
		                </tr>
		            </table>
		            <table class="div_content_table02">
		                <tr>
		                    <td class="div_content_table02_td1"><strong>상세내용</strong></td>
		                </tr>
		                <!--  소개글 상세내용-->
	
		         	</table>
		             <div class="div_button">
		             	<c:if test='${sessionScope.user.userId eq getBoard.b2bBoardWriter}'>
			                <a class="card-rink" onclick="location.href='businessBoardEdit.wow?b2bBoardIndex=${getBoard.b2bBoardIndex}'">수정하기</a>&nbsp;&nbsp;   
			                <a class="card-rink board_delete">삭제하기</a>&nbsp;&nbsp;
		               	</c:if>
		                <a class="card-rink" onclick="location.href='businessBoardList.wow?'">목록</a>
		            </div>
		        	</div>
		        </div>
		     </div>
		        
		        
	        <div class="div_join_button">
	        	<c:if test='${sessionScope.user.userId ne getBoard.b2bBoardWriter}'>
		   	      <button id="attend_button">참여하기</button><button id="attend_cancle_button">취소하기</button>
	          </c:if> 
		          <button id="attend_list_button">참여목록</button>
	        </div>
		</div>
	        
	        <div class="line">
	        </div>
	        <!-- 댓글 -->
	        <!--  -->
	        <div class="div_board_reply">
				<ul>
					<li>
					<form action="<c:url value='/reply/replyRegist' />" id="b2bReply" name="reply" method="post" onclick="return false;">
						<div id="div_reply_input">
							<input type="hidden" name="reParentNo" value="${getBoard.b2bBoardIndex}">
	                   <input type="hidden" name="reMemId" value='${sessionScope.user.userId}'>
	                   <input type="hidden" name="reCategory" value="business">
							<input type="text" id="reContent" name="reContent" class="input_reply form-control form-control-lg" placeholder="댓글을 입력해주세요." style="max-width:500px;">
							<input type="submit" id="input_reply_button" class="input_reply_button btn btn-primary" value="등록">
						</div>
					</form>	
					</li>
		<!--댓글 리스트  -->
					<li class="reply_content">
						<input type="hidden" name="reNo" value="'+ element.reNo +'">
						<span class="reply_content_id"><strong>아이디</strong></span><br>
						<span class="reply_content_content">댓글내용</span><br>
						<span class="reply_content_date">댓글작성날</span><br>
						<input type="button" class="button_update btn btn-primary" value="수정"><input type="button" class="button_delete btn btn-primary" value="삭제"><br>
						<span class="reply_content_line"></span>
	             </li>
	    <!--댓글 리스트  -->
				</ul>
	        </div>
	 
	        <!-- 참여인원 목록 -->
			<div id="div_modal"  class="toast show" role="alert" aria-live="assertive" aria-atomic="true" style="max-width: 400px; max-height: 500px; background-color: gainsboro;">
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
	
	        <!-- 회원 

 -->
		<div id="div_member_view_container">
			<!-- <div class="div_member_info_view" id="div_member_info_view"> -->
				<div class="div_member_info_view_table">
				  <div class="div_header">
				   
				  </div>
					<table id="div_content_table">
						
					</table>
				</div>
			<!-- </div> -->
		</div>
	
		
		<div class="div_modal_send modal">
		<!-- 쪽지보내기 -->
		</div>
</div>		 
</body>
<script>


$(".board_delete").on('click', function(){
	//글 삭제시 묻기
	if(confirm("글을 삭제하시겠습니까?")){
		//삭제 확인 -> 삭제
		location.href="businessBoardDelete.wow?b2bBoardIndex=${getBoard.b2bBoardIndex}";
	}else{
		//삭제 취소 -> 리스트로 이동
		location.href="businessBoardList.wow";
	}
});


$("#btn_prev").click(function(){
	page = "prev";
	find_num(page);
});

$("#btn_next").click(function(){
	page = "next";
	find_num(page);
});	
var cur_no = 0;
var next_no = 1;
var cur_size = ${attachList.size()};

function find_num(page){
	if(cur_size == 1){
		return;
	}
    console.log("page::::"+page);
    
    //2차-2 방향처리(2차-3)
    if(page == "next"){
        //2차-8 5->1페이지일떄 분기 처리(All-e)
        if(cur_no==0 && next_no == cur_size){
            cur_no= cur_size;
            next_no= 1;
        }else{

            if(cur_no == cur_size){
                cur_no =1;
            }else{
                //2차-7 prev -> next 일때 처리 두 변수 값이 동일함
                    //따라서 같지 않은경우에만 값을 증가시키기(2차-8)
                //cur_no++
                if(cur_no != next_no){
                    cur_no++;
                }
            }
            next_no = cur_no +1;
            if(next_no == (cur_size+1)){
                next_no =1;
            }
            
        }
        next_img(cur_no, next_no);

    }else{
        //2차-3 초기화면에서 prve 클릭(2차-4)
        /*
        if(cur_no == 0 && next_no ==1 ){
            cur_no = 1;
            next_no = 5;
        }else{
        } 
        */

        //2차-6 롤링(2차-7)
        if(cur_no == 0 && next_no ==1 ){
            cur_no = 1;
            next_no = cur_size;
            
        }else{
            //nxt_no가 현재페이지 이므로
            cur_no = next_no;
            next_no = cur_no -1;
            if (next_no == 0 ){
                next_no = cur_size;
            }
        }

        //2차-4 prve 함수 호출 및 cur_no-- (2차-5)
        prev_img(cur_no, next_no);
        cur_no--;
    }
}

function next_img(cur_no, next_no){
    console.log("cur_no:::"+cur_no+", next_no:::"+next_no);
    $(".div_attach_image img:nth-child("+next_no+")").show();
    $(".div_attach_image img:nth-child("+cur_no+")").hide();
}

//2차-5 prev 함수실행(2차-6)
function prev_img(cur_no, next_no){
    console.log("cur_no:::"+cur_no+", next_no:::"+next_no);
    $(".div_attach_image img:nth-child("+next_no+")").show();
    $(".div_attach_image img:nth-child("+cur_no+")").hide();
}

//글 상세내용 가져오기
$(document).ready(function(){

	//쪽지보내기 창 숨기기
	$(".div_modal_send").hide();
	
	
	//사진감추기
	$atch_length = ${attachList.size()};
	for(var i=1; i<=$atch_length; i++){
		$("#atch_img_"+(i+1)).hide();
	}
	
	 fn_reply_list();
	fn_cancle_yn();
	$('#div_member_view_container').hide();
	fn_part_count();
	fn_people_same(); 
	
	var b2bBoardIndex= '${getBoard.b2bBoardIndex}';
	var Index = {"b2bBoardIndex":b2bBoardIndex};
	$.ajax({
		url : "<c:url value='/businessBoard/b2bContent.wow'/>"
		,type : "post"
		,dataType : 'json'
		,data : Index 
		 ,success : function(map){
			var text = map.b2bContent
			var content = text.replaceAll('\r\n' , "<br>");
			var str="";
 			str += '<tr>';
 			str += '<td class="div_content_table02_td2"><div class="div_content_box">'+content+'</div></td>;'
 			str += '</tr>';
			$('.div_content_table02').append(str);
		}
		, 
		error : function(){
			alert("통신오류");
		}
	});
});



//참여인원수 0이면 참여목록 안보이게.
function fn_part_count(){
	var partCount = $('#div_content_table_td_count').children('span').text();
	if(partCount == 0){
		$('#attend_list_button').hide();
	}
	if(partCount > 0){
		$('#attend_list_button').show();
	}
}


var params = {"reCategory":"business", "reParentNo":${getBoard.b2bBoardIndex} };
//댓글 리스트
function fn_reply_list(){
/* 	alert(JSON.stringify(params )); */
	$.ajax({
		url : "<c:url value='/reply/replyList'/>"
		,type : "post"
		,dataType : 'JSON'
		,data : params
		,success : function(map){
			$(".reply_content").html('');
			if(map.result){
			var str="";
				
			$.each(map.data, function(i, elt){
				str += '<li class="reply_content">'
				str += '<input type="hidden" name="reNo" value="'+ elt.reNo +'">'
				str += '<span class="reply_content_id"><strong>'+elt.reMemId+'</strong></span><br>'
				str += '<span class="reply_content_content">'+elt.reContent+'</span><br>'
				str += '<span class="reply_content_date">'+elt.reRegDate+'</span><br>'
					// 로그인한 아이디랑 댓글 쓴 아이디랑 비교해서 
					if('${sessionScope.user.userId}'==elt.reMemId){
					str += '<input type="button" class="button_update btn btn-primary" value="수정"><input type="button" class="button_delete btn btn-primary" value="삭제"><br>'
					}
				str += '<span class="reply_content_line"></span>'
				str += '</li>'
				});
				$(".reply_content").append(str);
				$('.button_modify').hide();
			}
		}
	});
}
//댓글 수정 > input생 / 수정하기
$(document).on("click", '.button_update', function(){
	
	var $update_button = $(this);
	var $li = $update_button.parent();
	var $delete_button = $li.find('.button_delete');
	var reContent = $li.find('.reply_content_content').html();
	$(this).remove();
	$delete_button.remove();
	
	$li.find('.reply_content_content').remove();
	$li.find('.reply_content_id').append('<span class="reply_content_content"><input class="form-control form-control-lg" type="text" name="reContent" value="'+ reContent +'"></span>');
	$li.find('.reply_content_content').append('<div><input type="button" class="button_save btn btn-primary" value="저장"></div>');

	$('.button_save').on('click', function(e){
		//수정된 댓글 내용
		var reContent = $(this).parent().siblings('input').val();
		var reNo = $(this).parent().parent().parent().siblings('input').val();
		//댓글/번호/게시글번호/아이디
		var modifyReply={"reContent":reContent, "reNo": reNo}
		$.ajax({
			url : "<c:url value='/reply/replyModify' />"
			,type : "post"
			,dataType : "JSON"
			,data : modifyReply 
			,success : function(map){
				fn_reply_list();
			}
		});
	});
	
});
//등록
$('#input_reply_button').on('click',function(e){
	e.preventDefault();
	if(confirm("댓글을 등록하시겠습니까?")){
		$.ajax({
			url : "<c:url value='/reply/replyRegist'/>"
			,type : "post"
			,dataType : "JSON"
			,data :  $('#b2bReply').serialize()//b2bReContent b2bReParentNo b2bReMemId
			,success : function(map){
				fn_reply_list();
				//댓글 창 안에 값 다시 없애기
				$('.input_reply').val('');
			}
		});
	}
});

//댓글 삭제하기
$(document).on("click", '.button_delete', function(e){
	if(confirm("댓글을 삭제하시겠습니까?")){
		var reNo = $(this).siblings('input[name="reNo"]').val();
		var b2bReNo = {"reNo":reNo}
		$.ajax({
			url : "<c:url value='/reply/replyDelete'/>"
			,type : "post"
			,dataType : "JSON"
			,data : b2bReNo
			,success : function(map){
				fn_reply_list();
			}
		});
		
	
	}
});




//참여여부 -> 참여/취소버튼 
function fn_cancle_yn(){
	//처음 화면 뜰 때 id값이랑 참석여부(Y) 비교해서 참석한 회원이면 취소하기 버튼 나오고 참석하지 않았으면 참여하기 버튼 나오게

	var b2bRole = ('${sessionScope.user.userRole}');

	var b2bPartId = ('${sessionScope.user.userId}');
	var b2bPartBoardNumber = ('${getBoard.b2bBoardIndex}');
	var partIdNum={"b2bPartId":b2bPartId, "b2bPartBoardNumber":b2bPartBoardNumber};
	$.ajax({
		url: "<c:url value='/b2bParticipation/b2bCancleYn.wow'/>"
		,type: "post"
		,dataType: "json"
		,data: partIdNum
		/* ,asyns: false */
		,success: function(map){
			 console.log(map.data);
			 
				 if(map.data=="N"){
						$('#attend_button').hide();
						$('#attend_cancle_button').show();
						
						//모집인원 == 참여인원 같으면 참석, 취소버튼 안보이게
						fn_people_same();
						
				 }if(map.data=="Y"){
					$('#attend_cancle_button').hide();
					 $('#attend_button').show();
					 
					//모집인원 == 참여인원 같으면 참석, 취소버튼 안보이게
					fn_people_same();
				 }
				 if(b2bRole == "business"){
					 //권한이 사업자면 참여하기, 취소하기 버튼 안보이게
					$('#attend_cancle_button').hide();
					 $('#attend_button').hide();
				 }
				 
				//참여인원 수에 따라 참여목록버튼 
				fn_part_count();
	 
		}
	});
}


//참여인원 = 모집인원 수 같으면 참여하기 / 취소하기 버튼 안보이게
function fn_people_same(){
	//현재 참여인원
	var partCount = $('#div_content_table_td_count').children('span').text();
	//모집인원
	var deadLine = ${getBoard.b2bBoardDeadlineNumber};
	if(partCount == deadLine){
		$('#attend_button').hide();
	/* 	$('#attend_cancle_button').hide(); */
	}
	
}

//참여하기 버튼 누르기
 $('#attend_button').click(function(){
	 
	 if(confirm("참여하시겠습니까?")){
	//아이디 
	var b2bPartId = ('${sessionScope.user.userId}');
	//게시글 번호 
	var b2bPartBoardNumber = ('${getBoard.b2bBoardIndex}');
	
	var b2bIdNumber = {"b2bPartId":b2bPartId, "b2bPartBoardNumber":b2bPartBoardNumber}


		$.ajax({
			url : "<c:url value='/b2bParticipation/b2bParticipationAddr.wow'/>"
			,type : "post"
			,dataType : "JSON"
			,data : b2bIdNumber
			,success : function(map){
				var count = map.data;
				console.log(count);
				
				//소개글 내용 줄바꿈
				var text = map.b2bContent
				var content = text.replaceAll('\r\n' , "<br>");
				
				var str="";
					if(map.result){

			        str += '<table class="div_content_table01">'
			        str += '<tr>'
			        str += '<td class="div_content_table_td"><b>장소</b> : ${getBoard.b2bBoardRoadAddress} </td>'
			        str += '</tr>'
			        str += '<tr>'
			        str += '<td class="div_content_table_td"><b>기간</b> : ${getBoard.b2bBoardDate} / ${getBoard.b2bBoardHour} 시</td>'
			        str += '</tr>'
			        str += '<tr>'
			        str += '<td class="div_content_table_td" id="div_content_table_td_count"><b>모집인원</b> : <span>'+count+'</span>명 / ${getBoard.b2bBoardDeadlineNumber}명</td>'
			        str += '</tr>'
			        str += '</table>'
			        str += '<table class="div_content_table02">'
			        str += '<tr>'
			        str += '<td class="div_content_table02_td1">상세내용</td>'
			        str += '</tr>'
			        str += '<tr>'
			        str += '<td class="div_content_table02_td2"><div class="div_content_box">'+content+'</div></td>'
			        str += '</tr>'
			        str += '</table>'
			        str +=  "<div class='div_button'>"
				     str += "<c:if test='${sessionScope.user.userId eq getBoard.b2bBoardWriter}'>"
			        str +=  "<a class='card-rink' onclick='location.href=businessBoardEdit.wow?b2bBoardIndex=${getBoard.b2bBoardIndex}'>수정하기</a>&nbsp;&nbsp;"   
			        str +=  "<a class='card-rink' onclick='location.href=businessBoardDelete.wow?b2bBoardIndex=${getBoard.b2bBoardIndex}'>삭제하기</a>&nbsp;&nbsp;"
				     str += "</c:if>"
		 	        str +=  "<a class='card-rink' onclick='location.href=businessBoardList.wow?'>목록</a>" 
			        str +=  "</div>"
						}
					$('.div_content').html(str);
					fn_cancle_yn();
					
					//참여인원 수에 따라 참여목록버튼 
					fn_part_count();
				}
		});
	 }
}); 


//참여 취소하기 버튼 누를때
$('#attend_cancle_button').click(function(){
	
	 if(confirm("취소하시겠습니까?")){

	var b2bPartId = ('${sessionScope.user.userId}');
	var b2bPartBoardNumber = ('${getBoard.b2bBoardIndex}');
	var b2bIdNumber = {"b2bPartId":b2bPartId, "b2bPartBoardNumber":b2bPartBoardNumber}
	
		$.ajax({
			url : "<c:url value='/b2bParticipation/b2bParticipationAddr.wow'/>"
			,type : "post"
			,dataType : "JSON"
			,data : b2bIdNumber
			,success : function(map){
				$('#attend_cancle_button').hide();
				$('#attend_button').show();
				var count = map.data;
	
				//소개글 내용 줄바꿈
				var text = map.b2bContent
				var content = text.replaceAll('\r\n' , "<br>");
				
					var str="";
					var str="";
					if(map.result){
			        str += '<table class="div_content_table01">'
			        str += '<tr>'
			        str += '<td class="div_content_table_td"><b>장소</b> : ${getBoard.b2bBoardRoadAddress} </td>'
			        str += '</tr>'
			        str += '<tr>'
			        str += '<td class="div_content_table_td"><b>기간</b> : ${getBoard.b2bBoardDate} / ${getBoard.b2bBoardHour}   시</td>'
			        str += '</tr>'
			        str += '<tr>'
			        str += '<td class="div_content_table_td" id="div_content_table_td_count"><b>모집인원</b> : <span>'+count+'</span>명 / ${getBoard.b2bBoardDeadlineNumber}명</td>'
			        str += '</tr>'
			        str += '</table>'
			        str += '<table class="div_content_table02">'
			        str += '<tr>'
			        str += '<td class="div_content_table02_td1">상세내용</td>'
			        str += '</tr>'
			        str += '<tr>'
			        str += '<td class="div_content_table02_td2"><div class="div_content_box">'+content+'</div></td>'
			        str += '</tr>'
			        str += '</table>'
			        str +=  "<div class='div_button'>"
					 str += "<c:if test='${sessionScope.user.userId eq getBoard.b2bBoardWriter}'>"
					 str +=  "<a class='card-rink' onclick='location.href=businessBoardEdit.wow?b2bBoardIndex=${getBoard.b2bBoardIndex}'>수정하기</a>&nbsp;&nbsp;"   
					 
					 str +=  "<a class='card-rink' onclick='location.href=businessBoardDelete.wow?b2bBoardIndex=${getBoard.b2bBoardIndex}'>삭제하기</a>&nbsp;&nbsp;"
					 str += "</c:if>"
		 	        str +=  "<a class='card-rink' onclick='location.href=businessBoardList.wow?'>목록</a>" 
			        str +=  "</div>"
						}
					$('.div_content').html(str);
				
					//참여인원 수에 따라 참여목록버튼 
					fn_part_count();
					
					fn_cancle_yn();
					}
		});
	 }
});  


//참여목록 누르면 참여목록 나오기 
$(document).on('click', '#attend_list_button', function(){
	

	
	
	var b2bPartBoardNumber = ('${getBoard.b2bBoardIndex}');
	$('#div_modal').show();
	var maskHeight = $(document).height();
	var maskWidth = $(window).width();
	var div = $("#div_modal");
	$("#div_modal").css({'width':maskWidth, 'height':maskHeight});
	$("#div_modal").css('top',Math.max(0, (($(window).height() - div.outerHeight()) / 2) + $(window).scrollTop()) + "px");
	$("#div_modal").css("left", Math.max(0, (($(window).width() - div.outerWidth()) / 2) + $(window).scrollLeft()) + "px");

	
	var b2bPartBoardNumber = ('${getBoard.b2bBoardIndex}');
	var b2bNumber = {"b2bPartBoardNumber":b2bPartBoardNumber}
	$.ajax({
		url : "<c:url value='/b2bParticipation/b2bParticipationList.wow'/>"
		,type : "post"
		,dataType : "JSON"
		,data : b2bNumber
		,success : function(map){
			
			var str="";
			str+='<table style="width:100%">';
			str+='<tr>';
			str+='<td>';
			str+='<b>아이디</b>';
			str+='</td>';
			str+='<td>';
			str+='<b>이름</b>';
			str+='</td>';
			str+='<td>';
			str+='</td>';
			str+='</tr>';
				$.each(map.data, function(i, element){
					str+='<tr>';
					str+='<td id="find_id">';
					str+='<div class="div_join_view"><span>'+element.b2bPartId +'</span>';
					str+='</td>';
					str+='<td>';
					str+='<span>'+element.b2bPartName +'</span>';
					str+='</td>';
					str+='<td>';
					str+='<button class="member_info_button btn btn-info" style="position:relative; left:40px; margin-right:10px">상세보기</button></div>';
					str+='</td>';
					str+='</tr>';
				});
				str+='</table>';
			$(".toast-body").html(str);
		}	
	});		
});	

//상세보기 누르면 회원 상세보기 나오기
$(document).on('click', '.member_info_button', function(){
	

	$td = $(this).closest('td');
	$findId = $td.prev().prev();

	//상세보기에 해당하는 회원 아이디 찾기
	var b2bPartId =  $findId.text();
	var b2bPartBoardNumber = '${getBoard.b2bBoardIndex}';
	var memIdBoardNumber = {"b2bPartId":b2bPartId, "b2bPartBoardNumber":b2bPartBoardNumber};
	

	$.ajax({
		url : "<c:url value='/b2bParticipation/b2bParticipationMember.wow' />"
		,type : "post"
		,dataType : "JSON"
		,data : memIdBoardNumber
		,success : function(map){

			console.log(map.title);
			console.log(map.getName);
			console.log(map.gender);
			var str="";

			/* map.participationId; (쪽지 받는 사람 아이디) */
			
			str += '<tr>';
				str += '<td class="tr_text" colspan="2" width="400px" height="30px"><h4>회원 상세보기</h4><button class="member_close_button btn-info" >x</button>'
				str += '</td>';
			str += '</tr>';
			
			str += '<tr>';
				str += '<td class="tr_td_row_img" rowspan="2"><img src="${pageContext.request.contextPath}/design/img/'+map.gender+'" width="50%" height="100px"></td>';
				str += '<td class="tr_td_name_score" width="50%">&nbsp;이름:&nbsp;'+ map.getName +'</td>';
			str += '</tr>';
			str += '<tr>';
				str += '<td class="tr_td_name_score" width="200px">&nbsp;평점:&nbsp;'+map.score+'</td>';
			str += '</tr>';
			str += '<tr>';
				str += '<td class="tr_text_list" colspan="2" width="400px" height="30px">최근 활동내역(10개)</td>';
			str += '</tr>';
			
				$.each(map.title, function(i, element){
					str += '<tr>';
						str += '<td class="tr_td_title" colspan="2" width="400px" height="30px"> - '+ element+'</td>';
					str += '</tr>';
				});
				for (var i = 0; i < 10-map.length; i++) {
					str += '<tr>';
						str += '<td class="tr_td_title" colspan="2" width="400px" height="30px"></td>';
					str += '</tr>';
				}

			str += '<tr>';
				str += '<td colspan="2">';
				str += '<input type="button" value="쪽지보내기" class="send_button btn-info">';
				str += '</td>';
			str += '</tr>';

			$('#div_content_table').html(str);  
			
			$('#div_member_view_container').show();
			
			var maskHeight = $(document).height();
			var maskWidth = $(window).width();
			var div = $(".div_member_info_view_table");
			$(".div_member_info_view_table").css({'width':maskWidth, 'height':maskHeight});
			$(".div_member_info_view_table").css('top',Math.max(0, (($(window).height() - div.outerHeight()) / 2) + $(window).scrollTop()) + "px");
			$(".div_member_info_view_table").css("left", Math.max(0, (($(window).width() - div.outerWidth()) / 2) + $(window).scrollLeft()) + "px");

			
			//회원 상세보기에서 쪽지보내기 클릭
			$(document).on('click', '.send_button', function(){
				var str="";

				str +=  "<div class='modal-dialog' role='document'>";
				str +=    "<div class='modal-content'>";
				str +=      "<div class='modal-header'>";
				str +=        "<h5 class='modal-title'>쪽지보내기</h5>";
				str +=        "<button type='button' id='send-btn-close' class='btn-close' data-bs-dismiss='modal' aria-label='Close'>";
				str +=          "<span aria-hidden='true'></span>";
				str +=        "</button>";
				str +=      "</div>";
				str +=      "<div class='modal-body'>";
				str +=      	  '<input type="hidden" name="msgReceiver" class="msgReceiver" value='+map.participationId+'>';
				str +=      	  '<input type="hidden" name="msgSender" class="msgSender" value="${sessionScope.user.userId}">';
				/* str +=        '<input type="text" name="msgContent" class="msgContent" value="">'; */
				str +=        '<textarea name="msgContent" class="msgContent form-control"></textarea>';
				str +=      "</div>";
				str +=      "<div class='modal-footer'>";
				str +=        "<button type='button' class='btn btn-primary' id='message_send_button'>보내기</button>";
				str +=      "</div>";
				str +=    "</div>";
				str +=  "</div>";
				
				$(".div_modal_send").html(str);
				$(".div_modal_send").show();
				
				//쪽지 보내기
				$(document).on('click', '#message_send_button', function(){
					var msgReceiver = map.participationId;
					var msgSender = '${sessionScope.user.userId}';
					var msgContent= $("textarea[name='msgContent']").val();

					if(msgReceiver == msgSender){
						alert("자기 자신에게는 쪽지를 전송할 수 없습니다.");
					}else{

					var message={"msgReceiver":msgReceiver, "msgSender":msgSender, "msgContent":msgContent};
					$.ajax({
						url : "<c:url value='/businessBoard/businessBoardMessageSend.wow' />"
						,type : "post"
						,data : message
						,success : function(){
						alert("쪽지가 성공적으로 보내졌습니다.");
						$(".div_modal_send").hide();
						}
						,error : function(){
						alert("실패");
						}
					});
					}
				});
				
			});
		}
	});	
});			



//쪽지보내기 창 x버튼 닫기
$(document).on('click', '#send-btn-close', function(){
	$(".div_modal_send").hide();
});





//참여목록 x클릭 참여 목록 사라지기
$(document).on('click', '#list_close_button', function(){
	$('#div_modal').hide();
	$('#div_member_info_view').hide();
});

//상세보기 x클릭 상세보기 사라지기
$(document).on('click', '.member_close_button', function(){
	$('#div_member_view_container').hide();
});



</script>

</html>