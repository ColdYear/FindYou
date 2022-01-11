<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<%request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/noticeBoardModify.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/top.jsp" %>
<div class="div_container">
    <div class="notice_board_view_text">
        <h2>
            공지사항 - <small>글 수정</small>
        </h2>
    </div>
    <div class="notice_board_view">
        <div class="notice_board_view2">
            <table class="notice_board_view_tabel" border="0">
                <colgroup>
                    <col width="800px"/>
                </colgroup>
                <tr>
                    <td height="30px">&nbsp;&nbsp;<b>제목</b></td>
                </tr>
                <tr>
                    <td height="30px"  >&nbsp;&nbsp;<input type="text" id="notice_title"></td>
                </tr>
                <tr>
                    <td height="30px">&nbsp;&nbsp;<b>내용</b></td>
                </tr>
                <tr>
                    <td height="300px" >
                        &nbsp;&nbsp;<textarea id="notice_content"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="notice_board_view_button">
                            <div class="notice_board_update_button">
                                <button>수정</button>
                            </div>        
                            <div class="notice_board_list_button">
                                <button>목록</button>
                            </div>    
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        
    </div>



</div>

</body>
</html>