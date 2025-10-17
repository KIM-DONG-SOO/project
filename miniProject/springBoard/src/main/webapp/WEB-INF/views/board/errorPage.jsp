<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>


<body>
	<h2><spring:message code="${errorMsg}" /></h2>
<table align="center">
	<tr>
		<td align="right">
			<a href="/board/boardList.do">목록으로 돌아가기</a>
		</td>
	</tr>
</table>	
</body>
</html>