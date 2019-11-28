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
- security 와 handler를 이용해 처리<br>
### customLogin.jsp, customLogout.jsp : hidden속성으로 csrf토큰 사용.
~~~
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
~~~

### commonController : 회원가입 시 비밀번호 BCyptPasswordEncoder 적용
 ~~~
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
~~~
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
### 구현 화면<br>

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
~~~
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
 <img src="https://user-images.githubusercontent.com/19407579/69795805-2eaba900-1210-11ea-82b1-719d67da1303.gif">
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
~~~
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
~~~
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
~~~
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
~~~
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
