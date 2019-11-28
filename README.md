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
- 11.28 github 포트폴리오 소개(readme.md) 작성

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
- security 와 handler를 이용해 처리<br>
### customLogin.jsp, customLogout.jsp : hidden속성으로 csrf토큰 사용.
~~~jsp
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
~~~

### commonController : 회원가입 시 비밀번호 BCyptPasswordEncoder 적용
 ~~~java
 @PostMapping("/signUp")
	public String signUp(MemberVO member, RedirectAttributes rttr) {
		log.info("sign up---------------");
		log.info("member.getUserid() : "  + member.getUserid());
		log.info("member.getUserpw() : "  + member.getUserpw());
		log.info("member.getUserName() : "  + member.getUserName());
		BCryptPasswordEncoder pe = new BCryptPasswordEncoder();
		member.setUserpw(pe.encode(member.getUserpw()));
		mapper.signUp(member);
		mapper.auth(member);
		rttr.addFlashAttribute("result", "success");
		
		return "redirect:/customLogin";
	}
 ~~~

### security-context.xml : 로그인 시 핸들러 지정
~~~xml
<security:form-login login-page="/customLogin"
		authentication-success-handler-ref="customLoginSuccess"/>
		<security:logout logout-url="/customLogout" invalidate-session="true"
		delete-cookies="remember-me,JSESSION_ID" />
		<security:remember-me data-source-ref="dataSource" 
		token-validity-seconds="604800"/>
 ~~~
 
 ### db에 입력된 결과
 <div>
  <img src="https://user-images.githubusercontent.com/19407579/69789643-4c731100-1204-11ea-9a7e-d6810b19f202.PNG">
</div>
<br>

### 회원가입
<div>
  <img src="https://user-images.githubusercontent.com/19407579/69789626-44b36c80-1204-11ea-94ac-d53cf39954ff.gif">
</div>
<br>

### 로그인
<div>
  <img src="https://user-images.githubusercontent.com/19407579/69789630-4715c680-1204-11ea-8631-d50bd3f51808.gif">
</div>
<br>

### 로그아웃
<div>
  <img src="https://user-images.githubusercontent.com/19407579/69789640-4aa94d80-1204-11ea-9555-73fe04166569.gif">
</div>
<br>

> 게시판 CRUD
- 요청 - 컨트롤러 - 서비스 - mybatis - DB - 컨트롤러 - 뷰
### 글쓰기
### boardController - @PreAuthorize("isAuthenticated()")를 통해 로그인 인증이 되지 않았다면 로그인 화면으로 넘어감
~~~java
@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board, RedirectAttributes rttr) {
		
		log.info("====================");
		log.info("register : " + board);
		
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		
		log.info("====================");
		
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		
		return "redirect:/board/list";
	}
~~~
<div>
 <img src="https://user-images.githubusercontent.com/19407579/69805445-fe6e0580-1223-11ea-8451-67e22c7b7fee.gif">
</div>
<br>

### 글조회
<div>
 <img src="https://user-images.githubusercontent.com/19407579/69795810-2fdcd600-1210-11ea-9970-8068e33866e9.gif">
</div>
<br>

### 글조회나 글삭제는 글쓴이와 로그인한 계정을 비교하여 같을때만 가능
<div>
 <img src="https://user-images.githubusercontent.com/19407579/69795813-310e0300-1210-11ea-997a-27a75dd7e211.gif">
</div>
<br>

### 글삭제
<div>
 <img src="https://user-images.githubusercontent.com/19407579/69795818-31a69980-1210-11ea-9c70-84e3c9ff2884.gif">
</div>
<br>

> 게시판 검색 , 페이징
- 게시판 검색 - 검색 기능에서 검색 조건이 바뀔때 마다 다른 서비스를 호출하는 것은 비효율적. 하나의 서비스에서 mybatis 동적SQL을 사용해 처리
- 게시판 페이징 - 페이징을 위한 criteria클래스 뿐만 아니라 이를 이용해 요청에 대한 가공된 페이지정보를 가질 pageDTO 클래스 필요

### 검색과 페이징을 위한 criteria 클래스
~~~java
@Data
public class Criteria {
	
	private int pageNum; // 현재 페이지 번호 
	private int amount; // 페이징 처리에서 한번에 보여줄 페이지 버튼의 수
	
	private String type; // 검색 유형
	private String keyword; // 검색 내용
	
	public Criteria() {
		this(1, 10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		return type == null ? new String[] {}: type.split("");
	}
	
	public String getListLink() {

		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());

		return builder.toUriString();

	}
	
}
~~~

