<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		contents += "<td style='text-align:center;'>"+count+"<input type='hidden' value='"+count+"' name='count'></td>";
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
    			if(imgIndex=='0')
    				$('#itemImg').prepend("<div class='item active' id='detail1'><img src='" + rst.target.result+"' alt='First slide' height='250' width='200' style='margin-left: auto; margin-right: auto;'></div>");
    			else if(imgIndex=='1')
    				$('#itemImg').prepend("<div class='item active' id='detail2'><img src='" + rst.target.result+"' alt='Second slide' height='250' width='200' style='margin-left: auto; margin-right: auto;'></div>");
    			else
    				$('#itemImg').prepend("<div class='item active' id='detail3'><img src='" + rst.target.result+"' alt='Third slide' height='250' width='200' style='margin-left: auto; margin-right: auto;'></div>");
    		}else{
				if(imgIndex=='0'){
					if(first=="")
						$('#itemImg').append("<div class='item' id='detail1'><img src='" + rst.target.result+"' alt='First slide' height='250' width='200'  style='margin-left: auto; margin-right: auto;'></div>");
					else
						$('#detail1').html("<img src='" + rst.target.result+"' alt='First slide' height='250' width='200'  style='margin-left: auto; margin-right: auto;'>");
				}else if(imgIndex=='1'){
					if(second=="")
						$('#itemImg').append("<div class='item' id='detail2'><img src='" + rst.target.result+"' alt='First slide' height='250' width='200'  style='margin-left: auto; margin-right: auto;'></div>");
					else
						$('#detail2').html("<img src='" + rst.target.result+"' alt='Second slide' height='250' width='200'  style='margin-left: auto; margin-right: auto;'>");
				}else
					if(third=="")
						$('#itemImg').append("<div class='item' id='detail3'><img src='" + rst.target.result+"' alt='First slide' height='250' width='200'  style='margin-left: auto; margin-right: auto;'></div>");
					else
						$('#detail3').html("<img src='" + rst.target.result+"' alt='Third slide' height='250' width='200'  style='margin-left: auto; margin-right: auto;'>");
    		}
    	}
    	reader.readAsDataURL(file[0]);
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
<body>
<div id="dialog" title="ALERT DIALOG"></div>
	<section class="vbox">
		<!-- 상단바 -->
		<header
			class="bg-white header header-md navbar navbar-fixed-top-xs box-shadow">
			<div class="navbar-header aside-md dk">
				<a class="btn btn-link visible-xs"
					data-toggle="class:nav-off-screen,open" data-target="#nav,html">
					<i class="fa fa-bars"></i>
				</a> <a href="index.html" class="navbar-brand"> <span
					class="hidden-nav-xs">ONCE</span>
				</a> <a class="btn btn-link visible-xs" data-toggle="dropdown"
					data-target=".user"> <i class="fa fa-cog"></i>
				</a>
			</div>
		</header>
		<!-- 상단바 끝 -->

		<section>
			<section class="hbox stretch">
				<!-- 메뉴 위 프로필 -->
				<aside class="bg-black aside-md hidden-print hidden-xs" id="nav">
					<section class="vbox">
						<section class="w-f scrollable">
							<div class="slim-scroll" data-height="auto"
								data-disable-fade-out="true" data-distance="0" data-size="10px"
								data-railOpacity="0.2">
								<div class="clearfix wrapper dk nav-user hidden-xs">
									<div class="dropdown">
										<a href="#" class="dropdown-toggle" data-toggle="dropdown">
											<span class="hidden-nav-xs clear"> <span
												class="block m-t-xs"> <strong
													class="font-bold text-lt">${loginVO.managerId }</strong> <b
													class="caret"></b>
											</span>
										</span>
										</a>
										<!-- 프로필 클릭시 나오는 메뉴 -->
										<ul class="dropdown-menu animated fadeInRight m-t-xs">
											<li><a href="${ pageContext.request.contextPath }/manager/check">Profile</a></li>
											<li class="divider"></li>
											<li><a href="modal.lockme.html" data-toggle="ajaxModal">Logout</a>
											</li>
										</ul>
									</div>
								</div>
								<!-- 프로필 클릭시 나오는 메뉴 끝 -->
								<!-- 메뉴 위 프로필 끝 -->

								<!-- 사이드 메뉴 -->
								<nav class="nav-primary hidden-xs" id="sidemenu">
									<div
										class="text-muted text-sm hidden-nav-xs padder m-t-sm m-b-sm">Start</div>
									<ul class="nav nav-main" data-ride="collapse">
										<li class="active"><a
											href="${pageContext.request.contextPath}/item/register"
											class="auto"> <span class="pull-right text-muted">
													<i class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-statistics icon"> </i> <span class="font-bold">상품
													관리</span>
										</a>
											<ul class="nav dk">
												<li class="active"><a href="${pageContext.request.contextPath}/item/register"
													class="auto"> <i class="i i-dot"></i> <span>상품
															등록</span>
												</a></li>
												<li><a href="${pageContext.request.contextPath}/item/list"
													class="auto"> <i class="i i-dot"></i> <span>상품
															리스트</span>
												</a></li>
												<li><a href="icons.html" class="auto"> <i
														class="i i-dot"></i> <span>상품 재고 관리</span>
												</a></li>
											</ul>
										<li><a href="#" class="auto"> <span
												class="pull-right text-muted"> <i
													class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-stack icon"> </i> <span class="font-bold">프로모션</span>
										</a></li>
										<li><a href="#" class="auto"> <span
												class="pull-right text-muted"> <i
													class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-lab icon"> </i> <span class="font-bold">관리자
													답변 게시판</span>
										</a></li>
										<li><a href="#" class="auto"> <span
												class="pull-right text-muted"> <i
													class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-docs icon"> </i> <span class="font-bold">주문
													내역 게시판</span>
										</a></li>
										<li><a href="#" class="auto"> <span
												class="pull-right text-muted"> <i
													class="i i-circle-sm-o text"></i> <i
													class="i i-circle-sm text-active"></i>
											</span> <i class="i i-grid2 icon"> </i> <span class="font-bold">매장
													직원 관리</span>
										</a></li>
									</ul>

								</nav>
							</div>
						</section>
						<footer class="footer hidden-xs no-padder text-center-nav-xs">
							<!-- 메뉴 하단 로그아웃 버튼 -->
							<a href="modal.lockme.html" data-toggle="ajaxModal"
								class="btn btn-icon icon-muted btn-inactive pull-right m-l-xs m-r-xs hidden-nav-xs">
								<i class="i i-logout"></i>
							</a>
							<!-- 메뉴 하단 축소 버튼 -->
							<a href="#nav" data-toggle="class:nav-xs"
								class="btn btn-icon icon-muted btn-inactive m-l-xs m-r-xs">
								<i class="i i-circleleft text"></i> <i
								class="i i-circleright text-active"></i>
							</a>
						</footer>
					</section>
				</aside>
				<!-- 사이드 메뉴 끝 -->
				<section id="content">
					<section class="vbox">
						<section class="scrollable wrapper" style="padding-left: 50px">
							<br />
							<h3 class="font-bold m-b-none m-t-none">[${item.storeName}] 상품 등록</h3>
							<br /><br /><br /><br />
							<form action="${ pageContext.request.contextPath }/item/registerDetail"
								method="post" enctype="multipart/form-data" id="registerItem">
								<div style="background-color: #E0DFDF; height: 30px; padding: 5px;"
									id="registerImg">
									<i class="fa fa-angle-double-right" aria-hidden="true"></i> <span
										style="font-size: 10pt; font-weight: bold;  margin-top:50px;">&nbsp;&nbsp;&nbsp;상품 이미지 등록 </span>
								</div>
								<table style="margin-left: 100px;" id="images">
									<tr style="height: 100px;">
										<td style="width: 200px;">상세 이미지 등록</td>										
										<td><input type="file" value="파일 찾기" id="uploadLogo1" accept="image/*" onchange="fileInfo(this, '0')"></td>
										<!-- 이미지 -->
										<td rowspan="3" style="width: 50px;">
										<td rowspan="3" style="width: 300px;">
											<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
											  <!-- Wrapper for slides -->
											  <div class="carousel-inner" role="listbox" id="itemImg" >										   
											  </div>
											
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
										</td>
									</tr>
									<tr style="height: 100px;">
										<td>상세 이미지 등록</td>
										<td><input type="file" value="파일 찾기" id="uploadLogo2" accept="image/*" onchange="fileInfo(this, '1')"></td>
									</tr>
									<tr style="height: 100px;">
										<td>상세 이미지 등록</td>
										<td><input type="file" value="파일 찾기" id="uploadLogo3" accept="image/*" onchange="fileInfo(this, '2')"></td>
									</tr>
								</table>
								<br /> <br />
								<div
									style="background-color: #E0DFDF; height: 30px; padding: 5px;"
									id="registerDetail">
									<i class="fa fa-angle-double-right" aria-hidden="true"></i>
									<span style="font-size: 10pt; font-weight: bold;">&nbsp;&nbsp;&nbsp;상세
										정보 등록 </span>
								</div>
								<div>
								<p style="padding-top: 50px; font-weight: bold; margin-left: 25px; margin-bottom: 10px;">&nbsp;&nbsp;&nbsp;[SIZE 및 COUNT 등록]</p>
								<table id="itemDetail" style="margin-left: 90px; margin-top: 20px;">
									<tr>
										<td style="width: 50px;" align="right">SIZE</td>
										<td style="width: 10px;"></td>
										<td style="width: 50px;"><input type="text" id="size"></td>
										<td style="width: 20px;"></td>
										<td style="width: 50px;" align="right">COUNT</td>
										<td style="width: 10px;"></td>
										<td style="width: 50px;"><input type="number" id="count"></td>
										<td style="width: 20px;"></td>
										<td style="width: 50px;"><input type="button"
											name="addItem" id="addItem" value="추가"></td>
									</tr>
								</table>
								<br/><br/>
								</div>
								<br/>
								<div>
									<p style="font-weight: bold; margin-left: 25px;">[추가 상품 현황]</p>
									<table style="width: 900px; margin-left: 50px;  margin-top: 20px;" id="AddList">
										<tr>
											<th style="width: 20%; text-align: center;">상품 이름</th>
											<th style="width: 20%; text-align: center;">상품 코드</th>
											<th style="width: 20%; text-align: center;">SIZE</th>
											<th style="width: 20%; text-align: center;">COUNT</th>
											<th style="width: 20%; text-align: center;">삭제</th>
										</tr>
									</table>
								</div><br/><br/><br/><br/>
								<div>
									<p style="font-weight: bold; margin-left: 25px;">[상품 상세 정보]</p>
									<div style="margin-left: 110px;  margin-top: 20px;">
										<textarea rows="3" cols="110" name="detail" style="resize: none;"></textarea>
									</div>
								</div>
								<br/><br/>
								<div align="right">
									<input type="hidden" name="_method" value="post"> 
									<input type="submit" value="등록" class="btn btn-s-md btn-primary" id="finish">
									<input type="hidden" value="${ item.itemNo }" name="itemNo" id="itemNo">
									<input type="hidden" value="${ item.itemName }" name="itemName" id="itemName">
									<input type="hidden" value="${ item.managerId }" name="id">
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