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
	document.getElementById('noticeList').setAttribute('class','');
	document.getElementById('boardQAList').setAttribute('class','');
	document.getElementById('storeList').setAttribute('class','');
	document.getElementById('managerList').setAttribute('class','');
	document.getElementById('cusomterList').setAttribute('class','');
}

	var pageNo=${pageNo};
	var date1='${date1}';
	var date2='${date2}';
	var searchC='${searchC}';
	var search='${search}';
	var selectCategory3='${selectCategory3}';
	
$(document).ready(function() {
	sidemenu();
	document.getElementById('boardQAList').setAttribute('class','active');
	
	if(selectCategory3 == '') {
		$('#selectCategory3').val('all');
	} else {
		$('#selectCategory3').val(selectCategory3);
	}
	
	$('#selectCategory3').change(function() {
		selectCategory3 = $('#selectCategory3').val();
		location.href='${ pageContext.request.contextPath}/boardQA/list?pageNo='+1+'&date1='+date1+'&date2='+date2+'&searchC='+searchC
		+'&search='+search+'&selectCategory3='+selectCategory3;
	});
	
});
	function searchCheck() {
		if( $('#date1').val() == "" || $('#date2').val() == "" ) {
			alert('날짜를 입력해주세요');
			return false;
		}
		
		test1 = $("#date1").val();
		test2 = $("#date2").val();
		if( test1 > test2 ) {
			alert('날짜를 올바르게 입력해주세요');
			$("#date1").val("");
			$("#date2").val("");
			return false;
		}  
}
	
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
		+'&search='+search+'&selectCategory3='+selectCategory3;
		
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
							<form class="form-inline" onsubmit="return searchCheck()" id="searchForm" name="searchForm"
							action="${ pageContext.request.contextPath }/boardQA/list">
							<br />
							<h3 class="font-bold m-b-none m-t-none">QNA 답변</h3>
							<br />
							<div class="col-lg-12 text-right text-center-xs" style="width: 80%">
							
							<select id="selectCategory3" class="form-control " style="width: 150px; float: left" name="selectCategory3">
								<option value="all">전체</option>
								<option>고객편의시설</option>
								<option>기본시설</option>
								<option>영업시간</option>
								<option>서비스</option>
								<option>기타</option>
							</select>
							
							
									
									<span>입력날짜 선택</span>
									<input type="text" style="margin-left: 5px" id="date1" name="date1" value="${ date1 }" 
									readonly="readonly" class="datepicker-input form-control" data-date-format="yyyy-mm-dd" style="width: 150px">
									
									<input type="text" style="margin-left: 5px" id="date2" name="date2" value="${ date2 }" 
									readonly="readonly" class="datepicker-input form-control" data-date-format="yyyy-mm-dd" style="width: 150px">
									<input type="submit" value="검색" class="btn btn-default" id="dateSearch">
								
							<br/><br/>		
							</div>
							
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