### 검색과 페이징을 위한 BoardMapper.xml 
~~~xml
<sql id="criteria">
		<trim prefix="(" suffix=") AND " prefixOverrides="OR">
			<foreach item='type' collection="typeArr">
				<trim prefix="OR">
					<choose>
						<when test="type == 'T'.toString()">
							title like '%'||#{keyword}||'%'
						</when>
						<when test="type == 'C'.toString()">
							content like '%'||#{keyword}||'%'
						</when>
						<when test="type == 'W'.toString()">
							writer like '%'||#{keyword}||'%'
						</when>
					</choose>
				</trim>
			</foreach>
		</trim>
	</sql>
	...
	<select id="getListWithPaging" resultType="org.kin.domain.BoardVO">
	  <![CDATA[select bno, title, content, writer, regdate, updatedate from 
	      (select /*+INDEX_DESC(tbl_board pk_board) */
	       rownum rn, bno, title, content, writer, regdate, updatedate 
	       from tbl_board where 
	  ]]>
			<include refid="criteria"></include>
	      
	  <![CDATA[    
	    rownum <= #{pageNum} * #{amount})
	  	where rn > (#{pageNum} -1) * #{amount}   
	  ]]>
	</select>
~~~

### 페이징을 위한 PageDTO 
~~~java
@Data
public class PageDTO {
	
	private int startPage; // 현재페이지에서 첫번째페이지 번호
	private int endPage; // 현재페이지에서 마지막페이지 번호
	private boolean prev; // 1페이지일 경우와 아닐경우 이전페이지 버튼 처리
	private boolean next; // 마지막페이지일 경우와 아닐경우 다음 페이지 버튼 처리
	private int total; // 총 게시글 수
	private Criteria cri; // 페이징 계산에 필요한 객체
	
	public PageDTO(Criteria cri, int total) {
		
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) * 10;
		this.startPage = this.endPage - 9;
		int realEnd = (int)(Math.ceil((total * 1.0)/cri.getAmount()));
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
		
	}
	
}
~~~

### list.jsp
~~~jsp
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
~~~

### 검색
<div>
 <img src="https://user-images.githubusercontent.com/19407579/69799597-ed6ac780-1216-11ea-9af9-b569be35792c.gif">
</div>
<br>

### 페이징
<div>
 <img src="https://user-images.githubusercontent.com/19407579/69799600-ef348b00-1216-11ea-8690-404503367581.gif">
</div>
<br>


> 댓글
- 글조회 view가 이미 구성된 상태에서 댓글을 다는 것이므로 model(view+data)를 전달하는 @controller가 아닌 data만 전달하는 @RestController 사용

### 댓글 처리를 담당하는 ReplyController 중 댓글 등록 메서드
~~~java
@RequestMapping("/replies")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {
	private ReplyService service;
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/new", consumes="application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		
		log.info("ReplyVO:" + vo);
		int insertCount = service.register(vo);
		
		log.info("Reply INSERT COUNT:" + insertCount);
		
		return insertCount == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	...
}
~~~

### reply.js 중 댓글 등록 ajax 처리
~~~js
function add(reply, callback, error){
		console.log("reply......");
		
		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		})
	}
~~~

### 댓글 등록
<div>
 <img src="https://user-images.githubusercontent.com/19407579/69802236-77695f00-121c-11ea-84e2-7e5f5143c695.gif">
</div>
<br>

### 댓글 수정
<div>
 <img src="https://user-images.githubusercontent.com/19407579/69802238-79332280-121c-11ea-9063-b159c9dacba4.gif">
</div>
<br>

### 댓글 삭제
<div>
 <img src="https://user-images.githubusercontent.com/19407579/69802243-7a644f80-121c-11ea-8424-29e214b2ae97.gif">
</div>
<br>

>파일업로드
- ajax를 이용해 첨부파일은 글등록과 별도로 처리되도록 구성. 업로드된 파일의 정보는 DB에 저장할 때 다음의 정보가 필요하다.
  UUID로 구성된 파일의 이름과 원본 파일의 이름, 원본 파일이 저장된 경로, 썸네일 정보
  
### register.jsp 중 글을 게시할때 파일 정보를 참조할수 있도록 hidden으로 함께 전송
~~~jsp
$("button[type='submit']").on("click", function(e){
    
    e.preventDefault();
    
    console.log("submit clicked");
    
    var str = "";
    
    $(".uploadResult ul li").each(function(i, obj){
      
      var jobj = $(obj);
      
      console.dir(jobj);
      console.log("-------------------------");
      console.log(jobj.data("filename"));
      
      
      str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
      str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
      str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
      str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
      
    });
    
    console.log(str);
    
    formObj.append(str).submit();
    
  });
~~~

