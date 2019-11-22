<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
    <link rel="stylesheet" href="/resources/css/get_upload.css">
	<meta charset="UTF-8">
	<title>register form</title>
</head>
<body>
	
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Board Register</h1>
		</div>
	</div>

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
			
				<div class="panel-heading"> Board Read</div>
				<div class="panel-body">
					<div class="form-group">
						<label>글번호</label>
						<input class="form-control" name='bno'
						value='<c:out value="${board.bno}"/>' readonly="readonly">
					</div>
					<div class="form-group">
						<label>제목</label>
						<input class="form-control" name='title'
						value='<c:out value="${board.title}"/>' readonly="readonly">
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" rows="3" name='content'
						 readonly="readonly"><c:out value="${board.content }"/></textarea>
					</div>
					<div class="form-group">
						<label>작성자</label>
						<input class="form-control" name='writer'
						value='<c:out value="${board.writer}"/>' readonly="readonly">
					</div>
					<sec:authentication property="principal" var="pinfo"/>
        			<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq board.writer}">
							<button data-oper='modify' class="btn btn-default">글 수정</button>
						 </c:if>
       				</sec:authorize>
        			<button data-oper='list' class="btn btn-info">글 목록</button>
					
					<form id='operForm' action="/boad/modify" method="get">
						<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
						<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
						<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
						<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
  						<input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div class='bigPictureWrapper'>
		<div class='bigPicture'>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">첨부파일</div>
				<div class="panel-body">
					<div class='uploadResult'>
						<ul>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class='row'>
  		<div class="col-lg-12">
    		<div class="panel panel-default">
      			<div class="panel-heading">
        			<i class="fa fa-comments fa-fw"></i> Reply
        			<sec:authorize access="isAuthenticated()">
        				<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
        			</sec:authorize>
      			</div>          
      			<div class="panel-body">        
        			<ul class="chat"></ul>
      			</div>
				<div class="panel-footer"></div>
			</div>
  		</div>
	</div>
	
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"
                aria-hidden="true">&times;</button>
              <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            </div>
            <div class="modal-body">
              <div class="form-group">
                <label>Reply</label> 
                <input class="form-control" name='reply' value='New Reply!!!!'>
              </div>      
              <div class="form-group">
                <label>Replyer</label> 
                <input class="form-control" name='replyer' value='replyer'>
              </div>
              <div class="form-group">
                <label>Reply Date</label> 
                <input class="form-control" name='replyDate' value='2018-01-01 13:13'>
              </div>
      
            </div>
			<div class="modal-footer">
        		<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
       			<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
        		<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
        		<button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
      		</div>
      	</div>
        </div>
      </div>
	
	<script type="text/javascript" src="/resources/js/reply.js?ver=1"></script>
	
	<script>
	$(document).ready(function () {
		  
		  var bnoValue = '<c:out value="${board.bno}"/>';
		  var replyUL = $(".chat");
		  
		    showList(1);
		    
		function showList(page){
		    replyService.getList({bno:bnoValue,page: page|| 1 }, function(list) {
		     var str="";
		     if(list == null || list.length == 0){
		    	replyUL.html("");
		       	return;
		     }
		     
		     for (var i = 0, len = list.length || 0; i < len; i++) {
		         str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
		         str +="  <div><div class='header'><strong class='primary-font'>["
		      	   +list[i].rno+"] "+list[i].replyer+"</strong>"; 
		         str +="    <small class='pull-right text-muted'>"
		             +replyService.displayTime(list[i].replyDate)+"</small></div>";
		         str +="    <p>"+list[i].reply+"</p></div></li>";
		       }
		     replyUL.html(str);
		   });
		     
		 }
		
		 var modal = $(".modal");
		    var modalInputReply = modal.find("input[name='reply']");
		    var modalInputReplyer = modal.find("input[name='replyer']");
		    var modalInputReplyDate = modal.find("input[name='replyDate']");
		    
		    var modalModBtn = $("#modalModBtn");
		    var modalRemoveBtn = $("#modalRemoveBtn");
		    var modalRegisterBtn = $("#modalRegisterBtn");
		    
		    var replyer = null;
		    
		    <sec:authorize access="isAuthenticated()">
		    	replyer = '<sec:authentication property="principal.username"/>';   
		    </sec:authorize>
		 
		    var csrfHeaderName ="${_csrf.headerName}"; 
		    var csrfTokenValue="${_csrf.token}";
		    
		    
		    $("#modalCloseBtn").on("click", function(e){
		    	
		    	modal.modal('hide');
		    });
		    
		    $("#addReplyBtn").on("click", function(e){
		      
		      modal.find("input").val("");
		      modal.find("input[name='replyer']").val(replyer);
		      modalInputReplyDate.closest("div").hide();
		      modal.find("button[id !='modalCloseBtn']").hide();
		      
		      modalRegisterBtn.show();
		      
		      $(".modal").modal("show");
		      
		    });
		    
		    $(document).ajaxSend(function(e, xhr, options) { 
		        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
		      }); 
		    
		    modalRegisterBtn.on("click",function(e){
		        
		        var reply = {
		              reply: modalInputReply.val(),
		              replyer:modalInputReplyer.val(),
		              bno:bnoValue
		            };
		        replyService.add(reply, function(result){
		          
		          alert(result);
		          
		          modal.find("input").val("");
		          modal.modal("hide");
		          
		          showList(1);
		        });
		        
		      });
		    
		    $(".chat").on("click", "li", function(e){
		        var rno = $(this).data("rno");
		        
		        replyService.get(rno, function(reply){
		        
		          modalInputReply.val(reply.reply);
		          modalInputReplyer.val(reply.replyer);
		          modalInputReplyDate.val(replyService.displayTime( reply.replyDate))
		          .attr("readonly","readonly");
		          modal.data("rno", reply.rno);
		          
		          modal.find("button[id !='modalCloseBtn']").hide();
		          modalModBtn.show();
		          modalRemoveBtn.show();
		          
		          $(".modal").modal("show");
		              
		        });
		      });
		    
		    modalModBtn.on("click", function(e){
		    	var originalReplyer = modalInputReplyer.val();
		        var reply = {rno:modal.data("rno"),
		        		reply: modalInputReply.val(), replyer: originalReplyer};
		        
		        if(!replyer){
		   		  alert("로그인후 수정이 가능합니다.");
		   		  modal.modal("hide");
		   		  return;
		   	  	}
		        
		        console.log("Original Replyer: " + originalReplyer);
		        
		        if(replyer  != originalReplyer){
		   		  
		   		  alert("자신이 작성한 댓글만 수정이 가능합니다.");
		   		  modal.modal("hide");
		   		  return;
		   		  
		   	  }
		        
		        replyService.update(reply, function(result){ 
		          alert(result);
		          modal.modal("hide");
		          showList(1);
		          
		        });
		        
		      });

		      modalRemoveBtn.on("click", function (e){
		    	  var rno = modal.data("rno");

		       	  console.log("RNO: " + rno);
		       	  console.log("REPLYER: " + replyer);
		       	  
		       	  if(!replyer){
		       		  alert("로그인후 삭제가 가능합니다.");
		       		  modal.modal("hide");
		       		  return;
		       	  }
		       	  
		       	  var originalReplyer = modalInputReplyer.val();
		       	  
		       	  console.log("Original Replyer: " + originalReplyer);
		       	  
		       	  if(replyer  != originalReplyer){
		       		  
		       		  alert("자신이 작성한 댓글만 삭제가 가능합니다.");
		       		  modal.modal("hide");
		       		  return;
		       	  }
		       	  
		       	replyService.remove(rno, originalReplyer, function(result){
		   	        
			   	      alert(result);
			   	      modal.modal("hide");
			   	      showList(pageNum);
			   	      
			   	  });
		    	  
		    	});
		      
		      
		    
	});
	</script>
	
	<script>
		$(document).ready(function(){
			(function(){
				var bno = '<c:out value="${board.bno}"/>';
				$.getJSON("/board/getAttachList", {bno:bno}, function(arr){
					console.log(arr);
				       
				       var str = "";
				       
				       $(arr).each(function(i, attach){
				       
				         if(attach.fileType){
				           var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
				           
				           str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
				           str += "<img src='/display?fileName="+fileCallPath+"'>";
				           str += "</div>";
				           str +"</li>";
				         }else{
				             
				           str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
				           str += "<span> "+ attach.fileName+"</span><br/>";
				           str += "<img src='/resources/img/attach.png'></a>";
				           str += "</div>";
				           str +"</li>";
				         }
				       });
				       
				       $(".uploadResult ul").html(str);
				});
			})();
			
			$(".uploadResult").on("click","li", function(e){
			      
			    console.log("view image");
			    
			    var liObj = $(this);
			    
			    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
			    
			    if(liObj.data("type")){
			      showImage(path.replace(new RegExp(/\\/g),"/"));
			    }else {
			      //download 
			      self.location ="/download?fileName="+path
			    }
			    
			    
			  });
			  
			  function showImage(fileCallPath){
			    
			    $(".bigPictureWrapper").css("display","flex").show();
			    
			    $(".bigPicture")
			    .html("<img src='/display?fileName="+fileCallPath+"' >")
			    .animate({width:'100%', height: '100%'}, 1000);
			  }
			  
			  $(".bigPictureWrapper").on("click", function(e){
				    $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
				    setTimeout(function(){
				      $('.bigPictureWrapper').hide();
				    }, 1000);
				  });
		});
	</script>
	
	<script type="text/javascript">
	$(document).ready(function() {
		console.log(replyService);
	});
	</script>
	
	<script type="text/javascript">
		console.log("=====================");
		console.log("JS TEST");
		
		var bnoValue='<c:out value="${board.bno}"/>';
		
		/* replyService.add(
			{reply:"JS Test", replyer:"tester", bno:bnoValue},
			function(result){
				alert("RESULT:"+result);
			}
		); */
		
		replyService.getList({bno:bnoValue, page:1}, function(list){
			for(var i = 0, len = list.length||0; i < len; i++){
				console.log(list[i]);
			}
		});
		
		replyService.remove(2, function(count){
			console.log(count);
			if(count === "success"){
				alert("REMOVED");
			}
		}, function(err){
			alert('error....');
		});
		
		replyService.update({
			rno:22,
			bno:bnoValue,
			reply:"Modifyed Reply...."
		}, function(result){
			alert("수정완료...");
		});
		
		replyService.get(10, function(data){
			console.log(data);
		});
		
	</script>
	
	<script type="text/javascript">
		$(document).ready(function() {
  
 		 var operForm = $("#operForm"); 
  
  		$("button[data-oper='modify']").on("click", function(e){
    
    		operForm.attr("action","/board/modify").submit();
    
  		});
  
    
  		$("button[data-oper='list']").on("click", function(e){
    
   		 operForm.find("#bno").remove();
   		 operForm.attr("action","/board/list")
   		 operForm.submit();
    
  		});  
  		
  		
  		
		});
	</script>
</body>
</html>