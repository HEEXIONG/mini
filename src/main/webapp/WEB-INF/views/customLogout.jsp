<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<title>customLogout jsp 소스 코딩</title>
  <!-- page 737 소스코딩(시작) -->
<!-- Bootstrap Core CSS -->
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css"
   rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  <!-- page 737 소스코딩(끝) -->
</head>


<body>
  <!-- <h1>Logout Page</h1>
  
  <form method='post' action="/customLogout"> -->
  	<!-- Page633 아래 EL의 값은 실제 브라우저에서는 '_csrf'라는 이름으로 처리됩니다.-->
  <!-- page 737 소스코딩 할 때 아래 4줄 소스 주석처리(시작) -->
<%--     <input type="hidden" name="${_csrf.parameterName}"
    value="${_csrf.token}" />
    <button>로그아웃!!!</button>
  </form>
 --%>
 
 	<!-- page737 아래소스 코딩 시작 : 부트스트랩 테마의 로그인 페이지를 수정해서 custom-logout 페이지를 제작합니다 -->
 <div class="container">
      <div class="row">
         <div class="col-md-4 col-md-offset-4">
            <div class="login-panel panel panel-default">
               <div class="panel-heading">
                  <h3 class="panel-title">Logout Page</h3>
               </div>
               <div class="panel-body">
                  <form role="form" method='post' action="/customLogout">
                     <fieldset>
                        
                        <!-- Change this to a button or input when using this as a form -->
                        <a href="index.html" class="btn btn-lg btn-success btn-block">Logout</a>
                     </fieldset>
                     <input type="hidden" name="${_csrf.parameterName}"
                        value="${_csrf.token}" />
                  </form>
               </div>
            </div>
         </div>
      </div>
   </div>

   <!-- jQuery -->
   <script src="/resources/vendor/jquery/jquery.min.js"></script>

   <!-- Bootstrap Core JavaScript -->
   <script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

   <!-- Metis Menu Plugin JavaScript -->
   <script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

   <!-- Custom Theme JavaScript -->
   <script src="/resources/dist/js/sb-admin-2.js"></script>
   
   <script>
   
   $(".btn-success").on("click", function(e){
      
      e.preventDefault();
      $("form").submit();
      
   });
   
   </script>	
 <!-- 소스코딩 끝 -->
 
</body>
</html>
