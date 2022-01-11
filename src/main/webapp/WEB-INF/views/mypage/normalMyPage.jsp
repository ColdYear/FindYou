<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%request.setCharacterEncoding("utf-8"); %>
<%@ include file="/WEB-INF/inc/header.jsp" %>

<meta charset="UTF-8">
<title>일반회원 정보 수정</title>
<link href="https://fonts.googleapis.com/css?family=Jua" rel="stylesheet">
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/normalMyPage.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/bootstrap/bootstrap.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/top.jsp" %>
<section id="bg"></section>
<div class="div_container">

<a href="<%= request.getContextPath() %>/mypage/myPage.wow" class="return_Page card-link" style="color:#78c2ad !important;  ">뒤로가기</a>

	<h2>
	<label for="title"> ${member.memName }님 정보 수정</label>
	</h2>
	
	<form id="normalPass" action="<%=request.getContextPath()%>/join/modify.wow" method="post">
	<div class="div_center">

	
	<!-- PassWord -->
	<div class="div_flex">
	
		<div class="div_left form-group" style="max-width:150px;"><strong>비밀번호</strong></div>
	<div class="div_right box password">
			<input type="password" id="memPass" class="int form-control" maxlength="20" name="memPass">
			<img src="${pageContext.request.contextPath}/design/img/icon_pass.png" id="pass_img" class="passImg">
		</div>
		
	</div>
	
	

	<div class="div_flex">
		
		<div class="div_left form-group" style="max-width:150px;"><strong>이메일</strong></div>
		<div class="div_right box email">
			<input type="text"  class="int form-control" maxlength="20" value="${member.memEmail}" name="memEmail">
		</div>
		
	</div>
	<!-- PHONE NUMBER -->
	<div class="div_flex" id="div_hp_check">
	
	<div class="div_left form-group" style="max-width:150px;"><strong>휴대전화</strong></div>
	<div class="div_right box Hp">
			<input type="text" class="int form-control" id="member_hp_number" value="${member.memHp }" maxlength="20" name="memHp">
		
	</div>
		<input type="button" class="btn btn-primary" value="휴대전화 수정" onclick="fn_number_modify()" id="receive_button">
	</div>
	
	
		
	
	<div class="div_flex" id="div_inNumber">
	<div class="div_left form-group" style="max-width:150px;"><strong>인증번호</strong></div>
	<div class="div_right box number">
			<input type="text" class="int form-control" maxlength="20" id="hp_number">
	</div>
			<button type="button" class="btn btn-primary" id="button_number" onclick="fn_auth_co()">인증 확인</button>
		</div>
		

	<!-- 우편번호  -->
	<div class="div_zip">
		<div class="div_flex div_number">
			<div class="div_left form-group" style="max-width:150px;"></div>
			<div class="div_right box zip">
				<input type="text" id="memZip" value="${member.memZip }" class="int form-control" maxlength="20" name="memZip" placeholder="우편번호">
				
				<button type="button" id="find_button" class="btn btn-danger" onclick="sample4_execDaumPostcode()">찾기</button>
			</div>
		</div>	
		<!-- 주소-->
		<div class="div_flex div_number">
			<div class="div_left form-group" style="max-width:150px;"><strong>장소</strong></div>
			<div class="div_right box add1">
				<input type="text" id="memRoadAddr" value="${member.memRoadAddr }" class="int form-control" maxlength="20" name="memRoadAddr" placeholder="주소">
				
			</div>
		</div>	
		<div class="div_flex div_number">
			<div class="div_left form-group" style="max-width:150px;"></div>
			<div class="div_right box add2">
				<input type="text" id="memDetailedAddr" value="${member.memDetailedAddr}" class="int form-control" maxlength="20" name="memDetailedAddr" placeholder="상세주소">
				
			</div>
		</div>	
		</div>
	</div>

	

	<input type="hidden" value="<%=request.getRemoteAddr()%>" name="memIp">
	<input type="hidden" value="${member.memId }" name="memId">
	<input type="hidden" name="memAddrX" id="memAddrX" value="${member.memAddrX }">
	<input type="hidden" name="memAddrY" id="memAddrY" value="${member.memAddrY }">
	<button type="button" id="normal_button" class="btn btn-primary" onclick= "fn_normalModify()">완료</button>

	
	<button type="button" id="resign_button" class="btn btn-primary" onclick="fn_normalDelete()">회원탈퇴</button>
	
	