### register.jsp 중 실제로 파일 업로드를 처리하는 ajax
~~~jsp
$("input[type='file']").change(function(e){

    var formData = new FormData();
    
    var inputFile = $("input[name='uploadFile']");
    
    var files = inputFile[0].files;
    
    for(var i = 0; i < files.length; i++){

      if(!checkExtension(files[i].name, files[i].size) ){
        return false;
      }
      formData.append("uploadFile", files[i]);
      
    }
    
    $.ajax({
    	url: '/uploadAjaxAction',
        processData: false, 
        contentType: false,
        beforeSend: function(xhr) {
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        },
        data:formData,
        type: 'POST',
        dataType:'json',
        success: function(result){
          console.log(result); 
  		  showUploadResult(result);

      }
    }); //$.ajax
    
  });
~~~

### UploadController 중 파일 등록 부분
하나의 폴더내에 파일이 계속 누적되면 느려지기 때문에 일단위로 폴더를 새로 만들어 파일 저장, 이미지 파일이라면 썸네일 생성 
~~~java
@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {

		List<AttachFileDTO> list = new ArrayList<>();
		//저장경로 지정
		String uploadFolder = "C:\\upload";
		//하나의 폴더 내에 파일이 계속 누적되면 느려지기 때문에 일단위로 폴더를 새로 만들어 파일 저장
		String uploadFolderPath = getFolder();
		
		File uploadPath = new File(uploadFolder, uploadFolderPath);

		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		

		for (MultipartFile multipartFile : uploadFile) {

			AttachFileDTO attachDTO = new AttachFileDTO();

			String uploadFileName = multipartFile.getOriginalFilename();

			// IE has file path
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name: " + uploadFileName);
			attachDTO.setFileName(uploadFileName);
			//파일명 중복방지를 위한 UUID 지정
			UUID uuid = UUID.randomUUID();

			uploadFileName = uuid.toString() + "_" + uploadFileName;

			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);

				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);

				// 저장하는 파일이 이미지 라면 썸네일 생성
				if (checkImageType(saveFile)) {

					attachDTO.setImage(true);

					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));

					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 300, 300);

					thumbnail.close();
				}

				
				list.add(attachDTO);

			} catch (Exception e) {
				e.printStackTrace();
			}

		} 
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
~~~

### 파일 등록
<div>
 <img src="https://user-images.githubusercontent.com/19407579/69810710-d97f8f80-122f-11ea-9399-d0239680f341.gif">
</div>
<br>

### 파일 등록 결과
<div>
 <img src="https://user-images.githubusercontent.com/19407579/69810714-db495300-122f-11ea-9dde-3f1ed6ac6d01.gif">
</div>
<br>

### 파일 수정
<div>
 <img src="https://user-images.githubusercontent.com/19407579/69810723-e1d7ca80-122f-11ea-8f74-520b3d558352.gif">
</div>
<br>

### 파일 수정 결과
<div>
 <img src="https://user-images.githubusercontent.com/19407579/69810724-e308f780-122f-11ea-80c0-097e2ef922fe.gif">
</div>
<br>

### 게시글 파일 확인
<div>
 <img src="https://user-images.githubusercontent.com/19407579/69810729-e56b5180-122f-11ea-8a84-5801d17c6369.gif">
</div>
<br>

### 파일 삭제
<div>
 <img src="https://user-images.githubusercontent.com/19407579/69810733-e8664200-122f-11ea-8d5f-ed55c58879b9.gif">
</div>
<br>

### 파일 삭제 결과
<div>
 <img src="https://user-images.githubusercontent.com/19407579/69810742-ea300580-122f-11ea-8198-fc578566bc40.gif">
</div>
<br>

------------------------------------------------------------------------------------------------------------------------------------------

## 7. 추가해야 할 부분
- spring security 권한에 따른 페이지
- 마이페이지

------------------------------------------------------------------------------------------------------------------------------------------

## 8. 스프링으로 진행하며 느낀점
- jsp model2 mvc에 비해 의존성 주입을 활용한 어노테이션으로 객체 자동 생성이 편하다.
- jsp model2 mvc에서 요청한 URL을 잘라서 String 변수command 를 통해  요청을 해결하는 것보다 @requestmapping 혹은
@postmapping, @getmapping 한방으로 끝나는 요청 분기 나누는게 편하다.
- jsp model2 mvc의 preparedStatment 에 비해 월등히 편한 mybatis
- junit의 단위테스트의 편리함. 꼭 실행화면에서 안해도 된다. was를 사용하지 않아도 되서 실행시간을 엄청 절감 할 수 있다.
일반 main메소드에서 테스트를 한다고하면 해당 클래스를 만들고 메소드를 호출해야하는 번거로움 있다.
그냥 junit 테스트코드에서 단위테스트하면 여러 메소드가 바로 이루어지고 junit탭에 정리가 되어서 나와 에러가 뜨면 바로바로 잡을수 있어서 좋았음.
기능별로 하나의 단위테스트 모듈을 만들어 두면 두고두고 써먹을 수 있을 것 같다.
- 권한에 따른 흐름제어를 내가 1부터 코딩 하는것이 아니고 spring security를 통해 쉽게 제어할 수 있다.
- lombok을 통해 setter, getter, tostring 작성을 생략 가능해 편하다.

