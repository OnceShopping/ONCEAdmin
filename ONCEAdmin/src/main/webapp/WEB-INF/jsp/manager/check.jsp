<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> ONCE | 통합 관리자 페이지 </title>
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
<body>
	<section id="content" class="m-t-lg wrapper-md animated fadeInUp">   
		<div class="container aside-xl">
			 <a class="navbar-brand block">관리자 상세 정보 수정<br/></a>
			 <section class="m-b-lg">
				<header class="wrapper text-center">
					<strong>본인 확인을 위해 비밀번호를 한 번 더 입력해 주세요</strong>
				</header>
				<form action="${ pageContext.request.contextPath }/manager/check" method="post">
					<div class="list-group">
						<div class="list-group-item">
							<input type="password" id="password" name="password" placeholder="Password" class="form-control no-border">
						</div>
						<input type="submit" value="확인" class="btn btn-lg btn-primary btn-block"/>
					</div>
				</form>
			</section>
		</div>
	</section>
</body>
</html>