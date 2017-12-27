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
		
		<c:forEach var="detail" items="${ preAcceptOrderList }" varStatus="status">
			settingPrice($('#price_'+${status.index}).text(), ${status.index});
		</c:forEach>
		
	});

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
	function settingPrice(obj, index){
		
		var price = comma(obj);
		
		$('#price_'+index).html(price);
	}

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
					<h4 class="modal-title" id="exampleModalLabel">태그 출력</h4>
			 	</div>
		 	<div class="modal-body">
		 		<div id="tagInfo">
		 			<table style="text-align: center; width: 100%">
		 				<tr>
		 					<td style="font-size: 13px;">생성될 태그 정보입니다.</td>
		 				</tr>
		 				<tr>
		 				</tr>
		 				<tr>
		 					<td>TagNo.&nbsp;&nbsp;<span style="font-weight: bold;">${orderInfo.tagNo}</span></td>
		 				</tr>
		 				<tr>
		 				</tr>
		 				<tr>
		 					<td style="font-size: 13px;">주문번호: ${ orderInfo.orderNo } &nbsp; | 주문자: ${ orderInfo.id }</td>
		 				</tr>
		 			</table>
		 			<hr/>
		 			<table>
						<tr style="text-align: center;">
							<th width="25%">상품고유번호</th>
							<th width="50%">상품명</th>
							<th width="15%">수량</th>
							<th>가격</th>
						</tr>
		 			<c:forEach var="detail" items="${ preAcceptOrderList }" varStatus="status">
						<tr>
							<td>${ detail.detailNo }</td><!-- 선택 지워도됨 -->
							<td>${ detail.itemName }
							<span style="font-size: 10px;">(${detail.color} | ${detail.size})</span></td>
							<td>&nbsp;&nbsp;${ detail.count }</td>
							<td id="price_${status.index}">${ detail.price }</td>
							</tr>
		 			</c:forEach>
		 			</table>
		 			<hr/>
		 			<table style="float: right;">
		 				<tr>
							<td width="60%">현재상품개수</td>
								<td>주문상품개수</td>
						</tr>
						<tr style="text-align: right;">
							<th width="60%">${ count}</th>
								<th>${ orderInfo.count }</th>
						</tr>
		 				</table>
		 				<table>
							<tr style="text-align: right;">
								<th width="30%">INFO</th>
			 				<th width="35%">ID</th>
			 				<th width="35%">Store</th>
			 			</tr>
			 			<tr style="text-align: left;">
			 				<td>${ orderInfo.floor }</td>
			 				<td>${ orderInfo.id }</td>
			 				<td>${ orderInfo.storeName }</td>
			 			</tr>
		 			</table>		 				  
		 		</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="acceptOrder('${orderInfo.tagNo}')">태그 출력</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="history.go(0)">취소</button>
			</div>			
			</div>
		 </div>
	</div>	
</body>
</html>