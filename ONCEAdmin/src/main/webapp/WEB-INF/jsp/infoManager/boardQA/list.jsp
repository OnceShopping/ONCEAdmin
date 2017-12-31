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
function sidemenu(){
	document.getElementById('items').setAttribute('class', '');
    document.getElementById('addItem').setAttribute('class','');
    document.getElementById('itemDelivery').setAttribute('class','');
    document.getElementById('staffList').setAttribute('class','');
    document.getElementById('boardQAList').setAttribute('class','');
    
}


	var pageNo=${pageNo};
	var date1='${date1}';
	var date2='${date2}';
	var searchC='${searchC}';
	var search='${search}';
	var selectCategory3='${selectCategory3}';
	function sidemenu(){
		document.getElementById('addItem').setAttribute('class','');
		document.getElementById('itemDelivery').setAttribute('class','');
		document.getElementById('staffList').setAttribute('class','');
		document.getElementById('boardQAList').setAttribute('class','');
	}
	
$(document).ready(function() {
	sidemenu();
	document.getElementById('boardQAList').setAttribute('class', 'active');
	
	if(selectCategory3 == null)
	$('#selectCategory3').val('all');
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
		<!-- navbar -->
			<jsp:include page="/WEB-INF/jsp/infoManager/include/topmenu.jsp"></jsp:include>
		<!-- end navbar -->


      <section>
         <section class="hbox stretch">
			<!-- navbar -->
				<jsp:include page="/WEB-INF/jsp/infoManager/include/sidemenu.jsp"></jsp:include>
			<!-- end navbar -->

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
								<option>수령문의</option>
								<option>영업시간</option>
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