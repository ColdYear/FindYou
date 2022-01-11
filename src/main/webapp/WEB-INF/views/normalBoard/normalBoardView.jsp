<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="NEWLINE" value="\n"/>
<!DOCTYPE html>
<html>
<head>
<%request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/normalBoardView.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/bootstrap/bootstrap.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/top.jsp" %>
<div id="div_gray"> </div>   
    <div class="div_container">    	
		<div class="div_board_title">
            <h2>${normalBoardVO.normalBoardTitle}</h2>
        </div>
        <div class="div_board_img">
        	<div class="div_attach_image">
        	<c:forEach items="${attachList}" var="attachList" varStatus="st">        	
            	<img id="atch_img_${st.count}" src="<%=request.getContextPath()%>/images/normal/${attachList.atchFileName}" width="800px" height="600px">
        	</c:forEach>

      		</div>
       	<button type="button" id="btn_prev">&lt;</button>
       	<button type="button" id="btn_next">&gt;</button>
      		
          <div class="div_user_info">
        	   <img src="${pageContext.request.contextPath}/design/img/${gender}.png" width="80x" height="80px">
             <span><strong>${normalBoardVO.normalBoardWriter}&nbsp;&nbsp;&nbsp;&nbsp;</strong></span><span>${score}점</span>
          </div>            
        </div>
		<div class="card" style="max-width:50rem;">
			  <div class="card-body">
			  </div>
		</div>
        
        <div class="div_join_button">
          <button id="attend_list_button">참여목록</button>
        </div>
	</div>

        <div class="line">
        </div>
        <!-- 댓글 -->
        <div class="div_board_reply">
			<ul>
				<li>
					<div id="div_reply_input">
						<input type="text" class="input_reply form-control form-control-lg" placeholder="댓글을 입력해주세요." style="max-width:500px;">
						<input type="submit" class="input_reply_button btn btn-primary" value="등록">
					</div>
				</li>
			</ul>
        </div>
    
        
        <!-- 참여인원 목록 -->
			<div class="toast show" role="alert" aria-live="assertive"
				aria-atomic="true" id="div_modal" style="max-width:400px; max-height:500px;">
				<div class="toast-header">
					<strong class="me-auto">참여인원 목록</strong>
					<button type="button" class="btn-close ms-2 mb-1"
					id="list_close_button"
						data-bs-dismiss="toast" aria-label="Close">
						<span aria-hidden="true"></span>
					</button>
				</div>
				<div class="toast-body div_join_body_view">
				
				</div>
			</div>

	<!-- 회원 상세보기 -->
        <div class="div_member_info_view" id="div_member_info_view">
            <div class="div_member_info_view_table">
                <div class="div_member_info_view_table_top">
                    <h3>회원 상세보기</h3><button class="close_button2" id="member_close_button">x</button>
                </div>
                 
                <table id="member_info_view" style="width:100%;">
                </table>
            </div>
        </div>
        <!-- 회원 상세보기 -->
        
        <!-- 쪽지보내기 -->
		<div class="modal">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">쪽지 보내기</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close" id="close">
							<span aria-hidden="true"></span>
						</button>
					</div>
					<div class="modal-body">
						<textarea  class="form-control" id="exampleTextarea" style="width:100% !important; height:100px !important;"></textarea>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="sending">보내기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 쪽지보내기 -->

      </body>
