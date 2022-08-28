<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css" />
<link rel="stylesheet" href="/resources/css/cards-gallery.css">
<link href="/resources/css/styles.css" rel="stylesheet" />
<link rel="icon" type="/resources/image/x-icon" href="assets/favicon.ico" />
		<!-- Favicon-->
        <link rel="icon" type="/resources/image/x-icon" href="assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="/resources/css/styles.css" rel="stylesheet" />
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> -->
</head>
 
<body>
    <!-- <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="/board/list">1팀마켓</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                       
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="../customLogin">로그인</a></li>
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="../joinForm">회원가입</a></li>
                    </ul>
                </div>
            </div>
        </nav> -->
       
         <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="/board/list">1팀마켓</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    
                    	<li class="nav-item"><a class="nav-link active" href="/board/register">등록</a></li>
                    
                    	<sec:authorize access="hasRole('ROLE_ADMIN')">
                        <li class="nav-item"><a class="nav-link active" aria-current="page"  href="../customLogout"><i class="fa fa-sign-out fa-fw"></i> 로그아웃 </a>
                        </sec:authorize> 
                        
                       <sec:authorize access="isAnonymous()">
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="../customLogin">로그인</a></li>
                         </sec:authorize> 
                         
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="../joinForm">회원가입</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        
        
        
        <!-- Page header with logo and tagline-->
        <header class="py-5 bg-light border-bottom mb-4">
            <div class="container">
                <div class="text-center my-5">
                    <h1 class="fw-bolder">1팀마켓에 오신걸 환영합니다!</h1>
                    <p class="lead mb-0"><!-- 조그만한 글씨 --></p>
                </div>
            </div>
        </header>
<%-- 
 <div class="container">
<div class="row">
<form>
<table class="table table-striped" style="text-align: center; border: 1px solid black">
<thead>
<tr>
<th style="text-align: center;">pno</th>
<th style="text-align: center;">title</th>
<th style="text-align: center;">pinfo</th>
<th style="text-align: center;">celler</th>
<th style="text-align: center;">regdate</th>
<th style="text-align: center;">updatedate</th>
<th style="text-align: center;">price</th>
<th style="text-align: center;">image</th>
</thead>
<tbody>
<c:forEach items="${list}" var="list">
<tr>
<td><c:out value="${list.pno}" /></td>
<td><c:out value="${list.title}" /></td>
<td><c:out value="${list.pinfo}" /></td>
<td><c:out value="${list.celler}" /></td>
<td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.regdate}" /></td>
<td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.updatedate}" /></td>
<td><c:out value="${list.price}" /></td>
<!-- <td class="image"> -->
<td>
<div class="image_wrap" data-bookid="${list.imageList[0].pno}" data-path="${list.imageList[0].uploadPath}" data-uuid="${list.imageList[0].uuid}" data-filename="${list.imageList[0].fileName}">
	<img>
</div>
</td>
</tr>
</c:forEach>
</tbody>
<tr>
<td colspan="7"><input type="button" value="글쓰기 " class="btn btn-primary pullright" onclick="javascript:location.href='/register'"></td>
</tr>
</table>
</form>
</div>
</div> 
 --%>
	<section class="gallery-block cards-gallery">
	    <div class="container">
	  
	        <div class="heading">
	         
	        </div>
	        <div class="row">
	        <c:forEach items="${list}" var="list">
	            <div class="col-md-6 col-lg-4">
	            
	                <div class="card border-0 transform-on-hover">
	                	<a class="lightbox" href='/board/get?pno=<c:out value="${list.pno}"/>'>
	                		<!-- <img src="/resources/image/nothing.jpg" alt="Card Image" class="card-img-top"> -->
	                		<div class="image_wrap" data-pno="${list.imageList[0].pno}" data-path="${list.imageList[0].uploadPath}" data-uuid="${list.imageList[0].uuid}" data-filename="${list.imageList[0].fileName}">
	<!-- <img> --><img alt="Card Image" class="card-img-top">
</div>
	                		
	                	</a>
	                    <div class="card-body">
	                        <h6><a href="#"><c:out value="${list.title}" /></a></h6>
	                        <p class="text-muted card-text"><c:out value="${list.pinfo}" /></p>
	                        <p class="text-muted card-text"><b><c:out value="${list.price}원" /></b></p>
	                    </div>
	                </div>
	            </div>
	           
	            </c:forEach>
	        </div>
	    </div>
    </section>
  
	<script type="text/javascript">
	$(".image_wrap").each(function(i, obj){
		
		const bobj = $(obj);
		
		 if(bobj.data("pno")){ 
			
		const uploadPath = bobj.data("path");
		const uuid = bobj.data("uuid");
		const fileName = bobj.data("filename");
		
		const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
		
		$(this).find("img").attr('src', '/display?fileName=' + fileCallPath);
		} else{
			$(this).find("img").attr('src', '/resources/image/nothing.jpg');
		} 
		
	});
	
	</script>
	 <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="/resources/js/scripts.js"></script>
</body>
</html>