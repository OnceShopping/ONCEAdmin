<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="app">
<head>
<meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<title>ONCE</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/animate.css"	type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/font-awesome.min.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/icon.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/font.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/app.css"	type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/js/datepicker/datepicker.css" type="text/css" />

<script	src="${pageContext.request.contextPath }/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script	src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
<!-- App -->
<script src="${pageContext.request.contextPath }/resources/js/app.js"></script>
<script	src="${pageContext.request.contextPath }/resources/js/slimscroll/jquery.slimscroll.min.js"></script>
<script	src="${pageContext.request.contextPath }/resources/js/app.plugin.js"></script>
<!-- datepicker -->
<script src="${pageContext.request.contextPath }/resources/js/datepicker/bootstrap-datepicker.js"></script>
<script type="text/javascript">
	var orderNo = 0;
	var floor = "";
	var tagNo = "";
	
	function sidemenu(){
		document.getElementById('itemRegister').setAttribute('class','');
		document.getElementById('itemList').setAttribute('class','');
		document.getElementById('itemManage').setAttribute('class','');
		document.getElementById('orderList').setAttribute('class','');
		document.getElementById('staffManage').setAttribute('class','');
		document.getElementById('boardQAList').setAttribute('class','');
	}

	$(document).ready(function(){
		
		sidemenu();
		document.getElementById('orderList').setAttribute('class','active');
		
		$('#option').hide();
		
		<c:forEach var="order" items="${ orderList }" varStatus="loop">
			<c:forEach var="detail" items="${ order.orderDetails }" varStatus="status">
			settingPrice($('#price_'+${loop.index}+'_'+${status.index}).text(), ${loop.index}, ${status.index});
			</c:forEach>
		</c:forEach>
				
		var orderStatusList = document.getElementsByClassName('order_status');
		
		for(var i=0; i<orderStatusList.length; i++){
			var orderStatus = orderStatusList.item(i);
			
			if(orderStatus.innerHTML == '결제완료'){
				orderStatus.setAttribute('class','order_status label bg-info');
			}else if(orderStatus.innerHTML == '상품승인완료'){
				orderStatus.setAttribute('class','order_status label bg-primary');
			}else if(orderStatus.innerHTML == '상품전달완료'){
				orderStatus.setAttribute('class','order_status label bg-success');
			}else if(orderStatus.innerHTML == '상품준비완료'){
				orderStatus.setAttribute('class','order_status label bg-danger');
			}else if(orderStatus.innerHTML == '수령완료'){
				orderStatus.setAttribute('class','order_status label bg-warning');
			}
		}
		
	});
	
	function showOption(){
		var choice = $('#choice').val();
		
		if(choice=='status'){
			$('#option').html(
					'<option id="payFinish" value="결제완료">결제완료</option>'
					+'<option id="acceptFinish" value="상품승인완료">상품승인완료</option>'
					+'<option id="deliveryFinish" value="상품전달완료">상품전달완료</option>'
					+'<option id="getInfo" value="상품준비완료">상품준비완료</option>'
					+'<option id="getCus" value="수령완료">수령완료</option>');
			$('#option').show();
		}else if(choice=='orderNo'){
			$('#option').html('<option id="up">오름차순</option>'+'<option id="down">내림차순</option>');
			$('#option').show();
		}else if(choice=='floor'){
			$('#option').html('<option id="1F">1F</option>'+'<option id="B1">B1</option>');
			$('#option').show();
		}else if(choice=='all'){
			$('#option').html('');
			$('#option').hide();
		}
	}
	
	function serchOption(){
		
		var choice = $('#choice').val();
		var option = $('#option').val();
		
		$.ajax({
			url : "${ pageContext.request.contextPath }/orderList/serchOption",
			data : {
				'choice' : choice,
				'option' : option
			},
			success : function(data) {
				$('#changeResult').html("");
				$('#changeResult').html(data);
			}
		});
	}
	
	
	function infoAlert(str){	/* 알림 모달 다이얼로그 태그 설정 */
		
		$.ajax({
			url : "${ pageContext.request.contextPath }/orderList/alertModal",
			type : "get",
			data : {
				'str'  : str
			},
			contentType : "application/json; charset=UTF-8",
			success : function(data) {		
				$( "#dialog" ).html(data);				
			}
		});
		
	
	}
	
	function preAccept(){	/* 주문 번호 기준 | 태그 생성*/
		
		var checkVal = document.getElementsByClassName("check");	/* no의 모임 */
		var orderNos = document.getElementsByClassName("orderNo"); /* orderNo의 모임 */
		var statuses = document.getElementsByClassName("order_status"); /* status의 모임 */
		var count = 0;	/* 선택된 개수 */
		
		var noList = new Array();	/* 선택된 no의 모임 */
		var orderNoList = new Array();	/* 선택된 orderNo의 모임 */
		var statusList = new Array();	/* 선택된 status의 모임 */
		
		for(var i = 0; i < checkVal.length; i++){
			
			if(checkVal[i].checked){
				noList[count] = checkVal[i].value;
				orderNoList[count] = orderNos[i].innerHTML;
				statusList[count] = statuses[i].innerHTML;
				count++;
			}
			
		}
		
		var canAccept = false;
		var status = "";
		
		if(count==0){
			infoAlert("승인하고자 하는 주문의 체크박스를 선택해주세요.");	
		}else{
			orderNo = orderNoList[0];
			status = statusList[0];
			
			for(var i = 0; i<count; i++){	
				if(orderNoList[i]==orderNo){
					canAccept = true;
				}else{
					canAccept = false;			
					break;
				}
			}
			
			if(canAccept==false){
				
				infoAlert("같은 주문번호만 승인 할 수 있습니다. 다시 선택해 주세요.");
				return;
				
			}else if(status != "결제완료"){
				
				infoAlert("결제완료만 승인 할 수 있습니다. 다시 선택해 주세요.");
				return;
				
			}else if(canAccept==true){
				
				jQuery.ajaxSettings.traditional = true;

				$.ajax({
					url : "${ pageContext.request.contextPath }/orderList/preAcceptOrder",
					type : "get",
					data : {
						'orderNo'  : orderNo,
						'noList'	: noList
					},
					contentType : "application/json; charset=UTF-8",
					success : function(data) {		
						$( "#dialog" ).html(data);
					}
				});
				
			}	
		}
	}
	
	function preDelivery(){	/* info 위치 기준 | 배달 정보 모달 */
		
		var checkVal = document.getElementsByClassName("check");	/* no의 모임 */
		var orderNos = document.getElementsByClassName("orderNo"); /* orderNo의 모임 */
		var floors = document.getElementsByClassName("floor"); /* floor의 모임 */
		var statuses = document.getElementsByClassName("order_status"); /* status의 모임 */
		var count = 0;	/* 선택된 개수 */
		
		var noList = new Array();	/* 선택된 no의 모임 */
		var orderNoList = new Array();	/* 선택된 orderNo의 모임(중복O) */
		var floorList = new Array();	/* 선택된 floor의 모임 */
		var statusList = new Array();	/* 선택된 status의 모임 */
		
		for(var i = 0; i < checkVal.length; i++){
			
			if(checkVal[i].checked){
				noList[count] = checkVal[i].value;
				orderNoList[count] = orderNos[i].innerHTML;
				floorList[count] = floors[i].innerHTML;
				statusList[count] = statuses[i].innerHTML;
				count++;
			}
			
		}
		
		/* 선택된 orderNo의 모임(중복X) */
		var uniqOrderNoList = orderNoList.reduce(function(a,b){
			if (a.indexOf(b) < 0 ) a.push(b);
			return a;
		},[]);
		
		
		var canAccept = false;
		floor = "";
		var status = "";
		
		if(count==0){
			infoAlert("전달하고자 하는 주문의 체크박스를 선택해주세요.");
		}else{
			orderNo = orderNoList[0];
			floor = floorList[0];
			status = statusList[0];
			
			for(var i = 0; i<count; i++){	
				if(floorList[i]==floor){
					canAccept = true;
				}else{
					canAccept = false;			
					break;
				}
			}
			
			if(canAccept==false){
				
				infoAlert("같은 층의 INFO만 전달 할 수 있습니다. 다시 선택해 주세요.");
				return;
				
			}else if(status != "상품승인완료"){
				
				infoAlert("상품승인완료 상태만 전달 할 수 있습니다. 다시 선택해 주세요.");
				return;
				
			}else if(canAccept==true){
				
				jQuery.ajaxSettings.traditional = true;
				
				$.ajax({
					url : "${ pageContext.request.contextPath }/orderList/preDelivery",
					type : "get",
					data : {
						'uniqOrderNoList'  : uniqOrderNoList,
						'noList'		: noList,
						'floor'			: floor
					},
					contentType : "application/json; charset=UTF-8",
					success : function(data) {
						$( "#dialog" ).html(data);
					}
				});
				
			}
		}
	}
	
	function acceptOrder(tagNo){ /* 태그 생성 눌렀을 때 */
		location.href="${ pageContext.request.contextPath }/orderList/acceptOrder/"+orderNo+"/"+tagNo;
	}
	
	function deliveryOrder(){	/* 전달 -> 확인 */
		location.href="${ pageContext.request.contextPath }/orderList/deliveryOrder/"+floor;
	}
	
	//comma를 설정하는 로직
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
	
	
	//리스트에 존재하는 가격에 comma 설정 
	function settingPrice(obj, loop, index){
		
		var price = comma(obj);
		$('#price_'+loop+'_'+index).html(price);
	}
	