<script>
var page;
$(function(){
	$("#btn_prev").click(function(){
		page = "prev";
		find_num(page);
	});

	$("#btn_next").click(function(){
		page = "next";
		find_num(page);
	});	
	

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

$(document).ready(function(){
	$atch_length = ${attachList.size()};
	for(var i=1; i<=$atch_length; i++){
		$("#atch_img_"+(i+1)).hide();
	}
	
	
	
	/* 로그인한 사람이 현재 게시글에 참여했는지 여부 확인 후, 버튼(참여하기/취소하기)결정 */
	$.ajax({
		url:"<c:url value='/participation/load' />",
		type:"post",
		data:{'normalPartId':'${sessionScope.user.userId}'
			  ,'normalPartBoardNumber':'${normalBoardVO.normalBoardIndex}'},
		dataType:"json",
		success:function(map){
			btnName = map.data;
			idName = map.id;
			
			if('${sessionScope.user.userRole}' != 'business'){				
				$(".div_join_button").prepend('<button id="'+ idName +'">'+ btnName +'</button>');
			}
			
			//참여목록만 보여야 될때
			if('${sessionScope.user.userId}' == '${normalBoardVO.normalBoardWriter}'){
				$(".div_join_button").html('<button id="attend_list_button">참여목록</button>');
			}else if(map.result == false){
				$(".div_join_button").html('<button id="attend_list_button">참여목록</button>');
				//참여자면 보여야함
				if(map.partYN == true){
					$(".div_join_button").html('<button id="'+ idName +'">'+ btnName +'</button>'+'<button id="attend_list_button">참여목록</button>');
				}
			}
			
			
			//참여한 사람이 아무도 없을 때
			//참여하기 버튼만 보이면된다.
			if(map.count == 0 && '${sessionScope.user.userId}' != '${normalBoardVO.normalBoardWriter}'){
				$(".div_join_button").html('<button id="'+ idName +'">'+ btnName +'</button>');
			}
		    
		    var str= `<div id="div_etc_content"><p class="card-text"><strong>장소</strong> : \${map.normalBoard.normalBoardRoadAddress}</p>
		    <p class="card-text"><strong>일시</strong> :\${map.normalBoard.normalBoardDate} /  \${map.normalBoard.normalBoardHour}시</p>
		    <p class="card-text"><strong>참여인원</strong> : \${map.count}명 / \${map.normalBoard.normalBoardDeadlineNumber}명</p></div>
		    <p class="card-text" id="detailed_content"><strong>상세내용</strong><br><div id="div_detail_content"> \${map.normalBoard.normalBoardContent.replaceAll('\r\n', '<br/>')}</div></p>`
		    
	    	if("${sessionScope.user.userId}" == "${normalBoardVO.normalBoardWriter}"){				
				str += '<a href="normalBoardEdit.wow?normalBoardIndex=${normalBoardVO.normalBoardIndex}" class="card-link">수정하기</a>';
				str += '<a id="delete_board" class="card-link" href="#">삭제하기</a>';
			}
		    str += '<a href="normalBoardList.wow" class="card-link">목록</a>'; 
		    console.log(str); 
			$(".card-body").append(str);
			//댓글 리스트 불러오기@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
			replyList();
		},
		error:function(){
			alert("통신 오류");
		}
	});
	
});

$(document).on("click", "#delete_board", function(e){
	e.preventDefault();
	if(confirm("삭제하시겠습니까?")){		
		location.href="normalBoardDelete.wow?normalBoardIndex=${normalBoardVO.normalBoardIndex}";
	}
});


//댓글 리스트 불러오기
function replyList(){
	$.ajax({
		url:"<c:url value='/reply/replyList'/>",
		type:"post",
		data:{'reParentNo':'${normalBoardVO.normalBoardIndex}'
			  , 'reCategory' : 'normal'},
		dataType:"json",
		success:function(map){
			var str = "";
			str += '<li>';
			str += '<div id="div_reply_input">';
			str += '<input type="text" class="input_reply form-control form-control-lg" placeholder="댓글을 입력해주세요." style="max-width:500px;">';
			str += '<input type="submit" class="input_reply_button btn btn-primary" value="등록">';
			str += '</div>';
			str += '</li>';			
			if(map.data.length <= 0){
				str += '<li>';
				str += '<span id="span_not_reply">댓글이 존재하지 않습니다.</span>';
				str += '</li>';
			}
			$.each(map.data, function(i, element){
				 str += '<li class="reply_content">';
				 str += '<input type="hidden" name="reNo" value="'+ element.reNo +'">';
				 str += '<span class="reply_content_id"><strong>' + element.reMemId + '</strong></span><br>';
				 str += '<span class="reply_content_content">' + element.reContent + '</span><br>';
				 str += '<span class="reply_content_date">' + element.reRegDate + '</span><br>';
				 if('${sessionScope.user.userId}' == element.reMemId){ 
               	str += '<input type="button" class="button_update btn btn-primary" value="수정"><input type="button" class="button_delete btn btn-primary" value="삭제"><br>';
				 }
               str += '<span class="reply_content_line"></span>'
               str += '</li>';
			});
			$('.div_board_reply > ul').html(str);
		},
		error:function(){
			alert("통신오류");
		}
	});
}

var reParentNo = '${normalBoardVO.normalBoardIndex}';
var reCategory = 'normal';
var reMemId = '${sessionScope.user.userId}';
//댓글 삽입
$(document).on("click", ".input_reply_button", function(){
	var reContent = $('#div_reply_input').children('input.input_reply').val();
	replyData = {
		'reParentNo':reParentNo,
		'reCategory':reCategory,
		'reMemId':reMemId,
		'reContent':reContent
	};
	$.ajax({
		url:'<c:url value="/reply/replyRegist"/>',
		type:'post',
		data:replyData,
		dataType:'json',
		success:function(map){
			if(map.result){
				replyList();
			}
		},
		error:function(){
			alert("통신오류");
		}
	});
});

//댓글 수정 > input생
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

});

