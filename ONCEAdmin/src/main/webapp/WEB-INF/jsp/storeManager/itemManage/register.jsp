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

		//상품 코드가 기존에 존재하는지 여부 확인
		$("#itemNo").change(function() {
								
			$.ajax({
				url : "${ pageContext.request.contextPath }/item/checkItem",
				dataType : 'JSON',
				data : ({
					'itemNo' : $('#itemNo').val()
					}),
				type : "get",
				cache : false,
				contentType : "application/json; charset=UTF-8",
				success : function(data) {
					if (data == false)
						$('#checkItemNo').html("<span style='color:green;'><i class='fa fa-check' aria-hidden='true'></i>&nbsp;&nbsp;&nbsp;해당 상품코드로 등록이 가능합니다.</span>");
					else {
						$('#checkItemNo').html("<span style='color:red;'><i class='fa fa-times' aria-hidden='true'></i>&nbsp;&nbsp;&nbsp;기존의 상품이 등록되어 있어 해당 상품코드로 등록이 불가능합니다.</span>");
						$('#itemNo').val('');
						$('#itemNo').focus();
					}

				},
					error : function(request,status, error) {
						alert("에러 발생! : "+ request.status+ "message : "+ request.responseText+ "\n"+ "error : "+ error);
					}
				});
			});
		
		//중분류 선택에 따른 소분류 표시 변경
		$("#middle").change(function(){
			var middleType = $(this).val();
			
			if(middleType=="cloths")
				$('.stuff').hide();
			else
				$('.cloths').hide();
		});
		
		//소분류 선택에 따른 중분류 자동 선택
		$("#small").change(function(){
			
			var middleType = $("#middle").val();
			var smallType = $(this).val();
			
			if((smallType=="shoes")||(smallType=="bag")||(smallType=="accessory"))
				$("#middle").val('stuff').prop("selected", true);
			else
				$("#middle").val('cloths').prop("selected", true);
		});		
		
	});
</script>
<style type="text/css">
.ui-menu {
	width: 200px;
}

.ui-widget-header {
	padding: 0.2em;
}

