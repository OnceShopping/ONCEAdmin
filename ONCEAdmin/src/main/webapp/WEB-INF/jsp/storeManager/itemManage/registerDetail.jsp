<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

var index = 0; //추가된 size와 count에 해당하는 index

	$(document).ready(function(){
		
		var add = false;
		
		//상품의 size와 갯수를 추가하는 로직
		$('#addItem').click(function(){
			
			var item = {
					size : $('#size').val(),
					count : $('#count').val()
			}
			
			$.ajax({
				url : "${ pageContext.request.contextPath }/item/add/"+$('#itemNo').val(),
				dataType:'JSON',
				data : item,
				cache : false,
				contentType : "application/json; charset=UTF-8",
				success : function(data) {
					
					if(data!=null){ //새롭게 상품이 추가되는 경우
						addList(data);
						add = true;					
					}else
						//alert('아래 리스트에 추가된 상품이 존재합니다. 확인해보세요.');
						infoAlert('아래 리스트에 추가된 상품이 존재합니다. 확인해보세요.');
				},error : function(request,status, error) {
					alert("에러 발생! : "+ request.status+ "message : "+ request.responseText+ "\n"+ "error : "+ error);
				}
			});
			
			$('#size').val('');
			$('#count').val('');
		});
		
		$('#addManager').submit(function() {	
			if(add==false){ //상품의 size와 수량을 추가하지 않은 경우
				return false;
			}	
		});
		
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
	});

	//리스트에 추가한 상품의 size와 갯수를 표시
	function addList(data){
		
		var contents = "<tr>";
		contents += "<td style='text-align:center;'>"+$('#itemName').val()+"</td>";
		contents += "<td style='text-align:center;'>"+$('#itemNo').val()+"</td>";
		contents += "<td style='text-align:center;'>"+data.size+"</td>";
		contents += "<td style='text-align:center;'>"+data.count+"</td>";
		contents += "<td style='width: 20%; text-align:center;'><a class='delete' id="+data.size+" onclick=deleteItem('"+(++index)+"') style='color:red;'><i class='fa fa-times' aria-hidden='true'></i></a></td>";
		contents += "</tr>";
		
		$('#AddList').append(contents);
		
	}
	
	//추가한 size와 갯수를 삭제
	function deleteItem(index){
		
		var item = document.getElementsByClassName('delete')[index-1].id;
		var list = document.getElementById('AddList');
		
		$.ajax({
			url : "${ pageContext.request.contextPath }/item/delete",
			dataType:'JSON',
			type:'get',
			data : {
				'size' : item
			},
			cache : false,
			contentType : "application/json; charset=UTF-8",
			success : function(data) {
				alert(data);
				list.deleteRow(index);
			},error : function(request,status, error) {
				alert("에러 발생! : "+ request.status+ "message : "+ request.responseText+ "\n"+ "error : "+ error);
			}
		}); 
	}
	
	//알림 모달 다이얼로그 태그 설정
	function infoAlert(str){
		$('#dialog').html("<div style='text-align:center;'><p>"+str+"</p></div>");
		$("#dialog").dialog("open");
	}
	
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
<div id="dialog" title="ALERT DIALOG"></div>
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
												<li><a href="${pageContext.request.contextPath}/item/register"
													class="auto"> <i class="i i-dot"></i> <span>상품
															등록</span>
												</a></li>
												<li><a href="${pageContext.request.contextPath}/item/list"
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
										<li><a href="#" class="auto"> <span
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
										<li><a href="#" class="auto"> <span
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
							<h3 class="font-bold m-b-none m-t-none">${storeName}상품 등록</h3>
							<br /> <br />
							<form action="${ pageContext.request.contextPath }/item/registerDetail"
								method="post" enctype="multipart/form-data">
								<div style="background-color: #E0DFDF; height: 30px; padding: 5px;"
									id="registerImg">
									<i class="fa fa-angle-double-right" aria-hidden="true"></i> <span
										style="font-size: 10pt; font-weight: bold;">&nbsp;&nbsp;&nbsp;상품 이미지 등록 </span>
								</div>
								<table style="margin-left: 100px;" id="images">
									<tr style="height: 100px;">
										<td style="width: 200px;">상세 이미지 등록</td>
										<td><input type="file" value="파일 찾기"></td>
									</tr>
									<tr style="height: 100px;">
										<td>상세 이미지 등록</td>
										<td><input type="file" value="파일 찾기"></td>
									</tr>
									<tr style="height: 100px;">
										<td>상세 이미지 등록</td>
										<td><input type="file" value="파일 찾기"></td>
									</tr>
								</table>
								<br /> <br />
								<div
									style="background-color: #E0DFDF; height: 30px; padding: 5px;"
									id="registerDetail">
									<i class="fa fa-angle-double-right" aria-hidden="true"></i>
									<span style="font-size: 10pt; font-weight: bold;">&nbsp;&nbsp;&nbsp;상세
										정보 등록 </span>
								</div>
								<div>
								<p style="padding-top: 50px; font-weight: bold; margin-left: 25px;">[SIZE및 수량 등록]</p>
								<table id="itemDetail" style="margin-left: 90px; margin-top: 20px;">
									<tr>
										<td style="width: 50px;" align="right">SIZE</td>
										<td style="width: 10px;"></td>
										<td style="width: 50px;"><input type="text" name="size" id="size"></td>
										<td style="width: 20px;"></td>
										<td style="width: 50px;" align="right">수량</td>
										<td style="width: 10px;"></td>
										<td style="width: 50px;"><input type="number"
											name="count" id="count"></td>
										<td style="width: 20px;"></td>
										<td style="width: 50px;"><input type="button"
											name="addItem" id="addItem" value="추가"></td>
									</tr>
								</table>
								<br/>
								</div>
								<br/>
								<div>
									<p style="font-weight: bold; margin-left: 25px;">[추가 상품 현황]</p>
									<table style="width: 100%; margin-left: 50px;  margin-top: 20px;" id="AddList">
										<tr>
											<th style="width: 20%; text-align: center;">상품 이름</th>
											<th style="width: 20%; text-align: center;">상품 코드</th>
											<th style="width: 20%; text-align: center;">SIZE</th>
											<th style="width: 20%; text-align: center;">COUNT</th>
											<th style="width: 20%; text-align: center;">삭제</th>
										</tr>
									</table>
								</div><br/><br/><br/><br/>
								<div>
									<p style="font-weight: bold; margin-left: 25px;">[상품 상세 정보]</p>
										<div style="margin-left: 110px;  margin-top: 20px;">
											<textarea rows="3" cols="100" name="detail"></textarea>
											<!-- <pre id="detail" name="detail" conenteditable="true"></pre> -->
										</div>
								</div>
								<br/><br/>
								<div align="right">
									<input type="hidden" name="_method" value="post"> 
									<input type="submit" value="등록" class="btn btn-s-md btn-primary" id="finish">
									<input type="hidden" value="${ item.itemNo }" name="itemNo" id="itemNo">
									<input type="hidden" value="${ item.itemName }" name="itemName" id="itemName">
									<input type="hidden" value="${ item.num }" name="num">
									<input type="hidden" value="${ loginVO.managerId }" name="id">
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