$(document).on("click", '.button_save', function(){
	var reContent = $(this).parent().siblings('input').val();
	var reNo = $(this).parent().parent().parent().siblings('input').val();
	
	replyData = {
			'reNo':reNo,
			'reParentNo':reParentNo,
			'reCategory':reCategory,
			'reMemId':reMemId,
			'reContent':reContent	
	};
	$.ajax({
		url:'<c:url value="/reply/replyModify"/>',
		type:'post',
		data:replyData,
		dataType:'json',
		success:function(map){
			if(map.result){
				replyList();
			}
		},
		error:function(){
			alert("통신오류");
		}
	});
});

//댓글 삭제
$(document).on("click", '.button_delete', function(){
	var reNo = $(this).siblings('input[name="reNo"]').val();
	replyData = {
			'reNo':reNo,
	};
 	$.ajax({
		url:'<c:url value="/reply/replyDelete"/>',
		type:'post',
		data:replyData,
		dataType:'json',
		success:function(map){
			if(map.result){
				if(confirm("삭제하시겠습니까?")){
					replyList();				
				}
			}
		},
		error:function(){
			alert("통신오류");
		}
	});
});

$(document).on("click", "#join_button", function(){
	
	if('${sessionScope.user.userId}' == ""){
		alert("로그인 후 이용가능합니다.");
		return;
	}
	
	let btnYn = confirm("참여하시겠습니까?");
	if(btnYn){
		$.ajax({
			url:"<c:url value='/participation/join'/>",
			type:'post',
			data:{'userId':'${sessionScope.user.userId}'
				  ,'normalBoardIndex':'${normalBoardVO.normalBoardIndex}'
				  ,'normalBoardDeadlineNumber':'${normalBoardVO.normalBoardDeadlineNumber}'},
			dataType:'json',
			success:function(map){
				
				
				/*게시글 내용*/
				if(map.result == true){ //참여하기 성공
					/*취소버튼 생성*/
					$("#join_button").hide();
					$(".div_join_button").html('<button id="cancel_button">취소하기</button><button id="attend_list_button">참여목록</button>');
					
					
					var temp_content = `\${map.normalBoard.normalBoardContent.replaceAll('\r\n', '<br/>')}`;
					console.log(temp_content);
					var str="";
					str += '<div id="div_etc_content">';
					str += '<p class="card-text"><strong>장소</strong> : ${normalBoardVO.normalBoardRoadAddress}</p>';
					str += '<p class="card-text"><strong>일시</strong> :${normalBoardVO.normalBoardDate} /  ${normalBoardVO.normalBoardHour}시</p>';
					str += '<p class="card-text"><strong>참여인원</strong>: '+ map.count +'명 / ${normalBoardVO.normalBoardDeadlineNumber}명</p></li>';
					str += '</div>';
					str += '<p class="card-text" id="detailed_content"><strong>상세내용</strong><br><div id="div_detail_content">'+ temp_content +'</div></p></li>';
					if("${sessionScope.user.userId}" == "${normalBoardVO.normalBoardWriter}"){				
						str += '<a href="normalBoardEdit.wow?normalBoardIndex=${normalBoardVO.normalBoardIndex}" class="card-link">수정하기</a>';
						str += '<a id="delete_board" class="card-link" href="#">삭제하기</a>';
					}
				    str += '<a href="normalBoardList.wow" class="card-link">목록</a>';
					$(".card-body").html(str); 
	
					alert("참여 완료되었습니다.");
				}else{ //이미 마감
					alert("마감된 모임입니다.");
				}
			},
			error:function(){
				alert("통신오류");
			}
		});
	}else{
		alert("취소하셨습니다.");
	}
});

