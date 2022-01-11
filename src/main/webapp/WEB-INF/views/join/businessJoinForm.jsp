<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%request.setCharacterEncoding("utf-8"); %>
<%@ include file="/WEB-INF/inc/header.jsp" %>
<meta charset="UTF-8">
<title>사업회원 회원가입</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/businessJoinForm.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/bootstrap/bootstrap.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/top.jsp" %>
<div class="div_container">

<form id="businessPass" action="<%=request.getContextPath()%>/join/joinDB.wow" method="post">
	<h2>
	<label for="title"> 사업자회원 회원가입</label>
	</h2>
	<!-- ID -->
<div class="div_flex">
	<div class="div_left form-group" style="max-width:150px;">아이디</div>
	<div class="div_right box id">
			<input type="text" id="memId" class="int form-control" maxlength="20" name="memId">
	</div>
			<input type="button" class="button btn btn-primary" onclick="fn_idCheck()" value="중복확인" id="checkedId">
	</div>
	<!-- PassWord -->
	<div class="div_flex">
	
		<div class="div_left form-group" style="max-width:150px;">비밀번호</div>
	<div class="div_right box password">
			<input type="password" id="memPass" class="int form-control" maxlength="20" name="memPass" >
			<img src="${pageContext.request.contextPath}/design/img/icon_pass.png" id="pass_img" class="passImg">
		</div>
	
	</div>
		<div class="div_flex">
	<div class="div_left form-group" style="max-width:150px;">비밀번호 확인</div>
	<div class="div_right box repassword">
			<input type="password" id="rememPass" class="int form-control" maxlength="20" name="rememPass">
			<font name="check" size="2" color="red"></font>
			<img src="${pageContext.request.contextPath}/design/img/icon_pass.png" id="pass_img" class="passImg">
		</div>
	</div>
	<!-- Name -->

	<!-- 사업자 번호 -->
	<div class="div_flex">
		<div class="div_left form-group" style="max-width:150px;">사업자 번호</div>
		<div class="div_right box num">
			<input type="text" id="memB2bNumber" class="int form-control" maxlength="20" name="memB2bNumber">
			
		</div>
	</div>		

	<!-- 상호명 -->
	<div class="div_flex">
	<div class="div_left form-group" style="max-width:150px;">상호명</div>>
		<div class="div_right box company">
			<input type="text" id="memCompanyName" class="int form-control" maxlength="20" name="memCompanyName">
			
		</div>
	</div>		

	
	<!-- 우편번호  -->
	<div class="div_zip">
	<div class="div_flex div_number">
		<div class="div_left form-group" style="max-width:150px;"></div>
		<div class="div_right box zip">
			<input type="text" id="memZip" class="int form-control" maxlength="20" name="memZip" placeholder="우편번호">
			<button type="button" id="find_button" class="btn btn-danger" onclick="sample4_execDaumPostcode()">찾기</button>
		</div>
	</div>	
	<!-- 주소-->
	<div class="div_flex div_number">
		<div class="div_left form-group" style="max-width:150px;">장소</div>
		<div class="div_right box add1">
			<input type="text" id="memRoadAddr" class="int form-control" maxlength="20" name="memRoadAddr" placeholder="주소">
			
		</div>
	</div>	
	<div class="div_flex div_number">
		<div class="div_left form-group" style="max-width:150px;"></div>
		<div class="div_right box add2">
			<input type="text" id="memDetailedAddr" class="int form-control" maxlength="20" name="memDetailedAddr" placeholder="상세주소">
			
		</div>
	</div>	
	</div>


<input type="hidden" value="<%=request.getRemoteAddr()%>" name="memIp">
<input type="hidden" id="memAddrX" name="memAddrX">
<input type="hidden" id="memAddrY" name="memAddrY">
<button type="button" class="btn btn-primary" onclick="fn_sign()">가입하기</button>
</form>

</div>

