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

$(document).ready(function(){
	
	$('#searchType').val(''); // 검색 콤보 박스 초기화
	
	//검색
	$('#searchForm').submit(function() {

		if ($('#searchText').val() == "") {
			$("#searchResult").html('검색 란을 작성해주세요.');
			$("#exampleModal").modal();
			return false;
		}else if($('#searchType').val()==null){
			$("#searchResult").html('검색 타입을 설정해주세요.');
			$("#exampleModal").modal();
			return false;
		}else {
			
			type = $(this).serialize();

			$.ajax({
				url : "${ pageContext.request.contextPath }/item/search",
				data : type.replace(/%/g,'%25'), 
				type : "post",
				dataType : "json",
				cache : false,
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",

				success : function(data) {
				
					if(data==""){
						$("#searchResult").html('<p>죄송하지만 검색 결과가 존재하지 않습니다.<p/>다시 한번 확인해주세요.');
						$("#exampleModal").modal();
					}else{
						ModalTest = printResult(data);
						showModal(ModalTest);
					}	
												
				},error : function(request, status, error) {
					alert("에러 발생! : " + request.status + "message : "+ request.responseText+ "\n"+ "error : "+ error);
				}
			});
			
			$('#searchText').val(''); // 검색 텍스트 초기화 
			$('#searchType').val(''); // 검색 콤보 박스 초기화 
			return false;
		}
	});
});

//List 데이터를 각각의 데이터로 뽑아 검색 모달 다이얼로그에 출력되도록 태그 설정 
function printResult(data) {

	var row = "<table style='width: 100%;' id='searchList'>";
	row += "<tr style='width: 100%; height:30px; border: 1 solid; background: #E0DFDF;'>";
	row += "<th style='text-align: center; width='10%'; height:30px;'>상품 이름</th>";
	row += "<th style='text-align: center; width='10%'; height:30px;'>상품 코드</th>";
	row += "<th style='text-align: center; width='20%'; height:30px;'>색상</th>";
	row += "<th style='text-align: center; width='20%'; height:30px;'>SIZE</th>";
	row += "<th style='text-align: center; width='20%'; height:30px;'>수량</th>";
	row += "<th style='text-align: center; width='20%'; height:30px;'>가격</th>";
	row += "</tr>";
	
	$.each(data,function(index,item){
		
		row += "<tr>";
		row += "<td style='text-align: center; height:30px;'>" + item.itemName + "</td>";
		row += "<td style='text-align: center; height:30px;'>" + item.itemNo + "</td>";
		row += "<td style='text-align: center; height:30px;'>" + item.color + "</td>";
		row += "<td style='text-align: center; height:30px;'>" + item.size + "</td>";
		row += "<td style='text-align: center; height:30px;'>" + item.count + "</td>";
		row += "<td style='text-align: center; height:30px;'>" + item.price + "</td>";
		row += "</tr>";
		
	});
	
	row += "</table>";

	return row;
}
//검색 모달 다이얼로그 정보 출력 태그 설정 
function showModal(ModalTest){
	$("#searchResult").html(ModalTest);
	$("#exampleModal").modal();
}

</script>
<style type="text/css">
	.itemList {
		border-collapse: collapse;
		width: 100%;
		border: 1 solid;
		border-color: #bcbcbc;
	}

	.itemList td {
		text-align: center;
	}
