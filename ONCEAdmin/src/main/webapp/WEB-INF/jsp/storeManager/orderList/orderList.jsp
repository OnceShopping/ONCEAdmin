<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="app">
<head>
<meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<title>ONCE</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/animate.css"	type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/font-awesome.min.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/icon.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/font.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/app.css"	type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/js/datepicker/datepicker.css" type="text/css" />
<script	src="${pageContext.request.contextPath }/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script	src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
<!-- App -->
<script src="${pageContext.request.contextPath }/resources/js/app.js"></script>
<script	src="${pageContext.request.contextPath }/resources/js/slimscroll/jquery.slimscroll.min.js"></script>
<script	src="${pageContext.request.contextPath }/resources/js/app.plugin.js"></script>
<!-- datepicker -->
<script src="${pageContext.request.contextPath }/resources/js/datepicker/bootstrap-datepicker.js"></script>
<script type="text/javascript">
	
</script>
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
                                    <li>
                                    	<a  href="${pageContext.request.contextPath}/item/register" class="auto">
                                    		<i class="i i-dot"></i><span>상품 등록</span>
                                    </a></li>
                                    <li>
	                                    <a href="${pageContext.request.contextPath}/item/list" class="auto">
	                                    	<i class="i i-dot"></i><span>상품  리스트</span>
	                                    </a>
                                    </li>
                                    <li>
                                    <a href="icons.html" class="auto">
                                    	<i class="i i-dot"></i><span>상품 재고 관리</span>
                                    </a>
                                    </li>
                                 </ul>
                              <li>
                              	<a href="#" class="auto"> 
                              		<span class="pull-right text-muted"> 
                              		<i class="i i-circle-sm-o text"></i> 
                              		<i class="i i-circle-sm text-active"></i>
                                 	</span> 
                                 	<i class="i i-stack icon"> </i> <span class="font-bold">프로모션</span>
                              	</a>
                              </li>
                              <li>
                              	<a href="${pageContext.request.contextPath}/boardQA/list" class="auto"> 
                              	<span class="pull-right text-muted"> 
                              		<i class="i i-circle-sm-o text"></i> 
                              		<i  class="i i-circle-sm text-active"></i>
                                 </span> 
                                 	<i class="i i-lab icon"></i>
                                 <span class="font-bold">관리자  답변 게시판</span>
                              	</a>
                              </li>
                              <li class="active">
                              	<a href="${pageContext.request.contextPath}/orderList/orderList" class="auto">
	                              	<span class="pull-right text-muted"> 
	                              		<i class="i i-circle-sm-o text"></i> 
	                              		<i class="i i-circle-sm text-active"></i>
	                                </span>
	                                	<i class="i i-docs icon"></i>
	                                <span class="font-bold">주문 내역 게시판</span>
                              	</a>
                              </li>
                              <li>
                              	<a href="${pageContext.request.contextPath}/staffManage/list" class="auto">
                              		<span class="pull-right text-muted"> 
                              		<i class="i i-circle-sm-o text"></i> 
                              		<i class="i i-circle-sm text-active"></i>
                                 	</span>
                                 	<i class="i i-grid2 icon"></i> 
                                 	<span class="font-bold">매장  직원 관리</span>
                              </a>
                              </li>
                           </ul>
                        </nav>
                  </div>
                  </section>
                  <footer class="footer hidden-xs no-padder text-center-nav-xs">
                     <!-- 메뉴 하단 로그아웃 버튼 -->
                     <a href="modal.lockme.html" data-toggle="ajaxModal" class="btn btn-icon icon-muted btn-inactive pull-right m-l-xs m-r-xs hidden-nav-xs">
                        <i class="i i-logout"></i>
                     </a>
                     <!-- 메뉴 하단 축소 버튼 -->
                     <a href="#nav" data-toggle="class:nav-xs" class="btn btn-icon icon-muted btn-inactive m-l-xs m-r-xs">
                        <i class="i i-circleleft text"></i> <i class="i i-circleright text-active"></i>
                     </a>
                  </footer>
               </section>
            </aside>            
            <!-- 사이드 메뉴 끝 -->
			<section id="content">
				<section class="vbox">
					<section class="scrollable wrapper" style="padding-left: 50px; padding-right: 50px;">
						<br />
						<h3 class="font-bold m-b-none m-t-none">주문 내역 게시판</h3>
						<br />
						<div style="text-align: right;">
							<p style="float: left;">전체 주문 내역: <u>${orderCount}</u> 개</p>
							<div style="margin-left: 30px;">
								<select id="choice" style="width: 85px;">
									<option>전체</option>
									<option>처리사항</option>
									<option>주문번호</option>
									<option>수령장소</option>
								</select>
								<select id="option" style="width: 85px;">
									<option>전체</option>
								</select>
			                	<input type="submit" value="검색" class="btn btn-default" id="dateSearch">
								<br/><br/>
							</div>
						</div>
						
						<div style="text-align: center; width: 100%">
							<table class="table table-striped m-b-none dataTable no-footer" >
								<tr>
									<th width="7%">선택</th>
									<th width="20">주문번호</th>
									<th width="15">주문자</th>
									<th width="20">상품고유번호</th>
									<th width="50">상품명</th>
									<th width="20">수량</th>
									<th width="45">연락처</th>
									<th width="45">처리사항</th>
									<th width="20">가격</th>
									<th width="45">주문일</th>
									<th width="20">수령장소</th>
								</tr>
								<c:forEach var="order" items="${ storeNoorderList }" varStatus="loop">
								<c:forEach var="detail" items="${ order.orderDetails }" varStatus="status">
								<tr id="item_${loop.index}_${status.index}">
									<td id="item_${loop.index}_${status.index}"><input type="checkbox" id="choice_${loop.index}_${status.index}"></td>
									<td id="orderNo_${loop.index}_${status.index}">${ detail.orderNo }</td>
									<td id="id_${loop.index}_${status.index}">${ order.id }</td>
									<td id="detailNo_${loop.index}_${status.index}">${ detail.detailNo }</td>
									<td id="itemName_${loop.index}_${status.index}">${ detail.itemName }<br/>
									<span style="font-size: 10px;">(${detail.color} | ${detail.size})</span>
									</td>
									<td id="count_${loop.index}_${status.index}">${ detail.count }</td>
									<td id="phone_${loop.index}_${status.index}">${ order.telephone }</td>
									<td id="status_${loop.index}_${status.index}">${ order.status }</td><!-- 혹시나, status이름 같아서 오류날 수도 -->
									<td id="price_${loop.index}_${status.index}">${ detail.price }</td>
									<td id="date_${loop.index}_${status.index}">${ order.date }</td>
									<td id="floor_${loop.index}_${status.index}">${ order.floor }</td>
								</tr>
								</c:forEach>
								</c:forEach>
							</table>
						<br/>
						</div>
						<div style="float: right;">
							<button id="accept" type="button" class="btn btn-primary" style="margin: 10px;">승인</button><!-- (제어걸기) 주문 번호 기준  | 결재완료인 것만 -->
							<button id="delivery" type="button" class="btn btn-primary" >전달</button><!-- (제어걸기) 수령 장소 기준  | 상품승인완료인 것만 -->
						</div>								
					</section>
					<a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>						
				</section>
				<!-- 메뉴 사이즈 조정 끝-->
			</section>
      	 </section>
      </section>      
    </section>
</body>
</html>