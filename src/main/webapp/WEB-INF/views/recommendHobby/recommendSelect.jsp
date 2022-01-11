<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Select</title>

<%@ include file="/WEB-INF/views/common/top.jsp" %>
<link href="<%= request.getContextPath() %>/design/css/top.css" rel="stylesheet" style="text/css">
<link href="<%= request.getContextPath() %>/design/css/recommendSelect.css" rel="stylesheet" style="text/css">
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
</head>
<body>
<div id="div_mak"></div>
<!-- <div id="div_banner"></div> -->
<div class="div_container">
<div id=logo_image>
<a href="<%=request.getContextPath()%>"><img src="${pageContext.request.contextPath}/design/img/findyou_logo.png" width="70px" height="70px"></a>
	<div id="div_title_content">
		<div class="neon">FindYou만의</div>
		<div class="flux">특별한 모임 추천</div>
	</div>
	<img src="${pageContext.request.contextPath}/design/img/why.png" width="30px" height="30px" onclick="open_info()" id="why">
</div>

<div id="box">
<div class="card border-primary mb-3" id="mbti_box">
<c:forEach items="${mbtiList}" var ="mbti" varStatus="index">
 <c:if test="${index.index%4 eq 0}">
<div></div>
<span class="span_btn"><button class="btn btn-primary btn_mbti"  name="mbti_value" value="${mbti.recMbti}">${mbti.recMbti}</button></span>
</c:if>
<c:if test="${index.index%4 ne 0}">
 <span class="span_btn"><button class="btn btn-primary btn_mbti" name="mbti_value" value="${mbti.recMbti}">${mbti.recMbti}</button></span>
</c:if>
</c:forEach>

</div>
</div>

<form action="recommendResult.wow"  >
<div id ="result_box" class="card border-primary mb-3">

  <div class="card-header" id="div_result_input">입력항목</div>
  <div class="card-body">
	<div id="mbti_inp"class='div_str'><span class="input_result" ><strong>MBTI 종류:</strong></span><span id="mbti_select"></span>	</div>
	<div class='div_str'><span class="input_result" ><strong>활동여부:</strong><span id="activity_select"></span></span>	</div>
	<div class='div_str'><span class="input_result" ><strong>좋아하는 취미:</strong></span><span id="hobby_select"></span>	</div>
  	<div class='div_str'><span class="input_result" ><strong>지출 금액:</strong></span><span id="cash_select"><input id="cash_input" type="text" class="form-control" name="cash" placeholder="금액을 입력하세요." value=''></input> </span>	</div>
  </div>

</div>

<div id="next"><button  type="button"class="btn btn-danger" id="button_next" onclick="fn_next_active()">다음으로</button>
</div>

<div id="select">
</div>
</form>
</div>



<c:forEach items="${hobbyList}" var ="hobby" varStatus="index">
 <c:if test="${index.index%5 eq 0}">
<div></div>
<span class="span_btn"><button class="btn btn-primary btn_mbti"  name="mbti_value" value="${hobby.recHobby}">${hobby.recHobby}</button></span>
</c:if>
<c:if test="${index.index%5 ne 0}">
 <span class="span_btn"><button class="btn btn-primary btn_mbti" name="mbti_value" value="${hobby.recHobby}">${hobby.recHobby}</button></span>
</c:if>
</c:forEach>
<div id="div_info">
	<img src="${pageContext.request.contextPath}/design/img/MBTI-004.png" id="info" width="510px" height="600px" >
	<button class="img_button">x</button>
</div>

</body>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r72/three.min.js"></script>
<script type="text/javascript">

//배경화면 셋팅
var camera, scene, renderer, particles, particle, material, particleCount, points, texture;
var xSpeed, ySpeed;
xSpeed = 0.0005;
ySpeed = 0.001;
var winWidth, winHeight;
winWidth = window.innerWidth;
winHeight = window.innerHeight+200;

init();
animate();

