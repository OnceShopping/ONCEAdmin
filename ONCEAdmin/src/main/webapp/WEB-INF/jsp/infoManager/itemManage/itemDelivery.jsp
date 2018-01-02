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
<script src="http://malsup.github.io/min/jquery.form.min.js"></script>
<script type="text/javascript">
function sidemenu(){
	document.getElementById('items').setAttribute('class', '');
    document.getElementById('addItem').setAttribute('class','');
    document.getElementById('itemDelivery').setAttribute('class','');
    document.getElementById('staffList').setAttribute('class','');
    document.getElementById('boardQAList').setAttribute('class','');
    
}

$(document).ready(function() {
	sidemenu();
	document.getElementById('items').setAttribute('class', 'active');
	document.getElementById('itemDelivery').setAttribute('class','active');
	
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
	
	//알림 모달 다이얼로그 태그 설정
	function infoAlert(str){
		$('#dialog').html("<div style='text-align:center;'><p>"+str+"</p></div>");
		$("#dialog").dialog("open");
	}
	
	$('#customSearchResult').toggle();
	$('#customDelivery').toggle();
	$('#orderMsgName').hide();
	$('#cancelClick').hide();
	//숫자만 입력
		$('#inputOrderPassword').keyup(function() {
			this.value = this.value.replace(/[^0-9]/g,'');
		});
	
	//고객 검색
	$('#form-inline').ajaxForm({
		success : function(data) {
			
			var customer = $.parseJSON(data);
			
				$('#searchcustom').hide();
				$('#customSearchResult').hide();
				$('#customDelivery').hide();
				$('#cancelClick').hide();
				if(customer.msg != null) {
					$('#orderFloorName').hide();
					$('#orderMsgName').show();
					$('#orderMsgName').html(customer.msg);
					$('#orderId').text(customer.id);
					$('#orderPw').text(customer.orderPassword);
					$('#orderTotalName').hide();
					$('#tableOrderList').text("");
				} else {
					$('#orderMsgName').hide();
					$('#orderFloorName').show();
					$('#orderFloor').text(customer.floor);
					$('#orderId').text(customer.id);
					$('#orderPw').text(customer.orderPassword);
					
					$('#orderTotal').text(customer.wareCount+'/'+customer.totalCount);
					
					for(var i=0; i<customer.orderList.length; i++) {
						var table;
						if(customer.orderList[i].status == "수령완료")
							continue;
						
						table += '<tr>';
						table += '<td>'+customer.orderList[i].orderNo+'</td>';
						table += '<td>'+customer.orderList[i].storeName+'</td>';
						table += '<td>'+customer.orderList[i].count+'</td>';
						
						switch(customer.orderList[i].status) {
						case "결제완료" : table += '<td><span class="label bg-info" name="status'+customer.orderList[i].orderNo+'">결제완료</span></td>';
							break;
						case "상품승인완료" : table += '<td><span class="label bg-primary" name="status'+customer.orderList[i].orderNo+'">상품승인완료</span></td>';
							break;
						case "상품전달완료" : table += '<td><span class="label bg-success" name="status'+customer.orderList[i].orderNo+'">상품전달완료</span></td>';
							break;
						case "상품준비완료" : table += '<td><span class="label bg-danger" name="status'+customer.orderList[i].orderNo+'">상품준비완료</span></td>';
							break;
						}
						
						if(customer.orderList[i].status == "상품준비완료") {
							table += '<td><label class="checkbox m-l m-t-none m-b-none i-checks"><input type="checkbox" name="post" checked="checked"'
							+'value="'+customer.orderList[i].orderNo+'"><i></i></label></td>';
						}	
						else {
							table += '<td><label class="checkbox m-l m-t-none m-b-none i-checks"><input type="checkbox" name="post"'
							+'value="'+customer.orderList[i].orderNo+'"><i></i></label></td>';
						}
						table += '</tr>';
						
						$('#tableOrderList').html(table);
						$('#tableTotalCount').text(customer.wareCount+'/'+customer.totalCount);
						$('#Counts').val($('#tableTotalCount').text());
						$('#customerId').val($('#inputID').val());
					}
					
					
					
				}
				
				$('#modal-searchResult').modal();
			
		}
	});
	
	//태그모달창 닫기 이벤트
	$('#modal-searchResult').on('hidden.bs.modal', function () {
			$('#searchcustom').show();
		if($('#tableOrderList').text() != "") {
			
			$('#customSearchResult').show();
			$('#customDelivery').show();
			$('#cancelClick').show();
		}	


	});
	
	//취소 버튼 클릭 이벤트
	$('#cancelClick').click(function() {
		$('#inputID').val("");
		$('#inputOrderPassword').val("");
		$('#customSearchResult').hide();
		$('#customDelivery').hide();
		$('#cancelClick').hide();
	});
	
	
	$('#submitForm').submit(function() {
		//체크낸 것을 먼저 골라냄 -> 그 다음 반복문으로 다 돌려서 이상 없으면 보내고 아니면 모달창 띠우기
		var checkOrder = new Array(); 
		$('input[type="checkbox"]:checked')
		var length = $('input[name="post"]').length;
		
		for(var i=0; i<length; i++) {
			if($('input[name="post"]:eq('+i+')').prop("checked") ) {
				var value = $('input[name="post"]:eq('+i+')').val();
				checkOrder.push(value);
			}
		}
		
		 for(var i=0; i<checkOrder.length; i++) {
			var status = $('span[name=status'+checkOrder[i]+']').text();
			if(status != '상품준비완료') {
				infoAlert("준비완료가 아닌 물품이 체크되어있습니다");
				return false;
				break;
			} else if( i == checkOrder.length -1 ){
				return true;
			}
		} 
		
		
	});
});
</script>
<style type="text/css">
.bg-success, .bg-primary, .bg-info, .bg-warning, .bg-danger {
	font-size: 100%;
	color: #ffffff;
}
.bg-danger {
	background: #ff6600;
}
.list-group-item {
	float: left;
}
.no-radius {
	float: right;
}
.list-group {
	margin-bottom: 0px;
}
#inputID {
	background: #ffffff;
}
</style>
</head>
<body class="">
	<section class="vbox">
		<!-- Modal -->
		<div id="dialog" title="ALERT DIALOG"></div>
		<!-- 상단바 -->
			<jsp:include page="/WEB-INF/jsp/infoManager/include/topmenu.jsp" flush="false"></jsp:include>
		<!-- 상단바 끝 -->
		<section>
			<section class="hbox stretch">
				<!-- 사이드메뉴 -->
            	<jsp:include page="/WEB-INF/jsp/infoManager/include/sidemenu.jsp" flush="false"></jsp:include>
            	<!-- 사이드메뉴 끝 -->
				<section id="content">
					<section class="vbox">
						<section class="scrollable wrapper" style="padding-left: 50px; width: 80%">
							<br />
							<h3 class="font-bold m-b-none m-t-none">물품 전달</h3>
							<br /> <br />
							<section class="panel panel-default" id="searchcustom">
								<header class="panel-heading font-bold"> 고객정보 검색 </header>
								<div class="panel-body">
									<form class="form-inline" role="form" style="float: right" id="form-inline" 
									action="${ pageContext.request.contextPath }/info/searchCustomer">
										<div class="form-group">
											 <input type="text" class="form-control"
												id="inputID" name="inputID" placeholder="ID">
										</div>
										<div class="form-group">
											<input type="password" class="form-control"
												id="inputOrderPassword" name="inputOrderPassword" placeholder="OrderPassword">
										</div>
										<button type="submit" class="btn btn-default">검색</button>
									</form>
								</div>
							</section>
							
							<!-- 검색결과 테이블창 -->
							<form action="${ pageContext.request.contextPath }/info/handOver" id="submitForm">
							<section class="panel panel-default" id="customSearchResult">
								<header class="panel-heading font-bold"> 검색결과 </header>
								<div class="table-responsive">
									<table class="table table-striped b-t b-light">
										<thead>
											<tr>
												<th width="20">No</th>
												<th>Store</th>
												<th>Count</th>
												<th>Status</th>
												<th width="30"></th>
											</tr>
										</thead>
										<tbody id="tableOrderList">
											<tr>
												<td>4c</td>
												<td>Idrawfast</td>
												<td>Jul 25, 2013</td>
												<td><span class="label bg-danger">상품준비완료</span></td>
												<td><label
													class="checkbox m-l m-t-none m-b-none i-checks"><input
														type="checkbox" name="post[]"><i></i></label></td>
											</tr>
											<tr>
												<td>8c</td>
												<td>Formasa</td>
												<td>Jul 22, 2013</td>
												<td><span class="label bg-warning">상품수령완료</span></td>
												<td><label
													class="checkbox m-l m-t-none m-b-none i-checks"><input
														type="checkbox" name="post[]"><i></i></label></td>
											</tr>
											<tr>
												<td>15c</td>
												<td>Avatar system</td>
												<td>Jul 15, 2013</td>
												<td><span class="label bg-success">상품전달완료</span></td>
												<td><label
													class="checkbox m-l m-t-none m-b-none i-checks"><input
														type="checkbox" name="post[]"><i></i></label></td>
											</tr>
											<tr>
												<td>4c</td>
												<td>Throwdown</td>
												<td>Jul 11, 2013</td>
												<td><span class="label bg-primary">상품승인완료</span></td>
												<td><label
													class="checkbox m-l m-t-none m-b-none i-checks"><input
														type="checkbox" name="post[]"><i></i></label></td>
											</tr>
											<tr>
												<td>4c</td>
												<td>Idrawfast</td>
												<td>Jul 7, 2013</td>
												<td><span class="label bg-info">상품결재완료</span></td>
												<td><label
													class="checkbox m-l m-t-none m-b-none i-checks"><input
														type="checkbox" name="post[]"><i></i></label></td>
											</tr>
											
										</tbody>
									</table>
								</div>
								<footer class="panel-footer">
									<div class="row">
										<div class="col-sm-4 hidden-xs">
											
										</div>
										<div class="col-sm-4 text-center">
											
										</div>
										<div class="col-sm-4 text-right text-center-xs">
											<ul class="list-group no-radius">
												<li class="list-group-item">Total</li>
												<li class="list-group-item" id="tableTotalCount"><input type="text">2/3</li>
												
											</ul>
										</div>
										
									</div>
								</footer>
								<input type="hidden" name="customerId" id="customerId">
								<input type="hidden" name="Counts" id="Counts">
							</section>
							<div class="col-sm-4 text-right" style="float: right">
							<input type="submit" class="btn btn-default btn-lg" id="customDelivery" value="고객 전달">
							<input type="button" class="btn btn-default btn-lg" value="취소" id="cancelClick">				
							</div>
							</form>
						</section>
					</section>
				</section>

				<!-- 태그 등록 모델 -->
				<div class="modal fade" id="modal-searchResult">
					<div class="modal-dialog" style="width: 25%">
						<div class="modal-content">
							<div class="modal-header" style="text-align: center">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">검색 결과</h4>
							</div>
							<div class="modal-body wrapper-lg">
								<div class="row">
									<div class="col-sm-12">
										<div class="form-inline">
											<h4 class="m-t-none m-b" id="orderFloorName">주문층<span id="orderFloor" style="float: right"></span></h4>
											<h4 class="m-t-none m-b" id="orderMsgName">메세지<span id="orderMsg" style="float: right"></span></h4>
										</div>
										<div class="form-inline">
											<h4 class="m-t-none m-b" id="orderIdName">아이디<span id="orderId" style="float: right"></span></h4>
										</div>
										<div class="form-inline">
											<h4 class="m-t-none m-b" id="orderPwName">비밀번호<span id="orderPw" style="float: right"></span></h4>
										</div>
										<div class="form-inline">
											<h4 class="m-t-none m-b" id="orderTotalName">총개수<span id="orderTotal" style="float: right"></span></h4>
										</div>
										<div class="form-inline">
											<button type="button" data-dismiss="modal"
												class="btn btn-sm btn-success pull-right text-uc m-t-n-xs">
												<strong>확인</strong>
											</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>

			</section>
		</section>
	</section>
</body>
</html>