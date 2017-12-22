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
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/animate.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/font-awesome.min.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/icon.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/font.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/app.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/js/datepicker/datepicker.css" type="text/css" />

<style type="text/css">
	#insidePage {
		padding-top: 30px;
		padding-bottom: 50px;
		padding-left: 50px;
		
	}
	
	#scrollSearch {
		font-size: 20pt;
		font-weight: 800;
		margin-bottom: 20px;
		float: left;
	}
	
	#sideBtn {
		margin-right: 5%;
		margin-top: 10px;
	}
	
	.fa-plus, .fa-trash-o {
		margin-left: 10px;
		font-size: 16pt;
		float: right;
	}

	.divideLine {
		margin-left: 30px;
	}

	.storeList {
		margin-right: 10px;
		float: left;
		font-size: 11pt;
		text-align: center;
	}
	.storeListImg {
		width: 100px;
		height: 100px;
		margin-right: 10px;
		background-color: transparent;
	}
	
	.storeListImg i {
		font-size: 15pt;
		color: #fff;
		margin-top: 40px;
		margin-left: 40px;
	}
	
	.noList {
		text-align: left;
	}
	
	.noList span {
		font-size: 13pt;
		margin: 33px 33px;
	}
	
	.clear {
		clear: both;
		padding: 10px;
	}
</style>

<script src="${pageContext.request.contextPath }/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
<!-- App -->
<script src="${pageContext.request.contextPath }/resources/js/app.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/app.plugin.js"></script>

<script type="text/javascript">
	function sidemenu(){
		document.getElementById('noticeList').setAttribute('class','');
		document.getElementById('boardQAList').setAttribute('class','');
		document.getElementById('storeList').setAttribute('class','');
		document.getElementById('managerList').setAttribute('class','');
		document.getElementById('cusomterList').setAttribute('class','');
	}
	
	function addFirstStore() {
		form.submit="${pageContext.request.contextPath}/store/add";
	}
	
	$(document).ready(function() {
		sidemenu();
		document.getElementById('storeList').setAttribute('class','active');

		//삭제 버튼 생성
		$('#makeDelete').click(function(event) {
 			event.preventDefault();
			$('.deleteIcon').toggle();
		});
		
		//삭제 버튼 클릭
		$('.deleteIcon').click(function(event) {
 			event.preventDefault();
 			
 			var storeNo = $('#hiddenStoreNo').val();
 			
 			$.ajax({
 				data: {"storeNo" : storeNo },
 				url: "${pageContext.request.contextPath}/store/delete",
 				type: "get",
 				contentType : "application/json; charset=UTF-8",
 				cache : false,
 		        success: function(data){
 		        	alert(storeNo + '가 성공적으로 삭제되었습니다');
 		        	$('#div' + storeNo).remove();
 		        	
 		        }
 			});
 			
		});
	});
