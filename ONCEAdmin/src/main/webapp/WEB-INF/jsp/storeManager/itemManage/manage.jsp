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
	$(document).ready(function() {
		
		
		<c:forEach var="item" items="${itemList}" varStatus="index">
		settingComma($('#itemIndex_'+${index.count}).text(), ${index.count});
		</c:forEach> 
		
		
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
				var count = 0; //선택 체크한 item의 수

				//선택한 item의 수 확인
				for (var i = 0; i < checkVal.length; i++) {
					if (checkVal[i].checked)
						++count;
				}

				if (count != 1){ //선택한 item이 1개 이상일 때
					infoAlert("item 한개만 선택해 수량 수정을 해주시기 바랍니다.");
				}else { //선택한 item이 1개일 경우
					for (var i = 0; i < checkVal.length; i++) {
						if (checkVal[i].checked)
							location.href = "${ pageContext.request.contextPath }/item/modify/"+ checkVal[i].value;
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
		    	text : "CANCEL",
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
				infoAlert("삭제하고자 하시는 item의 체크박스를 선택해주세요.");
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
			infoAlert("죄송합니다.<br/>비밀 번호가 일치하지 않아 해당 정보를 삭제를 할 수 없습니다.");
		else
			document.getElementById("listForm").submit();
	}

	//수량에 comma를 설정하는 로직
	function comma(obj){
		
		var num = obj.toString(); 
		var array=[];
		var replay = parseInt((num.length)%3);
		var routine = parseInt((num.length+2)/3);
				
		if(replay==1){
			for(var i=0; i<routine; i++){
				var sample;				
				
				if(i==0)
					sample = num.substr(0,1);
				else if(i==1)
					sample = num.substr(1,3);
				else
					sample = num.substr(((i-1)*3)+1, 3);
				
				array.push(sample);
			}
		}		
		else if(replay==2){
			for(var i=0; i<routine; i++){
				var sample;				
				
				if(i==0)
					sample = num.substr(0,2);
				else if(i==1)
					sample = num.substr(2,3);
				else
					sample = num.substr(((i-1)*3)+2, 3);
				
				array.push(sample);
			}
		}
		else{
			for(var i=0; i<routine; i++){
				var sample;				
				
				if(i==0)
					sample = num.substr(0,3);
				else
					sample = num.substr((i*3), 3);
				
				array.push(sample);
			}
		}	
		return array.join(",");
	}
	
	
	//리스트에 존재하는 수량에 comma 설정 
	function settingComma(obj, count){
		
		var val = comma(obj);
	
		$('#itemIndex_'+count).html(val);
	}
</script>
<style type="text/css">
	.list {
		text-align: center;
	}
	
	th {
		text-align: center;
		font-size: 13pt;
		font-weight: bold;
		color: #788288;
	}
	td {
		text-align: center;
		padding: 5px;
	}

	tr:hover {
		background-color: #FBFCFD;
	}
		
</style>
</head>
<body class="">
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
												<li class="active"><a
													href="${pageContext.request.contextPath}/item/manage"
													class="auto"> <i class="i i-dot"></i> <span>상품
															재고 관리</span>
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
							<h3 class="font-bold m-b-none m-t-none">[${storeName}] 상품 재고
								관리</h3>
							<form action="${pageContext.request.contextPath}/item/manage"
								method="post" id="listForm" name="listForm">
								<table class="itemList" style="width: 100%; margin-top: 80px;">
									<tr style="text-align: center; background-color: #E7E7E7;">
										<th style="width: 5%;"><input type="checkbox"
											id="checkAll"></th>
										<th style="width: 5%;">No.</th>
										<th style="width: 10%;">상품 이름</th>
										<th style="width: 10%;">상품 코드</th>
										<th style="width: 10%;">색상</th>
										<th style="width: 5%;">SIZE</th>
										<th style="width: 10%;">수량 (개)</th>
									</tr>
									<c:forEach var="item" items="${itemList}" varStatus="index">
										<tr>
											<td class="list"><input type="checkbox" class="check"
												name="detailNo" value="${item.detailNo}"></td>
											<td class="list"><c:out value="${ index.count + startPage }"/></td>
											<td class="list"><c:out value="${ item.itemName }" /></td>
											<td class="list"><c:out value="${ item.itemNo }" /></td>
											<td class="list"><c:out value="${ item.color }" /></td>
											<td class="list"><c:out value="${ item.size }" /></td>
											<td class="list" id="itemIndex_${ index.count }"><c:out value="${ item.count }" /></td>
										</tr>
									</c:forEach>
								</table>
								<br /> <br /> <br />
								<div class="col-sm-4 text-right text-center-xs"
									style="margin-left: 340px;">
									<ul class="pagination pagination-sm m-t-none m-b-none">
										<!-- 처음페이지 -->
										<li><a
											href="${ pageContext.request.contextPath }/item/list?pageNo=1"><i
												class="fa fa-chevron-left"></i><i class="fa fa-chevron-left"></i></a></li>
										<!-- 이전페이지 -->
										<c:choose>
											<c:when test="${ pageNo == 1 }">
												<li><a
													href="${ pageContext.request.contextPath }/item/manage?pageNo=1"><i
														class="fa fa-chevron-left"></i></a></li>
											</c:when>
											<c:otherwise>
												<li><a
													href="${ pageContext.request.contextPath }/item/manage?pageNo=${ pageNo - 1}"><i
														class="fa fa-chevron-left"></i></a></li>
											</c:otherwise>
										</c:choose>
										<!-- 페이지번호  -->
										<c:forEach var="i" begin="${ beginPage }" end="${ endPage }">
											<li><a
												href="${ pageContext.request.contextPath }/item/manage?pageNo=${i}">${i}</a></li>
										</c:forEach>
										<!-- 다음페이지 -->
										<c:choose>
											<c:when test="${ pageNo == endPage }">
												<li><a
													href="${ pageContext.request.contextPath }/item/manage?pageNo=${ endPage }"><i
														class="fa fa-chevron-right"></i></a></li>
											</c:when>
											<c:otherwise>
												<li><a
													href="${ pageContext.request.contextPath }/item/manage?pageNo=${ pageNo + 1 }"><i
														class="fa fa-chevron-right"></i></a></li>
											</c:otherwise>
										</c:choose>
										<!-- 마지막페이지 -->
										<li><a
											href="${ pageContext.request.contextPath }/item/manage?pageNo=${ lastPage }"><i
												class="fa fa-chevron-right"></i><i
												class="fa fa-chevron-right"></i></a></li>
									</ul>
								</div>
								<br /> <br />
								<div align="right">
									<c:if test="${ !empty itemList }">
										<input type="button" value="수정" id="modify" class="btn btn-s-md btn-primary">
										<input type="hidden" name="_method" value="delete">
										<input type="submit" value="삭제"
											class="btn btn-s-md btn-primary">
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