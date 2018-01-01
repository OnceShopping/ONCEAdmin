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

<style type="text/css">
.ModifyManger {
	width: 500px;
	background: #F2F2F2;
	border: none;
	margin-left: auto;
	margin-bottom: 50px;
	margin-right: auto;
	border-radius: 20px;
	padding: 40px;
}

td {
	text-align: left;
	height: 50px;
}
th{
	text-align: right;
	height: 50px;
}
.impossible{
	background: #DADADA;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){

		sidemenu();
		document.getElementById('managerList').setAttribute('class','active');
		
		$('#goList').click(function(){
			location.href="${pageContext.request.contextPath}/manager/list";
		});	
	});
	function sidemenu(){
		document.getElementById('noticeList').setAttribute('class','');
		document.getElementById('boardQAList').setAttribute('class','');
		document.getElementById('storeList').setAttribute('class','');
		document.getElementById('managerList').setAttribute('class','');
		document.getElementById('cusomterList').setAttribute('class','');
	}
</script>
</head>
<body class="">
	<section class="vbox">
		<!-- 상단바 -->
			<jsp:include page="/WEB-INF/jsp/admin/include/topmenu.jsp" flush="false"></jsp:include>
		<!-- 상단바 끝 -->

		<section>
			<section class="hbox stretch">
			<!-- 사이드 메뉴 -->
					<jsp:include page="/WEB-INF/jsp/admin/include/sidemenu.jsp" flush="false"></jsp:include>
				<!-- 사이드 메뉴 끝 -->
				<section id="content">
					<section class="vbox">
						<br />
							<section class="scrollable wrapper" style="padding-left: 50px; margin-top:40px; margin-left:300px;">
							 <div class="row">
							<div class="col-sm-6"> 
							<form action="${pageContext.request.contextPath}/manager/update/${managerId}"
								method="post" data-validate="parsley">
							<section class="panel panel-default">
								 <header class="panel-heading">
                       			 	<span class="h4">매니저 정보 수정</span>
                       			 	</header>
                       			 	<div class="panel-body">
				                        <p class="text-muted">Modify the member's information.</p>
				                        <div class="form-group">
				                          <label>사원 번호</label>
				                          <input type="text" class="form-control parsley-validated" data-required="true" value="${managerVO.staffNo}" readonly="readonly" class="impossible">                        
				                        </div>
				                        <div class="form-group">
				                          <label>해당 매장</label>
				                          <input type="text" class="form-control" data-type="email" data-required="true"  value="${storeVO.storeName}" readonly="readonly" class="impossible">                        
				                        </div>
				                        <div class="form-group pull-in clearfix">
				                          <div class="col-sm-6">
				                            <label>ID</label>
				                            <input type="text" class="form-control" data-required="true" value="${managerVO.managerId}" readonly="readonly" class="impossible">   
				                          </div>
				                        </div>
				                        <div class="form-group">
				                          <label>Phone</label>
				                          <input type="tel" class="form-control" data-type="phone" value="${managerVO.telephone}" name="telephone"  pattern="(011|010|017|018|019)-\d{3,4}-\d{4}" title="xxx-xxx-xxxx 형식으로   작성해주세요."  data-required="true">
				                        </div>
				                        <div class="form-group">
				                          <label>가입일</label>
				                          <input type="text" class="form-control" value="${managerVO.date}" readonly="readonly" class="impossible">
				                        </div>
				                      </div>
				                      <footer class="panel-footer text-right bg-light lter">
				                        <input type="hidden" name="_method" value="PUT" />
										<input type="button" value="취소"  class="btn btn-success btn-s-xs" id="goList">
										 <input type="submit" value="수정 완료" class="btn btn-success btn-s-xs"/>
				                      </footer>
				                    </section>
				                  </form>
				                </div>
                 			</div>
					</section>
				</section>
			</section>
			</section>
		</section>
	</section>
	
</body>
</html>