</script>
</head>
<body class="">
   <section class="vbox">
      <!-- 상단바 -->
      <jsp:include page="/WEB-INF/jsp/admin/include/topmenu.jsp" flush="false"></jsp:include>
      <!-- 상단바 끝 -->

      <section>
         <section class="hbox stretch">
            <!-- 사이드메뉴 -->
            <jsp:include page="/WEB-INF/jsp/admin/include/sidemenu.jsp" flush="false"></jsp:include>
            <!-- 사이드메뉴 끝 -->
            
            <!-- 메뉴 사이즈 조정 -->
            <section id="content">
               <section class="vbox">
                  <section class="scrollable wrapper" id="insidePage">
                    <div id="scrollSearch"> 
						<a href="#1floor">1F</a> | <a href="#2floor">2F</a> | <a href="#3floor">3F</a>
					</div>
					<div id="sideBtn">
						<form action="" method="post">
							<a href="#" id="makeDelete"><i class="fa fa-trash-o"></i></a>
						</form>
						<a href="${pageContext.request.contextPath}/store/add"><i class="fa fa-plus"></i></a>
					</div>
					<div class="clear"></div>
					<form action="${pageContext.request.contextPath}/store/list" method="get">
						<div class="divideFloor" id="1floor">
							<h2>1F</h2>
							<div class="divideLine">			
								<c:forEach items="${ firstFloor }" var="list" varStatus="status">
									<c:if test="${status.count <= 5}">
										<div class="storeList" id="div${ list.storeNo }">
											<div class="storeListImg">
												<a href="${pageContext.request.contextPath}/store/detail/${ list.storeNo }">
													<img src="/image/${list.imgSaveName}" alt="${ list.storeName }" width="100%"/>
												</a>
											</div>
											${ list.storeNo }
											<a href="#" style="display: none;" class="deleteIcon">
												<i class="fa fa-minus-circle" style="color: red"></i>
											</a>
											<input type="hidden" name="storeNo" id="hiddenStoreNo" value="${ list.storeNo }"/>
										</div>				
									</c:if>
								</c:forEach>
							</div>
							<div class="clear"></div>
							<div class="divideLine">			
								<c:forEach items="${ firstFloor }" var="list" varStatus="status">
									<c:if test="${status.count > 5}">
										<div class="storeList" id="div${ list.storeNo }">
											<div class="storeListImg">
												<a href="${pageContext.request.contextPath}/store/detail/${ list.storeNo }">
													<img src="/image/${ list.imgSaveName }" alt="${ list.storeName }" width="100%"/>
												</a>
											</div>
											${ list.storeNo }
											<a href="#" style="display: none;" class="deleteIcon">
												<i class="fa fa-minus-circle" style="color: red"></i>
											</a>
											<input type="hidden" name="storeNo" id="hiddenStoreNo" value="${ list.storeNo }"/>
										</div>				
									</c:if>
								</c:forEach>
							</div>
						</div>
						
							<div class="clear"></div>
						
						<div class="divideFloor" id="2floor">
							<h2>2F</h2>
							<div class="divideLine">			
								<c:forEach items="${ secondFloor }" var="list" varStatus="status">
									<c:if test="${status.count <= 5}">
										<div class="storeList" id="div${ list.storeNo }">
											<div class="storeListImg">
												<a href="${pageContext.request.contextPath}/store/detail/${ list.storeNo }">
													<img src="/image/${ list.imgSaveName }" alt="${ list.storeName }" width="100%"/>
												</a>
											</div>
											${ list.storeNo }
											<a href="#" style="display: none;" class="deleteIcon">
												<i class="fa fa-minus-circle" style="color: red"></i>
											</a>
											<input type="hidden" name="storeNo" id="hiddenStoreNo" value="${ list.storeNo }"/>
										</div>				
									</c:if>
								</c:forEach>
							</div>
							<div class="clear"></div>
							<div class="divideLine">			
								<c:forEach items="${ secondFloor }" var="list" varStatus="status">
									<c:if test="${status.count > 5}">
										<div class="storeList" id="div${ list.storeNo }">
											<div class="storeListImg">
												<a href="${pageContext.request.contextPath}/store/detail/${ list.storeNo }">
													<img src="/image/${ list.imgSaveName }" alt="${ list.storeName }" width="100%"/>
												</a>
											</div>
											${ list.storeNo }
											<a href="#" style="display: none;" class="deleteIcon">
												<i class="fa fa-minus-circle" style="color: red"></i>
											</a>
											<input type="hidden" name="storeNo" id="hiddenStoreNo" value="${ list.storeNo }"/>
										</div>				
									</c:if>
								</c:forEach>
							</div>
						</div>
						
							<div class="clear"></div>
						
						<div class="divideFloor" id="3floor">
							<h2>3F</h2>
							<div class="divideLine">			
								<c:forEach items="${ thirdFloor }" var="list" varStatus="status">
									<c:if test="${status.count <= 5}">
										<div class="storeList" id="div${ list.storeNo }">
											<div class="storeListImg">
												<a href="${pageContext.request.contextPath}/store/detail/${ list.storeNo }">
													<img src="/image/${ list.imgSaveName }" alt="${ list.storeName }" width="100%"/>
												</a>
											</div>
											${ list.storeNo }
											<a href="#" style="display: none;" class="deleteIcon">
												<i class="fa fa-minus-circle" style="color: red"></i>
											</a>
											<input type="hidden" name="storeNo" id="hiddenStoreNo" value="${ list.storeNo }"/>
										</div>				
									</c:if>
								</c:forEach>
							</div>
							<div class="clear"></div>
							<div class="divideLine">			
								<c:forEach items="${ thirdFloor }" var="list" varStatus="status">
									<c:if test="${status.count > 5}">
										<div class="storeList" id="div${ list.storeNo }">
											<div class="storeListImg">
												<a href="${pageContext.request.contextPath}/store/detail/${ list.storeNo }">
													<img src="/image/${ list.imgSaveName }" alt="${ list.storeName }" width="100%"/>
												</a>
											</div>
											${ list.storeNo }
											<a href="#" style="display: none;" class="deleteIcon">
												<i class="fa fa-minus-circle" style="color: red"></i>
											</a>
											<input type="hidden" name="storeNo" id="hiddenStoreNo" value="${ list.storeNo }"/>
										</div>				
									</c:if>
								</c:forEach>
							</div>
						</div>
					</form>
                  </section>
               </section>
               <a href="#" class="hide nav-off-screen-block"
                  data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
            </section>
            <!-- 메뉴 사이즈 조정 끝-->

         </section>
      </section>
   </section>
   
</body>
</html>