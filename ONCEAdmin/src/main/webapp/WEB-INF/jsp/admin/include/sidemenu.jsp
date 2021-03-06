<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
		<!-- 메뉴 위 프로필 -->
            <aside class="bg-black aside-md hidden-print hidden-xs" id="nav">
               <section class="vbox">
                  <section class="w-f scrollable">
                     <div class="slim-scroll" data-height="auto" data-disable-fade-out="true" data-distance="0" data-size="10px" data-railOpacity="0.2">
                        <div class="clearfix wrapper dk nav-user hidden-xs">
                           <div class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                 <span class="hidden-nav-xs clear"> 
                                 <span class="block m-t-xs"> 
                                 	<strong class="font-bold text-lt">${loginVO.managerId }</strong>
                                 <b class="caret"></b>
                                 </span>
                              	 </span>
                              </a>
                              <!-- 프로필 클릭시 나오는 메뉴 -->
                              <ul class="dropdown-menu animated fadeInRight m-t-xs">
                                 <li><a href="${ pageContext.request.contextPath }/manager/check">Profile</a></li>
                                 <li class="divider"></li>
                                 <li><a href="${ pageContext.request.contextPath }/logout">Logout</a></li>
                              </ul>
                           </div>
                        </div>
                        <!-- 프로필 클릭시 나오는 메뉴 끝 -->
                        <!-- 메뉴 위 프로필 끝 -->

                        <!-- 사이드 메뉴 -->
                        <nav class="nav-primary hidden-xs" id="sidemenu">
                           <div class="text-muted text-sm hidden-nav-xs padder m-t-sm m-b-sm">Start</div>
                           <ul class="nav nav-main" data-ride="collapse">
                              <li id="noticeList">
                              	<a href="${ pageContext.request.contextPath }/notice/list" class="auto">
                              	<span class="pull-right text-muted">
                                <i class="i i-circle-sm-o text"></i> 
                                <i class="i i-circle-sm text-active"></i>
                                </span> 
                                <i class="i i-statistics icon"></i>
                               	<span class="font-bold">운영 공지</span>
                              </a>  
                              <li id="boardQAList">
                              	<a href="${ pageContext.request.contextPath }/boardQA/list" class="auto"> 
                              		<span class="pull-right text-muted"> 
                              		<i class="i i-circle-sm-o text"></i> 
                              		<i class="i i-circle-sm text-active"></i>
                                 	</span> 
                                 	<i class="i i-stack icon"> </i> <span class="font-bold">관리자 답변 게시판</span>
                              	</a>
                              </li>
                              <li id="storeList">
                              	<a href="${ pageContext.request.contextPath }/store/list" class="auto"> 
                              	<span class="pull-right text-muted"> 
                              		<i class="i i-circle-sm-o text"></i> 
                              		<i  class="i i-circle-sm text-active"></i>
                                 </span> 
                                 	<i class="i i-lab icon"></i>
                                 <span class="font-bold">매장 관리</span>
                              	</a>
                              </li>
                              <li id="managerList">
                              	<a href="${pageContext.request.contextPath}/manager/list" class="auto">
	                              	<span class="pull-right text-muted"> 
	                              		<i class="i i-circle-sm-o text"></i> 
	                              		<i class="i i-circle-sm text-active"></i>
	                                </span>
	                                	<i class="i i-docs icon"></i>
	                                <span class="font-bold">매니저 관리</span>
                              	</a>
                              </li>
                              <li id="cusomterList">
                              	<a href="${ pageContext.request.contextPath }/customer/list" class="auto">
                              		<span class="pull-right text-muted"> 
                              		<i class="i i-circle-sm-o text"></i> 
                              		<i class="i i-circle-sm text-active"></i>
                                 	</span>
                                 	<i class="i i-grid2 icon"></i> 
                                 	<span class="font-bold">고객 관리</span>
                              </a>
                              </li>
                           </ul>
                        </nav>
                  </div>
                  </section>
                  <footer class="footer hidden-xs no-padder text-center-nav-xs">
                     <!-- 메뉴 하단 로그아웃 버튼 -->
                     <a href="${ pageContext.request.contextPath }/logout" class="btn btn-icon icon-muted btn-inactive pull-right m-l-xs m-r-xs hidden-nav-xs">
                        <i class="i i-logout"></i>
                     </a>
                     <!-- 메뉴 하단 축소 버튼 -->
                     <a href="#nav" data-toggle="class:nav-xs" class="btn btn-icon icon-muted btn-inactive m-l-xs m-r-xs">
                        <i class="i i-circleleft text"></i> <i class="i i-circleright text-active"></i>
                     </a>
                  </footer>
               </section>
            </aside>            
            <!-- 사이드 메뉴 끝 -->
</body>
</html>