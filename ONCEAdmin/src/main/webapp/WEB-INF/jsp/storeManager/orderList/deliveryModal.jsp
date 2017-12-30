<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css">
<script src="${pageContext.request.contextPath }/resources/js/jquery.min.js"></script>
<script	src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	$('#exampleModal').modal('show');
	
});

</script>
</head>
<body>
<body class="">
	<!-- Modal --> 
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
						<span class="sr-only">Close</span>
						</button>
					<h4 class="modal-title" id="exampleModalLabel">전달 정보</h4>
			 	</div>
		 	<div class="modal-body">
		 		<div id="deliveryInfo">
		 			<table style="text-align: center; width: 100%">
		 				<tr>
		 					<td style="font-size: 13px;">전달되는 주문 정보입니다.</td>
		 				</tr>
		 				<tr>
		 				</tr>
		 				<tr>
		 					<td>Floor.&nbsp;&nbsp;<span style="font-weight: bold;">${floor}</span></td>
		 				</tr>
		 				<tr>
		 				</tr>
		 				<tr>
		 					<td style="font-size: 13px;">전달 주문 개수:&nbsp;&nbsp;<span style="font-weight: bold;">${ count }</span>건</td>
		 				</tr>
		 			</table>
		 		</div>
		 		<div id="deliveryDetail">
		 			<hr/>
		 			<c:forEach var="order" items="${ deliveryOrderList }" varStatus="loop">
		 			<table style="width: 100%; margin-bottom: 10px;">
		 				<tr>
		 					<td style="font-size: 13px; ">주문번호:&nbsp;&nbsp;${ order.orderNo }</td>
		 				</tr>
		 			</table>
		 			<table style="width: 100%;">
						<tr style="text-align: center; font-size: 10px;">
							<th width="25%">상품고유번호</th>
							<th width="65%">상품명</th>
							<th width="15%">수량</th>
						</tr>		 			
					<c:forEach var="detail" items="${ order.orderDetails }" varStatus="status">
					<tr id="item_${loop.index}_${status.index}"  style="font-size: 13px;">
						<td>${ detail.detailNo }</td>
						<td>${ detail.itemName }
						<span style="font-size: 10px;">(${detail.color} | ${detail.size})</span>
						</td>
						<td>${ detail.count }</td>
					</tr>
					</c:forEach>
		 			</table>
		 			<hr/>
		 			</c:forEach>
		 		</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="deliveryOrder()">확인</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="history.go(0)">취소</button>
			</div>			
			</div>
		 </div>
	</div>	
</body>
</html>