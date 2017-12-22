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
 	#insidePage {
		padding-top: 30px;
		padding-bottom: 50px;
		padding-left: 50px;
		
	}
	
 	.storeLogo {
 		float: left;
 		margin-top: 10px;
 		margin-right: 20px;
 		text-align: center;
 	}

 	.storeLogoImg {
 		margin-left: 10px;
 		width: 150px;
 		height: 150px;
 		background-color: transparent;
 	}

 	.storeLogoImg img {
 		max-width: 100%;
 	}
 	
 	table {
 		margin-top: 30px;
 		width: 500px;
 	}
 	
 	th {
 		width: 140px;
 		font-size: 12pt;
 		padding-bottom: 15px;
 	}
 	
 	th, td {
 		padding-left: 5px;
 		padding-right: 5px;
 		padding-top: 8px;
 	}
 	
 	.firstSelect {
 		width: 150px;
 		margin-bottom: 0px;
 		padding-bottom: 0px;
 	}
 	
 	.secondSelect, .thirdSelect {
 		width: 170px;
 		margin-bottom: 0px;
 		padding-bottom: 0px;
 	}
 	
 	.secondSelect {
 		float: left;
 		margin-right: 10px;
 	}
 	
 	.storeSubmit {
		margin-top: 100px;
		margin-left: 200px;
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
	   
		var registerBtn = false;
		
	    var mainCategoryArray = new Array();
	    var mainCategoryObject = new Object();
	     
	    mainCategoryObject = new Object();
	    mainCategoryObject.main_category_id = "1F";
	    mainCategoryObject.main_category_name = "1F";
	    mainCategoryArray.push(mainCategoryObject);
	     
	    mainCategoryObject = new Object();
	    mainCategoryObject.main_category_id = "2F";
	    mainCategoryObject.main_category_name = "2F";
	    mainCategoryArray.push(mainCategoryObject);
	    
	    mainCategoryObject = new Object();
	    mainCategoryObject.main_category_id = "3F";
	    mainCategoryObject.main_category_name = "3F";
	    mainCategoryArray.push(mainCategoryObject);
	     
	    var subCategoryArray = new Array();
	    var subCategoryObject = new Object();
	     
	    //1F
	    subCategoryObject.main_category_id = "1F";
	    subCategoryObject.sub_category_id = "S1F01"
	    subCategoryObject.sub_category_name = "S1F01" 
	    subCategoryArray.push(subCategoryObject);
	     
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "1F";
	    subCategoryObject.sub_category_id = "S1F02"
	    subCategoryObject.sub_category_name = "S1F02" 
	    subCategoryArray.push(subCategoryObject);
	     
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "1F";
	    subCategoryObject.sub_category_id = "S1F03"
	    subCategoryObject.sub_category_name = "S1F03" 
	    subCategoryArray.push(subCategoryObject);
	
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "1F";
	    subCategoryObject.sub_category_id = "S1F04"
	    subCategoryObject.sub_category_name = "S1F04" 
	    subCategoryArray.push(subCategoryObject);
	
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "1F";
	    subCategoryObject.sub_category_id = "S1F05"
	    subCategoryObject.sub_category_name = "S1F05" 
	    subCategoryArray.push(subCategoryObject);
	
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "1F";
	    subCategoryObject.sub_category_id = "S1F06"
	    subCategoryObject.sub_category_name = "S1F06" 
	    subCategoryArray.push(subCategoryObject);
	
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "1F";
	    subCategoryObject.sub_category_id = "S1F07"
	    subCategoryObject.sub_category_name = "S1F07" 
	    subCategoryArray.push(subCategoryObject);
		
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "1F";
	    subCategoryObject.sub_category_id = "S1F08"
	    subCategoryObject.sub_category_name = "S1F08" 
	    subCategoryArray.push(subCategoryObject);
	
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "1F";
	    subCategoryObject.sub_category_id = "S1F09"
	    subCategoryObject.sub_category_name = "S1F09" 
	    subCategoryArray.push(subCategoryObject);
	
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "1F";
	    subCategoryObject.sub_category_id = "S1F10"
	    subCategoryObject.sub_category_name = "S1F10" 
	    subCategoryArray.push(subCategoryObject);
	
	    //2F
	    subCategoryObject.main_category_id = "2F";
	    subCategoryObject.sub_category_id = "S2F01"
	    subCategoryObject.sub_category_name = "S2F01" 
	    subCategoryArray.push(subCategoryObject);
	     
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "2F";
	    subCategoryObject.sub_category_id = "S2F02"
	    subCategoryObject.sub_category_name = "S2F02" 
	    subCategoryArray.push(subCategoryObject);
	     
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "2F";
	    subCategoryObject.sub_category_id = "S2F03"
	    subCategoryObject.sub_category_name = "S2F03" 
	    subCategoryArray.push(subCategoryObject);
	
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "2F";
	    subCategoryObject.sub_category_id = "S2F04"
	    subCategoryObject.sub_category_name = "S2F04" 
	    subCategoryArray.push(subCategoryObject);
	
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "2F";
	    subCategoryObject.sub_category_id = "S2F05"
	    subCategoryObject.sub_category_name = "S2F05" 
	    subCategoryArray.push(subCategoryObject);
	
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "2F";
	    subCategoryObject.sub_category_id = "S2F06"
	    subCategoryObject.sub_category_name = "S2F06" 
	    subCategoryArray.push(subCategoryObject);
	
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "2F";
	    subCategoryObject.sub_category_id = "S2F07"
	    subCategoryObject.sub_category_name = "S2F07" 
	    subCategoryArray.push(subCategoryObject);
		
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "2F";
	    subCategoryObject.sub_category_id = "S2F08"
	    subCategoryObject.sub_category_name = "S2F08" 
	    subCategoryArray.push(subCategoryObject);
	
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "2F";
	    subCategoryObject.sub_category_id = "S2F09"
	    subCategoryObject.sub_category_name = "S2F09" 
	    subCategoryArray.push(subCategoryObject);
	
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "2F";
	    subCategoryObject.sub_category_id = "S2F10"
	    subCategoryObject.sub_category_name = "S2F10" 
	    subCategoryArray.push(subCategoryObject);
	    
	    //3F
	    subCategoryObject.main_category_id = "3F";
	    subCategoryObject.sub_category_id = "S3F01"
	    subCategoryObject.sub_category_name = "S3F01" 
	    subCategoryArray.push(subCategoryObject);
	     
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "3F";
	    subCategoryObject.sub_category_id = "S3F02"
	    subCategoryObject.sub_category_name = "S3F02" 
	    subCategoryArray.push(subCategoryObject);
	     
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "3F";
	    subCategoryObject.sub_category_id = "S3F03"
	    subCategoryObject.sub_category_name = "S3F03" 
	    subCategoryArray.push(subCategoryObject);
	
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "3F";
	    subCategoryObject.sub_category_id = "S3F04"
	    subCategoryObject.sub_category_name = "S3F04" 
	    subCategoryArray.push(subCategoryObject);
	
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "3F";
	    subCategoryObject.sub_category_id = "S3F05"
	    subCategoryObject.sub_category_name = "S3F05" 
	    subCategoryArray.push(subCategoryObject);
	
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "3F";
	    subCategoryObject.sub_category_id = "S3F06"
	    subCategoryObject.sub_category_name = "S3F06" 
	    subCategoryArray.push(subCategoryObject);
	
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "3F";
	    subCategoryObject.sub_category_id = "S3F07"
	    subCategoryObject.sub_category_name = "S3F07" 
	    subCategoryArray.push(subCategoryObject);
		
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "3F";
	    subCategoryObject.sub_category_id = "S3F08"
	    subCategoryObject.sub_category_name = "S3F08" 
	    subCategoryArray.push(subCategoryObject);
	
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "3F";
	    subCategoryObject.sub_category_id = "S3F09"
	    subCategoryObject.sub_category_name = "S3F09" 
	    subCategoryArray.push(subCategoryObject);
	
	    subCategoryObject = new Object();
	    subCategoryObject.main_category_id = "3F";
	    subCategoryObject.sub_category_id = "S3F10"
	    subCategoryObject.sub_category_name = "S3F10" 
	    subCategoryArray.push(subCategoryObject);
	     
	    var mainCategorySelectBox = $("select[name='floor']");
	     
	    for(var i=0;i<mainCategoryArray.length;i++){
	        mainCategorySelectBox.append("<option value='"+mainCategoryArray[i].main_category_id+"'>"+mainCategoryArray[i].main_category_name+"</option>");
	    }
	     
	    $(document).on("change","select[name='floor']",function(){
	         
	        var subCategorySelectBox = $("select[name='storeNo']");
	        subCategorySelectBox.children().remove();
	         
	        $("option:selected", this).each(function(){
	            var selectValue = $(this).val();
	            subCategorySelectBox.append("<option value=''>선택</option>");
	            for(var i=0;i<subCategoryArray.length;i++){
	                if(selectValue == subCategoryArray[i].main_category_id){
	                     
	                    subCategorySelectBox.append("<option value='"+subCategoryArray[i].sub_category_id+"'>"+subCategoryArray[i].sub_category_name+"</option>");
	                     
	                }
	            }
	        });
	         
	    });
	    
	    
		//존재하는 매장 체크
		$('#thirdSelect').change(function() {
			var selected = $(this).val();
	
			$.ajax({
	            data : { "storeNo" : selected },
	            url : "${pageContext.request.contextPath}/store/check",
	            type : "get",
	            cache : false,
	            contentType : "application/json; charset=UTF-8",
	            success : function(data) {
	            	if(data == "true") {
						alert('이미 해당하는 매장이 존재합니다');
						registerBtn = false;
	            	} else {
	            		$("#submitBtn").prop("disabled", false);
	            		registerBtn = true;
	            	} 
	           	}
	        });
			
		});
		
		$('#form').submit(function() {
			var checkCategory = $('#firstSelect').val();
			var checkStoreName = $('#storeName').val();
			var checkCeo = $('#ceo').val();
			var checkCompanyNo = $('#companyNo').val();
			var checkPhone = $('#phone').val();
			
			if(registerBtn == true){
				if(checkStoreName == '' || checkCeo == '' || checkPhone == '' || checkCategory == '선택' || checkCompanyNo == '') {
					$("#submitBtn").prop("disabled", true);
		            return false;
				} else {
					$("#submitBtn").prop("disabled", false);
		            return true;
				}
			}else {
				$("#submitBtn").prop("disabled", true);
		            return false;
			}
			
		});
		
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
	
	function goBack() {
		location.href ="${pageContext.request.contextPath}/store/list";
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
                  <section class="scrollable wrapper" id="insidePage">
					 <h3>매장 추가</h3>
					 <div style="padding-top: 10px; padding-left: 15%;">
						<form action="${pageContext.request.contextPath}/store/add" name="form" id="form" enctype="multipart/form-data" method="post">
							<div class="storeLogo">
								<div class="storeLogoImg" id="storeLogoImg">
								</div><br/>
								<label>
									로고 첨부
									<input type="file" name="file" id="uploadLogo" accept="image/*" onchange="javascript:document.getElementById('file_route').value=this.value; fileInfo(this);">
								</label>
								<input type="text" readonly="readonly" title="File Route" id="file_route">
							</div>
							<div class="storeData">
								<table>
									<tr>
										<th>
											카테고리
										</th>
										<td>
											<select class="firstSelect form-control m-b" name="storeCategory" id="firstSelect">
												<option value="선택">선택</option>
												<option value="스포츠">스포츠</option>
												<option value="영캐주얼">영캐주얼</option>
												<option value="SPA">SPA</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>
											상호명
										</th>
										<td>
											<input type="text" name="storeName" class="form-control" id="storeName"/>
										</td>
									</tr>
									<tr>
										<th>
											매장 위치
										</th>
										<td>
											<select class="secondSelect form-control m-b" name="floor" id="secondSelect">
												<option>선택</option>
											</select>
											<select class="thirdSelect form-control m-b" name="storeNo" id="thirdSelect">
												<option>선택</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>
											대표자
										</th>
										<td>
											<input type="text" name="ceo" class="form-control" id="ceo" required/>
										</td>
									</tr>
									<tr>
										<th>
											사업자 등록 번호
										</th>
										<td>
											<input type="text" name="companyNo" class="form-control" id="companyNo" pattern="\d{3}\-\d{4}\-\d{4}" title="xxx-xxxx-xxxx와 같은 형식으로  작성해 주세요" required/>
										</td>
									</tr>
									<tr>
										<th>
											매장  전화번호
										</th>
										<td>
											<input type="text" name="phone" class="form-control" id="phone" pattern="0\d{1,2}\-\d{3,4}\-\d{4}" title="0x-xxx-xxxx 또는  0xx-xxxx-xxxx와 같은 형식으로  작성해 주세요" required/>
										</td>
									</tr>
								</table>
							</div>
							<div class="storeSubmit">
								<input type="submit" class="btn btn-s-md btn-primary" id="submitBtn" disabled="disabled" value="매장 등록"/>
								<input type="button" class="btn btn-s-md btn-primary" value="취소" onclick="goBack()"/>
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