</style>
</head>
<body>
	<!-- Modal --> 						
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
						<span class="sr-only">Close</span>
						</button>
					<h3 class="modal-title" id="exampleModalLabel">SEARCH RESULT</h3>
			 	</div>
		 	<div class="modal-body">
		 		<div id="searchResult">검색 란을 작성해주세요.</div>
			</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
				</div>
			</div>
		 </div>
	</div>
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
							<h3 class="font-bold m-b-none m-t-none">${storeName} 상품 리스트</h3>
							<div align="left"  style="margin-top:50px;">
								<span style="text-align: left;"><span>대분류</span>
									<select>
										<option value="men">남성</option>
										<option value="woman">여성</option>
									</select>
								</span>
							</div>
							<form id = "searchForm">
							<div align="right" style=" margin-bottom:30px;">
								<select  id="searchType" name="searchType" style="height: 27px">
									<option value="itemName" id="itemName">상품이름</option>
									<option value="itemNo" id="itemNo">상품코드</option>
								</select>
								<input type="text" id="searchText" name="searchText">
								<input type="hidden" id="storeName" name="storeName" value="${storeName}">
								<input type="submit" value="검색" data-toggle="modal" data-target="#exampleModal"/>
							</div>
							</form>
							<table class="itemList" >
								<tr style="text-align: center; background-color: #E7E7E7;" >
									<td style="width: 5%;">NO</td>
									<td style="width: 20%;">상품 이름</td>
									<td style="width: 20%;">상품 코드</td>
									<td style="width: 15%;">색상</td>
									<td style="width: 15%;">SIZE</td>
									<td style="width: 10%;">수량</td>
									<td style="width: 15%;">가격</td>
								</tr>
								<c:forEach var="item" items="${itemList}" varStatus="index">
									<tr>
										<td><c:out value="${ index.count }"/></td>
										<td><c:out value="${ item.itemName }"/></td>
										<td><c:out value="${ item.itemNo }"/></td>
										<td><c:out value="${ item.color }"/></td>
										<td><c:out value="${ item.size }"/></td>
										<td><c:out value="${ item.count }"/></td>
										<td><c:out value="${ item.price }"/></td>
									</tr>
								</c:forEach>
							</table>
							<br /> <br /> <br />
								<div class="col-sm-4 text-right text-center-xs" style="margin-left: 340px;">                
			                      <ul class="pagination pagination-sm m-t-none m-b-none">
			         					<!-- 처음페이지 -->
			         					<li><a href="${ pageContext.request.contextPath }/item/list?pageNo=1"><i class="fa fa-chevron-left"></i><i class="fa fa-chevron-left"></i></a></li>
			                      		<!-- 이전페이지 -->
			                      		<c:choose>
			                      			<c:when test="${ pageNo == 1 }">
			                      				<li><a href="${ pageContext.request.contextPath }/item/list?pageNo=1"><i class="fa fa-chevron-left"></i></a></li>
			                      			</c:when>
			                      			<c:otherwise>
			                      				<li><a href="${ pageContext.request.contextPath }/item/list?pageNo=${ pageNo - 1}"><i class="fa fa-chevron-left"></i></a></li>
			                      			</c:otherwise>
			                      		</c:choose>
			                      		<!-- 페이지번호  -->
			                      		<c:forEach var="i" begin="${ beginPage }" end="${ endPage }">
												<li><a href="${ pageContext.request.contextPath }/item/list?pageNo=${i}">${i}</a></li>
			                      		</c:forEach>
			                      		<!-- 다음페이지 -->
			                      		<c:choose>
			                      			<c:when test="${ pageNo == endPage }">
			                      				<li><a href="${ pageContext.request.contextPath }/item/list?pageNo=${ endPage }"><i class="fa fa-chevron-right"></i></a></li>
			                      			</c:when>
			                      			<c:otherwise>
			                      				<li><a href="${ pageContext.request.contextPath }/item/list?pageNo=${ pageNo + 1 }"><i class="fa fa-chevron-right"></i></a></li>
			                      			</c:otherwise>
			                      		</c:choose>
			                      		<!-- 마지막페이지 -->
			                      		<li><a href="${ pageContext.request.contextPath }/item/list?pageNo=${ lastPage }"><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-right"></i></a></li>	
			                      </ul>
			                    </div>
                    		<br /> <br />
						</section>
					</section>
				</section>
			</section>
		</section>
	</section>
</body>
</html>