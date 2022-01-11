<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>Home</title>
</head>
<%@ include file="/WEB-INF/inc/header.jsp" %>
<%@ include file="/WEB-INF/views/common/chatting.jsp" %>
<link href="<%= request.getContextPath()%>/design/bootstrap/_bootswatch.scss" rel="stylesheet" style="text/css">
<link href="<%= request.getContextPath()%>/design/bootstrap/_variables.scss" rel="stylesheet" style="text/css">
<link href="<%= request.getContextPath()%>/design/bootstrap/bootstrap.css" rel="stylesheet" style="text/css">
<link href="<%= request.getContextPath()%>/design/bootstrap/bootstrap.min.css" rel="stylesheet" style="text/css">


<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/home.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/bootstrap/bootstrap.css">
<body>
<%@ include file="/WEB-INF/views/common/top.jsp" %>
<div class="div_container">


	<!-- 검색창 start -->
	<div class="div_search">
		<!-- <div class="div_main">		
			<h1>Find You</h1>
			<h1 id="h1_text">당신을 찾아드립니다</h1>
		</div> -->
	</div>
	<!-- 검색창 end -->

<!-- 게시판 소개 start -->
    <div  class="div_board_img">
    	<div class="product_con">
			<ul class="product_list">
				
			</ul>
       <button type="button" id="btn_prev">&lt;</button>
	   <button type="button" id="btn_next">&gt;</button>
		</div>

    </div>
    <!-- 게시판 소개 end -->

    <!-- 게시판 리스트 start -->
    <div class="div_board_list">
        <div class="div_board_list_choice">
            <button class="list_btn_normal" style="border-bottom:5px solid rgb(120,147,236)"><b>모임 게시판</b></button>
            <button class="list_btn_business"><b>사업자 게시판</b></button>
            <button class="list_btn_notice"><b>공지사항</b></button>
        </div>
 
        <div class="div_board_list_eight">
            <div class="div_14">
            		<c:forEach begin="0" end="${normalBoardList14.size()-1}" var="i">
	                <div class="div_board_list_${i+1}" onclick='location.href="/normalBoard/normalBoardView.wow?normalBoardIndex=${normalBoardList14.get(i).normalBoardIndex}"'>
	                    <h4>${normalBoardList14.get(i).normalBoardTitle}</h4>
	                    <h5>${normalBoardList14.get(i).normalBoardRegDate}</h5>
	                </div>
               	</c:forEach>            
            </div>

            <div class="div_58">
					<c:forEach begin="0" end="${normalBoardList58.size()-1}" var="i">
                <div class="div_board_list_${i+5}" onclick='location.href="/normalBoard/normalBoardView.wow?normalBoardIndex=${normalBoardList58.get(i).normalBoardIndex}"'>
                    <h4>${normalBoardList58.get(i).normalBoardTitle}</h4>
                    <h5>${normalBoardList58.get(i).normalBoardRegDate}</h5>
                </div>
                </c:forEach>
            </div>
        </div>
         <button class="div_board_list_button" onclick='location.href="normalBoard/normalBoardList.wow"'>더보기</button>
    </div>
    <!-- 게시판 리스트 end -->
	
	
	<!-- 조회수베스트/ 평점베스트 / 댓글베스트 start -->
	<div class="div_cnt_score_reply">
		<div class="div_cnt_score_reply2">
			<!--조회수 베스트  -->
			<div class="div_cnt_best">
				<div class="div_cnt_best_title">
					<h4><b>조회수 베스트</b></h4>
				</div>
				<div class="div_cnt_best_rank">
					<table class="div_cnt_best_rank_table">
						<thead>
							<tr>
								<td class="rank_width"><b>랭킹</b></td>
								<td><b>제목</b></td>
							</tr>
						</thead>
						<tbody>
						<c:forEach begin="0" end="${cntBestRankList.size()-1}" var="i">
							<tr class="change">
								<td class="rank_width">${i+1}</td>
									<c:if test="${cntBestRankList.get(i).b2bBoardCategory eq 'normal'}">
										<td >
											<span class="rank_width2 rank_normal" onclick="fn_cnt_rank_normal()">${cntBestRankList.get(i).b2bBoardTitle}</span>
											<input class="fn_cnt_rank_normal" type="hidden" value="${cntBestRankList.get(i).b2bBoardIndex}">
										</td>
									</c:if>
									
									<c:if test="${cntBestRankList.get(i).b2bBoardCategory eq 'business'}">
										<td ><span class="rank_width2 rank_business" onclick="fn_cnt_rank_business()">${cntBestRankList.get(i).b2bBoardTitle}</span>
											<input class="fn_cnt_rank_business" type="hidden" value="${cntBestRankList.get(i).b2bBoardIndex}">
										</td>
									</c:if>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<!--댓글 베스트  -->
			<div class="div_reply_best">
				<div class="div_reply_best_title">
					<h4><b>댓글 베스트</b></h4>
				</div>
				<div class="div_reply_best_rank">
					<table class="div_reply_best_rank_table">
						<thead>
							<tr >
								<td class="rank_width"><b>랭킹</b></td>
								<td><b>제목</b></td>
							</tr>
						</thead>
						<tbody>
							<c:forEach begin="0" end="${replyBestRankList.size()-1 }" var="i">
							<tr class="change">
								<td>${i+1}</td>
								
									<c:if test="${replyBestRankList.get(i).reCategory eq 'normal'}">
										<td>
											<span class="rank_width2 rank_normal_reply">${replyBestRankList.get(i).reContent }</span>
											<input class="fn_reply_rank_normal" type="hidden" value="${replyBestRankList.get(i).reParentNo}">
										</td>
									</c:if>
									
									<c:if test="${replyBestRankList.get(i).reCategory eq 'business'}">
										<td>
											<span class="rank_width2 rank_business_reply" >${replyBestRankList.get(i).reContent }</span>
											<input class="fn_reply_rank_business" type="hidden" value="${replyBestRankList.get(i).reParentNo}">
										</td>
									</c:if>
									
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<!--회원평점 베스트  -->
			<div class="div_score_best">
				<div class="div_score_best_title ">
					<h4><b>회원 평점 베스트</b></h4>
				</div>
				<div class="div_score_best_rank">
					<table class="div_score_best_rank_table">
						<thead>
							<tr>
								<td class="rank_width"><b>랭킹</b></td>
								<td><b>아이디</b></td>
							</tr>
						</thead>
						<tbody>
						<c:if test="${scoreBestRankList.size() eq 10}">
							<c:forEach begin="0" end="${scoreBestRankList.size()-1 }" var="i">
							<tr class="change">
								<td class="rank_width">${i+1}</td>
								<td class="rank_width_id">${scoreBestRankList.get(i).memberScoreId }</td>
							</tr>
							</c:forEach>
						</c:if>
						<c:if test="${scoreBestRankList.size() < 10}">
							<c:forEach begin="0" end="${scoreBestRankList.size()-1 }" var="i">
							<tr class="change">
								<td class="rank_width">${i+1}</td>
								<td class="rank_width_id">${scoreBestRankList.get(i).memberScoreId }</td>
							</tr>
							</c:forEach>
							<c:forEach begin="${scoreBestRankList.size()}" end="9" var="i">
							<tr class="change">
								<td class="rank_width">${i+1}</td>
								<td class="rank_width_id">-</td>
							</tr>
							</c:forEach>
						</c:if>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- 조회수베스트/ 평점베스트 / 댓글베스트 end -->
	
	
	
	

    <!-- 내주변 취미활동 / 취미추천 start -->
    <div class="div_hobby_recommend">
        <div class="div_hobby_recommend2">
            <div class="div_hobby">
                <div class="div_hobby_title">
                    <h2 class="changing-title">주변 친구</h2>
                </div>
                <div class="div_hobby_img">
                    <img src="<%=request.getContextPath()%>/design/img/findyoumap.png" width="500px" height="290px">
                    <button class="hobby_img_button btn btn-warning" onClick="location.href='/findFriend/findFriend.wow'">바로가기</button>
                </div>
                <div class="div_hobby_content">
                    <p>반경 3km 주변에 어떤 친구들이 있을까요 ? <br> 주변 친구들이 어떤 취미활동을 하고 있는지 찾아보세요. </p>
                </div>
            </div>
            <div class="div_recommend">
                    <div class="div_recommend_title ">
                        <h2 class="changing-title">모임 추천</h2>
                    </div>
                    <div class="div_recommend_img">
                        <img src="<%=request.getContextPath()%>/design/img/hobbyreco.png" width="500px" height="290px">
                        <button class="recommend_img_button btn btn-warning" onClick="location.href='/recommendHobby/recommendSelect.wow'">바로가기</button>
                    </div>
                    <div class="div_recommend_content">
                        <p>나의 MBTI와 맞는 취미활동은 ? <br>MBTI별 취미활동을 추천받아보세요.</p>
                    </div>
            </div>
        </div>
    </div>
    <!-- 내주변 취미활동 / 취미추천 end -->
	

	
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<script type="text/javascript">





