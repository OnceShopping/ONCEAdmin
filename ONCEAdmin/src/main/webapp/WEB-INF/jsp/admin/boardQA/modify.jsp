<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<form:form commandName="boardVO" method="PUT">
		<table border="1" width="80%">
			<tr>
				<th width="25%">제목</th>
				<td><form:input type="text" path="title"/> </td>
			</tr>
			<tr>
				<th width="25%">글쓴이</th>
				<td><form:input type = "text" path="writer"/></td>
			</tr>
			<tr>
				<th width="25%">내용</th>
				<td><form:textarea rows="7" cols="10" path="content"/></td>
			</tr>
		</table>
		<input type="submit" value="등록"/>
	</form:form>

</body>
</html>