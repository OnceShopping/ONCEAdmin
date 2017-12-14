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
	$(document).ready(function(){
		$('#goList').click(function(){
			location.href="${pageContext.request.contextPath}/manager/list";
		});	
	});
</script>
</head>
<body class="">
	<section class="vbox">
		<!-- 상단바 -->
		<header
			class="bg-white header header-md navbar navbar-fixed-top-xs box-shadow">
			<div class="navbar-header aside-md dk">
				<a class="btn btn-link visible-xs"
					data-toggle="class:nav-off-screen,open" data-target="#nav,html">
					<i class="fa fa-bars"></i>
				</a> <a href="index.html" class="navbar-brand"> <span
					class="hidden-nav-xs">ONCE</span>
				</a> <a class="btn btn-link visible-xs" data-toggle="dropdown"
					data-target=".user"> <i class="fa fa-cog"></i>
				</a>
			</div>
		</header>
		<!-- 상단바 끝 -->

		<section>
			<section class="hbox stretch">
				<!-- 메뉴 위 프로필 -->
				<aside class="bg-black aside-md hidden-print hidden-xs" id="nav">
					<section class="vbox">
						<section class="w-f scrollable">
							<div class="slim-scroll" data-height="auto"
								data-disable-fade-out="true" data-distance="0" data-size="10px"
								data-railOpacity="0.2">
								<div class="clearfix wrapper dk nav-user hidden-xs">
									<div class="dropdown">
										<a href="#" class="dropdown-toggle" data-toggle="dropdown">
											<span class="hidden-nav-xs clear"> <span
												class="block m-t-xs"> <strong
													class="font-bold text-lt">${loginVO.managerId }</strong> <b
													class="caret"></b>
											</span>
										</span>
										</a>
										<!-- 프로필 클릭시 나오는 메뉴 -->
										<ul class="dropdown-menu animated fadeInRight m-t-xs">
											<li><a
												href="${ pageContext.request.contextPath }/manager/check">Profile</a></li>
											<li class="divider"></li>
											<li><a href="modal.lockme.html" data-toggle="ajaxModal">Logout</a>
											</li>
										</ul>
									</div>
								</div>
								<!-- 프로필 클릭시 나오는 메뉴 끝 -->
								<!-- 메뉴 위 프로필 끝 -->

								<!-- 사이드 메뉴 -->
								<nav class="nav-primary hidden-xs" id="sidemenu">
									<div
										class="text-muted text-sm hidden-nav-xs padder m-t-sm m-b-sm">Start</div>
									<ul class="nav nav-main">
										<li><a
											href="${pageContext.request.contextPath}/notice/list"
											class="auto"> <i class="i i-circle-sm-o text"></i> <i
												class="i i-circle-sm text-active"></i><i
												class="i i-statistics icon"> </i> <span class="font-bold">운영
													공지</span>
										</a></li>
										<li><a
											href="${pageContext.request.contextPath}/boardQA/list"
											class="auto"> <span class="pull-right text-muted">
													<i class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-stack icon"> </i> <span class="font-bold">QNA
													답변</span>
										</a></li>
										<li><a href="#" class="auto"> <span
												class="pull-right text-muted"> <i
													class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-lab icon"> </i> <span class="font-bold">매장
													관리</span>
										</a></li>
										<li class="active"><a
											href="${pageContext.request.contextPath}/manager/list"
											class="auto"> <span class="pull-right text-muted">
													<i class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-docs icon"> </i> <span class="font-bold">매니저
													관리</span>
										</a></li>
										<li><a
											href="${pageContext.request.contextPath}/customer/list"
											class="auto"> <span class="pull-right text-muted">
													<i class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-grid2 icon"> </i> <span class="font-bold">고객
													관리</span>
										</a></li>
									</ul>
								</nav>
							</div>
						</section>
						<footer class="footer hidden-xs no-padder text-center-nav-xs">
							<!-- 메뉴 하단 로그아웃 버튼 -->
							<a href="modal.lockme.html" data-toggle="ajaxModal"
								class="btn btn-icon icon-muted btn-inactive pull-right m-l-xs m-r-xs hidden-nav-xs">
								<i class="i i-logout"></i>
							</a>
							<!-- 메뉴 하단 축소 버튼 -->
							<a href="#nav" data-toggle="class:nav-xs"
								class="btn btn-icon icon-muted btn-inactive m-l-xs m-r-xs">
								<i class="i i-circleleft text"></i> <i
								class="i i-circleright text-active"></i>
							</a>
						</footer>
					</section>
				</aside>
				<!-- 사이드 메뉴 끝 -->
				<section id="content">
					<section class="vbox">
						<section class="scrollable wrapper" style="padding-left: 50px">
							<br />
							<h3 class="font-bold m-b-none m-t-none">매니저 정보 수정</h3>
							<br /> <br />
							<form action="${pageContext.request.contextPath}/manager/update/${managerId}"
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
										<td><input type="text" value="${managerVO.name}" name="name" class="impossible" readonly="readonly"></td>
									</tr>
									<tr>
										<th>연락처</th>
										<td/>
										<td><input type="tel" value="${managerVO.telephone}" name="telephone"  pattern="(011|010|017|018|019)-\d{3,4}-\d{4}" title="xxx-xxx-xxxx 형식으로   작성해주세요." ></td>
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