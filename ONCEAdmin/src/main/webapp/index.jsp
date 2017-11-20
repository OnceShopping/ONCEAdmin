<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title>O N C E_admin</title>
  <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" /> 
  <link rel="stylesheet" href="resources/css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="resources/css/animate.css" type="text/css" />
  <link rel="stylesheet" href="resources/css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="resources/css/icon.css" type="text/css" />
  <link rel="stylesheet" href="resources/css/font.css" type="text/css" />
  <link rel="stylesheet" href="resources/css/app.css" type="text/css" />
</head>
<body class="" >

  <br/><br/>
  <section id="content" class="m-t-lg wrapper-md animated fadeInUp">    
    <div class="container aside-xl">
      <a class="navbar-brand block">O N C E 관리자 페이지<br/><br/></a>
      <section class="m-b-lg">
        <header class="wrapper text-center">
          <strong>admin ID 생성은 관리자에게 문의하세요</strong>
        </header>
        <form action="${pageContext.request.contextPath}/login" method="post">
          <div class="list-group">
            <div class="list-group-item">
              <input type="text" name="id" placeholder="ID" class="form-control no-border">
            </div>
            <div class="list-group-item">
               <input type="password" name="password" placeholder="Password" class="form-control no-border">
            </div>
          </div>
          <button type="submit" class="btn btn-lg btn-primary btn-block">로 그 인</button><br/>
          <div class="text-center m-t m-b"><a href="#"><small>ID나 비밀번호를 잊으셨나요?</small></a></div>
          <div class="line line-dashed"></div>
        </form>
      </section>
    </div>
  </section>
  <!-- footer -->
  <footer id="footer">
    <div class="text-center padder">
      <p>
        <small>ONCE ADMIN - Once shopping system Admin <br>&copy; 2017</small>
      </p>
    </div>
  </footer>
  <!-- / footer -->
  <script src="resources/js/jquery.min.js"></script>
  <!-- Bootstrap -->
  <script src="resources/js/bootstrap.js"></script>
  <!-- App -->
  <script src="resources/js/app.js"></script>  
  <script src="resources/js/slimscroll/jquery.slimscroll.min.js"></script>
  <script src="resources/js/app.plugin.js"></script>

</body>
</html>