$(document).on("click", "#cancel_button", function(){
	var cancelYn = confirm("취소하시겠습니까?");
	
	if(cancelYn){
		$.ajax({
			url:'<c:url value="/participation/delete" />',
			type:'post',
			data:{'normalPartId':'${sessionScope.user.userId}'
					,'normalPartBoardNumber':'${normalBoardVO.normalBoardIndex}'},
			success:function(map){
				$("#cancel_button").hide();
				
				//취소한 후, 참여한 사람이 없을 때
				if(map.count == 0){
					$(".div_join_button").html('<button id="join_button">참여하기</button>');	
				}else{					
					$(".div_join_button").prepend('<button id="join_button">참여하기</button>');
				}
				alert('취소되었습니다.');
				
				var temp_content = `\${map.normalBoard.normalBoardContent.replaceAll('\r\n', '<br/>')}`;
				console.log(temp_content);
				
				var str="";
								
				str += '<div id="div_etc_content">';
				str += '<p class="card-text"><strong>장소</strong> : ${normalBoardVO.normalBoardRoadAddress}</p>';
				str += '<p class="card-text"><strong>일시</strong> :${normalBoardVO.normalBoardDate} /  ${normalBoardVO.normalBoardHour}시</p>';
				str += '<p class="card-text"><strong>참여인원</strong>: '+ map.count +'명 / ${normalBoardVO.normalBoardDeadlineNumber}명</p></li>';
				str += '</div>';
				str += '<p class="card-text" id="detailed_content"><strong>상세내용</strong><br><div id="div_detail_content">'+ temp_content +'</div></p></li>';
				if("${sessionScope.user.userId}" == "${normalBoardVO.normalBoardWriter}"){				
					str += '<a href="normalBoardEdit.wow?normalBoardIndex=${normalBoardVO.normalBoardIndex}" class="card-link">수정하기</a>';
					str += '<a id="delete_board" class="card-link" href="#">삭제하기</a>';
				}
			    str += '<a href="normalBoardList.wow" class="card-link">목록</a>';
				$(".card-body").html(str); 
			
			},
			error:function(){
				alert('통신실패');
			}
		});
	}
});

//참여목록 누르면 참여목록 나오기 
$(document).on("click", "#attend_list_button" ,function(){
	if('${sessionScope.user.userId}' == ""){
		alert("로그인 후 이용가능합니다.");
		return;
	}
	
	$.ajax({
		url:"<c:url value='/participation/joinMemberList'/>",
		type:'post',
		data:{'normalBoardIndex':'${normalBoardVO.normalBoardIndex}'},
		dataType:'json',
		success:function(map){
			if(map.result){
				$('.toast').show();
				$("#div_gray").show();
				
				var maskHeight = $(document).height();
				var maskWidth = $(window).width();
				var div = $(".toast");
				$(".toast").css({'width':maskWidth, 'height':maskHeight});
				$(".toast").css('top',Math.max(0, (($(window).height() - div.outerHeight()) / 2) + $(window).scrollTop()) + "px");
				$(".toast").css("left", Math.max(0, (($(window).width() - div.outerWidth()) / 2) + $(window).scrollLeft()) + "px");
				
 				var str = "";
					str+='<table style="width:100%">';
					str+='<tr>';
					str+='<td><strong>아이디</strong></td>';
					str+='<td><strong>이름</strong></td>';
					str+='<td></td>';
					str+='</tr>';
 				$.each(map.data, function(i, element){
 					str+='<tr>';
 					str+='<td id="find_id">';
 					str+='<div class="div_join_view"><span>'+element.normalPartId +'</span>';
 					str+='</td>';
 					str+='<td>';
 					str+=element.normalPartName;
 					str+='</td>';
 					str+='<td>';
 					str+='<button class="member_view_button btn btn-info" style="position:relative; left:40px; margin-right:10px !important">상세보기</button></div>';
 					str+='</td>';
 					str+='</tr>';
 				});
					str+='</table>';
				$(".toast-body").html(str);
	
			}
		},
		error:function(){
			alert("통신오류");
		}
	});
});
	
