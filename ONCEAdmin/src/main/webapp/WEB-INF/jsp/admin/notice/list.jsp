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
function sidemenu(){
	document.getElementById('noticeList').setAttribute('class','');
	document.getElementById('boardQAList').setAttribute('class','');
	document.getElementById('storeList').setAttribute('class','');
	document.getElementById('managerList').setAttribute('class','');
	document.getElementById('cusomterList').setAttribute('class','');
}


$(document).ready(function() {
	sidemenu();
	document.getElementById('noticeList').setAttribute('class','active');
});

function doAction() {
		location.href = "${ pageContext.request.contextPath }/notice/write"

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
<body class="">
	<section class="vbox">
		<!-- 상단바 -->
		<jsp:include page="/WEB-INF/jsp/admin/include/topmenu.jsp" flush="false"></jsp:include>
      	<!-- 상단바 끝 -->

		<section>
			<section class="hbox stretch">
				<!-- 사이드메뉴 -->
            	<jsp:include page="/WEB-INF/jsp/admin/include/sidemenu.jsp" flush="false"></jsp:include>
            	<!-- 사이드메뉴 끝 -->

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
										<th width="7%">번호</th>
										<th width="70%">제목</th>
										<th width="15">조회수</th>
										<th width="15">날짜</th>
									</tr>
									<c:forEach var="noticeList" items="${ list }">
										<tr>
											<td>${ noticeList.noticeNo }</td>
											<td style="text-align: left"><a
												href="${ pageContext.request.contextPath }/notice/detail/${ noticeList.noticeNo }">${ noticeList.title }</a></td>
											<td>${ noticeList.viewCnt }</td>
											<td>${ noticeList.regDate }</td>
										</tr>
									</c:forEach>
								</table>
								<br />
								
<div class="col-sm-4 text-right text-center-xs" style="margin-left: 250px">                
                      <ul class="pagination pagination-sm m-t-none m-b-none">
         					<!-- 처음페이지 -->
         					<li><a href="${ pageContext.request.contextPath }/notice/list?pageNo=1"><i class="fa fa-chevron-left"></i><i class="fa fa-chevron-left"></i></a></li>
                      		<!-- 이전페이지 -->
                      		<c:choose>
                      			<c:when test="${ pageNo == 1 }">
                      				<li><a href="${ pageContext.request.contextPath }/notice/list?pageNo=1"><i class="fa fa-chevron-left"></i></a></li>
                      			</c:when>
                      			<c:otherwise>
                      				<li><a href="${ pageContext.request.contextPath }/notice/list?pageNo=${ pageNo - 1}"><i class="fa fa-chevron-left"></i></a></li>
                      			</c:otherwise>
                      		</c:choose>
                      		<!-- 페이지번호  -->
                      		<c:forEach var="i" begin="${ beginPage }" end="${ endPage }">
									<li><a href="${ pageContext.request.contextPath }/notice/list?pageNo=${i}">${i}</a></li>
                      		</c:forEach>
                      		<!-- 다음페이지 -->
                      		<c:choose>
                      			<c:when test="${ pageNo == endPage }">
                      				<li><a href="${ pageContext.request.contextPath }/notice/list?pageNo=${ endPage }"><i class="fa fa-chevron-right"></i></a></li>
                      			</c:when>
                      			<c:otherwise>
                      				<li><a href="${ pageContext.request.contextPath }/notice/list?pageNo=${ pageNo + 1 }"><i class="fa fa-chevron-right"></i></a></li>
                      			</c:otherwise>
                      		</c:choose>
                      		<!-- 마지막페이지 -->
                      		<li><a href="${ pageContext.request.contextPath }/notice/list?pageNo=${ lastPage }"><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-right"></i></a></li>	
                      </ul>
                    </div>

								<input type="button" onclick="doAction()" value="글쓰기"
									class="btn btn-s-md btn-primary" />
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