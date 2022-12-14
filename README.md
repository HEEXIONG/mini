# README

# 개발목적

- 처음하는 팀 프로젝트로서 SpringMVC의 MVC숙달
- 처음하는 팀 프로젝트로서 깃 협업&숙달

------------------------------------------------------------------------------------------------------------------------------------------

# 개발환경
>front-end
- bootstrap 
- jquery 

>back-end
- Java
- spring
- lombok 
- oracle DB
- mybatis 
- tomcat
- maven 


> ## 컴파일 실행 환경 
JAVA JDK 1.8, ORACLE 11g, TOMCAT 9.0 , STS


> ## 로그인 시큐리티
> DB모델링
![image](https://user-images.githubusercontent.com/101411257/190603345-6e033d96-372c-4fc6-be2e-5d5da633baa6.png)

> ## 시큐리티 구현 화면
로그인을 한 사용자만 상품등록이 가능함.
JSTL 태그 라이브러리로
~~~jsp
 <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
~~~
id에 권한을 주어 로그인을 한 사용자만이 글을 등록 할 수 있음.
~~~jsp
<input class="form-control" name='celler' value='<sec:authentication property="principal.username"/>' readonly="readonly" >
~~~
> 로그인을 하지 않은 유저는 글등록을 누르면 바로 로그인창으로 들어가짐

![ezgif com-gif-maker](https://user-images.githubusercontent.com/101411257/191140594-cdcd61e7-e704-4fbf-9a85-44f8d2793dc6.gif)

> 로그인 후 글등록 가능

![ezgif com-gif-maker (1)](https://user-images.githubusercontent.com/101411257/191140706-d941ebcf-2cc4-4117-ada1-527c81525d9c.gif)

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

> ## 회원가입
> 회원가입 서비스 주입으로 컨트롤러 작성
> BCryptPasswordEncoder 주입으로 회원가입시 비밀번호 암호화함
~~~java
@Setter(onMethod_ = @Autowired)
private singupService signupService;
@Setter(onMethod_ = @Autowired)
BCryptPasswordEncoder pwdEncoder;		
		@GetMapping(value = "/joinForm")
		public void signupGET() {
			
		}
		 @PostMapping(value = "/joinForm")
		 public String signupPOST(MemberVO memVo) throws Exception {
		 
			 String rawPW ="";
			 String encodePW="";
			 
			 rawPW = memVo.getUserpw();
			 encodePW = pwdEncoder.encode(rawPW);
			 memVo.setUserpw(encodePW);
		  signupService.insertMember(memVo);
~~~

> ## 회원가입 화면구현
![ezgif com-gif-maker (2)](https://user-images.githubusercontent.com/101411257/191141931-58ad33eb-1cd3-498f-b86e-cf26fc4b24bf.gif)

# 스프링으로 진행하며 느낀점
- jsp model2 mvc에 비해 의존성 주입을 활용한 어노테이션으로 객체 자동 생성이 편하다.
- jsp model2 mvc에서 요청한 URL을 잘라서 String 변수command 를 통해  요청을 해결하는 것보다 @requestmapping 혹은
@postmapping, @getmapping 한방으로 끝나는 요청 분기 나누는게 편하다.
- jsp model2 mvc의 preparedStatment 에 비해 월등히 편한 mybatis
- junit의 단위테스트의 편리함. 꼭 실행화면에서 안해도 된다. was를 사용하지 않아도 되서 실행시간을 엄청 절감 할 수 있다.
일반 main메소드에서 테스트를 한다고하면 해당 클래스를 만들고 메소드를 호출해야하는 번거로움 있다.
그냥 junit 테스트코드에서 단위테스트하면 여러 메소드가 바로 이루어지고 junit탭에 정리가 되어서 나와 에러가 뜨면 바로바로 잡을수 있어서 좋았음.
기능별로 하나의 단위테스트 모듈을 만들어 두면 두고두고 써먹을 수 있을 것 같다.
- 권한에 따른 흐름제어를 spring security를 통해 쉽게 제어할 수 있다.
- lombok을 통해 setter, getter, tostring 작성을 생략 가능해 편하다.
