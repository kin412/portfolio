<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="/resources/css/customLogin.css">
<meta charset="UTF-8">
<title>login</title>
</head>
<body>

	<div class="container constyle">
		<div class="row" >
			<div class="col-md-4 col-md-offset-4" >
				<div class="login-panel panel panel-default ">
					<div class="panel-heading text-center ">
						<h3 class="panel-title">로그인</h3>
					</div>
					<div class="panel-body">
						<form role="form" method='post' action="/login">
							<fieldset>
								<div class="form-group">
									<input class="form-control" placeholder="아이디"
										name="username" type="text" autofocus>
								</div>
								<div class="form-group">
									<input class="form-control" placeholder="비밀번호"
										name="password" type="password" value="">
								</div>
								<div class="checkbox">
									<label> <input name="remember-me" type="checkbox">자동 로그인
									</label>
								</div>
								<!-- Change this to a button or input when using this as a form -->
								<!-- <a href="index.html" class="btn btn-lg btn-success btn-block">Login</a> -->
								<input type="submit" class="shadow btn btn-lg btn-success btn-block login" value="로그인">
							</fieldset>
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</form>
						<button class="btn btn-lg btn-success btn-block" 
						onclick="location.href='/signUp'">회원 가입</button>
					</div>
				</div>
			</div>
		</div>
	</div>
  <script>
  $(".login").on("click", function(e){
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
<c:if test="${result != null}">
      <script>
	      $(document).ready(function(){
	      	alert("회원가입 되었습니다. 로그인 해주세요.");
	      });
      </script>
</c:if>

</body>
</html>