</form>







</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	f614523cd5dababea1d0a27b38ee9d9a&libraries=services"></script>
<script type="text/javascript">
let authNum ;

function fn_auth_co(){
	if($("#hp_number").val() != authNum){
		alert("인증번호가 일치하지 않습니다")
		return ;
		}else{
			alert("인증 완료!");
			$("#hp_number" ).prop('readonly', true);
			$("#hp_number").addClass("authNumberClear");
			
		}
}

function fn_normalModify() {
	var pass = document.getElementById("memPass");
	if("${member.memPass}"!= pass.value){
		alert("비밀번호가 일치하지 않습니다");
		return ;
	}else{
		if($("*").hasClass("changeHp")){
			if($("*").hasClass("authNumberClear")){
				alert("정보수정이 완료되었습니다!");
				$("#normalPass").submit();
			}else{
				alert("인증확인을 진행해주세요.");
				return ;
			}
		}else{
			alert("정보수정이 완료되었습니다!");
			$("#normalPass").submit();
		}
	}
}
function fn_normalDelete() {
	var pass = document.getElementById("memPass");
	if("${member.memPass}"!= pass.value){
		alert("비밀번호가 일치하지 않습니다");
		return ;
	}else{
		$.ajax({
			url: '<c:url value="/join/delete"/>',
			data: {"id":"${member.memId }"},
			type: "post",
			success: function(){
				if(confirm("삭제하시겠습니까?")){
					alert("삭제완료");
				location.href="<%=request.getContextPath()%>";
				}
			},
			error: function(){
			}
		});
	}
}


$(document).ready(function(){
	//여기에다가 인증번호 라인 안나오는 코드 사용하기
	$("#div_inNumber").hide();
	});
	
function fn_number_modify() {
	
	$("#member_hp_number").val("");
	$("#receive_button").remove();
	var str = "<button type='button' id='receive_button' class='auth_check btn btn-primary'>인증번호 확인</button>";
	$("#div_hp_check").append(str);
	$("#member_hp_number").addClass('changeHp');
	
}
$(document).on("click", ".auth_check", function(){
	let Hp = $("input[name=memHp]").val();
	var memHp = $("input[name=memHp]");
	
	if(memHp.val() == '' || memHp.val() == null){
		alert('수정하실 휴대폰 번호를 입력해주세요.');
		return;
	}else{		
		$.ajax({
			url : '<c:url value="/join/receiveAuthNumber.wow"/>',
			type : "POST",
			data : {
				"Hp" : Hp,
			}, //파라미터
			dataType:"json",
			success : function(map) {
				alert('인증번호를 발송하였습니다. 인증번호를 입력해주세요!');
				$("#div_inNumber").show();
				authNum = map.auth
			},
			error : function(err) {
				alert('통신오류');			
			}
		});
	}
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
					                $("#memZip").val(data.zonecode);
					                $("#memRoadAddr").val(roadAddr);
                              	
									  resolve({ lat: x, lon: y})
						           
                          }else{
                              reject();
                          }
                      });
                  })
              }).then(result => {
                  // 위, 경도 결과 값
                  console.log(result.lon + ", " + result.lat);
                  $("#memAddrX").val(result.lon);
                  $("#memAddrY").val(result.lat);
              });

             
				
        } //oncomplete
    }).open();
}
var blendAmount = 70;
var delay = -10;
var windowWidth = window.innerWidth;
var bg = document.getElementById("bg");

document.onmousemove = function(e){
  mouseX = Math.round(e.pageX / windowWidth * 100 - delay);
  
  col1 = mouseX - blendAmount;
  col2 = mouseX + blendAmount;
  
  bg.style.background = "linear-gradient(to right, #ffc3a0 "+ col1 +"%, #ffafbd "+ col2 +"%)";
  
}



</script>

	

</body>
</html>