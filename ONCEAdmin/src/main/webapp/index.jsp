<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title>O N C E</title>
  <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" /> 
  <link rel="stylesheet" href="resources/css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="resources/css/animate.css" type="text/css" />
  <link rel="stylesheet" href="resources/css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="resources/css/icon.css" type="text/css" />
  <link rel="stylesheet" href="resources/css/font.css" type="text/css" />
  <link rel="stylesheet" href="resources/css/app.css" type="text/css" />
</head>
<style>
	
	html:after {
	    content : "";
	    display: block;
	    position: absolute;
	    top: 0;
	    left: 0;
	    background-image: url('/image/background.jpg');
	    width: 100%;
	    height: 100%;
	    opacity : 0.8;
	    z-index: -1;
	    background-size: cover;
	}
	
	.container{
		border: 1px solid #D5D5D5;
		border-radius: 30px;
		background-color: rgba( 255, 255, 255, 0.5 );
	}
	
</style>
<body>
  <section id="content" class="m-t-lg wrapper-md animated fadeInUp" >
    <div class="container aside-xl"  style="text-align: center;">
      <section class="m-b-lg">
      <img src="/image/login.png" style="width: 65px; height: 65px; margin-top: 30px;"/>    
     	<header class="wrapper text-center">
          <strong style="font-size: 25px; color: #585858;">O N C E</strong>
        </header>
        <form action="${pageContext.request.contextPath}/login" method="post">
          <div class="list-group" style="border: 1px solid #D5D5D5; background: white;">
            <div class="list-group-item">
              <input type="text" name="id" placeholder="ID" class="form-control no-border">
            </div>
            <div class="list-group-item">
               <input type="password" name="password" placeholder="Password" class="form-control no-border">
            </div>
          </div>
          <button type="submit" class="btn btn-lg btn-primary btn-block">LOGIN</button><br/>
          <div class="text-center m-t m-b"><small>ONCE ADMIN - Once shopping system Admin <br>&copy; 2017</small></div>
          <div class="line line-dashed"></div>
        </form>
      </section>
      </div>
      <div class="text-center padder">
    </div>
  </section>
</body>
</html>