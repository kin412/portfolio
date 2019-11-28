# portfolio - spring_board_project

## 목차
#### 1. 개발목적
#### 2. 개발환경
#### 3. 개발일정
#### 4. 프로젝트 구조
#### 5. DB 모델링
#### 6. 기능별 주요 로직
#### 7. 추가해야 할 부분
#### 8. 스프링으로 진행하며 느낀 점
#### 9. 진행하면서 만났던 에러

------------------------------------------------------------------------------------------------------------------------------------------

## 1. 개발목적
- 신입으로써 필수적인 기본기 연습. &nbsp;

------------------------------------------------------------------------------------------------------------------------------------------

## 2. 개발환경
>front-end
- bootstrap 3.3.2
- jquery 3.3.1

>back-end
- openJDK 1.8
- spring 5.0.7 (spring tool suite 3)
- lombok 1.18
- oracle 18c
- mybatis 3.4.6
- tomcat 9.0
- maven 3.6

------------------------------------------------------------------------------------------------------------------------------------------

## 3. 개발일정 (2019.11.16 ~ 2019.11.28)
- 11.16 spring mvc 기본 환경설정 (lombok, oracle, mybatis)
- 11.17 DB Modeling, mybatis를 이용한 boardService,boardController CRUD 구현, 글목록 및 글작성 view 구현
- 11.18 글조회, 수정, 삭제 view 구현, 글목록 페이징처리 및 view 이동에 따른 페이징 유지 처리
- 11.19 ajax 댓글 CRUD 구현
- 11.20 ajax 첨부파일 CRUD 구현 
- 11.21 spring security 모듈 구현 및 테스트
- 11.22 spring security 적용
- 11.25 spring security 로그인 및 회원가입 구현
- 11.26 회원가입 중복체크 ajax 구현
- 11.27 bootstrap ui 정리
- github 포트폴리오 소개(readme.md) 작성

------------------------------------------------------------------------------------------------------------------------------------------

## 4. 프로젝트 구조
<div>
  <img src="https://user-images.githubusercontent.com/19407579/69785612-d66aac00-11fb-11ea-8a22-81bba6fdd174.PNG">
  <img src="https://user-images.githubusercontent.com/19407579/69785615-d8cd0600-11fb-11ea-8b3f-e077acaeb2a4.PNG" align="top">
  <img src="https://user-images.githubusercontent.com/19407579/69785622-db2f6000-11fb-11ea-9cae-00a49abd0f64.PNG" align="top">
</div>

------------------------------------------------------------------------------------------------------------------------------------------

## 5. DB 모델링
<div>
  <img src="https://user-images.githubusercontent.com/19407579/69786233-59d8cd00-11fd-11ea-8faa-b5b676c5aeec.PNG">
</div>

------------------------------------------------------------------------------------------------------------------------------------------

## 6. 기능별 주요 로직
> 회원가입, 로그인, 로그아웃
- security 와 handler를 이용해 처리
&nbsp; customLogin.jsp, customLogout - hidden속성으로 csrf토큰 사용.
~~~
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
~~~
