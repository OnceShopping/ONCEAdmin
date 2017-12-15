<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="app">
<head>
<meta name="description"
	content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1" />
<title>ONCE</title>
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
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/js/datepicker/datepicker.css" type="text/css" />

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
<!-- datepicker -->
<script src="${pageContext.request.contextPath }/resources/js/datepicker/bootstrap-datepicker.js"></script>

<script type="text/javascript">
	var pageNo=${pageNo};
	var date1='${date1}';
	var date2='${date2}';
	var searchC='${searchC}';
	var search='${search}';
	var selectCategory3='${selectCategory3}';
	
$(document).ready(function() { 
	if(selectCategory3 == null)
	$('#selectCategory3').val('all');
	
	 
//	$('#selectCategory3').change(function() {
//		location.href='${ pageContext.request.contextPath }/boardQA/list';
//		alert(selectCategory3);
//		location.href="${ pageContext.request.contextPath }/boardQA/list?selectCategory3="+$('#selectCategory3').val();
//	});
});
	function searchQNA(paging) {
		page = paging;
		if(date1 == null)
		date1 = $("#date1").val();
		if(date2 == null)
		date2 = $("#date2").val();

		searchC = document.getElementById('searchC').value;
		search = document.getElementById('search').value;
			
		if(selectCategory3 == null) 
		selectCategory3 = $('#selectCategory3').val();
				
		location.href='${ pageContext.request.contextPath}/boardQA/list?pageNo='+paging+'&date1='+date1+'&date2='+date2+'&searchC='+searchC
		+'&search='+search+'&selectCategory3='+selectCategory3
		
	}
</script>
<style type="text/css">
th {
	text-align: center;
	font-size: 13pt;
}

