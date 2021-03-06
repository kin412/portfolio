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
    <link rel="stylesheet" href="/resources/css/list.css">
	<meta charset="UTF-8">
	<title>list</title>
</head>
<body>
	<div class="logout">
		<jsp:include page="/WEB-INF/views/header.jsp"/>
	</div>
	<div class="free" align="center">자유 게시판</div>
	<div class="regB">
		<button id='regBtn' type="button" class="btn btn-xs btn-info">
			글등록
		</button>
	</div>
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
				<td class="title"><a class='move' href='<c:out value="${board.bno}"/>'>
				<c:out value="${board.title}"/></a></td>
				<td><c:out value="${board.writer}"/></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" 
				value="${board.regdate}"/></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" 
				value="${board.updateDate}"/></td>
			</tr>
		</c:forEach>
	</table>
	
	<div align="center">
		<ul class="pagination">
			<c:if test="${pageMaker.prev}">
				<li class="paginate_button previous"><a href="${pageMaker.startPage -1}">이전</a></li>
			</c:if>
			<c:forEach var="num" begin="${pageMaker.startPage}"
			end="${pageMaker.endPage}">
			<li class = "paginate_button ${pageMaker.cri.pageNum == num ? "active":"" }">
			<a href="${num}">${num}</a></li>
			</c:forEach>
			<c:if test="${pageMaker.next}">
				<li class="paginate_button next"><a href="${pageMaker.endPage +1}">다음</a></li>
			</c:if>
		</ul>
	</div>
	
	<div class='row' align="center">
		<div class="col-lg-12">
			<form id='searchForm' action="/board/list" method='get'>
				<select name='type'>
					<option value=""
						<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
					<option value="T"
						<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
					<option value="C"
						<c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
					<option value="W"
						<c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
					<option value="TC"
						<c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목
						or 내용</option>
					<option value="TW"
						<c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목
						or 작성자</option>
					<option value="TWC"
						<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목
						or 내용 or 작성자</option>
				</select> <input type='text' name='keyword'
					value='<c:out value="${pageMaker.cri.keyword}"/>' /> <input
					type='hidden' name='pageNum'
					value='<c:out value="${pageMaker.cri.pageNum}"/>' /> <input
					type='hidden' name='amount'
					value='<c:out value="${pageMaker.cri.amount}"/>' />
				<button class='btn btn-default'>검색</button>
			</form>
		</div>
	</div>
	<form id='actionForm' action="/board/list" method='get'>
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
		<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
		<input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type }"/>'>
		<input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword }"/>'>
	</form>
	
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">알림</h4>
				</div>
				<div class="modal-body">작성한 글이 등록 되었습니다.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default"
						data-dismiss="modal">닫기</button>
					<!-- <button type="button" class="btn btn-primary">Save
						changes</button> -->
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
			
			history.replaceState({},null,null);
			
			function checkModal(result){
				if(result==='' || history.state){
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
			
			var actionForm = $("#actionForm");
			$(".paginate_button a").on("click", function(e){
				e.preventDefault();
				console.log('click');
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionForm.submit();
			});
			
			$(".move").on("click", function(e){
				e.preventDefault();
				actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
				actionForm.attr("action","/board/get");
				actionForm.submit();
			});
			
			var searchForm = $("#searchForm");

			$("#searchForm button").on("click", function(e) {
				if (!searchForm.find("option:selected").val()) {
					alert("검색종류를 선택하세요");
					return false;
				}

				if (!searchForm.find("input[name='keyword']").val()) {
					alert("키워드를 입력하세요");
					return false;
				}

				searchForm.find("input[name='pageNum']").val("1");
				e.preventDefault();
				searchForm.submit();

			});

		});
	</script>
</body>
</html>