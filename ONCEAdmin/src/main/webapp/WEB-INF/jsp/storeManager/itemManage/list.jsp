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

$(document).ready(function(){

	sidemenu();
	document.getElementById('item').setAttribute('class','active');
	document.getElementById('itemList').setAttribute('class','active');
	
	$('#searchType').val(''); // 검색 콤보 박스 초기화
	
	<c:forEach var="item" items="${itemList}" varStatus="index">
	settingPrice($('#itemIndex_'+${index.count}).text(), ${index.count});
	settingCount($('#itemCount_'+${index.count}).text(), ${index.count});
	</c:forEach> 
	
	
	//검색
	$('#searchForm').submit(function() {

		if ($('#searchText').val() == "") {
			$("#searchResult").html('검색 란을 작성해주세요.');
			$("#exampleModal").modal();
			return false;
		}else if($('#searchType').val()==null){
			$("#searchResult").html('검색 타입을 설정해주세요.');
			$("#exampleModal").modal();
			return false;
		}else {
			
			type = $(this).serialize();

			$.ajax({
				url : "${ pageContext.request.contextPath }/item/search",
				data : type.replace(/%/g,'%25'), 
				type : "post",
				dataType : "json",
				cache : false,
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",

				success : function(data) {
				
					if(data==""){
						$("#searchResult").html('<p>죄송하지만 검색 결과가 존재하지 않습니다.<p/>다시 한번 확인해주세요.');
						$("#exampleModal").modal();
					}else{
						ModalTest = printResult(data);
						showModal(ModalTest);
					}	
												
				},error : function(request, status, error) {
					alert("에러 발생! : " + request.status + "message : "+ request.responseText+ "\n"+ "error : "+ error);
				}
			});
			
			$('#searchText').val(''); // 검색 텍스트 초기화 
			$('#searchType').val(''); // 검색 콤보 박스 초기화 
			return false;
		}
	});
});