.select {
	background-color: #F3F2F2;
}
</style>
</head>
<body>
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
											href="${pageContext.request.contextPath}/item/register"
											class="auto"> <span class="pull-right text-muted">
													<i class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-statistics icon"> </i> <span class="font-bold">상품
													관리</span>
										</a>
											<ul class="nav dk">
												<li><a
													href="${pageContext.request.contextPath}/item/register"
													class="auto"> <i class="i i-dot"></i> <span>상품
															등록</span>
												</a></li>
												<li><a
													href="${pageContext.request.contextPath}/item/list"
													class="auto"> <i class="i i-dot"></i> <span>상품
															리스트</span>
												</a></li>
												<li><a href="icons.html" class="auto"> <i
														class="i i-dot"></i> <span>상품 재고 관리</span>
												</a></li>
											</ul>
										<li><a href="#" class="auto"> <span
												class="pull-right text-muted"> <i
													class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-stack icon"> </i> <span class="font-bold">프로모션</span>
										</a></li>
										<li><a href="${pageContext.request.contextPath}/boardQA/list" class="auto"> <span
												class="pull-right text-muted"> <i
													class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-lab icon"> </i> <span class="font-bold">관리자
													답변 게시판</span>
										</a></li>
										<li><a href="#" class="auto"> <span
												class="pull-right text-muted"> <i
													class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-docs icon"> </i> <span class="font-bold">주문
													내역 게시판</span>
										</a></li>
										<li><a href="${pageContext.request.contextPath}/staffManage/list" class="auto"> <span
												class="pull-right text-muted"> <i
													class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-grid2 icon"> </i> <span class="font-bold">매장
													직원 관리</span>
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
							<h3 class="font-bold m-b-none m-t-none">${storeName} 상품 등록</h3>
							<br /> <br />
							<form action="${ pageContext.request.contextPath }/item/register"
								method="post" enctype="multipart/form-data">
									<div
										style="background-color: #E0DFDF; height: 30px; padding: 5px;"
										id="category">
										<i class="fa fa-angle-double-right" aria-hidden="true"></i>
										<span style="font-size: 10pt; font-weight: bold;">&nbsp;&nbsp;&nbsp;카테고리
											선택</span>
									</div>
									<table id="categoryTable"
										style="margin-left: 100px;">
										<tr style="height: 50px;"></tr>
										<tr>
											<td><div style="font-weight: bold; font-size: 10pt;">[
													대분류 ]</div></td>
											<td style="width: 10px;"></td>
											<td><div style="font-weight: bold; font-size: 10pt;">[
													중분류 ]</div></td>
											<td style="width: 10px;"></td>
											<td><div style="font-weight: bold; font-size: 10pt;">[
													소분류 ]</div></td>
										</tr>
										<tr style="height: 10px;"></tr>
										<tr>
											<td>
												<div class="col-lg-4 m-l-n" style="width: 220px;">
													<select multiple class="form-control" id="big"
														name="itemCategory1" required="required">
														<option value="men">남성</option>
														<option value="woman">여성</option>
													</select>
												</div>
											</td>
											<td style="width: 10px;"></td>
											<td>
												<div class="col-lg-4 m-l-n" style="width: 220px;">
													<select multiple class="form-control" id="middle"
														name="itemCategory2" required="required">
														<option value="cloths" id="cloths">의류</option>
														<option value="stuff" id="stuff">잡화</option>
													</select>
												</div>
											</td>
											<td style="width: 10px;"></td>
											<td>
												<div class="col-lg-4 m-l-n" style="width: 220px;">
													<select multiple class="form-control" id="small"
														name="itemCategory3" required="required">
														<option value="top" id="top" class="cloths">상의</option>
														<option value="pants" id="pants" class="cloths">하의</option>
														<option value="shoes" id="shoes" class="stuff">신발</option>
														<option value="bag" id="bag" class="stuff">가방</option>
														<option value="accessory" id="accessory" class="stuff">악세서리</option>
													</select>
												</div>
											</td>
										</tr>
										<tr style="height: 50px;"></tr>
									</table>
								<br />
								<div style="background-color: #E0DFDF; height: 30px; padding: 5px;" id="category">
									<i class="fa fa-angle-double-right" aria-hidden="true"></i>
									<span style="font-size: 10pt; font-weight: bold;">&nbsp;&nbsp;&nbsp;상품 등록</span>
								</div>
								<br /> <br />
								<table style="margin-left: 100px;">
									<tr style="height: 50px;">
										<td style="text-align: left;">상품 이름</td>
										<td style="width: 30px;"></td>
										<td><input type="text" name="itemName"
											required="required"></td>
									</tr>
									<tr style="height: 50px;">
										<td style="text-align: left;">상품 코드</td>
										<td style="width: 30px;"></td>
										<td><input type="text" name="itemNo" id="itemNo" required="required">&nbsp;&nbsp;<span
											id="checkItemNo"></span></td>
										
									</tr>
									<tr style="height: 50px;">
										<td style="text-align: left;">색상</td>
										<td style="width: 30px;"></td>
										<td><input type="text" name="color" required="required"></td>
									</tr>
									<tr style="height: 50px;">
										<td style="text-align: left;">가격</td>
										<td style="width: 30px;"></td>
										<td><input type="number"
											name="price" required="required"></td>
									</tr>
									<tr style="height: 50px;">
										<td style="text-align: left: ;">상품 대표 이미지 등록</td>
										<td style="width: 30px;"></td>
										<td style="text-align: center;"><input type="file" value="파일 찾기" name="attachFile" required="required"></td>
									</tr>
								</table>
								<br /> <br />
								<div align="right">
									<input type="hidden" name="_method" value="post"> <input
										type="submit" value="Next" class="btn btn-s-md btn-primary"
										id="add"> <input type="hidden"
										value="${loginVO.managerId }" name="id">
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