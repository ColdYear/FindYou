<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/common/top.jsp" %>
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
<link href="<%=request.getContextPath()%>/design/css/top.css"
	rel="stylesheet" style="text/css">
<link href="<%=request.getContextPath()%>/design/css/recommendResult.css"
	rel="stylesheet" style="text/css">
</head>
<body>

<c:if test="${boardList.size()-1 >= 0}">

<div class="div_body">
<div id="box_body">
<div class="div_header">
	<h1>검색 결과</h1>
</div>
<div class="div_container">
<!-- ajax 통신을 통해서 글  받아오기 -->
<%--       <c:forEach items="${boardList }" var="board" varStatus="i"  >
 --%>
 <input type="hidden" id="List"value="${boardList }">
	<c:forEach begin="0" end="${boardList.size()-1 }" var="i"   >
     
<div class="card border-primary mb-3 div_box" >
<div class="board_img">
<div class="title_bright_-1">
<div class="title_bright">${boardList.get(i).normalBoardTitle }</div></div>
<img src="<%=request.getContextPath()%>/images/normal/${list.get(i) } " width="250px" height="300px">
</div>
<div class="hobby_info">
<div><span class="left">취미 : </span><span><%=request.getParameter("hobby_value") %></span></div>
<div><span class="left">모집 인원 : </span><span>${boardList.get(i).normalBoardDeadlineNumber }</span></div>
<div><span class="left">마감 여부 :</span><span>${boardList.get(i).normalBoardDeadlineYn}</span></div>
<div><span class="left">비용 : </span><span>${boardList.get(i).normalBoardCost }</span></div>
<div><span class="left">지역 : </span><span>${boardList.get(i).normalBoardRoadAddress }</span></div>
</div>
<input type="hidden" class="board_index" value="${boardList.get(i).normalBoardIndex }"/>
<div class="div_box_btn">
<button class=" btn btn-danger btn_link" ><a color="white" href="<%=request.getContextPath()%>/normalBoard/normalBoardView.wow?normalBoardIndex=${boardList.get(i).normalBoardIndex}">상세보기</a></button>

</div>
</div>
</c:forEach>

</div>
</div>

</div>
</c:if>
<c:if test="${boardList.size()-1 < 0}">
<div id="div_mak"></div>
<div class="card border-primary mb-3" id="div_result_none" style="max-width: 40rem;">
  <div class="card-header">결과 값이 없습니다.</div>
  <div class="card-body">
    <p class="card-text">검색된 결과가 존재하지않습니다. 취미선택 화면으로 돌아가시겠습니까?</p>
    <button class="btn btn-primary" onclick="location.href='recommendSelect.wow'">취미선택 화면으로</button>
  </div>
</div>
</c:if>
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
winHeight = window.innerHeight;

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
	
 var board = $("#List").val();
var board_index = $(".board_index").val();

 if(board=='[]'){  //값이 없음
	 alert("값이없다.");
	 $("#box_body *").remove();
 	var str="";
 	str+="<div class='card border-primary mb-3'>"
 
 	str+= "<div class='card-body'>"
 	str+="<h4 class='card-title'>검색된 값이 존재하지 않습니다.</h4>"
 	str+="<p class='card-text'>검색된 값이 존재하지 않습니다. 처음으로 돌아가시기 바랍니다.</p>"
 	str+="<button type='button' class='btn btn-primary' onclick='fn_reset()' >"
 	str+=" 처음으로</button>"
 	str+="</div></div>"
 	$("#box_body").append(str);
 }

 
 
});
function fn_reset() {
	location.href="recommendSelect.wow";

	
} 



</script>
</html>