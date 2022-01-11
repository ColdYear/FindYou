<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<%request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<link href="<%= request.getContextPath()%>/design/bootstrap/bootstrap.css" rel="stylesheet" style="text/css">
<link href="<%= request.getContextPath()%>/design/bootstrap/bootstrap.min.css" rel="stylesheet" style="text/css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/manager.css">
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/top.jsp" %>

<div class="manager_top">
<h2>
	<label for="title" class="manager_top_title">관리자 페이지</label>
</h2>
</div>

<div class="total_box">
<div style="width:100%; height:100%; overflow:auto">
<table class="div_container">

	<colgroup>
		<col width="10%"/>
		<col width="20%"/>
		<col width="20%"/>
		<col width="20%"/>
		<col width="20%"/>
		<col width="10%"/>
	</colgroup>
	
<tbody class="div_body">
	<tr>
		<td></td>
		<td>아이디</td>
		<td>이름</td>
		<td>평균 평점</td>
		<td>권한</td>
		<td></td>
	</tr>

<c:forEach begin="0" end="${list.size()-1}" var="i">
	<tr>
		<td>
			<img src="<%=request.getContextPath() %>/design/img/${genderList.get(i)}.png" width="60px" height="60px">
		</td>
		<td>${list.get(i).memId }</td>
		<td>${list.get(i).memName }</td>
		<td>${scoreList.get(i)}</td>
		<td>${roleList.get(i)}</td>
		<td><button class="btn btn-danger" value="${list.get(i).memChatNo}">채팅방</button></td>
	</tr>
</c:forEach>
</tbody>


</table>
</div>
</div>
	<input name="url_path" type="hidden" value=<%=request.getRequestURL()%> />
	<c:if test="${(user.userId ne '') and !(empty user.userId)}">
		<input name="userId" type="hidden" value="${user.userId }" id="userId" />
		<input name="userRole" type="hidden" value="${user.userRole }"
			id="userRole" />
		<input name="userChatNo" type="hidden" value="${user.userChatNo }"
			id="userChatNo" />
	</c:if>
	<c:if test="${(user.userId eq '') or (empty user.userId)}">
		<input type="hidden" value='<%=session.getId().substring(0, 6)%>'
			id='chat_id' />
	</c:if>

<div id="chat_arlam" class="card text-white bg-primary mb-3"
		style="max-width: 20rem;">
		<div class="card-header">
		
		채팅 알람
			<button type="button" class="btn-close ms-2 mb-1"
				data-bs-dismiss="toast" aria-label="Close"></button>
			<span aria-hidden="true"></span>
		</div>
		<div class="card-body">
			<h4 class="card-title"></h4>
			<p id="card_text" class="card-text"></p>
		</div>
	</div>
	<input type="hidden" id="chat_hiddn_info" />

	<div id="chat_modal" class="modal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">채팅</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true"></span>
					</button>
				</div>
				<div id="modal-body" class="modal-body">
					<p></p>
				</div>
				<div class="modal-footer">
					<input name="chat_history" id="inputMessage" class="form-control"type="text"
						onkeyup="enterkey()" /> <input type="button"
						class="btn btn-primary" value="send" id="chat_submit"
						onclick="send()">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>



<c:if test="${user.userRole eq 'manager' }">
<style>
.chat_content_opponent{
	/*상대방 채팅 왼쪽  */
  position:relative;  
    display:block;   
    text-align:right; 
}
.chat_content_user_first{
 display:block;  
 text-align:left;  !important
 background-color: red;!important
t
}
.chat_content_user_send_first ,.chat_content_user{
 display:block;  
 text-align:left; 
}


.chat_content_user ,.chat_content_user_send_first {
  background-color: lightyellow;
  border: lightgreen solid 1px;
  border-radius: 5px;
  color:  black;
  font-size: 15px;
  font-weight: 500;
  height: auto;
  letter-spacing: -0.25px;
  margin-top: 6.8px;
  padding: 5px 11px;
  position: relative;
  width: fit-content;
  z-index: 100;
  text-overflow:clip;
}

.chat_content_opponent ,_user , .chat_content_user_first {
  background-color: lightyellow;
  border: lightgreen solid 1px;
  border-radius: 5px;
  color: black;
  font-size: 15px;
  font-weight: 500;
  height: auto;
  display:flex;  
  text-align:right;
  margin-top: 6.8px;
  padding: 5px 11px;
  display: flex;
  width:fit-content; 
  margin-left:auto;
  justify-content:flex-end;
  z-index: 100;
  text-overflow:clip;
}



