<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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

		$('#searchType').val(''); // 검색 콤보 박스 초기화 
		
		//체크박스 전체 선택, 선택 해제
		$('#checkAll').click(function() {

			var checkVal = document.getElementsByClassName("check");

			if (this.checked) {
				for (var i = 0; i < checkVal.length; i++)
					checkVal[i].checked = true;
			} else {
				for (var i = 0; i < checkVal.length; i++)
					checkVal[i].checked = false;
			}
		});
		
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
					url : "${ pageContext.request.contextPath }/customer/search",
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
		
		//다이얼로그 format 정의 - pwd 체크
		$( "#dialog-pwd" ).dialog({
			autoOpen: false,
		    modal: true,
		    width: '300',
		    height: '200',
		    buttons : [{
		    	id : "cancelPwd", //취소 버튼
		    	text : "cancel",
		    	click : function(){
		    		$(this).dialog("close");
		    	}
		     },
		     {
		      	id : "OKPwd",  //OK 버튼
		      	text : "OK",
		      	click : function(){
			    	$(this).dialog("close");
			   		}
		      }],
		      open: function( event, ui ) {
		    	  $('#pwd').val(''); 
		      }
		});
		
		//삭제 controller로 가기 전
		$('#listForm').submit(function(){
			var checkVal = document.getElementsByClassName("check");
			var count=0;
			requiredCheckPW = false;
			
			for (var i = 0; i < checkVal.length; i++){
				if(checkVal[i].checked)
					count++;
			}
			
			if(count==0)
				infoAlert("삭제하고자 하시는 매니저의 체크박스를 선택해주세요.");
			else
				$( "#dialog-pwd" ).dialog('open');
			
			return false;
		});
	
		//삭제 시 비밀번호를 확인하는 다이얼로그의 "OK"버튼 클릭 시
		$('#OKPwd').click(function(){
			var CheckPwd = $('#pwd').val();
			var loginPwd = "${sessionScope.loginVO.password}";
			
			alert(loginPwd);
			clickBtn(CheckPwd, loginPwd);
		});
		
	});
	
	//삭제 시 비밀번호를 확인하는 다이얼로그를 통해 비밀번호를 비교
	function clickBtn(CheckPwd, loginPwd){
		if(CheckPwd != loginPwd)
			infoAlert("죄송합니다. 비밀 번호가 일치하지 않아 해당 정보를 삭제를 할 수 없습니다.");
		else
			document.getElementById("listForm").submit();
	}
	
	//List 데이터를 각각의 데이터로 뽑아 검색 모달 다이얼로그에 출력되도록 태그 설정 
	function printResult(data) {
		
		var row = "<table style='width: 100%;' id='searchList'>";
		row += "<tr style='width: 100%; height:30px; border: 1 solid; background: #E0DFDF;'>";
		row += "<th style='text-align: center; width='10%'; height:30px;'>고객 번호</th>";
		row += "<th style='text-align: center; width='10%'; height:30px;'>아이디</th>";
		row += "<th style='text-align: center; width='20%'; height:30px;'>이름</th>";
		row += "<th style='text-align: center; width='30%'; height:30px;'>연락처</th>";
		row += "<th style='text-align: center; width='30%'; height:30px;'>가입일</th>";
		row += "</tr>";
		
		$.each(data,function(index,item){
			
			row += "<tr>";
			row += "<td style='text-align: center; height:30px;'>" + item.memNo + "</td>";
			row += "<td style='text-align: center; height:30px;'>" + item.id + "</td>";
			row += "<td style='text-align: center; height:30px;'>" + item.name + "</td>";
			row += "<td style='text-align: center; height:30px;'>" + item.telephone + "</td>";
			row += "<td style='text-align: center; height:30px;'>" + item.date + "</td>";
			row += "</tr>";
			
		});
		
		row += "</table>";

		return row;
	}

	//검색 모달 다이얼로그에 데이터 출력 태그 설정 후 open 
	function showModal(ModalTest){
		$("#searchResult").html(ModalTest);
		$("#exampleModal").modal();
	}
	
	//알림 모달 다이얼로그 태그 설정 후 open
	function infoAlert(str){
		$('#dialog').html("<div style='text-align:center;'><p>"+str+"</p></div>");
		$("#dialog").dialog("open");
	}
	
</script>
<style type="text/css">
th {
	text-align: center;
	font-size: 13pt;
	font-weight: bold;
}

td {
	text-align: center;
	font-size: 10pt;
}

