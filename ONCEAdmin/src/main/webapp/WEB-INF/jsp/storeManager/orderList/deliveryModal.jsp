<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <title>Insert title here</title> -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css">
<script src="${pageContext.request.contextPath }/resources/js/jquery.min.js"></script>
<script	src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	var changePage;
	$('#exampleModal').modal('show');
	
});

</script>
</head>
<body>
<body class="">
<!-- Modal --> 						
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
						<span class="sr-only">Close</span>
						</button>
					<h3 class="modal-title" id="exampleModalLabel">REGISTER COMPLETE!</h3>
			 	</div>
		 	<div class="modal-body">
		 		<div id="ask">상품 등록이 완료되었습니다.<br/>계속 상품을 등록하시겠습니까?</div>
			</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="yes" onclick="location.href='${pageContext.request.contextPath }/item/register'">전달 완료</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="no" onclick="location.href='${pageContext.request.contextPath }/item/list'">취소</button>
				</div>
			</div>
		 </div>
	</div>
</body>
</html>