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
								<div class="form-group" id="idCheck">
								<!-- <button type="button" id="idCheck" value="중복체크"></button> -->
								</div>
								<div class="form-group">
									<input class="form-control" id="userpw" placeholder="비밀번호"
										name="userpw" type="password" value="">
								</div>
								<div class="form-group">
									<input class="form-control" id="userName" placeholder="닉네임"
										name="userName" type="text" value="">
								</div>
								<input type="submit" id="submit" class="btn btn-lg btn-success btn-block" value="회원가입">
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
		var id=0;
		var pw=0;
		var nick=0;
		var csrfHeaderName="${_csrf.headerName}";
		var csrfTokenValue="${_csrf.token}";
		$("#submit").attr("disabled", true);
		
		
		$(function(){
		$("#userName").blur(function(){
			if(!$("#userName").val()){
				nick=0;
				console.log("nick:"+nick);
				$("#submit").attr("disabled", true);
			}else{
				nick=1;
				console.log("nick:"+nick);
				idCheck=id+pw+nick;
				console.log("idCheck:" + idCheck);
				if(idCheck==3){
					$("#submit").attr("disabled", false);
				}
			}
		});	
			
		$("#userpw").blur(function(){
			if(!$("#userpw").val()){
				pw=0;
				console.log("pw:"+pw);
				$("#submit").attr("disabled", true);
			}else{
				pw=1;
				console.log("pw:"+pw);
				idCheck=id+pw+nick;
				console.log("idCheck:" + idCheck);
				if(idCheck==3){
					$("#submit").attr("disabled", false);
				}
			}
		});
			
		$("#userid").blur(function(){
			var userid = $("#userid").val();
			if(!$("#userid").val()){
				$("#idCheck").text("아이디를 입력하세요.");
				$("#idCheck").css("color", "red");
				id=0;
				console.log("id:"+id);
				$("#submit").attr("disabled", true);
			}
			console.log(userid);
			$.ajax({
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				type : 'POST',
				data : userid,
				url : '/idcheck',
				dataType : 'json',
				success : function(data){
					console.log("ajax success");
					console.log(data);
					console.log("data : " + data);
					if(data > 0){
						$("#idCheck").text("사용중인 아이디 입니다.");
						$("#idCheck").css("color", "red");
						id=0;
						console.log("id:"+id);
						$("#submit").attr("disabled", true);
						
					}else{
						$("#idCheck").text("사용 가능한 아이디 입니다.");
						$("#idCheck").css("color", "green");
						id=1;
						console.log("id:"+id);
						idCheck=id+pw+nick;
						console.log("idCheck:" + idCheck);
						if(idCheck==3){
							$("#submit").attr("disabled", false);
						}
					}
				},
				error : function(){
					console.log("ajax 에러");
					
				}
			});
		});
		});
	</script>
</body>
</html>