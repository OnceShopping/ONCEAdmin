<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
  	.storeLogo {
  		margin-top: 10px;
  		text-align: center;
  	}

  	.storeLogoImg {
  		margin-left: 40%;
  		width: 150px;
  		height: 150px;
  		background-color: transparent;
  	}

  	.storeLogoImg img {
  		max-width: 100%;
  	}
  	
  	.storeLogo label {
	    position: relative;
	    cursor: pointer;
	    display: inline-block;
	    vertical-align: middle;
	    overflow: hidden;
	    width: 70px;
	    height: 30px;
	    background: #177bbb;
	    color: #fff;
	    text-align: center;
	    line-height: 30px;
	}
	.storeLogo label input {
	    position: absolute;
	    width: 0;
	    height: 0;
	    overflow: hidden;
	}
	.storeLogo input[type=text] {
	    margin-right: 8%;
	    vertical-align: middle;
	    display: inline-block;
	    width: 100px;
	    height: 28px;
	    line-height:28px;
	    font-size: 11px;
	    padding: 0;
	    border: 0;
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
   
	$(document).ready(function() { 
	   sidemenu();
	   document.getElementById('storeList').setAttribute('class','active');
	});
    
	//이미지 미리 보기
	function fileInfo(f){
		var file = f.files;
	
		var reader = new FileReader();
		reader.onload = function(rst){
			$('#storeLogoImg').html('<img src="' + rst.target.result + '">');
		}
		reader.readAsDataURL(file[0]);
	}
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
				<section class="scrollable bg-white">
					<div class="wrapper-lg bg-light">
						<div class="hbox">
							<aside>
							<h3 class="font-bold m-b-none m-t-none">${storeVO.storeNo} ${storeVO.storeName}</h3>
							</aside>
						</div>
					</div>
					<div class="tab-pane wrapper-lg" id="edit">
						<form class="form-horizontal" action="${ pageContext.request.contextPath }/store/detail/${ storeVO.storeNo }" name="form" enctype="multipart/form-data" method="post">
							<div class="storeLogo">
								<div class="storeLogoImg" id="storeLogoImg">
									<img src="/image/${storeVO.imgSaveName}" alt="${ storeVO.storeName }"/>
								</div><br/>
								<label>
									로고 첨부
									<input type="file" name="file" id="uploadLogo" accept="image/*" onchange="javascript:document.getElementById('file_route').value=this.value; fileInfo(this);">
								</label>
								<input type="text" readonly="readonly" title="File Route" id="file_route">
							</div>
							<div class="line line-dashed b-b line-lg pull-in"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label" for="storeCategory">카테고리:</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="storeCategory"
										disabled="disabled" value="${storeVO.storeCategory}">
								</div>
							</div>
							<div class="line line-dashed b-b line-lg pull-in"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label" for="storeCategory">상호명:</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="storeName"
										disabled="disabled" value="${storeVO.storeName}">
								</div>
							</div>
							<div class="line line-dashed b-b line-lg pull-in"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label">대표자:</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="storeName" name="ceo" value="${storeVO.ceo}" />
								</div>
							</div>
							<div class="line line-dashed b-b line-lg pull-in"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label">사업자 등록 번호:</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="companyNo" name="companyNo" value="${storeVO.companyNo}" pattern="\d{3}\-\d{4}\-\d{4}" title="xxx-xxxx-xxxx와 같은 형식으로  작성해 주세요" required/>
								</div>
							</div>
							<div class="line line-dashed b-b line-lg pull-in"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label">매장 전화번호:</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="phone" name="phone" value="${storeVO.phone}" pattern="0\d{1,2}\-\d{3,4}\-\d{4}" title="0x-xxx-xxxx 또는  0xx-xxxx-xxxx와 같은 형식으로  작성해 주세요" required/>
								</div>
							</div>
							<div class="line line-dashed b-b line-lg pull-in"></div>
							<div class="form-group" style="text-align: center;">
								<div class="col-sm-offset-3 col-sm-5">
									<button type="submit" class="btn btn-sm btn-primary" id="udtBtn">수정</button>
									<button type="button" class="btn btn-sm btn-primary" id="goBackBtn" onclick="goBack()">취소</button>
								</div>
							</div>
						</form>
					</div>
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