function init(){
	  scene = new THREE.Scene();
	  scene.fog = new THREE.FogExp2('#222', 0.001);

	  camera = new THREE.PerspectiveCamera(75, winWidth/winHeight, 1, 1300);
	  camera.position.z = 500;

	  // particle
	  // transparentとblendingたぶん効いてない
	  material = new THREE.PointsMaterial({
	    color: 0xffffff,
	    size: 3,
	    transparent: true,
	    blending: THREE.AdditiveBlending
	  });

	  particleCount = 15000;
	  particles = new THREE.Geometry();

	  for (var i = 0; i < particleCount; i++) {
	    var px = Math.random() * 2000 - 1300;
	    var py = Math.random() * 2000 - 1300;
	    var pz = Math.random() * 2000 - 1300;
	    particle = new THREE.Vector3(px, py, pz);
	    particle.velocity = new THREE.Vector3(0, Math.random(), 0);
	    particles.vertices.push(particle);
	  }

	  points = new THREE.Points(particles, material);
	  points.sortParticles = true;
	  scene.add(points);

	  renderer = new THREE.WebGLRenderer({ antialias: true });
	  renderer.setSize(winWidth, winHeight);
	  renderer.setClearColor('#222', 1);
	  document.getElementById('div_mak').appendChild(renderer.domElement);
	}

function animate(){
	  requestAnimationFrame(animate);
	  
	  scene.rotation.y += xSpeed;

	  var i = particleCount;
	  while(i--){
	    var particle = particles.vertices[i];

	    // y
	    if(particle.y > 1300){
	      particle.y = -1300;
	      particle.velocity.y = Math.random();
	    }
	    particle.velocity.y += Math.random() * ySpeed;

	    particle.add(particle.velocity);
	  }
	  points.geometry.verticesNeedUpdate = true;

	  render();
	}

	function render(){
	  camera.lookAt(scene.position);
	  renderer.render(scene, camera);
	}











$(document).ready(function () {
	
	$('.img_button').hide();
	
	fn_img_button();
	
    $("button[name=mbti_value]").click(function () {
        var mbti_value=$(this).val();
       	
        console.log($("#"+mbti_value).val());

  			
  		 	 $("#"+mbti_value).remove();
  		 	var str="<span id='mbti_value'>"+mbti_value+"</span>"
          $("#mbti_select").append(str);
  		   
 	     	var mbti_value = $("#mbti_value").html();
 	     	$.ajax({
				 url : "mbti_value.wow"
				,type : "POST"
				,data :{ "mbti_value" :mbti_value}
				,success : function() {
	
	 		
	 			 $("#mbti_select *").remove();
	 			 var str="<input id='mbit_value' name='mbti_value' readonly='readonly' value='"+mbti_value+"'></input>"
	 		   $("#mbti_select").append(str);
				}
				,error : function(req, st, err) {
					alert("에러남");
				}
			});		
  		});

    $(document).on("click",".btn_hobby",function(){
    	/* var reset ="<button type='button' id='btn_reset' class='btn btn-danger' onclick='fn_reset()'>처음으로</button>"
		$("#next").append(reset); */
    	$('#select').html('<button type="button" id="btn_reset" class="btn btn-danger" onclick="fn_reset()">초기화</button><button type="button" class="btn btn-danger" id=button_result>결과보기</button>');
    	
  		var hobby_value = $(this).val();
    	str = "";
    	str += "<input id='hobby_value' name='hobby_value' readonly='readonly' value ='"+hobby_value+"'></input>"
		 $("#hobby_select *").remove();
    	$("#hobby_select").append(str);
    	
    		}); 

	
    $(document).on("click","#button_result",function(){
    	var cash_input =$("#cash_input").val();
    	var hobby_value =$("#hobby_value").val();
    		
    	if(cash_input == ""){
    		alert("금액을 입력해주시기 바랍니다.");
    	}
    	else if(typeof hobby_value=="undefined"||hobby_value==""||hobby_value==null){
     		alert("취미를 입력해주시기 바랍니다."); 		
    	}else{
    		$("form").submit();
    	    		
    	}    	
	});
});
function fn_reset(){
	if(confirm("처음으로 이동하시겠습니까?")){
	location.reload();
	}
}
	
function fn_activity(){
		
   	 	 $("#activity_select *").remove();
    	 var str="<input id='activity_value' name='activity_value' value='활동적'></input>"
       $("#activity_select").append(str);
    	   
       	var activity_value = $("#activity_value").val();
       	
    }