$(document).ready(function(){

});
//모임게시판 버튼 클릭
$('.list_btn_normal').on('click', function(){
	$(this).css('border-bottom','5px solid rgb(120,147,236)');
	$(this).next().css('border-bottom','none');
	$(this).next().next().css('border-bottom','none');
	
	$.ajax({
		url : "<c:url value='/homenormalList.wow'/>"
		,type : "post"
		,dataType : 'json'
		 ,success : function(map){

    		var str="";
	    	var str2="";
    		$.each(map.normalBoardList14, function(i, element){
				str +=    		'<div class="div_board_list_${i+1} normalBoard_click_index" data-index='+element.normalBoardIndex+'>';
				str +=          	'<h4>'+element.normalBoardTitle+'</h4>';
				str +=          	'<h5>'+element.normalBoardRegDate+'</h5>';
				str +=      		'</div>';
    		});

    		$.each(map.normalBoardList58, function(i, element){
				str2 +=      	'<div class="div_board_list_${i+5} normalBoard_click_index" data-index='+element.normalBoardIndex+'>';
				str2 +=          	'<h4>'+element.normalBoardTitle+'</h4>';
				str2 +=          	'<h5>'+element.normalBoardRegDate+'</h5>';
				str2 +=      	'</div>';
    		});

			var str3='<button id="btn_business" class="div_board_list_button" onClick="fn_normal_move()">더보기</button>';
			$('div_board_list_button').remove();
			$('.div_14').html(str);
			$('.div_58').html(str2);
			$('.div_board_list').append(str3);

			}
	
	});

});


