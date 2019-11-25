<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="login-panel panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">회원가입</h3>
					</div>
					<div class="panel-body">
						<form role="form" method='post' action="/signUp">
							<fieldset>
								<div class="form-group">
									<input class="form-control" id="userid" placeholder="아이디"
										name="userid" type="text" autofocus>
									
								</div>
								<div class="form-group">
								<button id="idCheck" value="중복체크"></button>
								</div>
								<div class="form-group">
									<input class="form-control" placeholder="비밀번호"
										name="userpw" type="password" value="">
								</div>
								<div class="form-group">
									<input class="form-control" placeholder="닉네임"
										name="userName" type="text" value="">
								</div>
								<input type="submit" class="btn btn-lg btn-success btn-block" value="회원가입">
							</fieldset>
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		var idCheck = 0;
		$(function(){
		$("#idCheck").click(function(){
			var userid = $("#userid").val();
			
			$.ajax({
				type : 'POST',
				data : userid,
				url : "${pageContext.request.contextPath}/idcheck",
				success : function(data){
					console.log("ajax success");
					if(data.cnt > 0){
						alert("아이디가 존재합니다. 다른 아이디를 입력해주세요.");
					}else{
						alert("사용가능한 아이디 입니다 ^0^");
					}
				},
				error : function(){
					console.log("실패");
				}
			});
		});
		});
	</script>
</body>
</html>