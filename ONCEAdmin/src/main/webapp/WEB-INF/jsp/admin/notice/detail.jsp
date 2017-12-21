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
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	
<script>

$(document).ready(function() {
	//다이얼로그 format 정의 - alert창
	$( "#dialog" ).dialog({
		 autoOpen: false,
	      modal: true,
	      width: '300',
	      height: '200',
	      padding : '10px',
	      buttons : {
	    	 OK : function(){	  
	    	  	$(this).dialog("close");
	    	 }
	      }
	 });
	
	//다이얼로그 format 정의 - pwd 체크	
	$( "#dialog-pwd" ).dialog({
		autoOpen: false,
	    modal: true,
	    width: '300',
	    height: '200',
	    buttons : [{
	    	id : "cancelPwd", //취소 버튼
	    	text : "cancel",
	    	click : function(){
	    		$(this).dialog("close");
	    	}
	     },
	     {
	      	id : "OKPwd",  //OK 버튼
	      	text : "OK",
	      	click : function(){
		    	$(this).dialog("close");
		   		}
	      }],
	      open: function( event, ui ) {
	    	  $('#pwd').val(''); 
	      }
	 });
	
	//삭제 controller로 가기 전
	$('#deleteNotice').click(function(){
		
		$( "#dialog-pwd" ).dialog('open');
		
	});
	//삭제 시 비밀번호를 확인하는 다이얼로그의 "OK"버튼 클릭 시
	$('#OKPwd').click(function(){
		var CheckPwd = $('#pwd').val();
		var loginPwd = "${sessionScope.loginVO.password}";
		
		clickBtn(CheckPwd, loginPwd);
	});

	//삭제 시 비밀번호를 확인하는 다이얼로그를 통해 비밀번호를 비교
	function clickBtn(CheckPwd, loginPwd){
	if(CheckPwd != loginPwd)
		infoAlert("죄송합니다. 비밀 번호가 일치하지 않아 해당 정보를 삭제를 할 수 없습니다.");
	else
		location.href="${ pageContext.request.contextPath }/notice/delete/${ noticeVO.noticeNo }";
	}

	//알림 모달 다이얼로그 태그 설정
	function infoAlert(str){
		$('#dialog').html("<div style='text-align:center;'><p>"+str+"</p></div>");
		$("#dialog").dialog("open");
	}
});
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
		<!-- Modal -->
		<div id="dialog" title="ALERT DIALOG"></div>
		<div id="dialog-pwd" title="CHECK PASSWORD">
			<p class="validateTips">해당 정보를 삭제하기 위해서 비밀 번호를 다시 한번 입력해주세요.</p>
			<form>
				<fieldset>
					<label for="password">Password</label> <input type="password"
						name="pwd" id="pwd" class="text ui-widget-content ui-corner-all">
				</fieldset>
			</form>
		</div>
		<!-- 상단바 -->
		<header
			class="bg-white header header-md navbar navbar-fixed-top-xs box-shadow">
			<div class="navbar-header aside-md dk">
				<a class="btn btn-link visible-xs"
					data-toggle="class:nav-off-screen,open" data-target="#nav,html">
					<i class="fa fa-bars"></i>
				</a> <a href="${ pageContext.request.contextPath }/notice/list" class="navbar-brand"> <span
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
											<li><a href="${ pageContext.request.contextPath }/manager/check">Profile</a></li>
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
										<li class="active"><a
											href="${ pageContext.request.contextPath }/notice/list"
											class="auto"> <span class="pull-right text-muted">
												<i class="i i-circle-sm-o text"></i> <i
												class="i i-circle-sm text-active"></i> 
											</span> <i class="i i-statistics icon"> </i> <span class="font-bold">운영
													공지</span> </a></li>
										<li><a href="${ pageContext.request.contextPath }/boardQA/list" class="auto"> <span
												class="pull-right text-muted"> <i
													class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-stack icon"> </i> <span class="font-bold">QNA
													답변</span>
										</a></li>
										<li><a href="${ pageContext.request.contextPath }/store/list" class="auto"> <span
												class="pull-right text-muted"> <i
													class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-lab icon"> </i> <span class="font-bold">매장
													관리</span>
										</a></li>
										<li><a href="${pageContext.request.contextPath}/manager/list" class="auto"> <span
												class="pull-right text-muted"> <i
													class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-docs icon"> </i> <span class="font-bold">매니저
													관리</span>
										</a></li>
										<li><a href="${ pageContext.request.contextPath }/customer/list" class="auto"> <span
												class="pull-right text-muted"> <i
													class="i i-circle-sm-o text"></i> <i
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

				<!-- 메뉴 사이즈 조정 -->
				<section id="content">
					<section class="vbox">
						<section class="scrollable wrapper" style="padding-left: 50px">
							<br />
							<h3 class="font-bold m-b-none m-t-none">운영공지</h3>
							<br />
							<div style="text-align: right; width: 80%">
								<table width="100%"
									class="table table-striped m-b-none dataTable no-footer"
									style="text-align: center">
									<tr>
										<th colspan="3">${ noticeVO.title }</th>
									</tr>
									<tr>
										<td style="text-align: left; padding-left: 20px">${ noticeVO.noticeNo }</td>
										<td></td>
										<td style="text-align: right; padding-right: 20px">${ noticeVO.regDate }</td>
									</tr>
									<tr>
										<td style="text-align: left; align: center "  colspan="3">
										<c:if test="${ noticeVO.imgSaveName ne null }">
											<img src="/image/${ noticeVO.imgSaveName }" style="width: auto; height: auto; max-width:921px; align: center">
										</c:if>
										<br/><br/>
										<span >${ noticeVO.content }</span>
										</td>
								</table>
								<br />
								<input type="button" value="수정" class="btn btn-s-md btn-primary"
									onclick="location.href='${ pageContext.request.contextPath }/notice/update/${ noticeVO.noticeNo }'"/>
								<input type="button" value="삭제" class="btn btn-s-md btn-primary" id="deleteNotice"
									/>	
								<input type="button" 
									onclick="location.href='${ pageContext.request.contextPath }/notice/list'"
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