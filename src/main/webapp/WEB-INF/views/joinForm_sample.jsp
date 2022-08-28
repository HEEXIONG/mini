<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>


<body>

 <form action="/joinForm" method="post">
 
아이디<input type="text" name="userid"><br>
비밀번호<input type="text" name="userpw"><br>
유저코드<input type="text" name="USER_CODE"><br>
이메일<input type="text" name="EMAIL"><br>
이름<input type="text" name="NAME"><br>
생일<input type="text" name="BIRTH"><br>
전화<input type="text" name="PHONE_CD"><br>
전화<input type="text" name="PHONE_NUM"><br>
우편<input type="text" name="POST_NUM"><br>
주소<input type="text" name="ADDRESS"><br>
상세<input type="text" name="DT_ADDRESS"><br>
<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
<input type="submit">
</form>

</body>
</html>