<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css">
<script src="${pageContext.request.contextPath }/resources/js/jquery.min.js"></script>
<script	src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	$('#exampleModal').modal('show');
	
	
	$('#yes').click(function(){
		location.href="${ pageContext.request.contextPath }/orderList/orderList";
	});
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
					<h4 class="modal-title" id="exampleModalLabel">ALERT</h4>
			 	</div>
		 	<div class="modal-body">
		 		<div id="ask">${str }<br/>
		 		</div>
		 		<div id="moreInfo">${ more }</div>
			</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="yes" >확인</button>
				</div>
			</div>
		 </div>
	</div>	
</body>
</html>