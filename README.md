# README

> ## 컴파일 실행 환경 
JAVA JDK 1.8, ORACLE 11g, TOMCAT 9.0 , STS
> ## 적용 기술 
Spring MVC, Mybatis, JAVA, JSP, HTML, CSS, BootStrap, Jquery(AJAX, JSON) , OracleDB

> ## 회원가입 및 로그인 시큐리티
> DB모델링
![image](https://user-images.githubusercontent.com/101411257/190603345-6e033d96-372c-4fc6-be2e-5d5da633baa6.png)

> ## 시큐리티 구현 화면
로그인을 한 사용자만 상품등록이 가능함.
~~~jsp
<input class="form-control" name='celler' value='<sec:authentication property="principal.username"/>' readonly="readonly" >
~~~
![ezgif com-gif-maker](https://user-images.githubusercontent.com/101411257/190599580-7be93285-9f99-42f6-9057-18991c4aa51a.gif)

![ezgif com-gif-maker (1)](https://user-images.githubusercontent.com/101411257/190605749-261716ad-952a-4800-ba92-620f27a8660e.gif)


 security-context.xml을 추가해 구현했습니다.

~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:security="http://www.springframework.org/schema/security"
	xsi:schemaLocation="http://www.springframework.org/schema/security http://www.springframework.org/schema/security/spring-security.xsd
		http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">
	<bean id="customAccessDenied" class="org.zerock.security.CustomAccessDeniedHandler"></bean> 
	<bean id="customLoginSuccess" class="org.zerock.security.CustomLoginSuccessHandler"></bean> 
	<bean id="bcryptPasswordEncoder" class="org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder" />
	<bean id="CustomUserDetailsService" class="org.zerock.security.CustomUserDetailsService"></bean>
	<security:http>
		<security:form-login login-page="/customLogin" />
		<security:logout logout-url="/customLogout" invalidate-session="true" />
		 <security:access-denied-handler ref="customAccessDenied" />
		<security:logout logout-url="/customLogout" invalidate-session="true" />
	</security:http>
</beans>
~~~
> ## Bycrpt를 이용하여 사용자 비밀번호 암호화
``` c
	<security:authentication-manager> 
			<security:authentication-provider user-service-ref="CustomUserDetailsService"> 
			<security:password-encoder ref="bcryptPasswordEncoder" /> 
		</security:authentication-provider> 
	</security:authentication-manager>
```
![image](https://user-images.githubusercontent.com/101411257/190597441-a0491358-78ef-46a9-b450-da6890e95c96.png)