</style>
</c:if>
<c:if test="${user.userRole eq 'normal' || user.userRole eq 'business'}">
<style>
.chat_content_opponent{
	/*상대방 채팅 왼쪽  */
  position:relative;  
    display:block;    
    text-align:left;  
}
.chat_content_user_send_first{
 display:block;  
 text-align:right; !important
 background-color: red;!importan
 
}
.chat_content_user_first ,.chat_content_user{
 display:block;  
 text-align:right;  
	
}

.chat_content_user ,.chat_content_user_send_first {
  background-color: lightyellow;
  border: lightgreen solid 1px;
  border-radius: 5px;
  color:  black;
  font-size: 15px;
  font-weight: 500;
  height: auto;
  letter-spacing: -0.25px;
  margin-top: 6.8px;
  padding: 5px 11px;
  position: relative;
  width: fit-content;
  z-index: 100;
  text-overflow:clip;
}

.chat_content_opponent ,_user  ,.chat_content_user_first {
  background-color: lightyellow;
  border: lightgreen solid 1px;
  border-radius: 5px;
  color: black;
  font-size: 15px;
  font-weight: 500;
  height: auto;
  display:flex;  
  text-align:right;
  margin-top: 6.8px;
  padding: 5px 11px;
  display: flex;
  width:fit-content; 
  margin-left:auto;
  justify-content:flex-end;
  z-index: 100;
  text-overflow:clip;
}
</style>
</c:if>




