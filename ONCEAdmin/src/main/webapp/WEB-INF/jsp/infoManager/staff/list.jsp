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

<style type="text/css">
	.addDiv {
		width: 805px;
		background: #E0DFDF;
		border: none;
		margin-left: auto;
		margin-bottom: 50px;
		margin-right: auto;
		padding: 40px;
		border-radius: 20px;
	}
	
	.staffList {
		border-collapse: collapse;
		width: 100%;
		border: 1 solid;
		border-color: #bcbcbc;
	}
	
	.staffList td {
		text-align: center;
	}
</style>

<script src="${pageContext.request.contextPath }/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
<!-- App -->
<script src="${pageContext.request.contextPath }/resources/js/app.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/app.plugin.js"></script>

<script type="text/javascript">
	function sidemenu(){
		document.getElementById('addItem').setAttribute('class','');
		document.getElementById('itemDelivery').setAttribute('class','');
		document.getElementById('staffList').setAttribute('class','');
		document.getElementById('boardQAList').setAttribute('class','');
	}
   
	$(document).ready(function() { 
		sidemenu();
		document.getElementById('staffList').setAttribute('class','active');
	   
		var ModalTest;
		var requiredCheck = false; //ID 중복 확인
		
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
		
		//매장 선택 - 첫 번째 콤보박스 선택 시 두 번째 콤보박스에 표시되는 option 제어 
		$('#typeSelect').on("change", function() {
			$('#storeSelect').val('');
			$('#storeSelect').show(); // 두번 째 select-box를 표시함
	
			// 첫 번째 select-box에 해당하는 것만 보여주기 위한 로직
			if (state == "B1F") {
				$('.B1F').show();
			} else {
				$('.1F').show();
			}
		});
		
		//매장 선택 - 두 번째 콤보박스에서 option 선택 시 첫 번째 콤보박스 option이 자동으로 설정될 수 있도록 제어
		$('#storeSelect').on("change",function() {
			var store = $('#storeSelect').val();
	
			if (store == 'INFOB1') {
				$("#typeSelect").val("B1F").prop("selected", true);
			} else {
				$("#typeSelect").val("1F").prop("selected", true);
			}
		});
	
		//추가
		$('#addStaff').submit(function() {	
			//[추가] 전, 빈칸 체크  	
			var checkId= $('#managerId').val();
			var checkPW= $('#password').val();
			var checkName= $('#name').val();
			var checkTel= $('#telephone').val();
			var checkSN= $('#storeSelect').val();
			
			if(checkId=="") {
				infoAlert("아이디를 입력해 주세요");
			} else if(checkPW=="") {
				infoAlert("비밀번호를 입력해 주세요");
			} else if(checkName=="") {
				infoAlert("이름을 입력해 주세요");
			}else if(checkTel=="") {
				infoAlert("전화번호를 입력해 주세요");
			} else if(checkSN===null) {
				infoAlert("매장을 선택해 주세요");
			} else if(requiredCheck==false) {
				infoAlert("아이디 중복 체크를 해 주세요");
			} else {
				var type = "infoStaff";
	
				var params = {
					managerId : $('#managerId').val(),
					password : $('#password').val(),
					name : $('#name').val(),
					type : type,
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
						
						history.go(0);
					}
				});
			}
			return false;
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
		
		//id 중복 체크
		$("#IdCheck").click(function(){
			
			var check = $('#managerId').val();
			if(check==""){
				infoAlert("아이디를 입력해 주세요");
			}else{
				$.ajax({
					url : "${ pageContext.request.contextPath }/manager/checkId",
					data : {"managerId" : $('#managerId').val()},
					cache : false,
					type : "get",
					contentType : "application/json; charset=UTF-8",
					success : function(data){
						
						if(data=="true"){ // 해당 id가 존재하는 경우
							$('#dialog').html('죄송합니다 입력하신 아이디는 이미 존재하는 아이디입니다 다시 입력해 주세요');
							$("#dialog").dialog("open");
							requiredCheck = false;
						}else{ // 해당 id가 존재하지 않는 경우
							$('#dialog').html('<p>입력하신 아이디는 사용할 수 있는 아이디입니다</p>');
							$("#dialog").dialog("open");
							requiredCheck = true;
						}
					}
				});
				
				if(requiredCheck==false)
					$('#managerId').focus();
			}
		});
			
		//검색
		$('#searchForm').submit(function() {
	
			if ($('#searchText').val() == "") {
				$("#searchResult").html('검색 란을 입력해 주세요');
				$("#exampleModal").modal();
				return false;
			}else if($('#searchType').val()==null){
				$("#searchResult").html('검색 타입을 설정해 주세요');
				$("#exampleModal").modal();
				return false;
			}else {
				
				type = $(this).serialize();
	
				$.ajax({
					url : "${ pageContext.request.contextPath }/info/searchStaff",
					data : type.replace(/%/g,'%25'), 
					type : "post",
					dataType : "json",
					cache : false,
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
	
					success : function(data) {
					
						if(data==""){
							$("#searchResult").html('죄송하지만 검색 결과가 존재하지 않습니다');
							$("#exampleModal").modal();
						}else{
							ModalTest = printResult(data);
							showModal(ModalTest);
						}	
													
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
				infoAlert("삭제하고자 하시는 직원의 체크 박스를 선택해 주세요");
			else
				$( "#dialog-pwd" ).dialog('open');
			
			return false;
		});
	
		//삭제 시 비밀번호를 확인하는 다이얼로그의 "OK"버튼 클릭 시
		$('#OKPwd').click(function(){
			var CheckPwd = $('#pwd').val();
			var loginPwd = "${sessionScope.loginVO.password}";
			
			clickBtn(CheckPwd, loginPwd);
		});
   
	});

	//삭제 시 비밀번호를 확인하는 다이얼로그를 통해 비밀번호를 비교
	function clickBtn(CheckPwd, loginPwd){
		if(CheckPwd != loginPwd)
			infoAlert("죄송합니다 비밀번호가 일치하지 않아 해당 정보를 삭제할 수 없습니다");
		else
			document.getElementById("listForm").submit();
	}

	//매니저 추가 후 표에 데이터를 뿌려주기
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

	//List 데이터를 각각의 데이터로 뽑아 검색 모달 다이얼로그에 출력되도록 태그 설정 
	function printResult(data) {

		var row = "<table style='width: 100%;' id='searchList'>";
		row += "<tr style='width: 100%; height:30px; border: 1 solid; background: #E0DFDF;'>";
		row += "<th style='text-align: center; width='10%'; height:30px;'>사원 번호</th>";
		row += "<th style='text-align: center; width='10%'; height:30px;'>해당 위치</th>";
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
	
	//검색 모달 다이얼로그 정보 출력 태그 설정 
	function showModal(ModalTest){
		$("#searchResult").html(ModalTest);
		$("#exampleModal").modal();
	}
	
	//알림 모달 다이얼로그 태그 설정
	function infoAlert(str){
		$('#dialog').html("<div style='text-align:center;'><p>"+str+"</p></div>");
		$("#dialog").dialog("open");
	}
</script>
</head>
<body class="">
   <section class="vbox">
      <!-- 상단바 -->
      <jsp:include page="/WEB-INF/jsp/infoManager/include/topmenu.jsp" flush="false"></jsp:include>
      <!-- 상단바 끝 -->

      <section>
         <section class="hbox stretch">
            <!-- 사이드메뉴 -->
            <jsp:include page="/WEB-INF/jsp/infoManager/include/sidemenu.jsp" flush="false"></jsp:include>
            <!-- 사이드메뉴 끝 -->
            
            <!-- 메뉴 사이즈 조정 -->
            <section id="content">
               <section class="vbox">
                  <section class="scrollable wrapper" style="padding-left: 50px;">
  					<br />
					<h3 class="font-bold m-b-none m-t-none">인포메이션 직원 관리</h3>
					<br /> <br />
					<form action="" name="addStaff" id="addStaff">
						<div class="addDiv" align="center">
							<table style="width: 100%;">
								<tr>
									<th width="10%" style="text-align: right;">ID</th>
									<td width="5%" />
									<td width="40%"><input type="text" id="managerId"
										name="managerId" width="60%" pattern="\w+"
										title="알파벳 또는 숫자를 입력하세요.">&nbsp;&nbsp;&nbsp;<input
										type="button" id="IdCheck" class="btn btn-s-md btn-primary"
										value="중복 체크" name="IdCheck" width="40%"></td>
									<th width="20%" style="text-align: right;">비밀번호</th>
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
										name="telephone" pattern="(010)-\d{3,4}-\d{4}"
										title="010-xxx-xxxx 또는  010-xxxx-xxxx 형식으로  작성해주세요."></td>
								</tr>
								<tr height="20px" />
								<tr>
									<th colspan="2" style="text-align: right; padding-right: 33px;">해당
										위치</th>
									<td colspan="5" style="text-align: left;"><select
										style="height: 25px" id="typeSelect">
											<option value="B1F" id="B1F">B1F</option>
											<option value="1F" id="1F">1F</option>
									</select> <select style="height: 25px" id="storeSelect"
										name="storeSelect">
											<option value="INFOB1" class="storeType B1F">B1 안내데스크</option>
											<option value="INFO1F" class="storeType 1F">1F 안내데스크</option>
									</select>
								</tr>
								<tr height="5px" />
							</table>
							<div align="right" style="padding-right: 2px;">
								<input type="submit" class="btn btn-s-md btn-primary" value="추가"
									id="Add">
							</div>
						</div>
					</form>
					<form id="searchForm">
						<div align="right">
							<select id="searchType" name="searchType" style="height: 27px">
								<option value="name">이름</option>
								<option value="storeName">해당 위치</option>
								<option value="managerId">아이디</option>
							</select>&nbsp; <input type="text" name="searchText" id="searchText">&nbsp;
							<input type="submit" value="검색" class="btn btn-s-md btn-primary"
								data-toggle="modal" data-target="#exampleModal" />
						</div>
					</form>
					<br />
					<form action="${pageContext.request.contextPath}/info/staffList"
						method="post" id="listForm" name="listForm">
						<table class="staffList">
							<tr style="text-align: center; background-color: #E7E7E7"
								id="addStaffList">
								<td width="5%"><input type="checkbox" id="checkAll"></td>
								<td width="15%" class="tbTile">사원 번호</td>
								<td width="10%" class="tbTile">해당 위치</td>
								<td width="15%" class="tbTile">아이디</td>
								<td width="15%" class="tbTile">이름</td>
								<td width="20%" class="tbTile">연락처</td>
								<td width="20%" class="tbTile">가입일</td>
							</tr>

							<c:forEach items="${staffList}" var="staff" varStatus="status">
								<tr>
									<td><input type="checkbox" value=${ staff.managerId }
										name="managerId" class="check"></td>
									<td>${ staff.staffNo }</td>
									<c:forEach items="${storeList}" var="store"
										varStatus="storeStatus">
										<c:if test="${staff.storeNo eq store.storeNo}">
											<td>${ store.storeName }</td>
										</c:if>
									</c:forEach>
									<td>${ staff.managerId }</td>
									<td>${ staff.name }</td>
									<td>${ staff.telephone }</td>
									<td>${ staff.date }</td>
								</tr>
							</c:forEach>
						</table>
						<br /> <br /> <br />
						<div class="col-sm-4 text-right text-center-xs"
							style="margin-left: 340px;">
							<ul class="pagination pagination-sm m-t-none m-b-none">
								<!-- 처음페이지 -->
								<li><a
									href="${ pageContext.request.contextPath }/info/staffList?pageNo=1"><i
										class="fa fa-chevron-left"></i><i class="fa fa-chevron-left"></i></a></li>
								<!-- 이전페이지 -->
								<c:choose>
									<c:when test="${ pageNo == 1 }">
										<li><a
											href="${ pageContext.request.contextPath }/info/staffList?pageNo=1"><i
												class="fa fa-chevron-left"></i></a></li>
									</c:when>
									<c:otherwise>
										<li><a
											href="${ pageContext.request.contextPath }/info/staffList?pageNo=${ pageNo - 1}"><i
												class="fa fa-chevron-left"></i></a></li>
									</c:otherwise>
								</c:choose>
								<!-- 페이지번호  -->
								<c:forEach var="i" begin="${ beginPage }" end="${ endPage }">
									<li><a
										href="${ pageContext.request.contextPath }/info/staffList?pageNo=${i}">${i}</a></li>
								</c:forEach>
								<!-- 다음페이지 -->
								<c:choose>
									<c:when test="${ pageNo == endPage }">
										<li><a
											href="${ pageContext.request.contextPath }/info/staffList?pageNo=${ endPage }"><i
												class="fa fa-chevron-right"></i></a></li>
									</c:when>
									<c:otherwise>
										<li><a
											href="${ pageContext.request.contextPath }/info/staffList?pageNo=${ pageNo + 1 }"><i
												class="fa fa-chevron-right"></i></a></li>
									</c:otherwise>
								</c:choose>
								<!-- 마지막페이지 -->
								<li><a
									href="${ pageContext.request.contextPath }/info/staffList?pageNo=${ lastPage }"><i
										class="fa fa-chevron-right"></i><i class="fa fa-chevron-right"></i></a></li>
							</ul>
						</div>
						<br /> <br />
						<div align="right">
							<c:if test="${ !empty staffList }">
								<input type="hidden" name="_method" value="delete">
								<input type="submit" value="삭제" class="btn btn-s-md btn-primary">
							</c:if>
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