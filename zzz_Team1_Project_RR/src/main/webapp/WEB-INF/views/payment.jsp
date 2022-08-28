<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제하기</title>
<!-- jQuery -->
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
</head>
<body>
	<button type="button" onclick="fn_buy()">결제하기</button>
	<br><br>
	<a href="goMain.do">[처음으로]</a>
</body>
</html>