//사업자게시판 버튼 클릭
$('.list_btn_business').on('click', function(){
	$(this).css('border-bottom','5px solid rgb(120,147,236)');
	$(this).prev().css('border-bottom','none');
	$(this).next().css('border-bottom','none');
	
	$.ajax({
		url : "<c:url value='/homeB2bList.wow'/>"
		,type : "post"
		,dataType : 'json'
		 ,success : function(map){

    		var str="";
	    	var str2="";
    		$.each(map.businessBoardList14, function(i, element){
				str +=    		'<div class="div_board_list_${i+1} b2bBoard_click_index" data-index='+element.b2bBoardIndex+'>';
				str +=          	'<h4>'+element.b2bBoardTitle+'</h4>';
				str +=          	'<h5>'+element.b2bBoardRegDate+'</h5>';
				str +=      		'</div>';
    		});

    		$.each(map.businessBoardList58, function(i, element){
				str2 +=      	'<div class="div_board_list_${i+5} b2bBoard_click_index" data-index='+element.b2bBoardIndex+'>';
				str2 +=          	'<h4>'+element.b2bBoardTitle+'</h4>';
				str2 +=          	'<h5>'+element.b2bBoardRegDate+'</h5>';
				str2 +=      	'</div>';
    		});

			var str3='<button id="btn_business" class="div_board_list_button" onClick="fn_business_move()">더보기</button>';
			$('div_board_list_button').remove();
			$('.div_14').html(str);
			$('.div_58').html(str2);
			$('.div_board_list').append(str3);

			}
	
	});

});

