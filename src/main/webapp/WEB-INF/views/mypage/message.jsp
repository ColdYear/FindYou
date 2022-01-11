<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<% request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<meta charset="UTF-8">
<link href="<%= request.getContextPath()%>/design/bootstrap/bootstrap.css" rel="stylesheet" style="text/css">
<link href="<%= request.getContextPath()%>/design/css/message.css" rel="stylesheet" style="text/css">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/top.jsp" %>

<div class="div_container">
<a class="card-link" href="/mypage/myPage.wow">뒤로가기</a>
	<div class="div_message_header">
		<h1><img id="letter" src="<%=request.getContextPath()%>/design/img/letter.png" width="50px" height="50px"> 쪽지함</h1><br>
		<input type="button" value="받은쪽지함" id="receiveMessage" class="btn btn-primary">
		<input type="button" value="보낸쪽지함" id="sendMessage" class="btn btn-primary">
	</div>
	<form method="post" action="/message/deleteMessage" id="delete_check_form">
	<div class="div_message_body">
	
	<h3 id="sub_title">받은 쪽지함</h3>
		<div class="div_message_footer">
		 
	</div>
	<div class="div_body_rec">
		<table id="table_messageList">
			<colgroup>
				<col width="5%">
				<col width="15%">
				<col width="60%">
				<col width="15%">
			</colgroup>
			
		</table>
	</div>
	</div>
	</form>
	<div class="div_paging">
			<ul class="pagination">
				<li class="page-item disabled"><a class="page-link" href="#">&laquo;</a></li>
				<c:forEach begin="1" end="5" var="i">
					<li class="page-item"><a class="page-link" href="#">${i}</a></li>
				</c:forEach>
				<!-- <li class="page-item active"><a class="page-link" href="#">1</a></li> -->
				<li class="page-item disabled"><a class="page-link" href="#">&raquo;</a></li>
			</ul>

	</div>
	</div>
	
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
</body>
<script type="text/javascript">
let $receiveCurpage = 1;
let $sendCurpage = 1;

	$(document).ready(function() {
		getReceiveMessageList();
	});

	$('#receiveMessage').click(function() {
		getReceiveMessageList();
		$receiveCurpage = 1;
	})

	$('#sendMessage').click(function() {
		getSendMessageList();
		$sendCurpage = 1;
	});

	$(document).on("click", '#deleteReceiveMessage', function() {
		if (confirm("삭제하시겠습니까?")) {
			deleteReceiveMessage();
		}
	});

	$(document).on("click", '#deleteSendMessage', function() {
		if (confirm("삭제하시겠습니까?")) {
			deleteSendMessage();
		}
	});
	

	//받은쪽지함에서 페이징 처리
	$(document).on("click", '.receive-page', function(){
		$receiveCurpage = $(this).data('page');
		 $.ajax({
			url : '<c:url value="/message/receivePaging" />',
			data : {
				'receiver' : '${sessionScope.user.userId}',
				'curPage':$receiveCurpage
				
			},
			dataType : 'json',
			type : 'post',
			success : function(map) {
				settingReceiveBody(map);
				settingReceivePaging(map);
				$('*').removeClass('active');
				$(this).addClass('active');
			}
		}); 
		
	});
	

	//보낸쪽지함에서 페이징 처리
	$(document).on("click", '.send-page', function(){
		$sendCurpage = $(this).data('page');
		 $.ajax({
			url : '<c:url value="/message/sendPaging" />',
			data : {
				'sender' : '${sessionScope.user.userId}',
				'curPage':$sendCurpage
			},
			dataType : 'json',
			type : 'post',
			success : function(map) {
				settingSendBody(map);
				settingSendPaging(map);
				$('*').removeClass('active');
				$(this).addClass('active');
			} 
		});
	});
	
	$(document).on("click", '#reReceiveMessage', function(){
		
		var checked_box_length = $('input:checkbox:checked').length;
		if(checked_box_length == 1){			
			$('.modal').show();
		}else if(checked_box_length == 0){
			return;
		}else{
			alert('하나만 선택해주세요');
			return;
		}	
		
	});
	

	//받은 쪽지함 리스트 가져오기
	function getReceiveMessageList() {
		$.ajax({
					url : '<c:url value="/message/getReceiveMessageList" />',
					data : {
						'receiver' : '${sessionScope.user.userId}'
					},
					dataType : 'json',
					type : 'post',
					success : function(map) {
						console.log(map);
						settingReceiveBody(map);
						
						settingReceivePaging(map);;
						
						$('#sub_title').html('받은 쪽지함');
						var footer_str = "";

						footer_str += '<input type="button" value="삭제" id="deleteReceiveMessage" class="btn btn-danger">';
						footer_str += '<input type="button" value="답장" id="reReceiveMessage" class="btn btn-danger">';

						$('.div_message_footer').html(footer_str);
						
						
					},
					error : function() {
						alert("통신 오류");
					}
				});
	}

	//보낸 쪽지함에서 삭제하고 리스트 제대로 안불러와짐...
	//보낸 쪽지함 리스트 가져오기
	function getSendMessageList() {
			$.ajax({
					url : '<c:url value="/message/getSendMessageList" />',
					data : {
						'sender' : '${sessionScope.user.userId}'
					},
					dataType : 'json',
					type : 'post',
					success : function(map) {
						
						
						settingSendBody(map);
						settingSendPaging(map);
						
						var footer_str = "";

						footer_str += '<input type="button" value="삭제" id="deleteSendMessage" class="btn btn-danger">';
						footer_str += '<input type="button" value="답장" id="reSendMessage" class="btn btn-danger">';

						$('.div_message_footer').html(footer_str);
						$('#sub_title').html('보낸 쪽지함');
						
						
					},
					error : function() {
						alert("통신 오류");
					}
				});
	}
		
	
	//body부분 셋팅
	function settingSendBody(map){
		console.log(map.pagingVO);
		var str = "";
		str += '<table id="table_messageList">';
		str += '<colgroup>';
		str += '<col width="5%">';
		str += '<col width="15%">';
		str += '<col width="60%">';
		str += '<col width="15%">';
		str += '</colgroup>';
		str += '<thead>';
		str += '<tr>';
		str += '<td></td>';
		str += '<td>받은 사람</td>';
		str += '<td>내용</td>';
		str += '<td>날짜</td>';
		str += '</tr>';
		str += '</thead>';

		str += '<tbody>';
		$.each(map.list, function(index, element) {
			
				str += '<tr class="tr_send">';
				str += '<td><input class="form-check-input" type="checkbox" name="msgCheck" value="'+ element.msgIndex +'"></td>'
				str += '<td>' + element.msgReceiver
						+ '</td>';
				str += '<td>' + element.msgContent
						+ '</td>';
				str += '<td>' + element.msgRecTime
						+ '</td>';
				str += '</tr>';
		});
		str += '</tbody>';
		str += '</table>';
		$('#table_messageList').html(str);
	}
	
	function settingReceiveBody(map){
		console.log(map.pagingVO);
		var str = "";
		str += '<table id="table_messageList">';
		str += '<colgroup>';
		str += '<col width="5%">';
		str += '<col width="15%">';
		str += '<col width="60%">';
		str += '<col width="15%">';
		str += '</colgroup>';
		str += '<thead>';
		str += '<tr>';
		str += '<td></td>';
		str += '<td>보낸 사람</td>';
		str += '<td>내용</td>';
		str += '<td>날짜</td>';
		str += '</tr>';
		str += '</thead>';

		str += '<tbody>';
		$.each(map.list, function(index, element) {
			//메시지가 읽혀있다면 -> 'back_gray'라는 클래스를 tr에 추가해줄 것이다.
				str += '<tr class="tr_receive">';
				str += '<td><input class="form-check-input" type="checkbox" name="msgCheck" value="'+ element.msgIndex +'"></td>';
				str += '<td>' + element.msgSender
						+ '</td>';
				str += '<td>' + element.msgContent
						+ '</td>';
				str += '<td>' + element.msgRecTime
						+ '</td>';
				str += '</tr>';
				
		});
		str += '</tbody>';
		str += '</table>';
		$('#table_messageList').html(str);
	}
	
	
	function settingSendPaging(map){
		//페이징부분
		var paging_str = "";
		paging_str += '<ul class="pagination">';
		paging_str += '<li class="page-item disabled"><a class="send-page page-link" href="#">&laquo;</a></li>';
		
		var end = map.pagingVO.lastPage;
		
		for(var i=1; i<=end; i++){							
			paging_str += '<li class="page-item"><a class="send-page page-link" href="#" data-page="'+ i +'">'+ i +'</a></li>';
		}					
		
		paging_str += '<li class="page-item disabled"><a class="send-page page-link" href="#">&raquo;</a></li>';
		paging_str += '</ul>';
		
		$('.div_paging').html(paging_str);
	}
	
	function settingReceivePaging(map){
		//페이징부분
		var paging_str = "";
		paging_str += '<ul class="pagination">';
		paging_str += '<li class="page-item disabled"><a class="receive-page page-link" href="#">&laquo;</a></li>';
		
		var end = map.pagingVO.lastPage;
		
		for(var i=1; i<=end; i++){							
			paging_str += '<li class="page-item"><a class="receive-page page-link" href="#" data-page="'+ i +'">'+ i +'</a></li>';
		}					
		
		paging_str += '<li class="page-item disabled"><a class="receive-page page-link" href="#">&raquo;</a></li>';
		paging_str += '</ul>';
		
		$('.div_paging').html(paging_str);
	}

	function deleteReceiveMessage() {
		var $form = $('#delete_check_form');
		$.ajax({
			url : '<c:url value="/message/deleteMessage" />',
			data : $form.serialize(),
			type : 'post',
			success : function() {
				getReceiveMessageList();
			},
			error : function() {
				alert('통신오류');
			}
		});
	}

	function deleteSendMessage() {
		var $form = $('#delete_check_form');
		$.ajax({
			url : '<c:url value="/message/deleteMessage" />',
			data : $form.serialize(),
			type : 'post',
			success : function() {
				getSendMessageList();
			},
			error : function() {
				alert('통신오류');
			}
		});
	}
	
	
	//쪽지보내기
	$(document).on("click", '#sending', function(){
		$content = $(this).closest('div').siblings('.modal-body').children('textarea').val();
		
		//받는사람..
		
		receiver =  $('input:checkbox:checked').closest('td').next('td').html();
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
					$('.form-check-input').prop('checked',false);
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
	
	$(document).on("click", "#close", function(){
		$('.modal').hide();
		$('input[name=msgCheck]').prop('checked', false);
	});
</script>

</html>