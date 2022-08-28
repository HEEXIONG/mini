<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin 2 - Bootstrap Admin Theme</title>

<link href="/resources/css/login.css" rel="stylesheet">



<!-- Custom Fonts -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

<main class="main">
  <div class="container">
    <section class="wrapper">
      <div class="heading">
        <h1 class="text text-large">로그인</h1>
      </div>
      <form name="signin" class="form login-form" action="/login" method='post'>
        <div class="input-control">
        <label for="text" class="input-label" hidden>Email Address</label>
          <input type="text" name="username" class="input-field" placeholder="userid" autofocus>
        </div>
        
        <div class="input-control">
         <label for="password" class="input-label" hidden>Password</label>
          <input type="password" name="password"  class="input-field" placeholder="Password">
          
        </div>
        <div class="checkbox">
									<label> <input name="remember-me" type="checkbox">Remember
										Me
									</label>
								</div>
        
        <div class="input-control">
          <button class="input-submit btn-success" onClick="javascript.location='/board/list';">
          	로그인
          </button>
          <button class="input-submit btn-success" onClick="javascript.location='/board/list';">
          	취소
          </button>
        </div>
        <input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
      </form>
      <div class="striped">
        <span class="striped-line"></span>
        <span class="striped-text">Or</span>
        <span class="striped-line"></span>
      </div>
      <div class="method">
        <div class="method-control">
          <a href="#" class="method-action">
             <i class="ion ion-logo-facebook"><img src="/resources/img/google.png"></i>
            <span>Sign in with Google</span>
          </a>
        </div>
        <div class="method-control">
          <a href="#" class="method-action">
            <i class="ion ion-logo-facebook"><img src="/resources/img/facebook.png"></i>
            <span>Sign in with Facebook</span>
          </a>
        </div>
        
      </div>
    </section>
  </div>
</main>
	


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
  
<c:if test="${param.logout != null}">
      <script>
      $(document).ready(function(){
      	alert("로그아웃하였습니다.");
      });
      
      </script>
</c:if>  

</body>

</html>