</script>
<style type="text/css">
	.bg-success, .bg-primary, .bg-info, .bg-warning, .bg-danger {
		font-size: 100%;
		color: #ffffff;
	}
	.bg-danger {
		background: #ff6600;
	}
</style>
</head>
<body>
	<section class="vbox">
     	<!-- 상단바 -->
		<jsp:include page="/WEB-INF/jsp/storeManager/include/topmenu.jsp" flush="false"></jsp:include>
		<!-- 상단바 끝 -->
      <section>
      	 <section class="hbox stretch">
      	 	<!-- 사이드메뉴 -->
			<jsp:include page="/WEB-INF/jsp/storeManager/include/sidemenu.jsp" flush="false"></jsp:include>
			<!-- 사이드메뉴 끝 -->
			
			<section id="content">
				<section class="vbox">
					<section class="scrollable wrapper" style="padding-left: 50px; padding-right: 50px;">
						<br />
						<h3 class="font-bold m-b-none m-t-none">주문 내역 게시판</h3>
						<br/>
						<form id="OrderVO" name="OrderVO">
						<div id="changeResult">
							<div style="text-align: right;">
								<p style="float: left;">전체 주문 내역:&nbsp;&nbsp;<u>${orderCount}</u> 개</p>
								<div style="margin-left: 30px;">
									<select id="choice" onchange="showOption()" style="width: 85px;" class="m-b">
										<option value="all">전체</option>
										<option value="status">처리사항</option>
										<option value="orderNo">주문번호</option>
										<option value="floor">수령장소</option>
									</select>
									<select id="option" style="width: 150px;">
									</select>
				                	<input id="dateSearch" type="button" value="검색" class="btn btn-default" onclick="serchOption()">
									<br/><br/>
								</div>
							</div>
							<div style="width: 100%;">
								<table class="table table-striped m-b-none dataTable no-footer" >
									<tr style="text-align: center;">
										<th width="7%">선택</th>
										<th >주문번호</th>
										<th >주문자</th>
										<th >상품고유번호</th>
										<th >상품명</th>
										<th >수량</th>
										<th >연락처</th>
										<th >처리사항</th>
										<th >가격</th>
										<th >주문일</th>
										<th>수령장소</th>
									</tr>
									<c:forEach var="order" items="${ orderList }" varStatus="loop">
									<c:forEach var="detail" items="${ order.orderDetails }" varStatus="status">
									<tr id="item_${loop.index}_${status.index}">
										<td>
											<input type="checkbox" class="check" name="orderDetails[${ status.index }].orderNo" value="${ detail.no }">
										</td>
										<td class="orderNo">${ detail.orderNo }</td>
										<td>${ order.id }</td>
										<td>${ detail.detailNo }</td>
										<td>${ detail.itemName }<br/>
											<span style="font-size: 10px;">(${detail.color} | ${detail.size})</span>
										</td>
										<td>${ detail.count }</td>
										<td>${ order.telephone }</td>
										<td><span class="order_status label ">${ order.status }</span></td>									
										<td id="price_${loop.index}_${status.index}">${ detail.price }</td>
										<td>${ order.date }</td>
										<td class="floor">${ order.floor }</td>
									</tr>
									</c:forEach>
									</c:forEach>
								</table>
								<br/>
							</div>
						</div>
						<div style="float: right;">
							<button id="accept" type="button" class="btn btn-primary" onclick="preAccept()" style="margin: 10px;">승인</button><!-- (제어걸기) 주문 번호 기준  | 결재완료인 것만 -->
							<button id="delivery" type="button" class="btn btn-primary" onclick="preDelivery()"  >전달</button><!-- (제어걸기) 수령 장소 기준  | 상품승인완료인 것만 -->
						</div>
						</form>							
					<!-- 메뉴 사이즈 조정 끝-->
					<div id="dialog" title="ALERT DIALOG"></div>
					</section>
					<a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>						
				</section>
			</section>
      	 </section>
      </section>      
    </section>
</body>
</html>