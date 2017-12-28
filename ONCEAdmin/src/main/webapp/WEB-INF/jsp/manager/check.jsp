<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="app">
<head>
<meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

<title>ONCE</title>

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/animate.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/font-awesome.min.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/icon.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/font.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/app.css" type="text/css" />

<script src="${pageContext.request.contextPath }/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
<!-- App -->
<script src="${pageContext.request.contextPath }/resources/js/app.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/app.plugin.js"></script>
</head>
<body class="">
   <section class="vbox">
      <!-- 상단바 -->
      <c:choose>
	      <c:when test="${ type eq 'admin' }">
		      <jsp:include page="/WEB-INF/jsp/admin/include/topmenu.jsp" flush="false"></jsp:include>
	      </c:when>
	      <c:when test="${ type eq 'storeManager' || type eq 'storeStaff'}">
 		     <jsp:include page="/WEB-INF/jsp/storeManager/include/topmenu.jsp" flush="false"></jsp:include>
	      </c:when>
	      <c:when test="${ type eq 'infoManager' || type eq 'infoStaff'}">
		      <jsp:include page="/WEB-INF/jsp/infoManager/include/topmenu.jsp" flush="false"></jsp:include>
	      </c:when>
      </c:choose>
      <!-- 상단바 끝 -->

      <section>
         <section class="hbox stretch">
            <!-- 사이드메뉴 -->
			<c:choose>
			      <c:when test="${ type eq  'admin' }">
					<jsp:include page="/WEB-INF/jsp/admin/include/sidemenu.jsp" flush="false"></jsp:include>
			      </c:when>
			      <c:when test="${ type eq 'storeManager' || type eq 'storeStaff'}">
		            <jsp:include page="/WEB-INF/jsp/storeManager/include/sidemenu.jsp" flush="false"></jsp:include>
			      </c:when>
			      <c:when test="${ type eq 'infoManager' || type eq 'infoStaff'}">
		            <jsp:include page="/WEB-INF/jsp/infoManager/include/sidemenu.jsp" flush="false"></jsp:include>
			      </c:when>
		      </c:choose>
            <!-- 사이드메뉴 끝 -->
            
            <!-- 메뉴 사이즈 조정 -->
            <section id="content">
               <section class="vbox">
                  <section class="scrollable wrapper">
                     <section id="content" class="m-t-lg wrapper-md animated fadeInUp">   
						<div class="container aside-xl">
							 <a class="navbar-brand block">관리자 상세 정보 수정<br/></a>
							 <section class="m-b-lg">
								<header class="wrapper text-center">
									<strong>본인 확인을 위해 비밀번호를 한 번 더 입력해 주세요</strong>
								</header>
								<form action="${ pageContext.request.contextPath }/manager/check" method="post">
									<div class="list-group">
										<div class="list-group-item">
											<input type="password" id="password" name="password" placeholder="Password" class="form-control no-border">
										</div>
										<input type="submit" value="확인" class="btn btn-lg btn-primary btn-block"/>
									</div>
								</form>
							</section>
						</div>
					</section>
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