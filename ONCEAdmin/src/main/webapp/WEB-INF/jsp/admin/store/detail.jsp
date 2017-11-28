<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/bootstrap.css"
	type="text/css" />
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/animate.css"
	type="text/css" />
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/font-awesome.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/icon.css"
	type="text/css" />
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/font.css"
	type="text/css" />
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/app.css"
	type="text/css" />

<style type="text/css">
  	.storeLogo {
  		margin-top: 10px;
  		text-align: center;
  	}

  	.storeLogoImg {
  		margin: auto;
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

<script
	src="${ pageContext.request.contextPath }/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script
	src="${ pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
<!-- App -->
<script src="${ pageContext.request.contextPath }/resources/js/app.js"></script>
<script
	src="${ pageContext.request.contextPath }/resources/js/slimscroll/jquery.slimscroll.min.js"></script>
<script
	src="${ pageContext.request.contextPath }/resources/js/charts/easypiechart/jquery.easy-pie-chart.js"></script>
<script
	src="${ pageContext.request.contextPath }/resources/js/app.plugin.js"></script>
<script type="text/javascript">
	//이미지 미리 보기
	function fileInfo(f){
		var file = f.files;
	
		var reader = new FileReader();
		reader.onload = function(rst){
			$('#storeLogoImg').html('<img src="' + rst.target.result + '">');
		}
		reader.readAsDataURL(file[0]);
	}

	function goBack() {
		location.href = "${pageContext.request.contextPath}/store/list";
	}
</script>
</head>
<body>
	<section class="vbox"> <section class="scrollable bg-white">
	<aside>
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
					<img src="${pageContext.request.contextPath}/upload/admin/${storeVO.imgSaveName}" alt="${ storeVO.storeName }"/>
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
					<input type="text" class="form-control" id="companyNo" name="companyNo" value="${storeVO.companyNo}" />
				</div>
			</div>
			<div class="line line-dashed b-b line-lg pull-in"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label">매장 전화번호:</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="phone" name="phone" value="${storeVO.phone}">
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
	</div></section> </section>
</body>
</html>