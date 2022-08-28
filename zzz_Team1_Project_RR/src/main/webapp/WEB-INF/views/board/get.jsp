<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Blog Home - Start Bootstrap Template</title>
        <script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<script>
	function fn_buy() {
		var IMP = window.IMP;
		IMP.init("imp23866008"); // Insert your Code 부분에 자신의 아임포트 "가맹점 식별코드" 입력 바랍니다.
		IMP.request_pay({
			pg : "html5_inicis",
			pay_method : "card",
			merchant_uid : 'merchant_' + new Date().getTime(),
			name : "Snack",
			amount : 10,
			buyer_email : "hidden1477@naver.com",  // buyer_email도 수정하기 바랍니다.
			buyer_name : "장나라",
			buyer_tel : "010-1234-5678",
			buyer_addr : "서울특별시 강남구 역삼동",
			buyer_postcode : "11111",
			m_redirect_url : "/paymentDone.do"
		}, function(rsp) {
			if (rsp.success) {
				var paymentInfo = {
						imp_uid : rsp.imp_uid,
						merchant_uid : rsp.merchant_uid,
						paid_amount : rsp.paid_amount,
						apply_num : rsp.apply_num,
						paid_at : new Date()
					};
				$.ajax({
					url : "/iamport/paymentProcess.do",
					method : "POST",
					contentType : "application/json",
					data : JSON.stringify(paymentInfo), 
					success:function (data,textStatus){
				    	 console.log(paymentInfo);
				    	 location.href = "/iamport/paymentDone.do";
				     },
					error : function(e) {
						console.log(e);
					}
				})
			} else {
				alert("결제 실패 : " + rsp.error_msg);
			}
		});
	}
</script>
        <style type="text/css">
	#result_card img{
		max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	}
</style>
        <!-- Favicon-->
        <script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
        <link rel="icon" type="/resources/image/x-icon" href="assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="/resources/css/styles.css" rel="stylesheet" />
    </head>
    <body>
        <!-- Responsive navbar-->
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
        <!-- Page content-->
        <div class="container">
            <div class="row">
                <!-- Blog entries-->
                <div class="col-lg-8">
                    <!-- Featured blog post-->
                    <div class="card mb-4">
                    			<div class="form_section">
                    			<div class="form_section_title">
                    				
                    			</div>
                    			<div class="form_section_content">

									<div id="uploadReslut">
																		
									</div>
                    			</div>
                    		</div>
                       <!-- <a href="#!"><img class="card-img-top" src="https://dummyimage.com/850x350/dee2e6/6c757d.jpg" alt="..." /></a> --> 
                        <div class="card-body">
                            <div class="small text-muted"><fmt:formatDate pattern="yyyy-MM-dd"
									value="${board.regdate}" /></div>
                            <h2 class="card-title"><input type="text" name="title" readonly="readonly" value="${board.title}"></h2>
                            
                            <input type="text" name="pinfo" readonly="readonly" value="${board.pinfo}">
                            
                        </div>
                    </div>
                    <!-- Nested row for non-featured blog posts-->
                    
                    <!-- Pagination-->
                </div>
                <!-- Side widgets-->
                <div class="col-lg-4">
                    <!-- Search widget-->
                    <div class="card mb-4">
                        <div class="card-header">글번호 : <input type="text" name="title" readonly="readonly" value="${board.pno}"></div>
                       
                    </div>
                    <!-- Categories widget-->
                    <div class="card mb-4">
                        <div class="card-header">판매자 : <input type="text" name="celler" readonly="readonly" value="${board.celler}"> </div>
                       
                    </div>
                    <!-- Side widget-->
                    <div class="card mb-4">
                        <div class="card-header">가격 : <input type="number" name="price" readonly="readonly" value="${board.price}"></div>
                    </div>
                    
                    <div class="card mb-4">
                        <div class="card-header"><button type="button" onclick="fn_buy()">결제하기</button></div>
                    </div>
                    
                    <sec:authentication property="principal" var="pinfo"/>
				        <sec:authorize access="isAuthenticated()">
				        <c:if test="${pinfo.username eq board.celler}">
				        <button data-oper='modify' class="btn btn-default">Modify</button>
				        </c:if>
				     </sec:authorize>
                    
                    
                </div>
            </div>
        </div>
        						<div class="form_section">
                    			<div class="form_section_title">
                    				
                    			</div>
                    			<div class="form_section_content">

									<div id="uploadReslut">
																		
									</div>
                    			</div>
                    		</div>
     
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2022</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="/resources/js/scripts.js"></script>
        
      
        <script>
        $(document).ready(function(){
        
       // var pno = '<c:out value="${board.pno}"/>';
        var pno = '${board.pno}';
		let uploadReslut = $("#uploadReslut");			
		
		$.getJSON("/getAttachList", {pno : pno}, function(arr){	
			
			if(arr.length === 0){	
				
				let str = "";
				str += "<div id='result_card'>";
				str += "<img src='/resources/image/nothing.jpg'>";
				str += "</div>";
				
				uploadReslut.html(str);						
				
				return;
			}				
			
			let str = "";
			let obj = arr[0];	
			
			let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
			str += "<div id='result_card'";
			str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
			str += ">";
			str += "<img src='/display?fileName=" + fileCallPath +"'>";
			str += "</div>";		
			
			uploadReslut.html(str);						
			
		});					
		
		
	}); // $(document).ready
        </script>
   
    </body>
</html>

</html>