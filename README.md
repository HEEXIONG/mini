# README
1. 컴파일 실행 환경 = JAVA JDK 1.8, ORACLE 11g, TOMCAT 9.0 , STS

2. 적용 기술 = Spring MVC, Mybatis, JAVA, JSP, HTML, CSS, BootStrap, Jquery(AJAX, JSON) , OracleDB

3. Oracle 11g에 권한 부여

--상품 테이블

CREATE SEQUENCE pd_SEQ;

create table pd_board (

pno number(10, 0),                      -- 상품 번호

title varchar2(200) not null,           -- 상품 명

pinfo varchar2(2000) not null,          -- 상품 정보

celler varchar2(50) not null,           -- 판매자

regdate date default sysdate,           -- 등록일자

updatedate date default sysdate,        -- 수정일자

price int not null,                      -- 가격 price

CONSTRAINT  pd_board PRIMARY KEY(pno)

);

--상품 이미지 테이블

create table pd_image(

pno NUMBER(10,0) ,

fileName varchar2(100) not null,

uploadPath varchar2(200) not null,

uuid varchar2(100)not null ,

primary key (uuid),

foreign key (pno) references pd_board(pno)

);

--회원가입 테이블

CREATE SEQUENCE USER_SEQ;

CREATE TABLE TB_USER(

userid VARCHAR2(100) not null primary key,                   -- 아이디

userpw VARCHAR2(100),                   -- 패스워드

USER_CODE VARCHAR2(100),             -- 유저코드

EMAIL VARCHAR2(100),                      -- 이메일

NAME VARCHAR2(100),                       -- 이름

BIRTH VARCHAR2(100),                      -- 생일

PHONE_CD VARCHAR2(100),                    -- 전화번호앞자리 코드

PHONE_NUM VARCHAR2(100),                  -- 전화번호뒷자리

POST_NUM VARCHAR2(100),                   -- 우편번호

ADDRESS VARCHAR2(100),                   -- 주소

DT_ADDRESS VARCHAR2(100)     -- 상세주소 

enabled char(1) default '1'

); 

--시큐리티 권한 테이블

create table tbl_user_auth(

userid varchar(50) not null,

auth varchar2(50) varchar2(50) default 'ROLE_ADMIN',

constraint fk_user_auth foreign key(userid) REFERENCES tb_user(userid)

);

--카드결제 테이블

create table pay_import(

pay_id varchar2(50) not null primary key,

import_id varchar2(50),

pay_amount int,

per_num varchar2(50),

per_time date

);

create sequence idx_seq

minvalue 1

maxvalue 999999

start with 1

increment by 1

cache 20;

4. 
