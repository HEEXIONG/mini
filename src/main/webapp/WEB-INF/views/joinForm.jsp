<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('POST_NUM').value = data.zonecode;
				document.getElementById("ADDRESS").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("DT_ADDRESS").focus();
			}
		}).open();
	}
</script>
</head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

  <style>
    body {
      min-height: 100vh;

      background: -webkit-gradient(linear, left bottom, right top, from(#92b5db), to(#1d466c));
      background: -webkit-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: -moz-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: -o-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%);
    }

    .input-form {
      max-width: 680px;
      margin-top: 80px;
      padding: 32px;
      background: #fff;
      -webkit-border-radius: 10px;
      -moz-border-radius: 10px;
      border-radius: 10px;
      -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
    }
  </style>
<body>

 <div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3">회원가입</h4>
        <form class="validation-form" novalidate action="/joinForm" method="post"">
          <div class="row">
            <div class="col-md-6 mb-3">
              <label for="name">아이디</label>
              <input type="text" class="form-control" id="name" name="userid" placeholder="아이디" required>
              <div class="invalid-feedback">
              아이디를 입력해주세요.
              </div>
            </div>
            <div class="col-md-6 mb-3">
              <label for="nickname">패스워드</label>
              <input type="password" class="form-control"  id="nickname" name="userpw" placeholder="패스워드"  required>
              <div class="invalid-feedback">
                패스워드를 입력해 주세요
              </div>
            </div>
          </div>

          <div class="mb-3">
            <label for="email">이메일</label>
            <input type="email" class="form-control" id="email" name="EMAIL" placeholder="you@example.com" required>
            <div class="invalid-feedback">
              이메일을 입력해주세요.
            </div>
          </div>
          
          <div class="mb-3">
            <label for="email">이름</label>
            <input type="email" class="form-control" id="email" name="NAME" placeholder="" required>
            <div class="invalid-feedback">
             이름을 입력해 주세요.
            </div>
          </div>

          <div class="mb-3">
            <label for="email">생년월일</label>
            <input type="email" class="form-control" id="email" name="BIRTH" placeholder="941201" required>
            <div class="invalid-feedback">
             생년월일을 입력해 주세요.
            </div>
          </div>

          <div class="mb-3">
            <label for="address">전화번호 앞자리</label>
            <input type="text" class="form-control" id="address" name="PHONE_CD" placeholder="010" required>
            <div class="invalid-feedback">
              전화번호를 입력해주세요.
            </div>
          </div>

          <div class="mb-3">
            <label for="address">전화번호 뒷자리</label>
            <input type="text" class="form-control" id="address" name="PHONE_NUM" placeholder="1234-5678" required>
            <div class="invalid-feedback">
              전화번호를 입력해주세요.
            </div>
          </div>

          <div class="mb-3">
            <label for="address">우편번호</label>
            <input type="text" class="form-control" id="POST_NUM" name="POST_NUM" placeholder="우편번호" required readonly="readonly"> <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
            <div class="invalid-feedback">
             우편번호를 입력해 주세요.
            </div>
          </div>
          <div class="mb-3">
            <label for="address">주소</label>
            <input type="text" class="form-control" id="ADDRESS" name="ADDRESS" placeholder="주소" required readonly="readonly">
            <div class="invalid-feedback">
              주소를 입력해주세요.
            </div>
          </div>
          <div class="mb-3">
            <label for="address2">상세주소<span class="text-muted">&nbsp;(필수 아님)</span></label>
            <input type="text" class="form-control" id="DT_ADDRESS" name="DT_ADDRESS" placeholder="상세주소를 입력해주세요.">
          </div>
            </div>
            <input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
          </div>
          <hr class="mb-4">
          <div class="custom-control custom-checkbox">
            <input type="checkbox" class="custom-control-input" id="aggrement" required>
            <label class="custom-control-label" for="aggrement">개인정보 수집 및 이용에 동의합니다.</label>
          </div>
           <div class="mb-4">
          <button class="btn btn-primary btn-lg btn-block" type="submit" onclick="location.href='customLogiln.jsp'">가입 완료</button>
          </div>
       <div class="mb-4">
          <button class="btn btn-info btn-lg btn-block" type="reset" onclick="location.href='board/list'">취소</button>
          </div>
        </form>
      </div>
    </div>
    <footer class="my-3 text-center text-small">
      <p class="mb-1">&copy; 2021 YD</p>
    </footer>
  </div>
  


</body>
</html>