------------------------------------------------------------------------------------------------------------------------------------------

## 9. 진행하면서 만났던 에러
### 구글링은 위대하다
- 이미지 파일 경로를 webapp/resources 아래에 두어야하는데 src/main/resources 아래에 두어서 한참 찾았다.
src - 프로그램 소스 파일 두는곳
main/java - 자바 소스파일 두는곳
src/main/resources - 프로그램을 실행할때 사용하는 설정파일
properties, xml등을 두는곳
src/main/webapp -  html, css, javascript, gif등
정적 웹 자원을 두는곳
src/main/webapp/WEB-INF - 웹 어플리케이션 정보 파일 두는곳.
test - 코드 테스트 소스 두는곳
test/java  - 단위 테스트 관련 자바 소스파일 두는곳
bin - 소스코드가 컴파일된 *.class, *properties, *xml 파일.

- 이 프로젝트 전에 전체적으로 스프링을 공부할때는 mysql을 사용하고 이 프로젝트는 oracle로 진행 했다. 
mysql의 경우에는  gui 툴에서 쿼리문을 사용할때 그냥 사용하면 되었지만, oracle의 경우는 gui 툴에서 
쿼리문을 사용할 시 반드시 commit을 해줘야 적용이 된다는 걸 알았다.

- db 테스트 중 시퀀스값이 20씩 증가하는 문제. cache 옵션이 적용되어 그랬던 것.
시퀀스의 cache size를 조회해 보니 20으로 설정되어 있었다.
~~~
select sequence_name, cache_size from user_sequences
~~~
cache 옵션을 사용하지 않도록 설정을 변경 했다.
~~~
alter sequence seq1 nocache
~~~

- business tier에서 한글이 깨지는 현상 - web.xml에 filter를 추가한다.

- mapper select문 에서 resultType 지정을 replyVO 로 패키지명 없이 클래스 명만 기입해서 에러가 발생. 패키지명까지 지명해주어야 한다.

- ajax 댓글 처리시 json데이터로 db에 접근하지 못함. 데이터 입력, 수정, 삭제 별로 post, put, delete를 주어야하는데 설정을 잘못했다.
get이면 get post면 post 수정이면 put 삭제면 delete를 지정해줘야한다.

- /src/main/resources/log4j.xml 하단  Root Logger <priority value=""/> 부분 warn, info, debug 각 값에 따라 로깅 레벨이 달라진다.

- spring security SavedRequestAwareAuthenticationSuccessHandler- Using default Url: /
스프링 시큐리티는 핸들러를 따로 만들어 두지 않는다면 기본적으로 로그인 후처리를
SavedRequestAwareAuthenticationSuccessHandler 가 맡는다.
사용자가 원래 보려고 했던 페이지의 정보를 유지해서 로그인 후에 다시 원했던 페이지로 이동한다.
예를들면 로그인 하지 않은채 글작성을 시도할시 이를 이용해 로그인페이지로 가서 로그인후 다시 글작성 페이지로 돌아오는식이다.
일반 로그인 시에는 로그인 전용 핸들러를 만들어 경로를 지정해주자. 

- uncaught referenceError: $ajax is not defined
js파일에서 에러가 나서 크롬 콘솔창을 통해 확인하니 오타가 있었다. 오타를 제대로 고치고
페이지에 재접속했지만 동일한 에러가 났다. 페이지에서 js파일을 적용한 script 태그를
<script type="text/javascript" src="js파일명?ver=1">
src 뒤에 ?ver=1를 붙여 해결. 간혹가다 스크립트 파일이 갱신이 안되는 경우가 있다. 그런 경우 사용한다. <br>
	
- 페이지 이동 실수 회원가입 처리를 위해 <button onclick="location.href='/signUp.jsp'"> 경로지정 실수.
<button onclick="location.href='/signUp'"> 으로 컨트롤러의
@GetMapping("/signUp")
public void signUp(){}
이동한뒤 viewresolver에 의해 WEB-INF/views/signUp.jsp가 되어 이동
	
- 회원가입 스프링 시큐리티 ajax 중복체크 스프링 시큐리티가 적용 되었을때 ajax로 데이터를 전송하는 경우
반드시 csrf토큰값을 헤더정보에 추가해 보내야 한다.

- ajax 사용시 dataType:json을 지정해 주지 않아서 xml로 데이터가 넘어와 제대로 로직을 타지않아 헤맸음