</body>
<script type="text/javascript">
var userChatNo_send =null;
var userChatNo = null;
$(".btn-danger").on({
        "click" : function() {
          		chat_arlam_hide = 1;		
                $("#_chatbox").css("display", "block");
                $("#chat_modal").show();
                $("#chat_arlam").hide();
       
          
         		var userChatNo_send = $(this).val();
     			var str_no = "<input type='hidden' id='re_no' value='"+userChatNo_send+"'>"
         	
        		if(${user.userRole eq 'manager'}){
         		$.ajax({
            		url : "chatListFind_managerController.wow",  //MangaerController
            		type : "POST",
            		data : {
            			"userChatNo_send" : userChatNo_send		
            		} 
            , //파라미터
            		success : function(data) {
  						
            			$("#modal-body *").remove();
                    $("#modal-body").html("<p class='text-primary chat_content'>채팅에 참여하였습니다.</p>");
            			$.each(data, function(index, getChatList) { 
            			if(getChatList.memRole =='normal' || getChatList.memRole =='business'){ 
            			
            			let str ="<p class='text-primary 1 chat_content_user' > "+ getChatList.chatHistory; 
					
            			$("#modal-body").append(str);
            			}
            			if(getChatList.memRole =='manager' ){ 
            			
            				let str ="<p class='text-primary  chat_content_opponent' > "+ getChatList.chatHistory; 
    						$("#modal-body").append(str);
                			}
            			});
            			const $messageTextBox = $('#modal-body');
        				$messageTextBox.scrollTop($messageTextBox[0].scrollHeight);
            		},
            		error : function(err) {
            		
            		}
            	});
        		}
				/*              */


            $.ajax({
        		url : "chatListFind.wow",
        		type : "POST",
        		data : {
        			"userChatNo" : userChatNo		
        		} 
        , //파라미터
   
        		success : function(data) {
            	$("#modal-body *").remove();
                $("#modal-body").html("<p class='text-primary chat_content'>채팅에 참여하였습니다.</p>");
        			$.each(data, function(index, getChatList) { 
        		
        			if('${user.userRole}' != getChatList.memRole ){ 
        			let str ="<p class='text-primary 2 chat_content_user' >"+ getChatList.chatHistory;   //나  
			
					$("#modal-body").append(str);
    				const $messageTextBox = $('#modal-body');
    				$messageTextBox.scrollTop($messageTextBox[0].scrollHeight);

        			}
 
        				else if('${user.userRole}' == getChatList.memRole ){ 
        				let str ="<p class='text-primary  chat_content_opponent' >"+ getChatList.chatHistory; 
        				
        				$("#modal-body").append(str);
        				const $messageTextBox = $('#modal-body');
        				$messageTextBox.scrollTop($messageTextBox[0].scrollHeight);

            			}
        			});
        		},
        		error : function(err) {
        		}
        	});
		}
				
     
 });


	var textarea = document.getElementById("modal-body");
	let manager ="manager";
	let normal ="normal";
	let business ="business";
	

    var webSocket = new WebSocket('ws://192.168.20.2:8080/broadcasting');
	
    var inputMessage = document.getElementById('inputMessage');
    webSocket.onerror = function(event) {
        onError(event)
    };
    webSocket.onopen = function(event) {
        onOpen(event)
    };
    webSocket.onmessage = function(event) {
        onMessage(event)
    };
    function onMessage(event) {
        var message = event.data.split("|");
        var sender = message[0];
        var content = message[1];
        if (content == "") {
            
        } else {
            if (content.match("/")) {
                if (content.match(("/" + $("#userId").val()))) {
                    var temp = content.replace("/" + $("#userId").val(), "(귓속말) :").split(":");
                    if (temp[1].trim() == "") {
                    } else {
                        $("#modal-body").html($("#modal-body").html() + "<p class='whisper'>"
                            + sender + content.replace("/" + $("#userId").val(), "(귓속말) :") + "</p>");
                    }
                } else {
                }
            } else {
                if (content.match("!")) {
                    $("#modal-body").html($("#modal-body").html()
                        + "<p class='text-primary 4 chat_content_user'><b class='impress'>" + sender + " : " + content + "</b></p>");
                } else {
                   let   userChatNo_send = $("#userChatNo_send").val();
                   let	 userId_send = $("#userId_send").val()
                    $("#modal-body").html($("#modal-body").html()
                    		+ "<p class='text-primary  chat_content_user_send_first'>" + content + "</p>");/*상대방이 보낸거 처음받을때  */
                    
                   $("#chat_hiddn_info").html($("#chat_hiddn_info").html()+
                           content);
     						
               		if(chat_arlam_hide != 1){ //채팅시 알람 안보이게
                 	 $("#chat_arlam").show();
               				}
                     $("#card_text").html($("#card_text").html(""))
                    $("#card_text").html($("#card_text").html()+ "<p> 메세지가 도착하였습니다."+"</p>")
                    	
                   			
                   		
                }
            }
        }
    }
    function onOpen(event) {
        $("#modal-body").html("<p class='text-primary chat_content'>채팅에 참여하였습니다.</p>");
    }
    function onError(event) {
        //alert(event.data);
    }
    function send() {
        if (inputMessage.value == "") {
        } else {
            $("#modal-body").html($("#modal-body").html()
                + "<p class='text-primary  chat_content_user_first'>" + inputMessage.value + "</p>");/*처음 글쓸때 화면   */
        	const $messageTextBox = $('#modal-body');
			$messageTextBox.scrollTop($messageTextBox[0].scrollHeight);
	
        }
        let chat_history =inputMessage.value;  
	/* 	if( inputMessage.value.length <20){
			
		}	 */
		
		 $.ajax({  //no값받기
				url : "chat_no.wow",
				type : "POST",
				 
				success : function(no) {
					 var userChat = no;
					
					 userId = $("#userId").val();
			  		 userRole =$("#userRole").val();
			        webSocket.send($("#userId").val()+"" + "|" + inputMessage.value+"<input type="+"'hidden'"+"class="+"'sendUserNo'"+"name="+"'sendUserNo'"+"value="+""+userChat+">"
			        		+"<input type="+"'hidden'"+"id="+"'userChatNo_send'"+"name="+"'userChatNo'"+"value="+""+userChat+">"
			        		+"<input type="+"'hidden'"+"id="+"'userId_send'"+"name="+"'userId'"+"value="+"${user.userId}>");					
			          inputMessage.value = "";    //나 채팅 보냄
			       
				
				 $.ajax({  /* db에 값들 넣기 */
					url : "chat.wow",
					type : "POST",
					data : {
						"userId" :userId
						,"chat_history" : chat_history
						,"userRole" :userRole
						,"userChatNo" : userChat
					}, //파라미터
					success : function(data) {
				
					},
					error : function(err) {
					
					
					}
				});
				},
				error : function(err) {
				
				
				}
			});
		
		
		
		
		
    
   }
    //     엔터키를 통해 send함
    function enterkey() {
        if (window.event.keyCode == 13) {
            send();
        }
    }
    //     채팅이 많아져 스크롤바가 넘어가더라도 자동적으로 스크롤바가 내려가게함

$(".btn-close").click(function(){
    $("#chat_arlam").hide();
    $("#chat_modal").hide();
    location.reload();
})
$(".btn-secondary").click(function(){
    $("#chat_arlam").hide();
    $("#chat_modal").hide();
    location.reload();
})
</script>
</html>