<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

<style type="text/css">
	.vbox {
		padding-top: 20px;
		padding-bottom: 30px;
		padding-left: 20px;
		
	}
	
	#scrollSearch {
		font-size: 20pt;
		font-weight: 800;
		margin-bottom: 20px;
		float: left;
	}
	
	#sideBtn {
		margin-right: 65%;
		margin-top: 10px;
	}
	
	.fa-plus, .fa-trash-o {
		margin-left: 10px;
		font-size: 16pt;
		float: right;
	}

	.divideLine {
		margin-left: 30px;
	}

	.storeList {
		margin-right: 10px;
		float: left;
		font-size: 11pt;
		text-align: center;
	}
	.storeListImg {
		width: 100px;
		height: 100px;
		margin-right: 10px;
		background-color: transparent;
	}
	
	.storeListImg i {
		font-size: 15pt;
		color: #fff;
		margin-top: 40px;
		margin-left: 40px;
	}
	
	.noList {
		text-align: left;
	}
	
	.noList span {
		font-size: 13pt;
		margin: 33px 33px;
	}
	
	.clear {
		clear: both;
		padding: 10px;
	}
</style>

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
	function addFirstStore() {
		form.submit="${pageContext.request.contextPath}/store/add";
	}
	
	$(document).ready(function() {
		
		//삭제 버튼 생성
		$('#makeDelete').click(function(event) {
 			event.preventDefault();
			$('.deleteIcon').toggle();
		});
		
		//삭제 버튼 클릭
		$('.deleteIcon').click(function(event) {
 			event.preventDefault();
 			
 			var storeNo = $('#hiddenStoreNo').val();
 			
 			$.ajax({
 				data: {"storeNo" : storeNo },
 				url: "${pageContext.request.contextPath}/store/delete",
 				type: "get",
 				contentType : "application/json; charset=UTF-8",
 				cache : false,
 		        success: function(data){
 		        	alert(storeNo + '가 성공적으로 삭제되었습니다');
 		        	$('#div' + storeNo).remove();
 		        	
 		        }
 			});
 			
		});
	});
