<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/bootstrap.css"
	type="text/css" />
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/animate.css"
	type="text/css" />
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/font-awesome.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/icon.css"
	type="text/css" />
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/font.css"
	type="text/css" />
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/app.css"
	type="text/css" />

<style type="text/css">
  	.storeLogo {
  		margin-top: 10px;
  		text-align: center;
  	}

  	.storeLogoImg {
  		margin: auto;
  		width: 150px;
  		height: 150px;
  		background-color: transparent;
  	}

  	.storeLogoImg img {
  		max-width: 100%;
  	}
  	
  	.storeLogo label {
	    position: relative;
	    cursor: pointer;
	    display: inline-block;
	    vertical-align: middle;
	    overflow: hidden;
	    width: 70px;
	    height: 30px;
	    background: #177bbb;
	    color: #fff;
	    text-align: center;
	    line-height: 30px;
	}
	.storeLogo label input {
	    position: absolute;
	    width: 0;
	    height: 0;
	    overflow: hidden;
	}
	.storeLogo input[type=text] {
	    vertical-align: middle;
	    display: inline-block;
	    width: 100px;
	    height: 28px;
	    line-height:28px;
	    font-size: 11px;
	    padding: 0;
	    border: 0;
	}
</style>

<script
	src="${ pageContext.request.contextPath }/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script
	src="${ pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
<!-- App -->
<script src="${ pageContext.request.contextPath }/resources/js/app.js"></script>
<script
	src="${ pageContext.request.contextPath }/resources/js/slimscroll/jquery.slimscroll.min.js"></script>
<script
	src="${ pageContext.request.contextPath }/resources/js/charts/easypiechart/jquery.easy-pie-chart.js"></script>
<script
	src="${ pageContext.request.contextPath }/resources/js/app.plugin.js"></script>
<script type="text/javascript">
	//이미지 미리 보기
	function fileInfo(f){
		var file = f.files;
	
		var reader = new FileReader();
		reader.onload = function(rst){
			$('#storeLogoImg').html('<img src="' + rst.target.result + '">');
		}
		reader.readAsDataURL(file[0]);
	}

	function goBack() {
		location.href = "${pageContext.request.contextPath}/store/list";
	}
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

	<section class="vbox"> <section class="scrollable bg-white">
	<aside>
	<div class="wrapper-lg bg-light">
		<div class="hbox">
			<aside>
			<h3 class="font-bold m-b-none m-t-none">${storeVO.storeNo} ${storeVO.storeName}</h3>
			</aside>
		</div>
	</div>
	<div class="tab-pane wrapper-lg" id="edit">
		<form class="form-horizontal" action="${ pageContext.request.contextPath }/store/detail/${ storeVO.storeNo }" name="form" enctype="multipart/form-data" method="post">
			<div class="storeLogo">
				<div class="storeLogoImg" id="storeLogoImg">
					<img src="${pageContext.request.contextPath}/upload/admin/${storeVO.imgSaveName}" alt="${ storeVO.storeName }"/>
				</div><br/>
				<label>
					로고 첨부
					<input type="file" name="file" id="uploadLogo" accept="image/*" onchange="javascript:document.getElementById('file_route').value=this.value; fileInfo(this);">
				</label>
				<input type="text" readonly="readonly" title="File Route" id="file_route">
			</div>
			<div class="line line-dashed b-b line-lg pull-in"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="storeCategory">카테고리:</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="storeCategory"
						disabled="disabled" value="${storeVO.storeCategory}">
				</div>
			</div>
			<div class="line line-dashed b-b line-lg pull-in"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="storeCategory">상호명:</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="storeName"
						disabled="disabled" value="${storeVO.storeName}">
				</div>
			</div>
			<div class="line line-dashed b-b line-lg pull-in"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label">대표자:</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="storeName" name="ceo" value="${storeVO.ceo}" />
				</div>
			</div>
			<div class="line line-dashed b-b line-lg pull-in"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label">사업자 등록 번호:</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="companyNo" name="companyNo" value="${storeVO.companyNo}" pattern="\d{3}\-\d{4}\-\d{4}" title="xxx-xxxx-xxxx와 같은 형식으로  작성해 주세요" required/>
				</div>
			</div>
			<div class="line line-dashed b-b line-lg pull-in"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label">매장 전화번호:</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="phone" name="phone" value="${storeVO.phone}" pattern="0\d{1,2}\-\d{3,4}\-\d{4}" title="0x-xxx-xxxx 또는  0xx-xxxx-xxxx와 같은 형식으로  작성해 주세요" required/>
				</div>
			</div>
			<div class="line line-dashed b-b line-lg pull-in"></div>
			<div class="form-group" style="text-align: center;">
				<div class="col-sm-offset-3 col-sm-5">
					<button type="submit" class="btn btn-sm btn-primary" id="udtBtn">수정</button>
					<button type="button" class="btn btn-sm btn-primary" id="goBackBtn" onclick="goBack()">취소</button>
				</div>
			</div>
		</form>
	</div></section></section></section></section>
</body>
</html>