//List 데이터를 각각의 데이터로 뽑아 검색 모달 다이얼로그에 출력되도록 태그 설정 
function printResult(data) {

	var row = "<table style='width: 100%;' id='searchList'>";
	row += "<tr style='width: 100%; height:30px; border: 1 solid; background: #E0DFDF;'>";
	row += "<th style='text-align: center; width='10%'; height:30px;'>상품 이름</th>";
	row += "<th style='text-align: center; width='10%'; height:30px;'>상품 코드</th>";
	row += "<th style='text-align: center; width='20%'; height:30px;'>색상</th>";
	row += "<th style='text-align: center; width='20%'; height:30px;'>SIZE</th>";
	row += "<th style='text-align: center; width='20%'; height:30px;'>수량</th>";
	row += "<th style='text-align: center; width='20%'; height:30px;'>가격</th>";
	row += "</tr>";
	
	$.each(data,function(index,item){
		
		row += "<tr>";
		row += "<td style='text-align: center; height:30px;'>" + item.itemName + "</td>";
		row += "<td style='text-align: center; height:30px;'>" + item.itemNo + "</td>";
		row += "<td style='text-align: center; height:30px;'>" + item.color + "</td>";
		row += "<td style='text-align: center; height:30px;'>" + item.size + "</td>";
		row += "<td style='text-align: center; height:30px;'>" + item.count + "</td>";
		row += "<td style='text-align: right; height:30px;'>" + comma(item.price) + " 원</td>";
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
	
	//sorting
	function sort(category){
		document.getElementById('sortTable').submit();
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
	function settingPrice(obj, count){
		
		var price = comma(obj);
	
		$('#itemIndex_'+count).html(price);
	}

	//리스트에 존재하는 수량에 comma 설정 
	function settingCount(obj, count){
		
		var itemCount = comma(obj);
	
		$('#itemCount_'+count).html(itemCount);
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
<style type="text/css">
		.itemList {
			border-collapse: collapse;
			width: 100%;
			border: 1 solid;
			border-color: #bcbcbc;
		}
		
		.itemList th, .selector span{
			text-align: center;
			font-size: 13pt;
			font-weight: bold;
			color: #788288;
		}
		
		.itemList td {
			text-align: center;
			padding: 5px;
		}
		
		tr:hover {
			background-color: #FBFCFD;
		}
		
		.selector:hover{
			text-decoration: underline;
		}
		
</style>
</head>
<body class="">
<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
						<span class="sr-only">Close</span>
						</button>
					<h3 class="modal-title" id="exampleModalLabel">SEARCH RESULT</h3>
			 	</div>
		 	<div class="modal-body">
		 		<div id="searchResult">검색 란을 작성해주세요.</div>
			</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
				</div>
			</div>
		 </div>
	</div>
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
					<section class="vbox">
						<section class="scrollable wrapper" style="padding-left: 50px;">
							<br />
							<h3 class="font-bold m-b-none m-t-none">상품 리스트</h3>
							  <section class="panel panel-default" style=" margin-top: 30px;">
				                <header class="panel-heading">
				                  <b>${storeName}</b>
				                </header>
				                <div class="row wrapper">
				                <div class="col-sm-5 m-b-xs"></div>
                  				<div class="col-sm-2 m-b-xs"></div>
                  				<form id="searchForm">
				                <div class="col-sm-2 m-b-xs" style="padding-right: 0px;" align="right">
				                    <select class="input-sm form-control input-s-sm inline v-middle" id="searchType" name="searchType" >
					                    <option value="itemName" id="itemName">상품 이름</option>
										<option value="itemNo" id="itemNo">상품 코드</option>
				                    </select>
				               	</div>
				                  <div class="col-sm-3" >
				                    <div class="input-group">
				                      	<input type="text" class="input-sm form-control" placeholder="Search" id="searchText" name="searchText">
										<input type="hidden" id="storeName" name="storeName" value="${storeName}">
				                      <span class="input-group-btn">
				                        <input type="submit" value="검색" class="btn btn-sm btn-default" data-toggle="modal" data-target="#exampleModal"/>
				                      </span>
				                    </div>
				                  </div>
				                  </form> 
				                </div>
				                <div class="table-responsive">
				                <form action="${ pageContext.request.contextPath }/item/list" method="post" id="sortTable">
				                  <table class="table table-striped b-t b-light">
				                    <thead>
				                      <tr>
				                        <th width="20">No.</th>
				                        <th>상품 이름 </th>
				                        <th style="width: 10%;">상품 코드</th>
										<th style="width: 7%;">색상</th>
										<th style="width: 12%;"><a onclick="javascript:document.getElementById('category').value='itemCategory1'; sort();" class="selector"><span style="margin-right: 10px;font-size: 13px;">남성/여성</span><i class="fa fa-caret-down" aria-hidden="true"></i></a></th>
										<th style="width: 13%;"><a onclick="javascript:document.getElementById('category').value='itemCategory2'; sort();" class="selector"><span style="margin-right: 10px;font-size: 13px;">의류/잡화</span><i class="fa fa-caret-down" aria-hidden="true"></i></a></th>
										<th style="width: 13%;"><a onclick="javascript:document.getElementById('category').value='itemCategory3'; sort();" class="selector"><span style="margin-right: 10px;font-size: 13px;">Category</span><i class="fa fa-caret-down" aria-hidden="true"></i></a></th>
										<th style="width: 5%;">SIZE</th>
										<th style="width: 10%;">수량 (개)</th>
										<th style="width: 10%;">가격 (원)</th>
				                      </tr>
				                    </thead>
				                    <tbody>
				                    <c:forEach var="item" items="${itemList}" varStatus="index">
				                      <tr>
				                        <td><c:out value="${ index.count + startPage }"/></td>
										<td><c:out value="${ item.itemName }"/></td>
										<td><c:out value="${ item.itemNo }"/></td>
										<td><c:out value="${ item.color }"/></td>
										<td><c:out value="${ item.itemCategory1 }"/></td>
										<td><c:out value="${ item.itemCategory2 }"/></td>
										<td><c:out value="${ item.itemCategory3 }"/></td>
										<td><c:out value="${ item.size }"/></td>
										<td style="text-align: right" id="itemCount_${ index.count }"><c:out value="${ item.count }"/></td>
										<td style="text-align: right" id="itemIndex_${ index.count }"><c:out value="${ item.price }"/></td>
									</tr>
				                    </c:forEach>  
				                    </tbody>
				                  </table>
				                 </form> 
				                </div>
				                <footer class="panel-footer">
				                <div class="row">
				                    <div class="col-sm-4 hidden-xs">
				                    </div>
				                    <div class="col-sm-3 text-center">
				                    </div>
				                    <div class="col-sm-5 text-right text-center-xs">                
				                      <ul class="pagination pagination-sm m-t-none m-b-none">
				                        <!-- 처음페이지 -->
			         					<li><a href="${ pageContext.request.contextPath }/item/list?pageNo=1"><i class="fa fa-chevron-left"></i><i class="fa fa-chevron-left"></i></a></li>
			                      		<!-- 이전페이지 -->
			                      		<c:choose>
			                      			<c:when test="${ pageNo == 1 }">
			                      				<li><a href="${ pageContext.request.contextPath }/item/list?pageNo=1"><i class="fa fa-chevron-left"></i></a></li>
			                      			</c:when>
			                      			<c:otherwise>
			                      				<li><a href="${ pageContext.request.contextPath }/item/list?pageNo=${ pageNo - 1}"><i class="fa fa-chevron-left"></i></a></li>
			                      			</c:otherwise>
			                      		</c:choose>
			                      		<!-- 페이지번호  -->
			                      		<c:forEach var="i" begin="${ beginPage }" end="${ endPage }">
												<li><a href="${ pageContext.request.contextPath }/item/list?pageNo=${i}">${i}</a></li>
			                      		</c:forEach>
			                      		<!-- 다음페이지 -->
			                      		<c:choose>
			                      			<c:when test="${ pageNo == endPage }">
			                      				<li><a href="${ pageContext.request.contextPath }/item/list?pageNo=${ endPage }"><i class="fa fa-chevron-right"></i></a></li>
			                      			</c:when>
			                      			<c:otherwise>
			                      				<li><a href="${ pageContext.request.contextPath }/item/list?pageNo=${ pageNo + 1 }"><i class="fa fa-chevron-right"></i></a></li>
			                      			</c:otherwise>
			                      		</c:choose>
			                      		<!-- 마지막페이지 -->
			                      		<li><a href="${ pageContext.request.contextPath }/item/list?pageNo=${ lastPage }"><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-right"></i></a></li>	
			                      </ul>
				                    </div>
				                  </div>
				                </footer>
				              </section>
				            </section>
				          </section>
						</section>
					</section>
				</section>
			</section>
</body>
</html>