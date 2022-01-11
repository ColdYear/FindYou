<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%request.setCharacterEncoding("utf-8"); %>

<meta charset="UTF-8">
<title>Insert title here</title>


</head>
<%@include file="/WEB-INF/inc/header.jsp"%>
<link rel="stylesheet"
	href="<%= request.getContextPath() %>/design/css/footer.css">
<body>
    <div class="div_container2">
        <div class="div_footer">
            <div class="div_footer_img">
                <table class="div_table_logo" >
                    <tr>
                        <td><div class="div_logo_img"><input type="image" src="<%=request.getContextPath()%>/design/img/findyou_logo.png" width="70px;" height="60px;" ></div></td>
                        <td><div class="div_logo_text">Find You</div></td>
                    </tr>
                </table>
            </div>
            <table class="footer_table">
                <thead>
                    <tr>
	                        <td><b>회사정보</b></td>
	                        <td><b>고객센터 C/S Center</b></td>
	                        <td><b>근무시간</b></td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <ul>
                                <li>상호명 : Find You</li>
                                <li>대표: 여인욱</li>
                                <li>주소 : 서울특별시 송파구 올림픽로 300</li>
                                <li>사업자등록번호 : 202-20-11109</li>
                            </ul>
                        </td>
                        <td>
                            <ul>
                                <li>전화 : 02.987.6543</li>
                                <li>팩스 : 02.987.6542</li>
                                <li>이메일 : findyou@naver.com</li>
                                <li>카카오톡 ID : findyou</li>
                            </ul>
                        </td>
                        <td>
                            <ul>
                                <li>근무시간 : 월 ~ 금 AM 9:00 ~ PM 6:00</li>
                                <li>점심시간 : PM 12:00 ~ PM 1:00</li>
                                <li>고객센터 : AM 9:00 ~ PM 6:00</li>
                            </ul>
                        </td>

                    </tr>

                </tbody>
            </table>
        </div>
    </div>
</body>
<script>
</script>
</html>