//참여목록 x클릭 참여 목록 사라지기
$('#list_close_button').click(function(){
	$('.toast').css('display','none');
	$("#div_gray").hide();
	$('#div_member_info_view').css('display','none');
});

//상세보기 누르면 회원 상세보기 나오기
$(document).on("click", ".member_view_button", function(){
	var id = $(this).closest('td').siblings('#find_id').children('div').children('span');
	$.ajax({
		url : "<c:url value='/participation/joinMember'/>",
		type:'post',
		data:{'normalPartId':id.html()},
		dataType:'json',
		success:function(map){
			//쪽지보내기 위해서
			id.addClass('checked');
			
			var maskHeight = $(document).height();
			var maskWidth = $(window).width();
			var div = $("#div_member_info_view");
			$(".div_member_info_view").css('top',Math.max(0, (($(window).height() - div.outerHeight()) / 2) + $(window).scrollTop()) + "px");
			$(".div_member_info_view").css("left", Math.max(0, (($(window).width() - div.outerWidth()) / 2) + $(window).scrollLeft()) + "px");
			$('.div_member_info_view').show();
			
			var str = "";
			
			str += '<tr>';
			if(map.blackList == true){
				str += '<td  rowspan="2"><span id="col_line"></span><img src="${pageContext.request.contextPath}/design/img/criminal.png" width="100px" height="100px"></td>';
			}else{				
				if(map.gender == '남'){
					str += '<td  rowspan="2"><span id="col_line"></span><img src="${pageContext.request.contextPath}/design/img/man.png" width="100px" height="100px" position="relative" left="30px"></td>';
				}else{
					str += '<td  rowspan="2"><span id="col_line"></span><img src="${pageContext.request.contextPath}/design/img/woman.png" width="100px" height="100px"></td>';
				}
			}
			
 			
		
			str += '<td width="230px">이름:'+ map.name +'</td>';
			str += '</tr>';
			str += '<tr>' + '<td width="200px">평점 : '+ map.score +'점</td>' + '</tr>';
			str += '<tr>' + '<td id="active_title" colspan="2" width="200px">최근활동내역(10개) </td>' + '</tr>';
			
			$activity_length = map.activity.length;
			
			$.each(map.activity, function(i, element){
				str += '<tr>';
				str += '<td colspan="2"> &nbsp;&nbsp;- '+ element +'</td>';
				str += '</tr>';
			});
			for(var i=0; i<10-$activity_length; i++){
				str += '<tr>';
				str += '<td colspan="2"> &nbsp;&nbsp;</td>';
				str += '</tr>';
			}
			
			str += '<tr>' + ' <td colspan="2">';
			str += '<button type="button" class="btn btn-info" style="width:100%; padding-left:20px;" id="send_message">쪽지보내기</button>';
			str += '</td>' + '</tr>';
			
			$("#member_info_view").html(str);
		},
		error:function(){
			alert("통신 오류");	
		}
	});
	
});

//상세보기 x클릭 상세보기 사라지기
$('#member_close_button').click(function(){
	$('#div_member_info_view').css('display','none');
	$('*').removeClass('checked');
});

$(document).on("click", '#send_message', function(){
	$('.modal').show();
});

$('#close').click(function(){
	$('.modal').hide();
});

//쪽지보내기
$(document).on("click", '#sending', function(){
			$content = $(this).closest('div').siblings('.modal-body').children('textarea').val();
			receiver = $('.checked').html();
			console.log("content = "+$content);
			console.log("receiver = " + receiver);
			var message = {
				"msgSender":"${sessionScope.user.userId}",
				"msgReceiver":receiver,
				"msgContent":$content
			}
			$.ajax({
				url:'<c:url value="/message/sendMessage"/>',
				data:message,
				dataType:'text',
				type:'post',
				success:function(text){
					if(text == 'true'){						
						$('#exampleTextarea').val('');
						alert("전송 완료");
					}else{
						alert("자기 자신에게는 쪽지를 전송할 수 없습니다.");
						$('#exampleTextarea').val('');
					}
						$('.modal').hide();					
				},
				error:function(){
					alert("통신 에러");
				}
				
			});
		}); 






</script>

</html>