<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
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
			$('#option').html('<option id="up" value="오름차순">오름차순</option>'+'<option id="down" value="내림차순">내림차순</option>');
			$('#option').show();
		}else if(choice=='floor'){
			$('#option').html('<option id="1F" value="1F">1F</option>'+'<option id="B1" value="B1">B1</option>');
			$('#option').show();
		}else if(choice=='all'){
			$('#option').html('');
			$('#option').hide();
		}
	}

	$(document).ready(function(){
			
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
		
		var choice = '${choice}';
		if(choice=='' || choice==null){
			$('#choice').val("all").attr('selected', 'selected');
		}else{
			$('#choice').val(choice).attr('selected', 'selected');
		}
					
		showOption();	
		
		var option = '${option}';
		$('#option').val(option).attr('selected', 'selected');
		
		
		<c:forEach var="order" items="${ orderList }" varStatus="loop">
		<c:forEach var="detail" items="${ order.orderDetails }" varStatus="status">
			settingPrice($('#price_'+${loop.index}+'_'+${status.index}).text(), ${loop.index}, ${status.index});
		</c:forEach>
		</c:forEach>
	});
</script>
<div style="text-align: right;">
								<p style="float: left;">전체 주문 내역:&nbsp;&nbsp;<u>${orderCount}</u> 개</p>
								<div style="margin-left: 30px;">
									<select id="choice" onchange="showOption()" style="width: 85px;">
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