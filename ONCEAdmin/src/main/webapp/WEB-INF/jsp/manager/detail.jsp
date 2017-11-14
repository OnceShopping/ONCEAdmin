<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<title>ONCE | 통합 관리자 페이지</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/bootstrap.css"
	type="text/css" />
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/animate.css" type="text/css" />
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/font-awesome.min.css"
	type="text/css" />
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/icon.css" type="text/css" />
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/font.css" type="text/css" />
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/app.css" type="text/css" />

<script src="${ pageContext.request.contextPath }/resources/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="${ pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
<!-- App -->
<script src="${ pageContext.request.contextPath }/resources/js/app.js"></script>
<script src="${ pageContext.request.contextPath }/resources/js/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${ pageContext.request.contextPath }/resources/js/charts/easypiechart/jquery.easy-pie-chart.js"></script>
<script src="${ pageContext.request.contextPath }/resources/js/app.plugin.js"></script>
</head>
<body class="">
	<section class="vbox"> <section class="scrollable bg-white">
	<div class="wrapper-lg bg-light">
		<div class="hbox">
			<aside>
			<h3 class="font-bold m-b-none m-t-none">"${managerVO.name}"</h3>
			<p>
				<i class="fa fa-lg fa-circle-o text-primary m-r-sm"></i>
				<strong>"${storeVO.storeName} ${managerVO.type}"</strong>
			</p>
			</aside>
		</div>
	</div>
	<div class="tab-pane wrapper-lg" id="edit">
		<form class="form-horizontal" action="${ pageContext.request.contextPath }/manager/detail/${managerVO.managerId}" method="get">
			<div class="line line-dashed b-b line-lg pull-in"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="input-id-1">ID:</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="input-id-1"
						disabled="disabled" value="${managerVO.managerId}">
				</div>
			</div>
			<div class="line line-dashed b-b line-lg pull-in"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label">Password:</label>
				<div class="col-sm-5">
					<input type="password" class="form-control" name="password">
				</div>
			</div>
			<div class="line line-dashed b-b line-lg pull-in"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label">Password Again:</label>
				<div class="col-sm-5">
					<input type="password" class="form-control">
				</div>
			</div>
			<div class="line line-dashed b-b line-lg pull-in"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label">Phone:</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" value="${managerVO.telephone}" name="telephone">
				</div>
			</div>
			<div class="line line-dashed b-b line-lg pull-in"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="input-id-1">Hire
					Date</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="input-id-1"
						disabled="disabled" value="${managerVO.date}">
				</div>
			</div>
			<div class="line line-dashed b-b line-lg pull-in"></div>
			<div class="form-group">
				<div class="col-sm-offset-3 col-sm-5">
					<button type="submit" class="btn btn-sm btn-primary">Update</button>
				</div>
			</div>
		</form>
	</div>
	</section> </section>
	<a href="#" class="hide nav-off-screen-block"
		data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</body>
</html>