</script>
</head>
<body>
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
									<li class="active"><a href="${pageContext.request.contextPath}/store/list" class="auto">
										<span
											class="pull-right text-muted"> <i
												class="i i-circle-sm-o text"></i> <i
												class="i i-circle-sm text-active"></i>
										</span> <i class="i i-lab icon"> </i> <span class="font-bold">매장
												관리</span>
									</a></li>
									<li><a
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

	<section class="vbox">
		<div id="scrollSearch"> 
			<a href="#1floor">1F</a> | <a href="#2floor">2F</a> | <a href="#3floor">3F</a>
		</div>
		<div id="sideBtn">
			<form action="" method="post">
				<a href="#" id="makeDelete"><i class="fa fa-trash-o"></i></a>
			</form>
			<a href="${pageContext.request.contextPath}/store/add"><i class="fa fa-plus"></i></a>
		</div>
		<div class="clear"></div>
		<form action="${pageContext.request.contextPath}/store/list" method="get">
			<div class="divideFloor" id="1floor">
				<h2>1F</h2>
				<div class="divideLine">			
					<c:forEach items="${ firstFloor }" var="list" varStatus="status">
						<c:if test="${status.count <= 5}">
							<div class="storeList" id="div${ list.storeNo }">
								<div class="storeListImg">
									<a href="${pageContext.request.contextPath}/store/detail/${ list.storeNo }">
										<img src="${pageContext.request.contextPath}/upload/admin/${list.imgSaveName}" alt="${ list.storeName }" width="100%"/>
									</a>
								</div>
								${ list.storeNo }
								<a href="#" style="display: none;" class="deleteIcon">
									<i class="fa fa-minus-circle" style="color: red"></i>
								</a>
								<input type="hidden" name="storeNo" id="hiddenStoreNo" value="${ list.storeNo }"/>
							</div>				
						</c:if>
					</c:forEach>
				</div>
				<div class="clear"></div>
				<div class="divideLine">			
					<c:forEach items="${ firstFloor }" var="list" varStatus="status">
						<c:if test="${status.count > 5}">
							<div class="storeList" id="div${ list.storeNo }">
								<div class="storeListImg">
									<a href="${pageContext.request.contextPath}/store/detail/${ list.storeNo }">
										<img src="${pageContext.request.contextPath}/upload/admin/${ list.imgSaveName }" alt="${ list.storeName }" width="100%"/>
									</a>
								</div>
								${ list.storeNo }
								<a href="#" style="display: none;" class="deleteIcon">
									<i class="fa fa-minus-circle" style="color: red"></i>
								</a>
								<input type="hidden" name="storeNo" id="hiddenStoreNo" value="${ list.storeNo }"/>
							</div>				
						</c:if>
					</c:forEach>
				</div>
			</div>
			
				<div class="clear"></div>
			
			<div class="divideFloor" id="2floor">
				<h2>2F</h2>
				<div class="divideLine">			
					<c:forEach items="${ secondFloor }" var="list" varStatus="status">
						<c:if test="${status.count <= 5}">
							<div class="storeList" id="div${ list.storeNo }">
								<div class="storeListImg">
									<a href="${pageContext.request.contextPath}/store/detail/${ list.storeNo }">
										<img src="${pageContext.request.contextPath}/upload/admin/${ list.imgSaveName }" alt="${ list.storeName }" width="100%"/>
									</a>
								</div>
								${ list.storeNo }
								<a href="#" style="display: none;" class="deleteIcon">
									<i class="fa fa-minus-circle" style="color: red"></i>
								</a>
								<input type="hidden" name="storeNo" id="hiddenStoreNo" value="${ list.storeNo }"/>
							</div>				
						</c:if>
					</c:forEach>
				</div>
				<div class="clear"></div>
				<div class="divideLine">			
					<c:forEach items="${ secondFloor }" var="list" varStatus="status">
						<c:if test="${status.count > 5}">
							<div class="storeList" id="div${ list.storeNo }">
								<div class="storeListImg">
									<a href="${pageContext.request.contextPath}/store/detail/${ list.storeNo }">
										<img src="${pageContext.request.contextPath}/upload/admin/${ list.imgSaveName }" alt="${ list.storeName }" width="100%"/>
									</a>
								</div>
								${ list.storeNo }
								<a href="#" style="display: none;" class="deleteIcon">
									<i class="fa fa-minus-circle" style="color: red"></i>
								</a>
								<input type="hidden" name="storeNo" id="hiddenStoreNo" value="${ list.storeNo }"/>
							</div>				
						</c:if>
					</c:forEach>
				</div>
			</div>
			
				<div class="clear"></div>
			
			<div class="divideFloor" id="3floor">
				<h2>3F</h2>
				<div class="divideLine">			
					<c:forEach items="${ thirdFloor }" var="list" varStatus="status">
						<c:if test="${status.count <= 5}">
							<div class="storeList" id="div${ list.storeNo }">
								<div class="storeListImg">
									<a href="${pageContext.request.contextPath}/store/detail/${ list.storeNo }">
										<img src="${pageContext.request.contextPath}/upload/admin/${ list.imgSaveName }" alt="${ list.storeName }" width="100%"/>
									</a>
								</div>
								${ list.storeNo }
								<a href="#" style="display: none;" class="deleteIcon">
									<i class="fa fa-minus-circle" style="color: red"></i>
								</a>
								<input type="hidden" name="storeNo" id="hiddenStoreNo" value="${ list.storeNo }"/>
							</div>				
						</c:if>
					</c:forEach>
				</div>
				<div class="clear"></div>
				<div class="divideLine">			
					<c:forEach items="${ thirdFloor }" var="list" varStatus="status">
						<c:if test="${status.count > 5}">
							<div class="storeList" id="div${ list.storeNo }">
								<div class="storeListImg">
									<a href="${pageContext.request.contextPath}/store/detail/${ list.storeNo }">
										<img src="${pageContext.request.contextPath}/upload/admin/${ list.imgSaveName }" alt="${ list.storeName }" width="100%"/>
									</a>
								</div>
								${ list.storeNo }
								<a href="#" style="display: none;" class="deleteIcon">
									<i class="fa fa-minus-circle" style="color: red"></i>
								</a>
								<input type="hidden" name="storeNo" id="hiddenStoreNo" value="${ list.storeNo }"/>
							</div>				
						</c:if>
					</c:forEach>
				</div>
			</div>
		</form>
	</section>
	</section>
	</section>
</body>
</html>