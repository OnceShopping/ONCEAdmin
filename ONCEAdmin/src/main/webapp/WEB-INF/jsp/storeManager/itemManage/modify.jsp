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
<style type="text/css">
/* .ModifyItem {
	width: 500px;
	background: #F2F2F2;
	border: none;
	margin-bottom: 50px;
	border-radius: 20px;
	padding: 40px;
} */

td {
	text-align: left;
	height: 50px;
}
th{
	text-align: right;
	height: 50px;
	font-size: 12px;
}

.impossible{
	background: #DADADA;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		
		sidemenu();
		document.getElementById('item').setAttribute('class','active');
		document.getElementById('itemManage').setAttribute('class','active');
		
		$('#goList').click(function(){
			location.href="${pageContext.request.contextPath}/item/list";
		});	
		
		$('#ModifyList').submit(function(){
			return false;
		});
		
		$('#complete').click(function(){
			var itemName = $('#itemName').val();
			var count = $('#count').val();
			
			infoAlert("<span style='font-weight:bold;'>"+itemName+"</span> 상품의 수량을 <span style='font-weight:bold;'>" + count + "</span>(으)로 변경하시겠습니까?");
		});
		
		//다이얼로그 format 정의 - alert창
		$('#dialog').dialog({
			 autoOpen: false,
		      modal: true,
		      width: '300',
		      height: '200',
		      padding : '10px',
		      buttons : [{
			    	id : "cancel", //취소 버튼
			    	text : "CANCEL",
			    	click : function(){
			    		$(this).dialog("close");
			    	}
			     },
			     {
			      	id : "OK",  //OK 버튼
			      	text : "OK",
			      	click : function(){
				    	$(this).dialog("close");
				   		}
			      }]
		 });
		$('#OK').click(function(){
			document.getElementById("ModifyList").submit();
		});
	});
	
	//알림 모달 다이얼로그 태그 설정
	function infoAlert(str){
		$('#dialog').html("<div style='margin-top:30px;'><p>"+str+"</p></div>");
		$("#dialog").dialog("open");
	}

	function sidemenu(){
		document.getElementById('item').setAttribute('class','');
		document.getElementById('itemRegister').setAttribute('class','');
		document.getElementById('itemList').setAttribute('class','');
		document.getElementById('itemManage').setAttribute('class','');
		document.getElementById('orderList').setAttribute('class','');
		document.getElementById('staffManage').setAttribute('class','');
		document.getElementById('boardQAList').setAttribute('class','');
	}


</script>
</head>
<body class="">
<div id="dialog" title="ALERT DIALOG"></div>
<section class="vbox">
		<!-- 상단바 -->
			<jsp:include page="/WEB-INF/jsp/storeManager/include/topmenu.jsp" flush="false"></jsp:include>
		<!-- 상단바 끝 -->
		<section>
			<section class="hbox stretch">
				<!-- 사이드 메뉴 -->
					<jsp:include page="/WEB-INF/jsp/storeManager/include/sidemenu.jsp" flush="false"></jsp:include>
				<!-- 사이드 메뉴 끝 -->
				<section id="content">
					<section class="scrollable wrapper" style="padding-left: 50px; margin-top:40px; margin-left:300px;">
							 <div class="row">
							<div class="col-sm-6"> 
							<form action="${pageContext.request.contextPath}/item/update/${item.detailNo}"
								method="post" data-validate="parsley">
							<section class="panel panel-default">
								 <header class="panel-heading">
                       			 	<span class="h4">${item.itemName} 상품 수량 수정</span>
                       			 	</header>
                       			 	<div class="panel-body">
				                        <p class="text-muted">Modify the item's amount.</p>
				                        <div class="form-group">
				                          <label>상품 이름</label>
				                          <input type="text" class="form-control parsley-validated" data-required="true" value="${item.itemName}"  class="impossible"  readonly="readonly" id="itemName">                        
				                        </div>
				                        <div class="form-group">
				                          <label>상품 코드</label>
				                          <input type="text" class="form-control" data-type="email" data-required="true"  value="${item.itemNo}" readonly="readonly" class="impossible">                        
				                        </div>
				                        <div class="form-group">
				                            <label>Color</label>
				                            <input type="text" class="form-control" data-required="true" value="${item.color}" readonly="readonly" class="impossible">   
				                        </div>
				                        <div class="form-group">
				                          <label>SIZE</label>
				                          <input type="text"  class="form-control" value="${item.size}" name="size" class="impossible" readonly="readonly">
				                        </div>
				                       <div class="form-group pull-in clearfix">
                          					<div class="col-sm-6">
				                          	<label>수량</label>
				                         	<input type="number" class="form-control" value="${item.count}" name="count" id="count">
				                         	</div>
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
</body>
</html>