<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<% request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/findFriend.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/bootstrap/bootstrap.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<style type="text/css">
 .customoverlay {position:relative;bottom:60px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:5px 15px;font-size:14px;font-weight:bold;}
.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
</style>
<body>
<%@ include file="/WEB-INF/views/common/top.jsp" %>
<div class="div_container">
	<div class="div_header">
	</div>	
	<div class="div_container_flex">
	<div class="div_map" id="map">
		<h3>주소 : 대전 광역시 중구 용두12로 1</h3>
	</div>
	
    <div class="div_find_friend">
         <div class="div_modal_attend">
             <div class="div_modal_attend_top">
                 <h3>주변 친구 목록</h3>
                 <span id="span_line"></span>
             </div>
             <table id="around_friend">
             	<!-- ajax로  -->
             </table>
         </div>
     </div>
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
			<div class="modal-dialog" role="document"  style="z-index:99999 !important">
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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f614523cd5dababea1d0a27b38ee9d9a&libraries=services"></script>
	<script>

	let addr_arr = []; //주소저장
	let id_arr = []; // 아이디저장
	let centerAddr = ""; //중심 주소(로그인한 사람)
	let centerXY; // 중심 좌표
	let center_XY;
	let centerId = "";
	let xy_arr = []; //좌표저장
	//로딩 시 회원목록의 주소를 가져와 배열에 저장한다.
	
    function getAddrData(map){
    	var str;
    	
    	
    	str += `<tr>`;
    	str += `<td width="120px" height="20px">아이디</td>`;
    	str += `<td width="120px" height="20px">거리</td>`;
    	str += `</tr>`;
		$.each(map.memberList, function(i, element){
			//=============================DB에서 주소 가져오기======================================
		if(map.memberList_length != 0){
				var str_img;
				
				if(element.memGender=="적"){
					str_img = `<td width="50px"><img src="${pageContext.request.contextPath}/design/img/criminal.png" width="30px" height="30px"></td>`;	
				}else{					
					if(element.memGender == "남"){
						console.log(element.memGender);
						str_img = `<td width="50px"><img src="${pageContext.request.contextPath}/design/img/man.png" width="30px" height="30px"></td>`;		
					}else{
						str_img = `<td width="50px"><img src="${pageContext.request.contextPath}/design/img/woman.png" width="30px" height="30px"></td>`;
					}
				}
				
				
				str +=`<tr>`;
				str += str_img;
				str += `<td width="120px" id="find_id" height="20px"><span class="attend_list">\${element.memId}</span></td>
                     <td width="120px" height="20px"><span class="attend_list attend_list_dist">\${element.memDist}km<span></td>
                     <td width="120px" height="20px"><span class="attend_list"><button class="member_view_button btn btn-primary">상세보기</button><span></td>
	                  </tr>`;
	                  
				var memAddr = element.memRoadAddr;
				var memId = element.memId;
				
				id_arr.push(memId);
				addr_arr.push(memAddr);
		}	
		});//each
		console.log("id_arr = " + id_arr);
		if(map.memberList_length == 0){
			str = '<tr><td><div id="nothing_friend">주변 동네 친구가 없습니다.</div></td></tr>';
			$('.div_modal_attend_top').html('');
		}
		centerAddr = map.centerUser.memRoadAddr;
		centerId = map.centerUser.memId;
      $(".div_modal_attend_top + table").html(str);
		
      drawCenter();
    } //function getData
    
	$(document).ready(function(){
		$.ajax({
			url:'<c:url value="/findFriend/load" />',
			dataType:'json',
			data:{"userId":"${sessionScope.user.userId}"},
			type:'post',
			async:false,
			success:function(map){
				getAddrData(map);
				
	        //=============================DB에서 주소 가져오기======================================
		}, //success

			error:function(){
				alert("통신오류");
			} //error
		}); //ajax
	});
    
	//지도 객체 생성
	var container = document.getElementById('map');
	var options = {
		center: new kakao.maps.LatLng(33.450701, 126.570667),
		level: 6
	};

	var map = new kakao.maps.Map(container, options);

    //주소 정보를 좌표로 반환
    var geocoder = new kakao.maps.services.Geocoder();


	//좌표로 변환하는 promise 객체 선언
	const addressSearch = address => {
		return new Promise((resolve, reject) => {
			geocoder.addressSearch(address, function(result, status){
				if(status === kakao.maps.services.Status.OK){     //result[0].road_address.address_name
					resolve({"x":result[0].x, "y":result[0].y, "id":centerId});
				}else{
					reject(status);
				}
			})
		});   
	}; //addressSearch
    
    
	        


	async function drawCenter(){
		try{
			const result = await addressSearch(centerAddr);
			center_XY = {
			 		'x':result.x,
					'y':result.y
			} 
			var coords = new kakao.maps.LatLng(result.y, result.x);
		   var marker = new kakao.maps.Marker({
	                map: map,
	                position: coords
	           });
			  
		   		   var content = '<div class="customoverlay">'
	   					+'<a href="#" target="_blank">'
	   					+'<span class="title">나</span>'
	   					+'</a>'
	   					+'</div>';
	   					
	            var cutomOverlay = new kakao.maps.CustomOverlay({
		            map:map,
		            position:coords,
		            content:content,
		            yAnchor:1
	            });

		  map.setCenter(coords);
		  
		  // 지도에 표시할 원을 생성합니다=====================================================================
	            var circle = new kakao.maps.Circle({
	                center : coords,  // 원의 중심좌표 입니다 
	                radius: 3000, // 미터 단위의 원의 반지름입니다 
	                strokeWeight: 3, // 선의 두께입니다 
	                strokeColor: '#75B8FA', // 선의 색깔입니다
	                strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
	                strokeStyle: 'dashed', // 선의 스타일 입니다
	                fillColor: '#CFE7FF', // 채우기 색깔입니다
	                fillOpacity: 0.4  // 채우기 불투명도 입니다   
	            }); 

	            // 지도에 원을 표시합니다 
	            circle.setMap(map); 
		
	}catch(e){
		console.log(e);
	}			
	       getLocation();
}
	
	let count = 0;
	function getLocation(){
		// 주소로 좌표를 검색합니다
		addr_arr.forEach(function(addr, index){
			geocoder.addressSearch(addr, function(result, status) {
		        // 정상적으로 검색이 완료됐으면 
		         if (status === kakao.maps.services.Status.OK) {
		            
		            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		            
		         	//마커 생성
		            var marker = new kakao.maps.Marker({
		                map: map,
		                position: coords
		            });
				 
					 var content = '<div class="customoverlay">'
   					+'<a href="#" target="_blank">'
   					+'<span class="title">'+ id_arr[count] + '</span>'
   					+'</a>'
   					+'</div>';
   					
				var cutomOverlay = new kakao.maps.CustomOverlay({
					map:map,
					position:coords,
					content:content,
					yAnchor:1
				}); 
		    } // if (status == ok)
			count++;
		    	
		    
		}); //addressSearch
	});  

	}

		
		
		
		
		
		
		
		
		
		
		//상세보기 누르면 회원 상세보기 나오기
		$(document).on("click", ".member_view_button", function(){
			var id = $(this).closest('td').siblings('#find_id').children('span');
			$.ajax({
				url : "<c:url value='/participation/joinMember'/>",
				type:'post',
				data:{'normalPartId':id.html()},
				dataType:'json',
				success:function(map){
					
					//상세보기 버튼 클릭하면 쪽지보내기 위해서 토글 클래스 하나 추가해놓는다.
					id.addClass('checked');
					
					var maskHeight = $(document).height();
					var maskWidth = $(window).width();
					var div = $("#div_member_info_view");
					$(".div_member_info_view").css('top',Math.max(0, (($(window).height() - div.outerHeight()) / 2) + $(window).scrollTop()) + "px");
					$(".div_member_info_view").css("left", "1200px");
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
					str += '<tr>' + '<td width="200px">평점 : '+ map.score +'</td>' + '</tr>';
					str += '<tr>' + '<td id="active_title" colspan="2" width="200px">최근활동내역(10개) </td>' + '</tr>';
					
					if(map.activity.length == 0){
						str += '<tr><td colspan="2">&nbsp;&nbsp;참여한 활동이 없습니다.</td></tr>';
					}
					
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
					alert("통신 오류")	
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
				type:'post',
				dataType:'text',
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