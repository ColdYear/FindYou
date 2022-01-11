<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<% request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="map" style="width:1000px;height:800px;"></div>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f614523cd5dababea1d0a27b38ee9d9a&libraries=services"></script>
	<script>
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);

        //주소 정보를 좌표로 반환
        var geocoder = new kakao.maps.services.Geocoder();
       

        listData = [
        {
            groupAddress:'대전 서구 복수동로 21-19',
        },
        {
            groupAddress:'대전 서구 복수동로 21-20'
        }

        ] 

        var arr_xy = [];
// 주소로 좌표를 검색합니다
for(var i=0; i < listData.length; i++){
    geocoder.addressSearch(listData[i].groupAddress, function(result, status) {

        // 정상적으로 검색이 완료됐으면 
         if (status === kakao.maps.services.Status.OK) {
            arr_xy.push([result[0].y, result[0].x]);
            
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
            // 결과값으로 받은 위치를 마커로 표시합니다
            var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다    
            imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
            imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

            // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
            markerPosition = new kakao.maps.LatLng(37.54699, 127.09598); // 마커가 표시될 위치입니다

            var marker = new kakao.maps.Marker({
                map: map,
                position: coords,
                image:markerImage
            });
    
            // 인포윈도우로 장소에 대한 설명을 표시합니다
            var infowindow = new kakao.maps.InfoWindow({
                content: result[0].road_address.address_name
            });
            infowindow.open(map, marker);
    

            map.setCenter(coords);

            console.log(arr_xy);

            

        } 
    }); 
}
        
        var linePath = [
            new kakao.maps.LatLng(33.452344169439975, 126.56878163224233),
            new kakao.maps.LatLng(33.452739313807456, 126.5709308145358),
            new kakao.maps.LatLng(33.45178067090639, 126.5726886938753) 
        ];

        // 지도에 표시할 선을 생성합니다
        var polyline = new daum.maps.Polyline({
            path: linePath, // 선을 구성하는 좌표배열 입니다
            strokeWeight: 5, // 선의 두께 입니다
            strokeColor: '#FFAE00', // 선의 색깔입니다
            strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
            strokeStyle: 'solid' // 선의 스타일입니다
        });

        polyline.setMap(map);

        var distance = polyline.getLength();
            
	</script>
</body>
</html>