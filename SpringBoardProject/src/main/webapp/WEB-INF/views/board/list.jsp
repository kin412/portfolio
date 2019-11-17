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
	<title>list</title>
</head>
<body>
	<div align="center">list</div>
	<table align="center">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>수정일</th>
			</tr>
		</thead>
		<c:forEach items="${list}" var="board">
			<tr>
				<td><c:out value="${board.bno}"/></td>
				<td><c:out value="${board.title}"/></td>
				<td><c:out value="${board.writer}"/></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" 
				value="${board.regdate}"/></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" 
				value="${board.updateDate}"/></td>
			</tr>
		</c:forEach>
	</table>
	
	<button id='regBtn' type="button" class="btn btn-xs pull-right">
		글등록
	</button>
	
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">Modal title</h4>
				</div>
				<div class="modal-body">처리가 완료되었습니다.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default"
						data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save
						changes</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	
	<script type="text/javascript">
		$(document).ready(function(){
			var result='<c:out value="${result}"/>';
			checkModal(result);
			
			function checkModal(result){
				if(result===''){
					return;
				}
				if(parseInt(result)>0){
					$(".modal-body").html("게시글" + parseInt(result) + "번이 등록 되었습니다.");
				}
				$("#myModal").modal("show");
			}
			
			$("#regBtn").on("click", function(){
				self.location = "/board/register";
			});
		});
	</script>
</body>
</html>