ul {
	
}
</style>
</head>
<body>
   <section class="vbox">
      <!-- 상단바 -->
      <header class="bg-white header header-md navbar navbar-fixed-top-xs box-shadow">
         <div class="navbar-header aside-md dk">
            <a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen,open" data-target="#nav,html">
               <i class="fa fa-bars"></i></a> 
            <a href="index.html" class="navbar-brand"> <span class="hidden-nav-xs">ONCE</span></a>
            <a class="btn btn-link visible-xs" data-toggle="dropdown" data-target=".user"> <i class="fa fa-cog"></i></a>
         </div>
      </header>
      <!-- 상단바 끝 -->

      <section>
         <section class="hbox stretch">
            <!-- 메뉴 위 프로필 -->
            <aside class="bg-black aside-md hidden-print hidden-xs" id="nav">
               <section class="vbox">
                  <section class="w-f scrollable">
                     <div class="slim-scroll" data-height="auto" data-disable-fade-out="true" data-distance="0" data-size="10px" data-railOpacity="0.2">
                        <div class="clearfix wrapper dk nav-user hidden-xs">
                           <div class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                 <span class="hidden-nav-xs clear"> 
                                 <span class="block m-t-xs"> 
                                 	<strong class="font-bold text-lt">${loginVO.managerId }</strong>
                                 <b class="caret"></b>
                                 </span>
                              	 </span>
                              </a>
                              <!-- 프로필 클릭시 나오는 메뉴 -->
                              <ul class="dropdown-menu animated fadeInRight m-t-xs">
                                 <li><a href="${ pageContext.request.contextPath }/manager/check">Profile</a></li>
                                 <li class="divider"></li>
                                 <li><a href="modal.lockme.html" data-toggle="ajaxModal">Logout</a></li>
                              </ul>
                           </div>
                        </div>
                        <!-- 프로필 클릭시 나오는 메뉴 끝 -->
                        <!-- 메뉴 위 프로필 끝 -->

                        <!-- 사이드 메뉴 -->
                        <nav class="nav-primary hidden-xs" id="sidemenu">
                           <div class="text-muted text-sm hidden-nav-xs padder m-t-sm m-b-sm">Start</div>
                           <ul class="nav nav-main" data-ride="collapse">
                              <li>
                              <a href="#" class="auto">
                              	<span class="pull-right text-muted">
                                       <i class="i i-circle-sm-o text"></i> 
                                       <i class="i i-circle-sm text-active"></i>
                                </span> 
                                	   <i class="i i-statistics icon"></i> 
                               	<span class="font-bold">상품 관리</span>
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
                              <li class="active"><a href="${pageContext.request.contextPath}/boardQA/list" class="auto"> <span
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
							<form class="form-inline" onsubmit="return searchCheck()" id="searchForm" name="searchForm"
							action="${ pageContext.request.contextPath }/boardQA/list">
							<br />
							<h3 class="font-bold m-b-none m-t-none">QNA 답변</h3>
							<br />
							<!-- <div class="col-lg-12 text-right text-center-xs" style="width: 80%; display: table;" align="left"> -->
							
							<select id="selectCategory3" class="form-control " style="width: 150px; display: table-cell;" name="selectCategory3" >
								<option value="all">전체</option>
								<option>고객편의시설</option>
								<option>기본시설</option>
								<option>영업시간</option>
								<option>서비스</option>
								<option>기타</option>
							</select>
									
		                           <input type="submit" value="검색" class="btn btn-default" id="dateSearch" style="margin-left: ">
							<br/><br/>		
							<!-- </div> -->
							
							<div style="text-align: right; width: 80%">
								
								<table width="100%"
									class="table table-striped m-b-none dataTable no-footer"
									style="text-align: center">
									<tr>
										<th width="7%">번호</th>
										<th width="60%">제목</th>
										<th width="10">ID</th>
										<th width="18">조회수</th>
										<th width="15">날짜</th>
									</tr>
									<c:forEach var="list" items="${ BoardList }">
										<tr>
											<td>${ list.boardNo }</td>
											<td style="text-align: left">
												<a href="${ pageContext.request.contextPath }/boardQA/detail/${ list.boardNo }">
													${ list.title }
												</a>
											</td>
											<td>${ list.writer }</td>	
											<td>${ list.viewCnt }</td>
											<td>${ list.regDate }</td>
										</tr>
									</c:forEach>
								</table>
								<br />

				<div class="col-sm-4 text-right text-center-xs" style="margin-left: 250px">                
                      <ul class="pagination pagination-sm m-t-none m-b-none">
         					<!-- 처음페이지 -->
         					<li><a  href="#" onclick="searchQNA(1)"><i class="fa fa-chevron-left"></i><i class="fa fa-chevron-left"></i></a></li>
                      		<!-- 이전페이지 -->
                      		<c:choose>
                      			<c:when test="${ pageNo == 1 }">
                      				<li><a href="#" onclick="searchQNA(1)"><i class="fa fa-chevron-left"></i></a></li>
                      			</c:when>
                      			<c:otherwise> 
                      				<li><a href="#" onclick="searchQNA(${pageNo -1 })"><i class="fa fa-chevron-left"></i></a></li>
                      			</c:otherwise>
                      		</c:choose>
                      		<!-- 페이지번호  -->
                      		<c:forEach var="i" begin="${ beginPage }" end="${ endPage }">
									<li><a href="#" onclick="searchQNA(${i})">${i}</a></li>
                      		</c:forEach>
                      		<!-- 다음페이지 -->
                      		<c:choose>
                      			<c:when test="${ pageNo == endPage }">
                      				<li><a href="#" onclick="searchQNA(${ endPage })"><i class="fa fa-chevron-right"></i></a></li>
                      			</c:when>
                      			<c:otherwise>
                      				<li><a href="#" onclick="searchQNA(${pageNo +1 })"><i class="fa fa-chevron-right"></i></a></li>
                      			</c:otherwise>
                      		</c:choose>
                      		<!-- 마지막페이지 -->
                      		<li><a href="#" onclick="searchQNA(${ lastPage })"><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-right"></i></a></li>	
                      </ul>
                    
				
							</div>
					
					<div class="col-sm-6 text-center-xs" style="margin-left: 150px">
					<br/>
					<!-- 검색 -->
								<select name="searchC" class="form-control m-b" style="margin-top: 15px" id="searchC">
									<option value="t">제목</option>
									<option value="w">작성자</option>
									<option value="c">내용</option>
									<option value="tc">제목+내용</option>
								</select> 
								<input type="text" name="search" id="search" class="form-control" style="width: 200px"/> <input type="button" value="검색" class="btn btn-default" onclick="searchQNA(1)"/>
							
					</div>							
					</div>	
					</form>	
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