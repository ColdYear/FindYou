<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="true"%>
<link
	href="<%=request.getContextPath()%>/design/bootstrap/_bootswatch.scss"
	rel="stylesheet" style="text/css">
<link
	href="<%=request.getContextPath()%>/design/bootstrap/_variables.scss"
	rel="stylesheet" style="text/css">
<link
	href="<%=request.getContextPath()%>/design/bootstrap/bootstrap.css"
	rel="stylesheet" style="text/css">
<link
	href="<%=request.getContextPath()%>/design/bootstrap/bootstrap.min.css"
	rel="stylesheet" style="text/css">
<body>

	<!-- 로그인한 상태일 경우와 비로그인 상태일 경우의 chat_id설정 -->


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
	<!--채팅창-->


<!-- 	<div id="manager_chatRoom_modal" class="modal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">채팅방 선택</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true"></span>
					</button>
				</div>
				<div class="modal-body">
					<p>Modal body text goes here.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div> -->
   <c:if test="${user ne null }">
	<img class="chat"
		src="<%=request.getContextPath()%>/design/img/chat.png" />
		</c:if>
<%-- 	<c:if test="${user.userRole eq 'manager' }">
		<img class="chat2"
			src="<%=request.getContextPath()%>/design/img/chat2.png" />

	</c:if> --%> <!--  매니저방 만들다-->
 
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
.chat_content_user_send_first {
 display:block;  
 text-align:left; 
}
.chat_content_user{
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
.2chat_content_user{
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
 text-align:right; 
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
<!-- 말풍선아이콘 클릭시 채팅창 열고 닫기 -->
<script>

$("#manager_chatRoom_modal").hide();
$("#chat_arlam").hide();
$("#chat_modal").hide();
let chat_arlam_hide =0;
$(".btn-secondary, .btn-close").click(function(){
	 chat_arlam_hide = 0;	
	 $(".chat").attr("src", "<%=request.getContextPath()%>/design/img/chat.png");
    $("#_chatbox").css("display", "none");
    $("#manager_chatRoom_modal").hide();
    $("#chat_modal").hide();
    location.reload();

});

$(".btn-close").click(function(){
    $("#chat_arlam").hide();
    $("#chat_modal").hide();
    location.reload();
})
    $(".chat").on({
        "click" : function() {
 	
            if ($(this).attr("src") == "<%=request.getContextPath()%>/design/img/chat.png") {
          		chat_arlam_hide = 1;		
                $("#_chatbox").css("display", "block");
                $("#chat_modal").show();
                $("#chat_arlam").hide();
             if(${user.userRole eq 'manager'}){
            	let sendUserNo = $(".sendUserNo").val(); 
            	$.ajax({
            			url : "chatNoFind.wow",
            			type : "POST",
            			 data : {
            				"sendUserNo" :sendUserNo
            			} , //파라미터
            			success : function(data) {       
            			},
            			error : function(err) {
            			
            			}
            		});
                }
            } else if ($(this).attr("src") == "<%=request.getContextPath()%>/design/img/chathide.png") {
                $(".chat").attr("src", "<%=request.getContextPath()%>/design/img/chat.png");
                $("#_chatbox").css("display", "none");
                $("#chat_arlam").hide();
                $("#chat_modal").hide();
      
        }
            let userChatNo = $("#userChatNo").val();
         		let userChatNo_send = $("#userChatNo_send").val();
        		if(${user.userRole eq 'manager'}){
         		$.ajax({
            		url : "chatListFind_manager.wow",
            		type : "POST",
            		data : {
            			"userChatNo_send" : userChatNo_send		
            		} 
            , //파라미터
            		success : function(data) {
                	$("#modal-body *").remove();
                    $("#modal-body").html("<p class='text-primary chat_content'>채팅에 참여하였습니다.</p>");
            			$.each(data, function(index, getChatList) { 
            		
            			 if('${user.userRole}' != getChatList.memRole ){ 
            			let str ="<p class='text-primary 1 chat_content_user' > "+ getChatList.chatHistory; 
					
            			$("#modal-body").append(str);
            			}
            				else if('${user.userRole}' == getChatList.memRole ){ 
            			
            				let str ="<p class='text-primary  chat_content_opponent' > "+ getChatList.chatHistory; 
    						$("#modal-body").append(str);
                			}
            			});
            			const $messageTextBox = $('#modal-body');
        				$messageTextBox.scrollTop($messageTextBox[0].scrollHeight);
            		},
            		error : function(err) {
            			alert("통신 상대가 없습니다.");
            		}
            	});
        		}
				/*              */

            $.ajax({
        		url : "<c:url value='chatListFind.wow'/>",
        		type : "POST",
        		data : {
        			"userChatNo" : userChatNo		
        		} 
        , //파라미터
        		success : function(data) {
            	$("#modal-body *").remove();
                $("#modal-body").html("<p class='text-primary chat_content'>채팅에 참여하였습니다.</p>");
        			$.each(data, function(index, getChatList) { 
        			if('${user.userRole}' != getChatList.memRole){
        			let str ="<p class='text-primary  chat_op_user'  >"+ getChatList.chatHistory;   //나  
        		
					$("#modal-body").append(str);
    				const $messageTextBox = $('#modal-body');
    				$messageTextBox.scrollTop($messageTextBox[0].scrollHeight);

        			}
        			else if('${user.userRole}' == getChatList.memRole ){ 
        				let str ="<p class='text-primary  chat_content_opponent'>"+ getChatList.chatHistory; 
        				$("#modal-body").append(str);
        				const $messageTextBox = $('#modal-body');
        				$messageTextBox.scrollTop($messageTextBox[0].scrollHeight);

            		}
        			});
        		},
        		error : function(err) {
        			alert(err);
        			alert("ddd");
        		}
        	});
		}
				
     
 });
   
<%--     $(".chat2").on({
        "click" : function() {
 		  let userRole =$("#userRole").val();
 		   let userId = $("#userId").val();
	if ($(this).attr("src") == "<%=request.getContextPath()%>/design/img/chat2.png") {
        $("#_chatbox").css("display", "block");
        $("#manager_chatRoom_modal").show();              		
   $.ajax({
	url :"chatRoomFind.wow",
		type : "POST",
		  	success : function(data){
		  	alert("통신성공햇슴");
			$("#modal-body *").remove();
			$.each(data, function(index, getChatList) { 
			
			    str = "<button class='btn btn-primary' name='enterNo' type='button' value='"+getChatList.chatNo+"' onclick='fn_enterRoom()'>"+getChatList.chatNo+"</button>"
			    
			    $("#modal-body").append(str);
			});
		  	}
   ,error : function(){
		alert("통신실패햇슴");
		  	}
        });
     
	} 
    
        }
    });
  --%>


	

	

   
     
    
    
    
    
</script>

<script type="text/javascript">
/* function fn_enterRoom(){  /* 버튼 누르면 그방으로 이동 */
	
function fn_enterRoom(){
	    $(".btn-primary[name=enterNo]").click(function () {

	    	userChatNo_send=$(this).val();

        });
}



if(${user.userRole eq 'manager'}){
	
	$.ajax({
	url : "/findYou/common/chatListFind_manager.wow",
	type : "POST",
	if(userChatNo_send != null){
	data : {
		"userChatNo_send" : userChatNo_send		
	} 
	}
, //파라미터
	success : function(data) {
	
		$("#modal-body *").remove();
    $("#modal-body").html("<p class='text-primary chat_content'>채팅에 참여하였습니다.</p>");
		$.each(data, function(index, getChatList) { 
		if(getChatList.memRole =="normal" || getChatList.memRole =="business"){ 
		
		let str ="<p class='text-primary 3 chat_content_user'>"+ getChatList.chatHistory;  //나 채팅 올리기
		$("#modal-body").append(str);
		const $messageTextBox = $('#modal-body');
		$messageTextBox.scrollTop($messageTextBox[0].scrollHeight);

		}
		if(getChatList.memRole =="manager" ){ 
		
			let str ="<p class='text-primary 4 chat_content_opponent' > : "+ getChatList.chatHistory; //매니저 채팅 올리기 
			$("#modal-body").append(str);
			const $messageTextBox = $('#modal-body');
			$messageTextBox.scrollTop($messageTextBox[0].scrollHeight);

			}
		});
	},
	error : function(err) {
		alert(err);
	}
});





}

</script>
<script type="text/javascript">

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
                 	 		var hidden_sendNo = $("#userChatNo_send").val();
             			
               		if(${user.userRole eq 'manager'}){
               			$("#chat_arlam").show();
               		}
               		
               		else{
               		if($("#userChatNo").val() == hidden_sendNo ){
               				
               			$("#chat_arlam").show();
               			}
               		}
               	
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
		
        webSocket.send($("#userId").val()+"" + "|" + inputMessage.value+"<input type="+"'hidden'"+"class="+"'sendUserNo'"+"name="+"'sendUserNo'"+"value="+"${user.userChatNo}>"
        		+"<input type="+"'hidden'"+"id="+"'userChatNo_send'"+"name="+"'userChatNo'"+"value="+"${user.userChatNo}>"
        		+"<input type="+"'hidden'"+"id="+"'userId_send'"+"name="+"'userId'"+"value="+"${user.userId}>");					
          inputMessage.value = "";    //나 채팅 보냄
        userId = $("#userId").val();
   		 userRole =$("#userRole").val();
		 userChatNo = $("#userChatNo").val();

    $.ajax({  /* db에 값들 넣기 */
		url : "chat.wow",
		type : "POST",
		data : {
			"userId" :userId
			,"chat_history" : chat_history
			,"userRole" :userRole
			,"userChatNo" : userChatNo
		}, //파라미터
		success : function(data) {
	
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
	

</script>








