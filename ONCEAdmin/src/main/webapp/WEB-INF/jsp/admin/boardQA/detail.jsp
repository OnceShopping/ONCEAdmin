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
<script>
function sidemenu(){
	document.getElementById('noticeList').setAttribute('class','');
	document.getElementById('boardQAList').setAttribute('class','');
	document.getElementById('storeList').setAttribute('class','');
	document.getElementById('managerList').setAttribute('class','');
	document.getElementById('cusomterList').setAttribute('class','');
}

$(document).ready(function() {
	sidemenu();
	document.getElementById('boardQAList').setAttribute('class','active');
	
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
	$('#deleteBoardQA').click(function(){
		
		$( "#dialog-pwd" ).dialog('open');
		
	});
	//삭제 시 비밀번호를 확인하는 다이얼로그의 "OK"버튼 클릭 시
	$('#OKPwd').click(function(){
		var CheckPwd = $('#pwd').val();
		var loginPwd = "${sessionScope.loginVO.password}";
		
		clickBtn(CheckPwd, loginPwd);
	});

	//삭제 시 비밀번호를 확인하는 다이얼로그를 통해 비밀번호를 비교
	function clickBtn(CheckPwd, loginPwd){
	if(CheckPwd != loginPwd)
		infoAlert("죄송합니다. 비밀 번호가 일치하지 않아 해당 정보를 삭제를 할 수 없습니다.");
	else
		location.href="${ pageContext.request.contextPath }/boardQA/delete/${ boardQAVO.boardNo }";
	}

	//알림 모달 다이얼로그 태그 설정
	function infoAlert(str){
		$('#dialog').html("<div style='text-align:center;'><p>"+str+"</p></div>");
		$("#dialog").dialog("open");
	}
});

function doAction() {
	location.href='${ pageContext.request.contextPath}/boardQA/list';
}	
</script>
<style type="text/css">
th {
	text-align: center;
	font-size: 13pt;
}
</style>
</head>
<body class="">
	<section class="vbox">
		<!-- Modal -->
		<div id="dialog" title="ALERT DIALOG"></div>
		<div id="dialog-pwd" title="CHECK PASSWORD">
			<p class="validateTips">해당 정보를 삭제하기 위해서 비밀 번호를 다시 한번 입력해주세요.</p>
			<form>
				<fieldset>
					<label for="password">Password</label> <input type="password"
						name="pwd" id="pwd" class="text ui-widget-content ui-corner-all">
				</fieldset>
			</form>
		</div>
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
							<h3 class="font-bold m-b-none m-t-none">QNA 답변</h3>
							<br />
							<div style="text-align: right; width: 80%">
								<table width="100%"
									class="table table-striped m-b-none dataTable no-footer"
									style="text-align: center">
									<tr>
										<th colspan="3">${ boardQAVO.title }</th>
									</tr>
									<tr>
										<td style="text-align: left; padding-left: 20px">${ boardQAVO.boardNo }</td>
										<td style="text-align: right; width: 60%">${ boardQAVO.writer }</td>
										<td style="text-align: right; padding-right: 20px">${ boardQAVO.regDate }</td>
									</tr>
									<tr>
										<td style="text-align: left; align: center "  colspan="3">
										<span >${ boardQAVO.content }</span>
										</td>
								</table>
								<br />
								<input type="button" value="답변" class="btn btn-s-md btn-primary"
									onclick="location.href='${ pageContext.request.contextPath }/boardQA/write/${boardQAVO.boardNo}'"/>
								<input type="button" value="삭제" class="btn btn-s-md btn-primary" id="deleteBoardQA"
									/>
								<input type="button"
									onclick="doAction()"
									value="목록" class="btn btn-s-md btn-primary"/>
									 
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