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
	
		var ModalTest;
		var requiredCheck = false; //ID 중복 확인
		var requiredCheckPW = false; //삭제 시 pw 확인
		
			$('#typeSelect').val(''); // 매장 타입 콤보 박스 초기화
			$('#storeSelect').val(''); // 매장 이름  콤보 박스 초기화
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
			
			//정보 수정
			$('#modify').click(function() {
				var checkVal = document.getElementsByClassName("check");
					var count = 0; //선택 체크한 사원의 수

					//선택한 사원의 수 확인
					for (var i = 0; i < checkVal.length; i++) {
						if (checkVal[i].checked)
							++count;
					}

					if (count != 1) //선택한 사원이 1명 이상일 때
						alert('사원 한명만 선택해 정보 수정을 해주시기 바랍니다.');
						else { //선택한 사원이 1명일 경우
							for (var i = 0; i < checkVal.length; i++) {
								if (checkVal[i].checked)
									location.href = "${ pageContext.request.contextPath }/manager/modify/"+ checkVal[i].value;
							}
						}
			});
			
			//매장 선택 - 첫 번째 콤보박스 선택 시 두 번째 콤보박스에 표시되는 option 제어 
			$('#typeSelect').on("change", function() {

				var state = $('#typeSelect option:selected').val();

				$('#storeSelect').val('');
				$('.storeType').hide(); // 두 번째 select-box에 존재하는 option 모두 숨기기

					if (state == "0000") { // admin일 경우
						$('#storeSelect').hide(); // 두번 째 select-box가 사라짐
					} else { // admin이 아닐 경우 
						$('#storeSelect').show(); // 두번 째 select-box를 표시함

						// 첫 번째 select-box에 해당하는 것만 보여주기 위한 로직
						if (state == "info")
							$('.info').show();
						else if (state == "F01")
							$('.F01').show();
						else if (state == "F02")
							$('.F02').show();
						else
							$('.F03').show();
					}
			});
			
			//매장 선택 - 두 번째 콤보박스에서 option 선택 시 첫 번째 콤보박스 option이 자동으로 설정될 수 있도록 제어
			$('#storeSelect').on("change",function() {

				var store = $('#storeSelect').val();

				if ((store == 'INFO1F')|| (store == 'INFOB1'))
					$("#typeSelect").val("info").prop("selected", true);
				else if ((store == 'S1F01')|| (store == 'S1F02'))
					$("#typeSelect").val("F01").prop("selected", true);
				else if ((store == 'S2F01')|| (store == 'S2F01'))
					$("#typeSelect").val("F02").prop("selected", true);
				else
					$("#typeSelect").val("F03").prop("selected", true);
			});

			//추가
			$('#addManager').submit(function() {	
				//[추가] 전, 빈칸 체크  	
				var checkId= $('#managerId').val();
				var checkPW= $('#password').val();
				var checkName= $('#name').val();
				var checkTel= $('#telephone').val();
				var checkSN= $('#storeSelect').val();
				
				if(checkId==""){
					infoAlert("ID를 입력해주세요.");
				}else if(checkPW==""){
					infoAlert("비밀 번호를 입력해주세요.");
				}else if(checkName==""){
					infoAlert("이름을 입력해주세요.");
				}else if(checkTel==""){
					infoAlert("전화번호를 입력해주세요.");
				}else if(checkSN===null){
					infoAlert("매장을 선택해주세요.");
				}else if(requiredCheck==false){
					infoAlert("ID 중복 체크를 해주세요.");
				}else{ // 정상적으로 모두 작성이 되어있는 경우
					var type = $('#typeSelect').val();
					var Mtype;
	
					if (type == 'info')
						Mtype = "infoManager";
					else if (type == '0000')
						Mtype = "admin";
					else
						Mtype = "storeManager";

					var params = {
						managerId : $('#managerId').val(),
						password : $('#password').val(),
						name : $('#name').val(),
						type : Mtype,
						telephone : $('#telephone').val(),
						storeNo : $('#storeSelect').val()
					};

					$.ajax({
						url : "${ pageContext.request.contextPath }/manager/add",
						data : params,
						type : "get",
						cache : false,
						contentType : "application/json; charset=UTF-8",
						success : function(data) {
								
							var result = $.parseJSON(data);
							
							printList(result); //리스트에 추가

							$('#managerId').val('');
							$('#password').val('');
							$('#name').val('');
							$('#typeSelect').val('');
							$('#telephone').val('');
							$('#storeSelect').val('');
								
						},
						error : function(request,status, error) {
							alert("에러 발생! : " + request.status + "message : "+ request.responseText+ "\n"+ "error : "+ error);
						}
					});
				}
				return false;
			});
			
			//다이얼로그 format 정의
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
			
			//id 중복 체크
			$("#IdCheck").click(function(){
				
				var check = $('#managerId').val();
				if(check==""){
					infoAlert("ID를 입력해주세요.");
				}else{
					$.ajax({
						url : "${ pageContext.request.contextPath }/manager/checkId",
						data : {"managerId" : $('#managerId').val()},
						cache : false,
						type : "get",
						contentType : "application/json; charset=UTF-8",
						success : function(data){
							
							if(data=="true"){ // 해당 id가 존재하는 경우
								$('#dialog').html('<p>죄송합니다.</p><p>작성하신 ID가 기존에 존재합니다.</p>다시 작성해주세요.');
								$("#dialog").dialog("open");
								requiredCheck = false;
							}else{ // 해당 id가 존재하지 않는 경우
								$('#dialog').html('<p>작성하신 ID로 사용할 수 있습니다.</p>');
								$("#dialog").dialog("open");
								requiredCheck = true;
							}
						},
						error : function(request,status, error) {
							alert("에러 발생! : " + request.status + "message : "+ request.responseText+ "\n"+ "error : "+ error);
						}
						
					});
					
					if(requiredCheck==false)
						$('#managerId').focus();
				}
			});
				
			//검색
			$('#searchForm').submit(function() {
		
				if ($('#searchText').val() == "") {
					$("#searchResult").html('검색 란을 작성해주세요.');
					$("#exampleModal").modal();
					return false;
					
				} else {
					
					type = $(this).serialize();

					$.ajax({
						url : "${ pageContext.request.contextPath }/manager/search",
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
			
			//ID 값을 중복 체크 이후에 바꿀 경우를 대비한 예외 처리
			$('#managerId').on("change", function() {
				requiredCheck = false;
			});
			
			//다이얼로그 format 정의 - pwd 체크
			$( "#dialog-pwd" ).dialog({
				autoOpen: false,
			    modal: true,
			    width: '300',
			    height: '200',
			    buttons : [{
			    	id : "cancelPwd",
			    	text : "cancel",
			    	click : function(){
			    		$(this).dialog("close");
			    	}
			     },
			     {
			      	id : "OKPwd",
			      	text : "OK",
			      	click : function(){
				    	$(this).dialog("close");
				   		}
			      }],
			      open: function( event, ui ) {
			    	  $('#pwd').val(''); 
			      }
			 });
			
			$('#listForm').submit(function(){
				var checkVal = document.getElementsByClassName("check");
				var count=0;
				requiredCheckPW = false;
				
				for (var i = 0; i < checkVal.length; i++){
					if(checkVal[i].checked)
						count++;
				}
				
				if(count==0){
					infoAlert("삭제하고자 하시는 매니저의 체크박스를 선택해주세요.");
				}
				else{
					$( "#dialog-pwd" ).dialog('open');
				}
						
				if(requiredCheckPW==true)
					return true;
				
				return false;
			});
	
			$('#OKPwd').click(function(){
				var CheckPwd = $('#pwd').val();
				var loginPwd = "${sessionScope.loginVO.password}";
				
				clickBtn(CheckPwd, loginPwd);
			});
	});
	
		function clickBtn(CheckPwd, loginPwd){
			if(CheckPwd != loginPwd){
				infoAlert("죄송합니다. 비밀 번호가 일치하지 않아 해당 정보를 삭제를 할 수 없습니다.");
			}else if(CheckPwd==""){
				infoAlert("빈칸입니다.");
			}else{
				document.getElementById("listForm").submit()
			}
		}
	
		function printList(result) {
	
			var row = "<tr>";
			row += "<td><input type='checkbox' value= " + result.managerId + " name='managerId' class='check'></td>";
			row += "<td>" + result.staffNo + "</td>";
			row += "<td>" + result.storeName + "</td>";
			row += "<td>" + result.managerId + "</td>";
			row += "<td>" + result.name + "</td>";
			row += "<td>" + result.telephone + "</td>";
			row += "<td>" + result.date + "</td>";
			row += "</tr>";
	
			$('#addList').after(row);
	
		}
	
		function printResult(data) {
	
			var row = "<table style='width: 100%;' id='searchList'>";
			row += "<tr style='width: 100%; height:30px; border: 1 solid; background: #E0DFDF;'>";
			row += "<th style='text-align: center; width='10%'; height:30px;'>사원 번호</th>";
			row += "<th style='text-align: center; width='10%'; height:30px;'>해당 매장</th>";
			row += "<th style='text-align: center; width='20%'; height:30px;'>아이디</th>";
			row += "<th style='text-align: center; width='20%'; height:30px;'>이름</th>";
			row += "<th style='text-align: center; width='20%'; height:30px;'>연락처</th>";
			row += "<th style='text-align: center; width='20%'; height:30px;'>가입일</th>";
			row += "</tr>";
			
			$.each(data,function(index,item){
				
				row += "<tr>";
				row += "<td style='text-align: center; height:30px;'>" + item.staffNo + "</td>";
				row += "<td style='text-align: center; height:30px;'>" + item.storeName + "</td>";
				row += "<td style='text-align: center; height:30px;'>" + item.managerId + "</td>";
				row += "<td style='text-align: center; height:30px;'>" + item.name + "</td>";
				row += "<td style='text-align: center; height:30px;'>" + item.telephone + "</td>";
				row += "<td style='text-align: center; height:30px;'>" + item.date + "</td>";
				row += "</tr>";
				
			});
			
			row += "</table>";
	
			return row;
		}
	
		function showModal(ModalTest){
			$("#searchResult").html(ModalTest);
			$("#exampleModal").modal();
		}
		
		function infoAlert(str){
			$('#dialog').html("<div style='text-align:center;'><p>"+str+"</p></div>");
			$("#dialog").dialog("open");
		}
		
</script>
<style type="text/css">
.addDiv {
	width: 700px;
	background: #E0DFDF;
	border: none;
	margin-left: auto;
	margin-bottom: 50px;
	margin-right: auto;
	padding: 40px;
	border-radius: 20px;
}

.managerList {
	border-collapse: collapse;
	width: 100%;
	border: 1 solid;
	border-color: #bcbcbc;
}

.managerList td {
	text-align: center;
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
	  	<p class="validateTips">Check your password for deleting managers' data.</p>
	 	<form>
		    <fieldset>
		        <label for="password">Password</label>
		      <input type="password" name="pwd" id="pwd" class="text ui-widget-content ui-corner-all">
		      <input type="submit" value="H" tabindex="-1" style="position:absolute; top:-1000px">
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
										<li><a
											href="${pageContext.request.contextPath}/boardQA/list"
											class="auto"> <span class="pull-right text-muted">
													<i class="i i-circle-sm-o text"></i> <i
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
										<li class="active"><a
											href="${pageContext.request.contextPath}/manager/list"
											class="auto"> <span class="pull-right text-muted">
													<i class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-docs icon"> </i> <span class="font-bold">매니저
													관리</span>
										</a></li>
										<li><a
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
							<h3 class="font-bold m-b-none m-t-none">매니저 관리</h3>
							<br />
							<br />
							<form action="" name="addManager" id="addManager">
								<div class="addDiv" align="center">
									<table style="width: 100%;">
										<tr>
											<th width="10%" style="text-align: right;">ID</th>
											<td width="5%" />
											<td width="40%">
												<input type="text" id="managerId" name="managerId" width="60%" pattern="\w+" title="알파벳 또는 숫자를 입력하세요.">&nbsp;&nbsp;&nbsp;<input type="button" id="IdCheck" value="중복 체크" name="IdCheck" width="40%"></td>
											<th width="20%" style="text-align: right;">비밀 번호</th>
											<td width="5%" />
											<td width="25%"><input type="password" id="password"
												name="password"></td>
										</tr>
										<tr height="10px" />
										<tr>
											<th width="10%" style="text-align: right;">이름</th>
											<td width="5%" />
											<td width="40%"><input type="text" id="name" name="name"></td>
											<th width="20%" style="text-align: right;">연락처</th>
											<td width="5%" />
											<td width="25%"><input type="tel" id="telephone"
												name="telephone" pattern="(010)-\d{3,4}-\d{4}" title="010-xxx-xxxx 또는  010-xxxx-xxxx 형식으로   작성해주세요." ></td>
										</tr>
										<tr height="20px" />
										<tr>
											<th colspan="2" style="text-align: left;">매장 이름 &nbsp;</th>
											<td colspan="5" style="text-align: left;"><select
												style="height: 25px" id="typeSelect">
													<option value="0000" id="center">통합관리자</option>
													<option value="info" id="infoDesk">info</option>
													<option value="F01" id="F01">1층</option>
													<option value="F02" id="F02">2층</option>
													<option value="F03" id="F03">3층</option>
											</select> <select style="height: 25px" id="storeSelect"
												name="storeSelect">
													<option value="INFO1F" class="storeType info">1F 안내데스크</option>
													<option value="INFOB1" class="storeType info">B1 안내데스크</option>
													<option value="S1F01" class="storeType F01">MLB</option>
													<option value="S1F02" class="storeType F01">나이키</option>
													<option value="S2F01" class="storeType F02">뱅뱅</option>
													<option value="S2F02" class="storeType F02">팬콧</option>
													<option value="S3F01" class="storeType F03">자라</option>
													<option value="S3F02" class="storeType F03">유니클로</option>
											</select>
										</tr>
										<tr height="5px" />
									</table>
									<div align="right" style="padding-right: 2px;">
										<!-- <input type="button" value="추가" id="Add"> -->
										<input type="submit" value="추가" id="Add">
									</div>
								</div>
							</form>
							<form id="searchForm">
								<div align="right">
									<select id="searchType" name="searchType" style="height: 27px">
										<option value="name">이름</option>
										<option value="storeName">해당 매장</option>
										<option value="managerId">아이디</option>
									</select>&nbsp; <input type="text" name="searchText" id="searchText">&nbsp;
									<input type="submit" value="검색" id="modalBtn"  data-toggle="modal" data-target="#exampleModal"/>
									<!-- <input type="button" style="display: none;" id="modalBtn"  data-toggle="modal" data-target="#exampleModal" /> -->
								</div>
							</form>							
							<br />
							<form action="${pageContext.request.contextPath}/manager/list"
								method="post" id="listForm" name="listForm">
								<table class="managerList" >
									<tr style="text-align: center; background-color: #E7E7E7"  id="addList">
										<td width="5%"><input type="checkbox" id="checkAll"></td>
										<td width="15%" class="tbTile">사원 번호</td>
										<td width="10%" class="tbTile">해당 매장</td>
										<td width="15%" class="tbTile">아이디</td>
										<td width="15%" class="tbTile">이름</td>
										<td width="20%" class="tbTile">연락처</td>
										<td width="20%" class="tbTile">가입일</td>
									</tr>

									<c:forEach items="${managerList}" var="manager"	varStatus="managerStatus">									
										<tr>
											<td><input type="checkbox" value=${ manager.managerId }
												name="managerId" class="check"></td>
											<td>${ manager.staffNo }</td>
											<c:forEach items="${storeList}" var="store"
												varStatus="storeStatus">
												<c:if test="${manager.storeNo eq store.storeNo}">
													<td>${ store.storeName }</td>
												</c:if>
											</c:forEach>
											<td>${ manager.managerId }</td>
											<td>${ manager.name }</td>
											<td>${ manager.telephone }</td>
											<td>${ manager.date }</td>
										</tr>
									</c:forEach>
								</table>								
								<br /> <br /> <br />
								<div class="col-sm-4 text-right text-center-xs" style="margin-left: 340px;">                
			                      <ul class="pagination pagination-sm m-t-none m-b-none">
			         					<!-- 처음페이지 -->
			         					<li><a href="${ pageContext.request.contextPath }/manager/list?pageNo=1"><i class="fa fa-chevron-left"></i><i class="fa fa-chevron-left"></i></a></li>
			                      		<!-- 이전페이지 -->
			                      		<c:choose>
			                      			<c:when test="${ pageNo == 1 }">
			                      				<li><a href="${ pageContext.request.contextPath }/manager/list?pageNo=1"><i class="fa fa-chevron-left"></i></a></li>
			                      			</c:when>
			                      			<c:otherwise>
			                      				<li><a href="${ pageContext.request.contextPath }/manager/list?pageNo=${ pageNo - 1}"><i class="fa fa-chevron-left"></i></a></li>
			                      			</c:otherwise>
			                      		</c:choose>
			                      		<!-- 페이지번호  -->
			                      		<c:forEach var="i" begin="${ beginPage }" end="${ endPage }">
												<li><a href="${ pageContext.request.contextPath }/manager/list?pageNo=${i}">${i}</a></li>
			                      		</c:forEach>
			                      		<!-- 다음페이지 -->
			                      		<c:choose>
			                      			<c:when test="${ pageNo == endPage }">
			                      				<li><a href="${ pageContext.request.contextPath }/manager/list?pageNo=${ endPage }"><i class="fa fa-chevron-right"></i></a></li>
			                      			</c:when>
			                      			<c:otherwise>
			                      				<li><a href="${ pageContext.request.contextPath }/manager/list?pageNo=${ pageNo + 1 }"><i class="fa fa-chevron-right"></i></a></li>
			                      			</c:otherwise>
			                      		</c:choose>
			                      		<!-- 마지막페이지 -->
			                      		<li><a href="${ pageContext.request.contextPath }/manager/list?pageNo=${ lastPage }"><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-right"></i></a></li>	
			                      </ul>
			                    </div>
                    		<br /> <br />
								<div align="right">
									<c:if test="${ !empty managerList }">
										<input type="button" value="수정" id="modify"
											class="btn btn-s-md btn-primary">
										<input type="hidden" name="_method" value="delete">
										<input type="submit" value="삭제"
											class="btn btn-s-md btn-primary" id="deleteConfirm">
									</c:if>
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