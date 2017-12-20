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
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
<script type="text/javascript">
$(document).ready(function() {
	var vo;
	//태그 검색 클릭 전
	$('#searchTagbar').toggle();
	$('#searchTagButton').toggle();
	$('#insertTag').hide();
	
	//태그 검색 클릭 후
	$('#searchTag').click(function() {
		$('#searchTagbar').val("");
		$('#searchTagbar').toggle();
		$('#searchTagButton').toggle();
		$('#insertTag').hide();
		$('#customerID').text("ID : ");
		$('#customerTag').text("TagNo : ");
	});
	
	<c:forEach var="warehouse" items="${warehouseList }">
	var idCount = "";
	var id = "";
		<c:forEach var="noList" items="${memNoList}">
			<c:if test="${noList.memNo eq warehouse.memNo}">
				id = '${noList.id}';
				idCount = '${noList.itemCount}';
			</c:if>
		</c:forEach>
		
	$('#warehouse-'+'${warehouse.floorWareNo}').html('<span id="id-'+'${warehouse.floorWareNo}">ID : '+id+
			'</span><br>package<br><span id="count-'+'${warehouse.floorWareNo}">${warehouse.count}/'+idCount+'</span>');
	</c:forEach>

	//tag 검색
	$('#searchTagButton').click(function() {
		var tagNo = $('#searchTagbar').val();
		$.ajax({
			url : '${pageContext.request.contextPath}/tag/searchTag',
			data : { "tagNo" : tagNo},
			type : "get",
			cache : false,
			success : function(data) {
				vo = $.parseJSON(data);
				
				if(vo.msg == null) {
					$('#customerID').text("ID : "+vo.customerVO.id);
					$('#customerTag').text("TagNo : "+vo.tagStickerVO.tagNo);
					$('#insertTag').show();
				} else {
					alert(vo.msg);
					$('#customerID').text("ID");
					$('#customerTag').text("TagNo");
					$('#insertTag').hide();
					$('#searchTagbar').val("");
					$('#searchTagbar').focus();
				}
				
			},
			error: function() {
				alert('에러');
			}
		});
	});
	
	//숫자만 입력
	$('#searchTagbar').keyup(function() {
		this.value = this.value.replace(/[^0-9]/g,'');
		$('#insertTag').hide();
	});
	
	//태그등록 클릭
	$('#insertTag').click(function() {
		var insertId = $('#customerID').text().substring(5);
		var TagNo = $('#customerTag').text().substring(8);
		for(var i=1; i<=15; i++) {
			var warehouseId = $('#id-'+i).text();
			if(insertId == warehouseId.substring(5)) {
				 $('#changeColor'+i).addClass("yellowColor");
				 alert('있는것 등록');
				 $.ajax({
					url : '${pageContext.request.contextPath}/warehouse/insert',
					type : "get",
					data: {"warehouseId" : insertId, "TagNo" : TagNo, "memNo" : vo.customerVO.memNo, "floor" : '${loginVO.storeNo}'.substring(4), "floorWareNo": i},
					cache : false, 
					success : function(data) {
						var tagmodal = $.parseJSON(data);
						$('#tagOrderNo').text(tagmodal.orderNo);
						$('#tagId').text(tagmodal.id);
						$('#tagNo').text(tagmodal.tagNo);
						$('#tagCount').text(tagmodal.count+'/'+tagmodal.totalCount);
						
						$('#count-'+i).text(tagmodal.count+'/'+tagmodal.totalCount);
						
					}
				});
				$('#customerID').text("ID");
				$('#customerTag').text("TagNo");
				$('#insertTag').hide();
				$('#searchTagbar').val("");
				$('#modal-form').modal({backdrop: 'static'});	//모달창 다른 곳 눌러도 안닫히게 변경
				break;
				 
			}  else if($('#id-'+i).text() == "") {
				$('#changeColor'+i).addClass("yellowColor");
				alert('없는것 등록'); 
				$.ajax({
					url : '${pageContext.request.contextPath}/warehouse/insert',
					type : "get",
					data: {"warehouseId" : null, "TagNo" : TagNo, "memNo" : vo.customerVO.memNo, "floor" : '${loginVO.storeNo}'.substring(4), "floorWareNo": i},
					cache : false,
					success : function(data) {
						var tagmodal = $.parseJSON(data);
						$('#tagOrderNo').text(tagmodal.orderNo);
						$('#tagId').text(tagmodal.id);
						$('#tagNo').text(tagmodal.tagNo);
						$('#tagCount').text(tagmodal.count+'/'+tagmodal.totalCount);
						
						$('#warehouse-'+i).html('<span id="id-'+i+'">ID : '+tagmodal.id+
								'</span><br>package<br><span id="count-'+i+'">'+tagmodal.count+'/'+tagmodal.totalCount+'</span>');
					}
				});
				$('#customerID').text("ID");
				$('#customerTag').text("TagNo");
				$('#insertTag').hide();
				$('#searchTagbar').val("");
				$('#modal-form').modal({backdrop: 'static'});
				break;
			}
			
		
		}
	});
	
	//태그모달창 닫기 이벤트
	$('#modal-form').on('hidden.bs.modal', function () {
		for(var i=1; i<=15; i++) {
			$('#changeColor'+i).removeClass("yellowColor");
		} 
	});
	
	//보관함 클릭 
	$('section[id^="changeColor"]').click(function() {
		
		if($('#warehouse-'+$(this).attr('id').substring(11)).text() != "") {
			$(this).addClass("yellowColor");
			$('#wareOrderNo').text($(this).attr('id').substring(11));
			$('#wareId').text($('#id-'+$(this).attr('id').substring(11)).text().substring(5));
			var id = $('#id-'+$(this).attr('id').substring(11)).text().substring(5);
			alert(id);
			
			 $.ajax({
				url : '${pageContext.request.contextPath}/tag/oneTotalTag',
				type : "get",
				data: {"id" : id},
				cache : false,
				success : function(data) {
					var tagmodal = $.parseJSON(data);
					var Notext;
					var brCount ="";
					for(var i = 0; i<tagmodal.tagList.length; i++) {
						for(var j = 0; j<tagmodal.orderList.length; j++) {
							
						}
						
						if(i == 0) {
							Notext = tagmodal.tagList[i].tagNo;
						} else {
							Notext += '<br>'+tagmodal.tagList[i].tagNo;
							brCount += '<br><br>';
						}
					}
					$('#brCount').html('태그번호  '+brCount);
					$('#wareNo').html(Notext);
					$('#wareCount').text(tagmodal.warehouseVO.count+'/'+tagmodal.tagList.length); 
				}
			}); 
			
			
//			wareNo
//			wareCount
			$('#modal-warehouse').modal();
		} else {
			alert('없음');
		}
	});
	
	//보관함 닫기 이벤트
	$('#modal-warehouse').on('hidden.bs.modal', function () {
		for(var i=1; i<=15; i++) {
			$('#changeColor'+i).removeClass("yellowColor");
		} 
	});
});
</script>
<style>
.yellowColor {
		background-color: #FFCC00;
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
									<ul class="nav nav-main" data-ride="collapse">
										<li class="active"><a
											href="#"
											class="auto"> <span class="pull-right text-muted">
													<i class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-statistics icon"> </i> <span class="font-bold">물품
													관리</span>
										</a>
											<ul class="nav dk">
												<li class="active"><a
													href="${ pageContext.request.contextPath }/info/addItem"
													class="auto"> <i class="i i-dot"></i> <span>물품
															추가</span>
												</a></li>
												<li><a
													href="${ pageContext.request.contextPath }/info/itemDelivery"
													class="auto"> <i class="i i-dot"></i> <span>물품
															전달</span>
												</a></li>
												
											</ul>
										<li><a href="${ pageContext.request.contextPath }/info/staffList" class="auto"> <span
												class="pull-right text-muted"> <i
													class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-stack icon"> </i> <span class="font-bold">직원 관리</span>
										</a></li>
										<li><a href="${ pageContext.request.contextPath }/boardQA/list" class="auto"> <span
												class="pull-right text-muted"> <i
													class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-lab icon"> </i> <span class="font-bold">관리자
													답변 게시판</span>
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
							<h3 class="font-bold m-b-none m-t-none">물품추가</h3>
							
							<br /> <br />
							<div>
							<div class="col-sm-4 form-inline">
							<input type="button" value="태그 번호 검색" class="btn btn-s-md btn-warning" id="searchTag">
							<input type="text" class="form-control" style="margin-left: 10px; margin-top: -1px" id="searchTagbar">
							<input type="button" value="확인" class="btn btn-success" id="searchTagButton">
							</div>
							<div class="col-sm-8">
							<section class="panel panel-default col-sm-2">
                    		<div class="panel-body" id="customerID">ID</div>
                  			</section>
							<br><br><br><br>
							<section class="panel panel-default col-sm-2">
                    		<div class="panel-body" id="customerTag">TagNo</div>
                  			</section>
                  			<section class=" col-sm-6" style="padding-left: 100px">
                  			<br>
                  			<input type="button" value="태그 등록" class="btn btn-success" id="insertTag">
                    		<input type="button" value="테이블 보기" class="btn btn-s-md btn-warning" style="margin-left: 20px">
                    		<input type="button" value="리스트 보기" class="btn btn-s-md btn-warning" style="margin-left: 20px">
                  			</section>
                  			<br><br><br><br>
							</div>
							
							</div>
							
							<div class="row" style="padding-top: 120px">
								<div class="col-sm-2">
									<section class="panel panel-default" id="changeColor1"
										style="height: 150px; width: 150px">
										<div class="panel-body" ><span>1</span><br><br><br>
										<span style="float: right; text-align: right"  id="warehouse-1"></span>
										</div>
									</section>
								</div>
								<div class="col-sm-2">
									<section class="panel panel-default" id="changeColor2"
										style="height: 150px; width: 150px">
										<div class="panel-body" ><span>2</span><br><br><br>
										<span style="float: right; text-align: right"  id="warehouse-2"></span>
										</div>
									</section>
								</div>
								<div class="col-sm-2">
									<section class="panel panel-default" id="changeColor3"
										style="height: 150px; width: 150px">
										<div class="panel-body" ><span>3</span><br><br><br>
										<span style="float: right; text-align: right"  id="warehouse-3"></span>
										</div>
									</section>
								</div>
								<div class="col-sm-2">
									<section class="panel panel-default" id="changeColor4"
										style="height: 150px; width: 150px">
										<div class="panel-body" ><span>4</span><br><br><br>
										<span style="float: right; text-align: right"  id="warehouse-4"></span>
										</div>
									</section>
								</div>
								<div class="col-sm-2">
									<section class="panel panel-default" id="changeColor5"
										style="height: 150px; width: 150px">
										<div class="panel-body" ><span>5</span><br><br><br>
										<span style="float: right; text-align: right"  id="warehouse-5"></span>
										</div>
									</section>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-2">
									<section class="panel panel-default" id="changeColor6"
										style="height: 150px; width: 150px">
										<div class="panel-body" ><span>6</span><br><br><br>
										<span style="float: right; text-align: right"  id="warehouse-6"></span>
										</div>
									</section>
								</div>
								<div class="col-sm-2">
									<section class="panel panel-default" id="changeColor7"
										style="height: 150px; width: 150px">
										<div class="panel-body" ><span>7</span><br><br><br>
										<span style="float: right; text-align: right"  id="warehouse-7"></span>
										</div>
									</section>
								</div>
								<div class="col-sm-2">
									<section class="panel panel-default" id="changeColor8"
										style="height: 150px; width: 150px">
										<div class="panel-body" ><span>8</span><br><br><br>
										<span style="float: right; text-align: right"  id="warehouse-8"></span>
										</div>
									</section>
								</div>
								<div class="col-sm-2">
									<section class="panel panel-default" id="changeColor9"
										style="height: 150px; width: 150px">
										<div class="panel-body" ><span>9</span><br><br><br>
										<span style="float: right; text-align: right" id="warehouse-9"></span>
										</div>
									</section>
								</div>
								<div class="col-sm-2">
									<section class="panel panel-default" id="changeColor10"
										style="height: 150px; width: 150px">
										<div class="panel-body" ><span>10</span><br><br><br>
										<span style="float: right; text-align: right" id="warehouse-10"></span>
										</div>
									</section>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-2">
									<section class="panel panel-default" id="changeColor11"
										style="height: 150px; width: 150px">
										<div class="panel-body" ><span>11</span><br><br><br>
										<span style="float: right; text-align: right" id="warehouse-11"></span>
										</div>
									</section>
								</div>
								<div class="col-sm-2">
									<section class="panel panel-default" id="changeColor12"
										style="height: 150px; width: 150px">
										<div class="panel-body" ><span>12</span><br><br><br>
										<span style="float: right; text-align: right" id="warehouse-12"></span>
										</div>
									</section>
								</div>
								<div class="col-sm-2">
									<section class="panel panel-default" id="changeColor13"
										style="height: 150px; width: 150px">
										<div class="panel-body" ><span>13</span><br><br><br>
										<span style="float: right; text-align: right" id="warehouse-13"></span>
										</div>
									</section>
								</div>
								<div class="col-sm-2">
									<section class="panel panel-default" id="changeColor14"
										style="height: 150px; width: 150px">
										<div class="panel-body" ><span>14</span><br><br><br>
										<span style="float: right; text-align: right" id="warehouse-14"></span>
										</div>
									</section>
								</div>
								<div class="col-sm-2">
									<section class="panel panel-default" id="changeColor15"
										style="height: 150px; width: 150px">
										<div class="panel-body" ><span>15</span><br><br><br>
										<span style="float: right;" id="warehouse-15"></span>
										
										</div>
									</section>
								</div>
							</div>
							 
							 <!-- 태그 등록 모델 -->
							<div class="modal fade" id="modal-form">
								<div class="modal-dialog" style="width: 25%">
									<div class="modal-content" >
										<div class="modal-header" style="text-align: center">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
											<h4 class="modal-title">태그 등록</h4>
										</div>
										<div class="modal-body wrapper-lg">
											<div class="row">
												<div class="col-sm-6">
													<div class="form-group">
															<h4 class="m-t-none m-b">주문번호</h4>
													</div>
													<div class="form-group">
															<h4 class="m-t-none m-b">아이디</h4>
													</div>
													<div class="form-group">
															<h4 class="m-t-none m-b">태그번호</h4>
													</div>
													<div class="form-group">
															<h4 class="m-t-none m-b">총개수</h4>
													</div>
												</div>
												<div class="col-sm-6" >
													<div class="form-group" >
															<h4 class="m-t-none m-b" id="tagOrderNo">4</h4>
													</div>
													<div class="form-group" >
															<h4 class="m-t-none m-b" id="tagId">cus1</h4>
													</div>
													<div class="form-group" >
															<h4 class="m-t-none m-b" id="tagNo">2</h4>
													</div>
													<div class="form-group">
															<h4 class="m-t-none m-b" id="tagCount">1/5</h4>
													</div>
														<div class="form-group m-t-lg">
															<button type="button"  data-dismiss="modal"
																class="btn btn-sm btn-success pull-right text-uc m-t-n-xs">
																<strong>확인</strong>
															</button>
														</div>	
												</div>
											</div>
										</div>
									</div>
									<!-- /.modal-content -->
								</div>
								<!-- /.modal-dialog -->
							</div>
							
							 <!-- 창고 모델 -->
							<div class="modal fade" id="modal-warehouse">
								<div class="modal-dialog" style="width: 25%">
									<div class="modal-content" >
										<div class="modal-header" style="text-align: center">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
											<h4 class="modal-title">보관함 정보</h4>
										</div>
										<div class="modal-body wrapper-lg">
											<div class="row">
												<div class="col-sm-6">
													<div class="form-group">
															<h4 class="m-t-none m-b">보관함번호</h4>
													</div>
													<div class="form-group">
															<h4 class="m-t-none m-b">아이디</h4>
													</div>
													<div class="form-group" >
															<h4 class="m-t-none m-b" id="brCount">태그번호</h4>
													</div>
													<div class="form-group">
															<h4 class="m-t-none m-b">총개수</h4>
													</div>
												</div>
												<div class="col-sm-6" >
													<div class="form-group" >
															<h4 class="m-t-none m-b" id="wareOrderNo">테스트번호 4</h4>
													</div>
													<div class="form-group" >
															<h4 class="m-t-none m-b" id="wareId">테스트아이디 cus1</h4>
													</div>
													<div class="form-group" >
															<h4 class="m-t-none m-b" id="wareNo">테스트태그 2</h4>
													</div>
													<div class="form-group">
															<h4 class="m-t-none m-b" id="wareCount">테스트총개수 1/5</h4>
													</div>
														<div class="form-group m-t-lg">
															<button type="button"  data-dismiss="modal"
																class="btn btn-sm btn-success pull-right text-uc m-t-n-xs">
																<strong>확인</strong>
															</button>
														</div>	
												</div>
											</div>
										</div>
									</div>
									<!-- /.modal-content -->
								</div>
								<!-- /.modal-dialog -->
							</div>
						</section>
					</section>
				</section>
			</section>
		</section>
	</section>
</body>
</html>