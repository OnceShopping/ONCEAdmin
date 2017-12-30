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
.ModifyManger {
	width: 500px;
	background: #F2F2F2;
	border: none;
	margin-left: auto;
	margin-bottom: 50px;
	margin-right: auto;
	border-radius: 20px;
	padding: 40px;
}

td {
	text-align: left;
	height: 50px;
}
th{
	text-align: right;
	height: 50px;
}

input[type=text]{
	width: 200%;
	border: none;
}
.impossible{
	background: #DADADA;
}
</style>
<script type="text/javascript">
function sidemenu(){
	document.getElementById('itemRegister').setAttribute('class','');
	document.getElementById('itemList').setAttribute('class','');
	document.getElementById('itemManage').setAttribute('class','');
	document.getElementById('orderList').setAttribute('class','');
	document.getElementById('staffManage').setAttribute('class','');
	document.getElementById('boardQAList').setAttribute('class','');
}
	$(document).ready(function(){
		sidemenu();
		document.getElementById('staffManage').setAttribute('class','active');
		$('#goList').click(function(){
			location.href="${pageContext.request.contextPath}/staffManage/list";
		});	
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
				<section id="content">
					<section class="vbox">
						<section class="scrollable wrapper" style="padding-left: 50px">
							<br />
							<h3 class="font-bold m-b-none m-t-none">매니저 정보 수정</h3>
							<br /> <br />
							<form action="${pageContext.request.contextPath}/staffManage/update/${managerId}"
								method="post">
								<div class="ModifyManger">
								<table >
									<tr>
										<th width="25%">사원 번호</th>
										<td width="10%"/>
										<td width="65%"><input type="text" value="${managerVO.staffNo}" readonly="readonly" class="impossible"></td>
									</tr>
									<tr>
										<th>해당 매장</th>
										<td/>
										<td><input type="text" value="${storeVO.storeName}" readonly="readonly" class="impossible"></td>
									</tr>
									<tr>
										<th>아이디</th>
										<td/>
										<td><input type="text" value="${managerVO.managerId}" readonly="readonly" class="impossible"></td>
									</tr>
									<tr>
										<th>이름</th>
										<td/>
										<td><input type="text" value="${managerVO.name}" name="name" readonly="readonly" class="impossible"></td>
									</tr>
									<tr>
										<th>연락처</th>
										<td/>
										<td><input type="text" value="${managerVO.telephone}" name="telephone"></td>
									</tr>
									<tr>
										<th>가입일</th>
										<td/>
										<td><input type="text" value="${managerVO.date}" readonly="readonly" class="impossible"></td>
									</tr>
								</table>
								</div>
								<div align="right">
									<input type="hidden" name="_method" value="PUT" /> <input
										type="submit" value="수정 완료" class="btn btn-s-md btn-primary"/>
									<input type="button" value="취소"  class="btn btn-s-md btn-primary" id="goList">		
								</div>
							</form>
						</section>
					</section>
				</section>
			</section>
		</section>
	</section>
</body>
</html>