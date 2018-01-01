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
var index = 0; //추가된 size와 count에 해당하는 index
var img = 0; //상세 이미지를 등록했는지 여부

var first = 0;
var second = 0;
var third = 0;	
	
	$(document).ready(function(){

		sidemenu();
		document.getElementById('item').setAttribute('class','active');
		document.getElementById('itemRegister').setAttribute('class','active');
		
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
		      height: '200',
		      padding : '10px',
		      buttons : {
		    	 OK : function(){	  
		    	  	$(this).dialog("close");
		    	 }
		      }
		 });
		
		//상품 상세 이미지의 값을 change 이벤트가 발생하기 전에 우선 체크
		$('#uploadLogo1').click(function(){
			first = $('#uploadLogo1').val();
		});
		
		$('#uploadLogo2').click(function(){
			second = $('#uploadLogo2').val();
		});
		
		$('#uploadLogo3').click(function(){
			third = $('#uploadLogo3').val();
		});
		
		//상품의 size와 수량을 추가하지 않은 경우를 위한 예외 처리
		$('#finish').click(function() {	
			if(add==false) 
				infoAlert("<span style='text-align:left;'><strong>[필수 입력]</strong></span><br/><br/>상품의 size와 count를 입력해주세요.");
			else
				document.getElementById("registerItem").submit();
		});
		
		$('#registerItem').submit(function(){
			return false;	
		});
	});

	//리스트에 추가한 상품의 size와 갯수를 표시
	function addList(size, count){
		++index;
		var indexItem = index;
		
		var contents = "<tr id="+indexItem+">";
		contents += "<td style='text-align:center;'>"+$('#itemName').val()+"</td>";
		contents += "<td style='text-align:center;'>"+$('#itemNo').val()+"</td>";
		contents += "<td style='text-align:center;'>"+size+"<input type='hidden' class='addSize' value='"+size+"' name='size'></td>";
		contents += "<td style='text-align:center;'>"+comma(count)+"<input type='hidden' value='"+count+"' name='count'></td>";
		contents += "<td style='width: 20%; text-align:center;'><a class='delete' id="+size+" onclick=deleteItem('"+(index)+"') style='color:red;'><i class='fa fa-times' aria-hidden='true'></i></a></td>";
		contents += "</tr>";
		
		$('#AddList').append(contents);
		
	}

	//추가한 size와 수량 삭제
	function deleteItem(index){
		
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
	
	//이미지 미리 보기
    function fileInfo(f, imgIndex){
				
		var file = f.files;
    	var reader = new FileReader();
    	reader.onload = function(rst){
    		
    		
    		
    		if(img==0){ //상세 이미지를 등록했는지 여부 - 처음 이미지를 등록하는 경우
	   			++img;
	   			$('#carousel-example-generic').prepend("<div class='carousel-inner' role='listbox' id='itemImg' ></div>");
    			if(imgIndex=='0'){
    				$('#itemImg').prepend("<div class='item active' id='detail1'><img src='" + rst.target.result+"' alt='First slide' style='margin-left: auto; margin-right: auto;'></div>");
    			}
    			else if(imgIndex=='1')
    				$('#itemImg').prepend("<div class='item active' id='detail2'><img src='" + rst.target.result+"' alt='Second slide' style='margin-left: auto; margin-right: auto;'></div>");
    			else
    				$('#itemImg').prepend("<div class='item active' id='detail3'><img src='" + rst.target.result+"' alt='Third slide' style='margin-left: auto; margin-right: auto;'></div>");
    		}else{
				if(imgIndex=='0'){
					if(first=="")
						$('#itemImg').append("<div class='item' id='detail1'><img src='" + rst.target.result+"' alt='First slide' style='margin-left: auto; margin-right: auto;'></div>");
					else
						$('#detail1').html("<img src='" + rst.target.result+"' alt='First slide' style='margin-left: auto; margin-right: auto;'>");
				}else if(imgIndex=='1'){
					if(second=="")
						$('#itemImg').append("<div class='item' id='detail2'><img src='" + rst.target.result+"' alt='Second slide' style='margin-left: auto; margin-right: auto;'></div>");
					else
						$('#detail2').html("<img src='" + rst.target.result+"' alt='Second slide'  style='margin-left: auto; margin-right: auto;'>");
				}else
					if(third=="")
						$('#itemImg').append("<div class='item' id='detail3'><img src='" + rst.target.result+"' alt='Third slide' style='margin-left: auto; margin-right: auto;'></div>");
					else
						$('#detail3').html("<img src='" + rst.target.result+"' alt='Third slide'  style='margin-left: auto; margin-right: auto;'>");
    		}
    	}
    	reader.readAsDataURL(file[0]);
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

	.carousel-inner > .item > img {
      top: 0;
      left: 0;
      min-width: 100%;
      min-height: 300px;
    } 

</style>
</head>
<body>
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
					<section class="vbox">
						<section class="scrollable wrapper" style="padding-left: 50px">
							<br />
							<h3 class="font-bold m-b-none m-t-none">[${item.storeName}] 상품 등록</h3>
							<form action="${ pageContext.request.contextPath }/item/registerDetail"
								method="post" enctype="multipart/form-data" id="registerItem">
							<div class="col-sm-6" style="margin-top: 30px;">
			                    <section class="panel panel-default">
			                      <header class="panel-heading">
			                        <strong>상품 상세 등록</strong>
			                      </header>
			                      <div class="panel-body">
			                        <div class="form-group">
			                          <label>상세 이미지 1</label>
			                          <input type="file" value="파일 찾기" id="uploadLogo1" name="attachFile0"  accept="image/*" onchange="fileInfo(this, '0')">                     
			                        </div>
			                        <div class="form-group">
			                          <label>상세 이미지 2</label>
			                          <input type="file" value="파일 찾기" id="uploadLogo2" name="attachFile1" accept="image/*" onchange="fileInfo(this, '1')" >                        
			                        </div>
			                        <div class="form-group pull-in clearfix">
			                          <div class="col-sm-6">
			                            <label>상세 이미지 2</label>
			                            <input type="file" value="파일 찾기" id="uploadLogo3" name="attachFile2" accept="image/*" onchange="fileInfo(this, '2')">
			                          </div>
			                        </div>
			                        <div class="form-group pull-in clearfix">
			                          <div class="col-sm-6">
			                            <label>상품 상세 정보</label>
			                           	 <textarea rows="3" cols="70" name="detail" style="resize: none;"></textarea>
			                          </div>
			                        </div>
			                      </div>
			                    </section>
			                   </div>
			                   <div class="col-sm-6"style="margin-top: 30px; margin-bottom: 200px;">
			                    <section class="panel panel-default">
			                      <header class="panel-heading">
			                        <strong>상세 정보 등록</strong>
			                      </header>
			                      <div class="panel-body">
			                        <div class="form-group">
				                          <label class="col-sm-3 control-label">SIZE</label>
				                          <div class="col-sm-9"  style="margin-bottom: 10px;">
				                            <select data-required="true" class="form-control" id="size" name="itemCategory1" required="required">
				                                <option value="Free">Free</option>
												<c:if test="${ item.itemCategory2 eq '의류' }">
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
				                            <input type="number" id="count" name="count" min="0" onkeypress="return numberCheck(event)" style="text-align: right;" class="form-control" data-required="true" required="required">
				                          </div>
				                    </div>
			                        <div class="col-sm-6" style="padding-top: 25px;float: right;">
			                            <input type="button" name="addItem" id="addItem" value="추가" class="btn btn-s-md btn-default" >     
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
				                          <div class="form-group pull-in clearfix">
				                            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
				                            	<!-- Wrapper for slides -->
											
												<div align="center">	
													<!-- Controls -->
												  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
												    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
												    <span class="sr-only">Previous</span>
												  </a>
												  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
												    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
												    <span class="sr-only">Next</span>
												  </a>
				                            </div>
				                            </div>
				                        </div>
				                        </div>
				                    </section>
				                </div>
			                    <div class="col-sm-6">
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
					                    </tbody>
					                  </table>
					                </div>
					                <footer style="float: right; margin-top: 10px;">
					                	<input type="hidden" name="_method" value="post"> 
											<input type="submit" value="등록" class="btn btn-s-md btn-primary" id="finish">
											<input type="hidden" value="${ item.itemNo }" name="itemNo" id="itemNo">
											<input type="hidden" value="${ item.itemName }" name="itemName" id="itemName">
											<input type="hidden" value="${ item.managerId }" name="id">
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