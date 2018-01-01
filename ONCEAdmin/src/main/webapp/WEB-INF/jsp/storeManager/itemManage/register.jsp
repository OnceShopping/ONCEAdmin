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

var rgx1 = /\D/g;
var rgx2 = /(\d+)(\d{3})/; 

	$(document).ready(function() {
		
		sidemenu();
		document.getElementById('item').setAttribute('class','active');
		document.getElementById('itemRegister').setAttribute('class','active');
		
		$('#big').val('');
		$('#middle').val('');
		$('#small').val('');
		
		//상품 코드가 기존에 존재하는지 여부 확인
		$("#itemNo").change(function() {
								
			$.ajax({
				url : "${ pageContext.request.contextPath }/item/checkItem",
				dataType : 'JSON',
				data : ({
					'itemNo' : $('#itemNo').val()
					}),
				type : "get",
				cache : false,
				contentType : "application/json; charset=UTF-8",
				success : function(data) {
					if (data == true){ // 존재하지 않은 경우
						$('#checkItemNo').html("<span></span>");
						infoAlert("해당 상품코드로 상품이 등록되어 있습니다.<br/>상품을 추가 등록 하시겠습니까?<br/><br/><span style='font-weight:bold;'><span style='color:red;'><i class='fa fa-exclamation' aria-hidden='true'></i>&nbsp;)</span>&nbsp;&nbsp;취소를 누르실 경우, <br/>해당 상품 코드 외 다른 상품 코드로 상품을 등록시켜주시기 바랍니다.</span>");
					}else
						$('#checkItemNo').html("<span style='color:green;'><i class='fa fa-check' aria-hidden='true'></i>&nbsp;&nbsp;&nbsp;해당 상품 코드로 등록이 가능합니다.</span>");
				},
					error : function(request,status, error) {
						alert("에러 발생! : "+ request.status+ "message : "+ request.responseText+ "\n"+ "error : "+ error);
					}
				});
			});
		
		$('#big').change(function(){
			
				$('#middle').val('');
				$('#small').val('');
				for(var i=0; i<$(".cate2").length; i++){
					$(".cate2")[i].selected=false;
				}
				for(var j=0; j<$(".cate3").length; j++){
					$(".cate3")[j].selected=false;
					$('.cloths').show();
					$('.stuff').show();
				}
				if ( $('#big').val() =="남성" || $('#big').val() == "남아" ) {
					$("#dress").hide();
				}
		});
		
		//중분류 선택에 따른 소분류 표시 변경
		$("#middle").change(function(){
				var middleType = $(this).val();
				
				if(middleType=="의류"){
					$('.cloths').show();
					if ( $('#big').val() =="남성" || $('#big').val() == "남아" ) {
						$("#small").val('');
						$("#dress").hide();
					}
					$("#small").val('');
					$('.stuff').hide();
				}
				else{
					$("#small").val('');
					$('.cloths').hide();
					$('.stuff').show();
				}				
		});
		
		//소분류 선택에 따른 중분류 자동 선택
		$("#small").change(function(){
				var middleType = $("#middle").val();
				var smallType = $(this).val();
				
				if((smallType=="가방")||(smallType=="악세서리"))
					$("#middle").val('잡화').prop("selected", true);
				else
					$("#middle").val('의류').prop("selected", true);				
		});	
		
		//다이얼로그 format 정의 - alert창
		$('#dialog').dialog({
			 autoOpen: false,
		      modal: true,
		      width: '300',
		      height: '250',
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
		
		$('#cancel').click(function(){
			$('#itemNo').val('');
			$('#itemNo').focus();
		});
		
		$('#OK').click(function(){
			var itemNo = $('#itemNo').val();
			location.href="${ pageContext.request.contextPath }/item/register/"+itemNo;
		});
		
		$('#dialog2').dialog({
			 autoOpen: false,
		      modal: true,
		      width: '300',
		      height: '250',
		      padding : '10px',
		      buttons : [{
			      	id : "OK2",  //OK 버튼
			      	text : "OK",
			      	click : function(){
				    	$(this).dialog("close");
				   		}
			      }]
		 });
	});
	
	//이미지 미리 보기
    function fileInfo(f){
    	var file = f.files;
    	var reader = new FileReader();
    	reader.onload = function(rst){
    		$('#storeLogoImg').html('<img src="' + rst.target.result + '"height="250" width="200">');
    	}
    	reader.readAsDataURL(file[0]);
    }
	
	//알림 모달 다이얼로그 태그 설정
	function infoAlert(str){
		$('#dialog').html("<div><p>"+str+"</p></div>");
		$("#dialog").dialog("open");
	}
	
	//알림 모달 다이얼로그 태그 설정 : 카테고리 선택 설정
	function infoAlert2(str){
		$('#dialog2').html("<div><p>"+str+"</p></div>");
		$("#dialog2").dialog("open");
	}
	
	//특수문자를 입력받지 않도록 설정
	function charCheck(e){
		var keyValue = event.keyCode;

		if((keyValue>=33) && (keyValue<=47))
			return false;	
		else if((keyValue>=58) && (keyValue<=64))
			return false;	
		else if((keyValue>=91) && (keyValue<=96))
			return false;
		else if((keyValue>=123) && (keyValue<=126))
			return false;
		else
			return true;
	}
	
	//자동으로 comma를 setting할 수를 가져옴
	function getNumber(no){

	     var num01;
	     var num02;
	    	 	
	     num01 = no.value;
	     num02 = num01.replace(rgx1,"");
	     num01 = setComma(num02);
	     no.value = num01;

	}
	
	//자동으로 comma를 설정하도록 설정
	function setComma(inNum){
	     
	     var outNum;
	     outNum = inNum; 
	     while (rgx2.test(outNum)) {
	          outNum = outNum.replace(rgx2, '$1' + ',' + '$2');
	      }
	     return outNum;

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
</style>
</head>
<body class="">
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
						<h3 class="font-bold m-b-none m-t-none">[${ storeName}] 상품 등록</h3>
						 <form action="${ pageContext.request.contextPath }/item/register"
								method="post" enctype="multipart/form-data">
						 <div class="col-sm-6" style="margin-top: 30px;">
			                    <section class="panel panel-default">
			                      <header class="panel-heading">
			                        <strong>기본 정보 등록</strong>
			                      </header>
			                      <div class="panel-body">
			                        <p class="text-muted">Please fill the information to continue</p>
			                        <div class="form-group">
			                          <label>상품 이름</label>
			                          <input type="text" class="form-control" data-required="true" name="itemName" required="required" pattern="[^0-9]+$" title="숫자 또는 특수문자를 제외한 한글 또는 알파벳으로 작성해주세요." onkeypress="return charCheck(event)">                     
			                        </div>
			                        <div class="form-group">
			                          <label>상품 코드</label>
			                          <input type="text" class="form-control" data-type="email" data-required="true" name="itemNo" id="itemNo" required="required" pattern="[A-Z0-9]+$" title="알파벳(대문자)와 숫자로 표시된 상품 코드를 확인해주시고 작성해주세요."  onkeypress="return charCheck(event)"><span style="padding-left: 20px;" id="checkItemNo"></span>                        
			                        </div>
			                        <div class="form-group pull-in clearfix">
			                          <div class="col-sm-6">
			                            <label>Color</label>
			                            <input type="text" name="color" class="form-control" data-required="true" required="required">   
			                          </div>
			                          <div class="col-sm-6">
			                            <label>가격</label>
			                            <input type="text" class="form-control" required="required" onchange="getNumber(this);" onkeyup="getNumber(this);" style="text-align: right;" name="price">     
			                          </div>   
			                        </div>
			                      </div>
			                    </section>
			                   </div>
			                    <div class="col-sm-6"  style="margin-top: 30px; margin-bottom: 220px;">
				                    <section class="panel panel-default">
				                      <header class="panel-heading">
				                        <strong>Item 대표 Image 등록</strong>
				                      </header>
				                      <div class="panel-body">
				                          <div class="form-group pull-in clearfix">
				                            <div class="col-sm-6">
				                              <label>상품 image</label>
				                              <input type="file" value="파일 찾기" name="attachFile" required="required"onchange="javascript:document.getElementById('file_route').value=this.value; fileInfo(this);" accept="image/*"><input type="hidden" readonly="readonly" title="File Route" id="file_route">
				                            </div>
				                        </div>
				                        </div>
				                    </section>
				                </div>
				                <div class="col-sm-6">
				                    <section class="panel panel-default">
				                      <header class="panel-heading">
				                        <strong>카테고리 설정</strong>
				                      </header>
				                      <div class="panel-body">                    
				                        <div class="form-group">
				                          <label class="col-sm-3 control-label">[대분류]</label>
				                          <div class="col-sm-9"  style="margin-bottom: 10px;">
				                            <select data-required="true" class="form-control" id="big" name="itemCategory1" required="required">
				                                <option disabled="disabled">Please choose</option>
				                                <option value="남성" class="cate1">남성</option>
												<option value="여성" class="cate1">여성</option>
												<option value="남아" class="cate1">남아</option>
												<option value="여아" class="cate1">여아</option>
				                            </select>
				                          </div>
				                          </div>
				                          <div class="form-group">
				                          <label class="col-sm-3 control-label">[중분류]</label>
				                          <div class="col-sm-9"  style="margin-bottom: 10px;">
				                            <select data-required="true" class="form-control" id="middle" name="itemCategory2" required="required">
				                                <option disabled="disabled">Please choose</option>
				                                <option id="cloths" class="cate2">의류</option>
												<option id="stuff" class="cate2">잡화</option>
				                            </select>
				                          </div>
				                        </div>
				                        <div class="form-group">
				                          <label class="col-sm-3 control-label">[소분류]</label>
				                          <div class="col-sm-9"  style="margin-bottom: 10px;">
				                            <select data-required="true" class="form-control" id="small" name="itemCategory3" required="required">
				                                <option disabled="disabled">Please choose</option>
				                                <option id="top" class="cloths cate3">상의</option>
												<option id="pants" class="cloths cate3">하의</option>
												<option id="dress" class="cloths cate3">원피스</option>
												<option id="outer" class="cloths cate3">아우터</option>
												<option id="bag" class="stuff cate3">가방</option>
												<option id="accessory" class="stuff cate3">악세서리</option>
				                            </select>
				                          </div>
				                        </div>
				                      </div>
				                    </section>
				                </div>
				               	<div class="col-sm-6">
					               <section class="panel panel-default">
					                  <header class="panel-heading">
					                     <strong>Item Image</strong>
					                     </header>
					                     <div class="panel-body">                    
					                     <div class="form-group">
					                         <div class="storeLogoImg" id="storeLogoImg" style="text-align: center;"></div>
				                        </div>
				                      </div>  
				                    </section>
					         	  </div>
					         	   <div style="float: right;">
	                       				 <input type="hidden" name="_method" value="post"> <input
											type="submit" value="Next" class="btn btn-s-md btn-primary"
											id="add"> <input type="hidden"
											value="${loginVO.managerId }" name="id">
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