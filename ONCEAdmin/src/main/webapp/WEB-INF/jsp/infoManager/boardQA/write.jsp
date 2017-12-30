<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
 <!-- parsley -->
<script src="${pageContext.request.contextPath }/resources/js/parsley/parsley.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/parsley/parsley.extend.js"></script>
<script type="text/javascript">

function sidemenu(){
	document.getElementById('items').setAttribute('class', '');
    document.getElementById('addItem').setAttribute('class','');
    document.getElementById('itemDelivery').setAttribute('class','');
    document.getElementById('staffList').setAttribute('class','');
    document.getElementById('boardQAList').setAttribute('class','');
    
}

$(document).ready(function() {
	sidemenu();
	document.getElementById('boardQAList').setAttribute('class', 'active');
});


	function doAction() {
		location.href = "${ pageContext.request.contextPath }/boardQA/list"

	}
</script>
<style type="text/css">
th {
	text-align: center;
	font-size: 13pt;
}
</style>
</head>
<body class="">
	<section class="vbox">
		<!-- navbar -->
			<jsp:include page="/WEB-INF/jsp/infoManager/include/topmenu.jsp"></jsp:include>
		<!-- end navbar -->


		<section>
			<section class="hbox stretch">
			<!-- navbar -->
				<jsp:include page="/WEB-INF/jsp/infoManager/include/sidemenu.jsp"></jsp:include>
			<!-- end navbar -->

				<!-- 메뉴 사이즈 조정 -->
				<section id="content">
					<section class="vbox">
						<section class="scrollable wrapper" style="padding-left: 50px">
							<br />
							<h3 class="font-bold m-b-none m-t-none">운영공지</h3>
							<br />
							<div style="text-align: right; width: 80%">
								<form:form commandName="boardQAVO" method="post" >
									<table border="1" width="100%">
										<tr>
											<td><form:input type="text" path="title" class="form-control" placeholder="제목을 입력해 주세요"/></td>
										</tr>
										<tr>
											<td>
											<form:textarea class="form-control" rows="7" cols="10" path="content" />
											</td>
										</tr>
									</table>
									<br />
									<input type="submit" value="등록" class="btn btn-s-md btn-primary"/>
									<input type="button" value="취소" onclick="doAction()" class="btn btn-s-md btn-primary"/>
								</form:form>
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