</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f614523cd5dababea1d0a27b38ee9d9a&libraries=services"></script>
<script type="text/javascript">
var checkText = "";
var checkIdYn = "";
function fn_sign() {
	var id = document.getElementById("memId");
	var pass = document.getElementById("memPass");
	var rePass = document.getElementById("rememPass");
	
	var b2bNum = document.getElementById("memB2bNumber");
	var cpName = document.getElementById("memCompanyName");
	var memZip = document.getElementById("memZip");
	var roadAddr = document.getElementById("memRoadAddr");
	var DeAddr = document.getElementById("memDetailedAddr");
	var idCheck = /^[a-zA-z0-9]{4,12}$/;
	var passCheck = /^[a-zA-z0-9]{4,12}$/;
	var nameCheck =  /^[가-힣]{2,4}$/;
	var b2bNumCheck = /^[a-zA-Z0-9]+$/;;

	var zipCheck =  /^\d{3}?\d{2}$/u;

	
		
	if(!idCheck.test(id.value)){
		alert("아이디는 영문 대소문자와 숫자 4~12자리로 입력해야합니다!");
		id.focus();
		return ;
	}
	
	if(!passCheck.test(pass.value)){
		alert("비밀번호는 영문 대소문자와 숫자 4~12자리로 입력해야합니다!");
		pass.focus();
		return ;
	}
	
	if(pass.value != rePass.value){
		alert("두 비밀번호가 일치하지 않습니다.");
		rePass.focus();
		return ;
	}
	

	
	if(!b2bNumCheck.test(b2bNum.value)){
		alert("사업자번호를 정확히 입력해주세요!");
		b2bNum.focus();
		return ;
	}
	

	if(!zipCheck.test(memZip.value)){
		alert("우편번호를 정확히 입력해 주세요!");
		zip.focus();
		return ;
	}
	if(roadAddr.value ==null || roadAddr.value == ""){
		alert("도로명 주소를 입력해 주세요!");
		rePass.focus();
		return ;
	}
	if(DeAddr.value ==null || DeAddr.value == ""){
		alert("상세주소를 입력해 주세요!");
		rePass.focus();
		return ;
	}
	

	
	if(checkIdYn != "check"){
		alert("아이디 중복체크를 확인해주세요!");
		return ;
	}else{
		if(checkText=="사용 가능한 아이디입니다."){
			alert("환영합니다. 회원가입이 완료되었습니다!")
			$("#businessPass").submit();
		}else{
			checkIdYn = "";
			return ;
		}
	}
	
	




}




$(function(){
	  $('#memPass').keyup(function(){
	   $('font[name=check]').text('');
	  }); //#user_pass.keyup

	  $('#rememPass').keyup(function(){
	   if($('#memPass').val()!=$('#rememPass').val()){
	    $('font[name=check]').text('');
	    $('font[name=check]').html("비밀번호를 다르게 입력하셨습니다");
	   }else{
	    $('font[name=check]').text('');
	    $('font[name=check]').html("비밀번호 확인 완료!");
	   }
	  }); //#chpass.keyup
	 });


function fn_idCheck() {
	event.preventDefault();
	var idCheck = $("#memId").val();
	alert(idCheck);
	$.ajax({
		url : "<c:url value = '/join/idCheck.wow'/>",
		type : "POST",
		dataType: "json",
		data : {"memId" : idCheck},		//파라미터
		success : function(data) {
			checkIdYn = data.result;
			checkText = data.text;
			alert(data.text);
		},
		error : function(err) {
			alert("error  발생");
		}
	});
};


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
                              	
									  resolve({ lat: y, lon: x })
                          }else{
                              reject();
                          }
                      });
                  })
              }).then(result => {
                  // 위, 경도 결과 값
            	  $("#memAddrX").val(result.lon);
                $("#memAddrY").val(result.lat);
              });	
        } //oncomplete
    }).open();
}

</script>
</html>