//공지사항 게시판 리스트로 이동
$('.list_btn_notice').on('click', function(){
	$(this).css('border-bottom','5px solid rgb(120,147,236)');
	$(this).prev().css('border-bottom','none');
	$(this).prev().prev().css('border-bottom','none');
	
	$.ajax({
		url : "<c:url value='/homeNoticeList.wow'/>"
		,type : "post"
		,dataType : 'json'
		 ,success : function(map){

    		var str="";
	    	var str2="";
    		$.each(map.noticeBoardList14, function(i, element){
				str +=    		'<div class="div_board_list_${i+1} noticeBoard_click_index" data-index='+element.noticeBoardIndex+'>';
				str +=          	'<h4>'+element.noticeBoardTitle+'</h4>';
				str +=          	'<h5>'+element.noticeBoardRegDate+'</h5>';
				str +=      		'</div>';
    		});

    		$.each(map.noticeBoardList58, function(i, element){
				str2 +=      	'<div class="div_board_list_${i+5} noticeBoard_click_index" data-index='+element.noticeBoardIndex+'>';
				str2 +=          	'<h4>'+element.noticeBoardTitle+'</h4>';
				str2 +=          	'<h5>'+element.noticeBoardRegDate+'</h5>';
				str2 +=      	'</div>';
    		});

			var str3='<button id="btn_business" class="div_board_list_button" onClick="fn_notice_move()">더보기</button>';
			$('div_board_list_button').remove();
			$('.div_14').html(str);
			$('.div_58').html(str2);
			$('.div_board_list').append(str3);

			}
	
	});
	
	
});
//ajax로 만든 게시글 클릭할때 해당 게시글로 이동(공지사항)
$(document).on('click','.noticeBoard_click_index', function(){
	var dataIndex = $(this).data('index');
	 window.location.href = '<%=request.getContextPath()%>/managerBoard/noticeBoardView.wow?noticeBoardIndex='+dataIndex;

});








//ajax로 만든 게시글 클릭할때 해당 게시글로 이동(비지니스)
$(document).on('click','.b2bBoard_click_index', function(){
	var dataIndex = $(this).data('index');
	 window.location.href = '<%=request.getContextPath()%>/businessBoard/businessBoardView.wow?b2bBoardIndex='+dataIndex;

});
//ajax로 만든 게시글 클릭할때 해당 게시글로 이동(일반)
$(document).on('click','.normalBoard_click_index', function(){
	var dataIndex = $(this).data('index');
	 window.location.href = '<%=request.getContextPath()%>/normalBoard/normalBoardView.wow?normalBoardIndex='+dataIndex;

});



//비지니스 게시판 리스트로 이동
function fn_business_move(){
	location.href='<%=request.getContextPath()%>/businessBoard/businessBoardList.wow';
}
//모임 게시판 리스트로 이동
function fn_normal_move(){
	location.href='<%=request.getContextPath()%>/normalBoard/normalBoardList.wow';
}
function fn_notice_move(){
	location.href='<%=request.getContextPath()%>/managerBoard/noticeBoardList.wow';
}




//조회수 게시물 클릭(normal)
$('.rank_normal').on('click', function(){
	var dataIndex = $(this).next().val();
	//location.href="<c:url value=''/>"
	window.location.href = '<c:url value="normalBoard/normalBoardView.wow?normalBoardIndex="/>'+dataIndex;
});
//조회수 게시물 클릭(business)
$('.rank_business').on('click', function(){
var dataIndex = $(this).next().val();
	window.location.href = '<%=request.getContextPath()%>/businessBoard/businessBoardView.wow?b2bBoardIndex='+dataIndex;
});
//댓글 게시물 클릭(normal)
$('.rank_normal_reply').on('click', function(){
	var dataIndex = $(this).next().val();
	window.location.href = '<%=request.getContextPath()%>/normalBoard/normalBoardView.wow?normalBoardIndex='+dataIndex;
});
//댓글 게시물 클릭(business)
$('.rank_business_reply').on('click', function(){
var dataIndex = $(this).next().val();
	window.location.href = '<%=request.getContextPath()%>/businessBoard/businessBoardView.wow?b2bBoardIndex='+dataIndex;
});





