<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="reply.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
form {
	display: inline;
}
</style>
</head>
<body>
	<h2>상세 게시판</h2>

	<table border="1" width="80%">
		<tr>
			<th>글번호</th>
			<td>${ boardQAVO.no }</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${ boardQAVO.title }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${ boardQAVO.writer }</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${ boardQAVO.content }</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${ boardQAVO.regDate }</td>
		</tr>
	</table>
	<form
		action="${ pageContext.request.contextPath }/boardQA/${ boardQAVO.boardNo }"
		method="get">
		<input type="submit" value="수정" />
	</form>
	<form
		action="${ pageContext.request.contextPath }/boardQA/${ boardQAVO.boardNo }"
		method="post">
		<input type="hidden" name="_method" value="delete"> <input
			type="submit" value="삭제" />
	</form>
	<input type="button"
		onclick="location.href='${ pageContext.request.contextPath }/boardQA/list'"
		value="목록" />


	<!-- 댓글 -->

	<div class="container">
		<label for="content">comment</label>
		<form name="commentInsertForm">
			<div class="input-group">
				<input type="hidden" name="rno" value="${ boardQAVO.boardNo }" /> 
				<input type="text"  id="writer" name="writer" placeholder="작성자를 입력하세요."/>
				<input type="text" id="content" name="content"	placeholder="내용을 입력하세요."/>
				<span class="input-group-btn">
				<button type="button" name="commentInsertBtn">등록</button>
				</span>
			</div>
		</form>
	</div>

	<div class="container">
		<div class="commentList"></div>
	</div>



</body>
</html>