function fn_non_activity(){
	
		
	 $("#activity_select *").remove();
	 var str="<input id='non_activity_value' name='activity_value' value='비활동적'></input>"
   $("#activity_select").append(str);
	   
   	var activity_value = $("#activity_value").val();
   	
}

   /*  $("button[name=mbti_value]").click(function () {
      var mbti_value=$(this).val();
      console.log($("#"+mbti_value).val());
			if($("#"+mbti_value).val()==null){
			var str="<span id='"+mbti_value+"'>"+mbti_value+"</span>"

        $("#mbti_select").append(str);
		}
			else{
		        $("#"+mbti_value).remove();
		     
			}
			
		});

}); 여러개 선택시 하려던 방법12-24 12 */ 

function fn_next_active(){
	var mbit_value = $("#mbit_value").val();

	if(typeof mbit_value=="undefined"||mbit_value==""||mbit_value==null){
	}
	else{
	$("#mbti_box ").remove();
	var	 str= "<div class='card border-primary mb-3' id='activity_box'>"
		str += "<button type='button' onclick='fn_activity()'class='btn btn-primary btn_activity'name='activity_value' value='activity'>활동적</button>"
		str+= "<button type='button'class='btn btn-primary btn_activity'onclick='fn_non_activity()' name='activity_value' value='non_activity'>비활동적</button>"
		str+="</div>"
		$("#button_next ").remove();
	
		$("#box").append(str)
	var next_hobby ="<button type='button' id='btn_hobby' class='btn btn-danger' onclick='fn_next_hobby()'>다음으로</button>"
	$("#next").append(next_hobby);
	}
}

function fn_next_hobby(){
	var recMbti = $("#mbit_value").val();
	if($("#activity_value").val()=='활동적'){
	var recActiceYn =$("#activity_value").val();
	$.ajax({
		 url : "next_hobby.wow"
		,type : "POST"
		,data :{ "recMbti" :recMbti
			       ,"recActiceYn" : recActiceYn}
		,success : function(data) {	
			$("#activity_box ").remove();
			$("#btn_hobby").remove();
			
				
			var	 str= "<div class='card border-primary mb-3' id='hobby_box'>"	
			$.each(data, function(index,hobby) { 
			str+= "<button type='button' value='"+hobby.recHobby+"' name='btn_hobby' class='btn btn-primary btn_hobby'>"
			str+= hobby.recHobby+"</button>"
			console.log(hobby);
			})
			str+="</div>"
		
			$("#box").append(str);
			
		
			
		}
		,error : function(req, st, err) {
			alert("에러남");
		}
	});	
	}
	else if($("#non_activity_value").val()=='비활동적'){
	var recActiceYn =$("#non_activity_value").val();
	$.ajax({
		 url : "next_hobby.wow"
		,type : "POST"
		,data :{ "recMbti" :recMbti
			       ,"recActiceYn" : recActiceYn}
		,success : function(data) {	
			$("#activity_box ").remove();
			$("#btn_hobby").remove();
			/* var reset ="<button type='button' id='btn_hobby' class='btn btn-danger' onclick='fn_reset()'>처음으로</button>"
			$("#next").append(reset); */
				
			var	 str= "<div class='card border-primary mb-3' id='hobby_box'>"	
			$.each(data, function(index,hobby) { 
			str+= "<button type='button' value='"+hobby.recHobby+"' name='btn_hobby' class='btn btn-primary btn_hobby'>"
			str+= hobby.recHobby+"</button>"
			console.log(hobby);
			})
			str+="</div>"
		
			$("#box").append(str);
			
		
			
		}
		,error : function(req, st, err) {
			alert("에러남");
		}
	});	
	}
	else{
		alert("활동을 입력해주세요.");
	}	
 

}

function open_info(){
	var div = $('#div_info');
	console.log(div.css('display'));
	$('.img_button').show();
	if(div.css('display') == 'none'){		
		$('#div_info').show();
	}else{
		$('#div_info').hide();
	}
	
}
//x버튼 누르면 추천 설명 없어지도록..
function fn_img_button(){
	
	$('.img_button').on('click', function(){
		$('#div_info').hide();
	});
}





</script>
</html>