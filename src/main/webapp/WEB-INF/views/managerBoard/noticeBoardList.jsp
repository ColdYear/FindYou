<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<%request.setCharacterEncoding("utf-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/css/noticeBoardList.css">
<link href="<%= request.getContextPath()%>/design/bootstrap/bootstrap.css" rel="stylesheet" style="text/css">
<link href="<%= request.getContextPath()%>/design/bootstrap/bootstrap.min.css" rel="stylesheet" style="text/css">
<meta charset="UTF-8">
<title>공지사항</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/top.jsp" %>




<div class="div_container">
    <div class="div_notice_text">
        <h1 class="title_main"></h1>
    <img src="${pageContext.request.contextPath}/design/img/noticebanner.png" width="100%" height="300px">
        
    </div>
    
                <c:if test="${user.userRole =='manager' }">
            <div class="div_notice_regist_button">
                <button class="notice_button btn btn-danger" onclick="location.href='<%=request.getContextPath()%>/managerBoard/noticeBoardRegist.wow?userRole=${user.userRole}'">등록</button>
            </div>
            </c:if>
    <div class="div_notice">
        <div class="div_notice_table">
            <table class="notice_table" style="border-collapse: collapse; overflow:auto;"  >
                <colgroup>
                    <col width="100px"/>
                    <col width="700px"/>
                    <col width="100px">
                    <col width="150px"/>
                </colgroup>
                <thead>
                    <tr class="notice_tr">
                        <td height="40px">글 번호</td>
                        <td>제 목</td>
                        <td>작성자</td>
                        <td>등록일</td>
                    </tr>
                </thead>
                <tbody class="notice_table_tbody">
	                <c:forEach items="${list }" var="list">
								<tr class="notice_tr" onclick="location.href='<%=request.getContextPath() %>/managerBoard/noticeBoardView.wow?noticeBoardIndex=${list.noticeBoardIndex}'">
									<td height="40px">${list.noticeBoardIndex }</td>
									<td class="notice_title">${list.noticeBoardTitle}</td>
									<td>${list.noticeBoardWriter }</td>
									<td>${list.noticeBoardRegDate }</td>
								</tr>
							</c:forEach>
     

                </tbody>
            </table>

        </div>
    </div>
</div>
</body>
</html>