<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="app">
<head>

<title>ONCE</title>
<meta name="description"
	content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/bootstrap.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/animate.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/font-awesome.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/icon.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/font.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/app.css"
	type="text/css" />

<script
	src="${pageContext.request.contextPath }/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script
	src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
<!-- App -->
<script src="${pageContext.request.contextPath }/resources/js/app.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/js/slimscroll/jquery.slimscroll.min.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/js/app.plugin.js"></script>

<style type="text/css">
th {
	text-align: center;
	font-size: 13pt;
}
</style>
<script>
function sidemenu(){
	document.getElementById('itemRegister').setAttribute('class','');
	document.getElementById('itemList').setAttribute('class','');
	document.getElementById('itemManage').setAttribute('class','');
	document.getElementById('orderList').setAttribute('class','');
	document.getElementById('staffManage').setAttribute('class','');
	document.getElementById('boardQAList').setAttribute('class','');
}

$(document).ready(function() { 
	sidemenu();
	document.getElementById('boardQAList').setAttribute('class','active');
});
</script>
</head>
<body class="">
	<section class="vbox">
	<!-- navbar -->
		<jsp:include page="/WEB-INF/jsp/storeManager/include/topmenu.jsp"></jsp:include>
	<!-- end navbar -->
	
		<section>
			<section class="hbox stretch">
		    
		    <!-- navbar -->
				<jsp:include page="/WEB-INF/jsp/storeManager/include/sidemenu.jsp"></jsp:include>
			<!-- end navbar -->				

				<!-- 메뉴 사이즈 조정 -->
				<section id="content">
					<section class="vbox">
						<section class="scrollable wrapper" style="padding-left: 50px">
							<br />
							<h3 class="font-bold m-b-none m-t-none">QNA 답변</h3>
							<br />
							<div style="text-align: right; width: 80%">
								<table width="100%"
									class="table table-striped m-b-none dataTable no-footer"
									style="text-align: center">
									<tr>
										<th colspan="3">${ boardQAVO.title }</th>
									</tr>
									<tr>
										<td style="text-align: left; padding-left: 20px">${ boardQAVO.boardNo }</td>
										<td style="text-align: right; width: 60%">${ boardQAVO.writer }</td>
										<td style="text-align: right; padding-right: 20px">${ boardQAVO.regDate }</td>
									</tr>
									<tr>
										<td style="text-align: left; align: center "  colspan="3">
										<span >${ boardQAVO.content }</span>
										</td>
								</table>
								<br />
								<input type="button" value="답변" class="btn btn-s-md btn-primary"
									onclick="location.href='${ pageContext.request.contextPath }/boardQA/write/${boardQAVO.boardNo}'"/>
								<input type="button" value="삭제" class="btn btn-s-md btn-primary"
									onclick="location.href='${ pageContext.request.contextPath }/boardQA/delete/${ boardQAVO.boardNo }'"/>
								<input type="button"
									onclick="history.go(-1); return false"
									value="목록" class="btn btn-s-md btn-primary"/>
									 
							</div>
						</section>
					</section>
					<a href="#" class="hide nav-off-screen-block"
						data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
				</section>
				<!-- 메뉴 사이즈 조정 끝-->
			</section>
		</section>
	</section>
</body>
</html>