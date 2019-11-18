package org.kin.service;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kin.domain.BoardVO;
import org.kin.domain.Criteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTest {
	
	@Setter(onMethod_ = {@Autowired})
	private BoardService service;
	
	
	  @Test public void testExist() { assertNotNull(service); }
	 
	
	
	 @Test public void testRegister() { BoardVO board = new BoardVO();
	 board.setTitle("새로 작성"); board.setContent("새로 작성한 내용");
	 board.setWriter("user11");
	 
	 service.register(board); log.info("생성된 게시물의 번호 : " + board.getBno()); }
	 
	
	
	 @Test public void testGetList(){
	 service.getList(new Criteria(2, 10)).forEach(board->log.info(board)); }
	 
	 @Test public void testGet() { service.get(64L); }
	 
	 @Test public void testDelete() { log.info("remove : " + service.remove(64L));
	 }
	 
	
	@Test
	public void testUpdate() {
		BoardVO board = service.get(5L);
		
		if(board == null) {
			return;
		}
		
		board.setTitle("타이틀 수정");
		log.info("update : " + service.modify(board));
	}
	
}