//공지사항 버튼 클릭
$('.list_btn_notice').on('click', function(){
	$(this).css('border-bottom','5px solid rgb(120,147,236)');
	$(this).prev().css('border-bottom','none');
	$(this).prev().prev().css('border-bottom','none');
});


/////////////////////////////////////////사진////////////
let page="";


$(function(){

    $("#btn_next").click(function(){
        page = "next";
        clearInterval(time_interval);
        find_num(page);

    });
    $("#btn_prev").click(function(){
        page = "prev";
        clearInterval(time_interval);
        find_num(page);

    });

    //2차-1 li태그 생성(2차-2)
    let outPut="";
    for(let i=0; i<img_size; i++){
        console.log("img_size::"+i);
        outPut +="<li><a href='#'></a></li>";
    }
    $(".product_list").html(outPut);

    //3차-1  li태그에 이미지넣기(3차-2)
    for(let i=0; i<img_size; i++){
        $(".product_list > li:nth-child("+(i+1)+")")
            .css({"background": "url('"+img_files[i]+"')", "background-size":"60% 500px"}); 

    }

    $(window).resize(function() { 
        fn_win_size();
        find_num(page);
    });

    fn_win_size();

    let time_interval= setInterval(function(){
        find_num(page); 
    },2000);
});  

//1차-1 이미지 배열선언(1차-2)
let img_files=[
    //3차-3 추가이미지 넣고 확인해보기(All-e)
    "./design/img/mainblack.png",
    "./design/img/mainmbti.png",
    "./design/img/mainhobby.png",
    "./design/img/mianservice.png",
];
//1차-2  이미지 개수 구하기(1차-3)
let img_size = img_files.length;

let cur_no =0; 
let next_no =1;

function find_num(page){
    if(page == "next"){
         if(cur_no==0 && next_no == img_size ){//1차-3 개수 바꾸기(1차-4)
            cur_no= img_size;//1차-4 개수 바꾸기(1차-5)
            next_no= 1;
        }else{
            if(cur_no == img_size){//1차-5 개수 바꾸기(1차-6)
                cur_no =1;
            }else{
                if(cur_no != next_no){
                    cur_no++;
                }
            }
            next_no = cur_no +1;
            if(next_no == img_size+1){//1차-6 개수 바꾸기(1차-7)
                next_no =1;
            }
        }
        find_img(cur_no, next_no, page);
    }else{
        if(cur_no == 0 && next_no ==1 ){
            cur_no = 1;
            next_no = img_size;//1차-7 개수 바꾸기(1차-8)
        }else{
            cur_no = next_no;
            next_no = cur_no -1;
            if (next_no == 0 ){
                next_no = img_size;//1차-8 개수 바꾸고 잘되는지 확인 (1차-e) 
            }
        }
        find_img(cur_no, next_no, page);
        cur_no--;
    }
};

function find_img(cur_no, next_no, page){
    let next_size, cur_size;
    if(page == "next"){
        next_size = win_size;
        cur_size = win_size*-1;
    }else{
        next_size = win_size*-1;
        cur_size = win_size;
    }
    $(".product_list > li:nth-child("+next_no+")")
        .css({ left : next_size, display : 'block'});
    $(".product_list > li:nth-child("+cur_no+")")
        .stop().animate({left : cur_size, opacity : 0});
    $(".product_list > li:nth-child("+next_no+")")
        .stop().animate({left : 0, opacity : 1},500);
}
function fn_win_size(){
    win_size= document.body.offsetWidth  -20;

    let product_con = $(".product_con");
    let product_list = $(".product_list");
    let product_list_li = $(".product_list > li");

    product_con.css("width", win_size);
    product_list.css("width", win_size);
    product_list_li.css("width", win_size);

    product_list_li.css("left", win_size);
    let img =  $(".product_list > li:nth-child(1)");
    img.css("left",0);
}



</script>

</html>
