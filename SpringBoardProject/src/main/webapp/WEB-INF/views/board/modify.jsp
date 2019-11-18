<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	<title>modify form</title>
</head>
<body>
	
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Board modify</h1>
		</div>
	</div>
	<form role="form" action="/board/modify" method="post">
		<div class="panel-body">
			<div class="form-group">
				<label>글번호</label>
				<input class="form-control" name='bno'
				value='<c:out value="${board.bno}"/>' readonly="readonly">
			</div>
			<div class="form-group">
				<label>제목</label>
				<input class="form-control" name='title'
				value='<c:out value="${board.title}"/>'>
			</div>
			<div class="form-group">
				<label>내용</label>
				<textarea class="form-control" rows="3" name='content'>
				 <c:out value="${board.content }"/></textarea>
			</div>
			<div class="form-group">
				<label>작성자</label>
				<input class="form-control" name='writer'
				value='<c:out value="${board.writer}"/>' readonly="readonly">
			</div>
			<div class="form-group">
				<label>작성일</label>
				<input class="form-control" name='regDate'
				value='<fmt:formatDate pattern="yyyy/MM/dd"
				value="${board.regdate}"/>' readonly="readonly">
			</div>
			<div class="form-group">
				<label>수정일</label>
				<input class="form-control" name='updateDate'
				value='<fmt:formatDate pattern="yyyy/MM/dd"
				value="${board.updateDate}"/>' readonly="readonly">
			</div>
			<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
			<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
			<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
			<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
			<button type='submit' data-oper='modify' class="btn btn-default">글 수정</button>
			<button type='submit' data-oper='remove' class="btn btn-default">글 삭제</button>
			<button type='submit' data-oper='list' class="btn btn-default">글 목록</button>
		</div>
	</form>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $('form');
			$('button').on("click", function(e){
				e.preventDefault();
				var operation = $(this).data("oper");
				console.log(operation);
				
				if(operation === 'remove'){
					formObj.attr("action", "/board/remove");
				}else if(operation === 'list'){
					formObj.attr("action", "/board/list").attr("method","get");
					var pageNumTag = $("input[name='pageNum']").clone();
					var amountTag = $("input[name='amount']").clone();
					var keywordTag = $("input[name='keyword']").clone();
					var typeTag = $("input[name='type']").clone();
					formObj.empty;
					formObj.append(pageNumTag);
					formObj.append(amountTag);
					formObj.append(keywordTag);
					formObj.append(typeTag);
				}
				formObj.submit();
			});
		});
	</script>
	
</body>
</html>