tr:hover {
	background-color: #f5f5f5;
}
</style>
</head>
<body class="">
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
	<div id="dialog" title="ALERT DIALOG"></div>
	<div id="dialog-pwd" title="CHECK PASSWORD">
	  	<p class="validateTips">해당 정보를 삭제하기 위해서 비밀 번호를 다시 한번 입력해주세요.</p>
	 	<form>
		    <fieldset>
		        <label for="password">Password</label>
		      <input type="password" name="pwd" id="pwd" class="text ui-widget-content ui-corner-all">
		    </fieldset>
	  	</form>
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
									<ul class="nav nav-main">
										<li><a
											href="${pageContext.request.contextPath}/notice/list"
											class="auto"> <i class="i i-circle-sm-o text"></i> <i
												class="i i-circle-sm text-active"></i><i
												class="i i-statistics icon"> </i> <span class="font-bold">운영
													공지</span>
										</a></li>
										<li><a href="${pageContext.request.contextPath}/boardQA/list" class="auto"> <span
												class="pull-right text-muted"> <i
													class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-stack icon"> </i> <span class="font-bold">QNA
													답변</span>
										</a></li>
										<li><a href="#" class="auto"> <span
												class="pull-right text-muted"> <i
													class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-lab icon"> </i> <span class="font-bold">매장
													관리</span>
										</a></li>
										<li><a href="${pageContext.request.contextPath}/manager/list" class="auto"> <span
												class="pull-right text-muted"> <i
													class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-docs icon"> </i> <span class="font-bold">매니저
													관리</span>
										</a></li>
										<li class="active"><a
											href="${pageContext.request.contextPath}/customer/list"
											class="auto"> <span class="pull-right text-muted">
													<i class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-grid2 icon"> </i> <span class="font-bold">고객
													관리</span>
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
							<h3 class="font-bold m-b-none m-t-none">고객 관리</h3>
							<br/>
							현재 총 회원 수 ${fn:length(customerAll)}명
							<br/><br/>
							<div align="right">
								<form id="searchForm">
									<select id="searchType" name="searchType" style="height: 27px; width: 80px;">
										<option value="name">이름</option>
										<option value="id">아이디</option>
									</select>&nbsp; 
									<input type="text" name="searchText" id="searchText">
									&nbsp; <input type="submit" value="검색" id="modalBtn"  data-toggle="modal" data-target="#exampleModal">
								</form>
							</div>
							<div>
								<br />
								<form
									action="${pageContext.request.contextPath}/customer/list"
									method="post" id="listForm" name="listForm">
									<!--<div style="text-align: right;">
										회원 등급 <select class="select">
												<option value="1">Option 1</option>
												<option value="2">Option 2</option>
												<option value="3">Option 3</option>
										</select>
									</div>  -->
									<table
										class="table table-striped m-b-none dataTable no-footer">
										<tr style="text-align: center; background-color: #E7E7E7">
											<td width="5%"><input type="checkbox" id="checkAll"></td>
											<th width="15%" class="tbTile">고객 번호</th>
											<th width="15%" class="tbTile">아이디</th>
											<th width="15%" class="tbTile">이름</th>
											<th width="20%" class="tbTile">연락처</th>
											<th width="10%" class="tbTile">회원 등급</th>
											<th width="20%" class="tbTile">가입일</th>
										</tr>
										<c:forEach items="${ customerList }" var="customer">
											<tr>
												<td><input type="checkbox" class="check"
													value=${ customer.memNo } name="memNo"></td>
												<td>${ customer.memNo }</td>
												<td>${ customer.id }</td>
												<td>${ customer.name }</td>
												<td>${ customer.telephone }</td>
												<td>등급</td>
												<td>${ customer.date }</td>
											</tr>
										</c:forEach>
									</table>
									<br /><br /> <br /> <br />
								<div class="col-sm-4 text-right text-center-xs" style="margin-left: 340px;">                
			                      <ul class="pagination pagination-sm m-t-none m-b-none">
			         					<!-- 처음페이지 -->
			         					<li><a href="${ pageContext.request.contextPath }/customer/list?pageNo=1"><i class="fa fa-chevron-left"></i><i class="fa fa-chevron-left"></i></a></li>
			                      		<!-- 이전페이지 -->
			                      		<c:choose>
			                      			<c:when test="${ pageNo == 1 }">
			                      				<li><a href="${ pageContext.request.contextPath }/customer/list?pageNo=1"><i class="fa fa-chevron-left"></i></a></li>
			                      			</c:when>
			                      			<c:otherwise>
			                      				<li><a href="${ pageContext.request.contextPath }/customer/list?pageNo=${ pageNo - 1}"><i class="fa fa-chevron-left"></i></a></li>
			                      			</c:otherwise>
			                      		</c:choose>
			                      		<!-- 페이지번호  -->
			                      		<c:forEach var="i" begin="${ beginPage }" end="${ endPage }">
												<li><a href="${ pageContext.request.contextPath }/customer/list?pageNo=${i}">${i}</a></li>
			                      		</c:forEach>
			                      		<!-- 다음페이지 -->
			                      		<c:choose>
			                      			<c:when test="${ pageNo == endPage }">
			                      				<li><a href="${ pageContext.request.contextPath }/customer/list?pageNo=${ endPage }"><i class="fa fa-chevron-right"></i></a></li>
			                      			</c:when>
			                      			<c:otherwise>
			                      				<li><a href="${ pageContext.request.contextPath }/customer/list?pageNo=${ pageNo + 1 }"><i class="fa fa-chevron-right"></i></a></li>
			                      			</c:otherwise>
			                      		</c:choose>
			                      		<!-- 마지막페이지 -->
			                      		<li><a href="${ pageContext.request.contextPath }/customer/list?pageNo=${ lastPage }"><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-right"></i></a></li>	
			                      </ul>
			                    </div>
                    		<br /> <br />
									<div style="text-align: right;">
										<c:if test="${ !empty customerList }">			
											<input type="hidden" name="_method" value="delete">
											<input type="submit" value="삭제"
												class="btn btn-s-md btn-primary">
										</c:if>
									</div>
								</form>
							</div>
						</section>
					</section>
				</section>
			</section>
		</section>
	</section>
</body>
</html>