<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>	
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

var index = 0; //[SIZE 및 COUNT 추가 등록] 테이블에 해당하는 index
var addIndex = 0; //새로 추가된 size와 count에 해당하는 index

	$(document).ready(function(){

		sidemenu();
		document.getElementById('item').setAttribute('class','active');
		document.getElementById('itemRegister').setAttribute('class','active');
		
		
		index = $('#index').val();
		
		var add = false;
			
		//상품의 size와 갯수를 추가하는 로직
		$('#addItem').click(function(){
			
			var size = $('#size').val();
			var count = $('#count').val();
			
			if(size==""&&count=="")
				infoAlert('추가하려는 상품의 size와 count를 입력해주세요.');
			else if(size=="")
				infoAlert('추가하려는 상품의  size를 입력해주세요.');
			else if(count=="")
				infoAlert('추가하려는 상품의  count를 입력해주세요.');
			else{
				if(!checkSize(size)) {//기존에 추가된 size가 없는 경우
					addList(size, count);
					add = true;
					++addIndex;
				}else
					infoAlert('추가한 사이즈가 바로 아래 리스트에 존재합니다.<br/>다시 작성해주세요.');

				$('#size').val('');
				$('#count').val('');
			}	
		});
		
		//다이얼로그 format 정의 - alert창
		$('#dialog').dialog({
			 autoOpen: false,
		      modal: true,
		      width: '300',
		      height: '245',
		      padding : '10px',
		      buttons : {
		    	 OK : function(){	  
		    	  	$(this).dialog("close");
		    	 }
		      }
		 });
				
		//상품의 size와 수량을 추가하지 않은 경우를 위한 예외 처리
		$('#finish').click(function() {	
			if(add==false) 
				infoAlert("<span style='text-align:left;'><strong>[필수 입력]</strong></span><br/><br/>상품의 size와 count를 입력해주세요.");
			else if(addIndex==0)
				askAlert("현재 상품의 size와 count를 추가하지 않으시겠습니까?<br/>[OK] 버튼 클릭 시 상품 리스트 페이지로 이동합니다.");
			else
				document.getElementById("registerItem").submit();
		});
		
		$('#registerItem').submit(function(){
			return false;	
		});
		
		//다이얼로그 format 정의 - alert창
		$('#dialog2').dialog({
			 autoOpen: false,
		      modal: true,
		      width: '300',
		      height: '220',
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
		
		//확인&취소 알림창의 [OK] 버튼을 클릭했을 경우
		$('#OK').click(function(){
			location.href="${pageContext.request.contextPath}/item/list";
		});
		
		//확인&취소 알림창의 [CANCEL] 버튼을 클릭했을 경우		
		$('#cancel').click(function(){
			infoAlert("size와 count를 추가해주세요.");
		});
	});

	//리스트에 추가한 상품의 size와 갯수를 표시
	function addList(size, count){
		index++;
		var indexItem = index;
		
		var contents = "<tr id="+indexItem+">";
		contents += "<td>"+$('#itemName').val()+"</td>";
		contents += "<td>"+$('#itemNo').val()+"</td>";
		contents += "<td>"+size+"<input type='hidden' class='addSize' value='"+size+"' name='size'></td>";
		contents += "<td>"+count+"<input type='hidden' value='"+comma(count)+"' name='count'></td>";
		contents += "<td><a class='delete' id="+size+" onclick=deleteItem('"+(index)+"') style='color:red;'><i class='fa fa-times' aria-hidden='true'></i></a></td>";
		contents += "</tr>";
		
		$('#AddList').append(contents);
		
	}

	//추가한 size와 수량 삭제
	function deleteItem(index){

		--addIndex;
		
		$('tr').each(function(){
			var check = $(this).attr('id');
			if(check==index){
				$(this).remove();
			}
		});
	}
	
	//추가한 사이즈가 존재하는지 여부 확인
	function checkSize(size){
		var result=false;
		var sizeList = 	document.getElementsByClassName('addSize');
		
		for(var i=0; i<sizeList.length; i++){
			if(sizeList[i].value==size)
				result=true;
		}
		return result;
	}
	
	//알림 모달 다이얼로그 태그 설정
	function infoAlert(str){
		$('#dialog').html("<div><p>"+str+"</p></div>");
		$("#dialog").dialog("open");
	}
	
	//확인&취소 모달 다이얼로그 태그 설정
	function askAlert(str){
		$('#dialog2').html("<div><p>"+str+"</p></div>");
		$("#dialog2").dialog("open");
	}
	
	//기존에 추가한 size와 수량은 삭제가 불가능하도록 설정
	function impossible(){
		++index;
		infoAlert("<br/>죄송하지만 해당 상품은 현재 페이지에서 삭제할 수 없습니다.<br/><span style='font-weight:bold;'>상품의 수량을 변경/삭제를 원하시는 경우, </span>상품 제고 관리 페이지에서 원하시는 상품을 삭제하시기 바랍니다.");
	}
	
	//숫자만 입력 받을 수 있도록 설정
	function numberCheck(e){
		var keyValue = event.keyCode;

		if((keyValue>=48) && (keyValue<=57))
			return true;	
		else if(keyValue==8)
			return true;
		else if((keyValue>=96) && (keyValue<=105))
			return true;
		else
			return false;
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
.ui-menu {
	width: 200px;
}

.ui-widget-header {
	padding: 0.2em;
}

.select {
	background-color: #F3F2F2;
}

th{
	text-align: center;
}

td{
 	text-align: center; 
 	padding: 5px;
 }
</style>
</head>
<body>
<div id="dialog" title="ALERT DIALOG"></div>
<div id="dialog2" title="ALERT DIALOG"></div>
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
						<section class="scrollable wrapper" style="padding-left: 50px">
							<br />
							<h3 class="font-bold m-b-none m-t-none">[${ itemOne.storeName}] 상품 추가 등록</h3>
							<form action="${ pageContext.request.contextPath }/item/extraAdd" method="post" id="registerItem">
								<div class="col-sm-6" style="margin-top: 30px;">
								<section class="panel panel-default">
			                      <header class="panel-heading">
			                        <strong>SIZE 및 COUNT 추가 등록</strong>
			                      </header>
			                      <div class="panel-body">
			                        <div class="form-group">
				                          <label class="col-sm-3 control-label">SIZE</label>
				                          <div class="col-sm-9">
				                            <select class="form-control" id="size">
				                                <option value="Free">Free</option>
												<c:if test="${ itemOne.itemCategory2 eq '의류' }">
													<option value="S">S</option>
													<option value="M">M</option>
													<option value="L">L</option>
													<option value="XS">XS</option>
													<option value="XL">XL</option>
													<option value="XXL">XXL</option>
													<option value="44">44</option>
													<option value="55">55</option>
													<option value="66">66</option>
													<option value="77">77</option>
													<option value="88">88</option>
												</c:if>
											</select>
				                          </div>
				                    </div>
				                    <div class="form-group">
				                          <label class="col-sm-3 control-label">COUNT</label>
				                          <div class="col-sm-9">
				                            <input type="number" id="count" min="0" onkeypress="return numberCheck(event)" style="text-align: right;" class="form-control">
				                          </div>
				                    </div>
			                        <div class="col-sm-6" style="padding-top: 25px;float: right;">
			                            <input type="button" name="addItem" id="addItem" value="추가" class="btn btn-s-md btn-default" >     
			                          </div>
			                      </div>
			                    </section>
			                    </div>
			                    <div class="col-sm-6" style="margin-top: 30px;">
								<section class="panel panel-default">
					                 <header class="panel-heading">
			                        <strong>추가 상품 현황</strong>
			                      </header>
					                <div class="table-responsive">
					                  <table class="table table-striped b-t b-light"  id="AddList">
					                    <thead>
					                      <tr>
					                        <th>상품 이름</th>
					                        <th>상품 코드</th>
					                        <th>SIZE</th>
					                        <th>COUNT</th>
					                        <th>삭제</th>
					                      </tr>
					                    </thead>
					                    <tbody>
					                    <c:forEach var="item" items="${itemList}" varStatus="status">
										<tr>
											<td style='text-align:center;'><c:out value="${item.itemName}"></c:out></td>
											<td style='text-align:center;'><c:out value="${item.itemNo}"></c:out></td>
											<td style='text-align:center;'><c:out value="${item.size}"></c:out><input type="hidden" value="${item.size}" class="addSize"></td>
											<td style='text-align:center;'><c:out value="${item.count}"></c:out></td>
											<td style='text-align:center;'><a class='delete' onclick="impossible()" style="color:gray;" id="${item.size}"><i class="fa fa-minus" aria-hidden="true"></i></a></td>
										</tr>
										</c:forEach>
					                    </tbody>
					                  </table>
					                </div>
					                <footer style="float: right; margin-top: 10px;">
					                	<input type="hidden" name="_method" value="post"> 
											<input type="submit" value="등록" class="btn btn-s-md btn-primary" id="finish">
											<input type="hidden" value="${ itemOne.storeName }" name="storeName">
											<input type="hidden" value="${ itemOne.itemName }" name="itemName" id="itemName">
											<input type="hidden" value="${ itemOne.itemNo }" name="itemNo" id="itemNo">
											<input type="hidden" value="${fn:length(itemList)}" id="index">
										</footer>
									</section>
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