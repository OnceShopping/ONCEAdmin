<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<script type="text/javascript">
	$(document).ready(function() {

		//체크박스 전체 선택, 선택 해제
		$('#checkAll').click(function() {

			var checkVal = document.getElementsByClassName("check");

			if (this.checked) {
				for (var i = 0; i < checkVal.length; i++)
					checkVal[i].checked = true;
			} else {
				for (var i = 0; i < checkVal.length; i++)
					checkVal[i].checked = false;
			}
		});
		
		$('#modify').click(function(){
			
			var checkVal = document.getElementsByClassName("check");
			var count=0; //선택 체크한 사원의 수
			
			//선택한 사원의 수 확인
			for(var i=0; i<checkVal.length; i++){
				if(checkVal[i].checked)
					++count;
			}
			
			
			if(count!=1) //선택한 사원이 1명 이상일 때
				alert('사원 한명만 선택해 정보 수정을 해주시기 바랍니다.');
			else{ //선택한 사원이 1명일 경우
				for(var i=0; i<checkVal.length; i++){
					if(checkVal[i].checked)
						location.href="${ pageContext.request.contextPath }/manager/modify/"+checkVal[i].value;							
				}
			}
		});
	});
	
	
</script>
<style type="text/css">
.addManger {
	width: 500px;
	background: #E0DFDF;
	border: none;
	margin-left: auto;
	margin-bottom: 50px;
	margin-right: auto;
	padding: 40px;
	border-radius: 20px;
}

.managerList {
	border-collapse: collapse;
	width: 100%;
	border: 1 solid;
	border-color: #bcbcbc;
}

.managerList td {
	text-align: center;
}
</style>
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
							<h3 class="font-bold m-b-none m-t-none">매니저 관리</h3>
							<br/><br/>
							<form action="">
								<div class="addManger" align="center">
									<table style="width: 100%">
										<tr>
											<th width="10%">ID</th>
											<td width="30%"><input type="text"></td>
											<th width="20%">비밀 번호</th>
											<td width="40%"><input type="text"></td>
										</tr>
										<tr height="10px" />
										<tr>
											<th width="10%">이름</th>
											<td width="30%"><input type="text"></td>
											<th width="20%">연락처</th>
											<td width="40%"><input type="text"></td>
										</tr>
										<tr height="20px" />
										<tr>
											<th colspan="4" style="text-align: left;">매장 이름 &nbsp; <select
												style="height: 25px">
													<option>패션&잡화</option>
													<option>패션&잡화</option>
											</select> <select style="height: 25px">
													<option>매장 이름</option>
													<option>매장 이름</option>
											</select>
											</th>
										</tr>
										<tr height="5px" />
									</table>
									<div align="right" style="padding-right: 40px;">
										<input type="submit" value="추가">
									</div>
								</div>
							</form>
							<form action="${pageContext.request.contextPath}/manager/list"
								method="post">
								<table class="managerList">
									<tr style="text-align: center; background-color: #E7E7E7">
										<td width="5%"><input type="checkbox" id="checkAll"></td>
										<td width="15%" class="tbTile">사원 번호</td>
										<td width="10%" class="tbTile">해당 매장</td>
										<td width="15%" class="tbTile">아이디</td>
										<td width="15%" class="tbTile">이름</td>
										<td width="20%" class="tbTile">연락처</td>
										<td width="20%" class="tbTile">가입일</td>
									</tr>
									<c:forEach items="${managerList}" var="manager">
										<tr>
											<td><input type="checkbox" value=${ manager.managerId }
												name="staffNo" class="check"></td>
											<td>${ manager.staffNo }</td>
											<td>${ manager.storeNo }</td>
											<td>${ manager.managerId }</td>
											<td>${ manager.name }</td>
											<td>${ manager.telephone }</td>
											<td>${ manager.date }</td>
										</tr>
									</c:forEach>
								</table>
								<br />
								<br />
								<div align="right">
									<c:if test="${ !empty managerList }">
										<input type="button" value="수정" id="modify" class="btn btn-s-md btn-primary">
										<input type="hidden" name="_method" value="delete">
										<input type="submit" value="삭제" class="btn btn-s-md btn-primary">
									</c:if>
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