package org.kin.mapper;

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
public class BoardMapperTests {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	
	/*
	 * @Test public void testGetList() {
	 * 
	 * mapper.getList().forEach(board -> log.info(board));
	 * 
	 * }
	 * 
	 * @Test public void testInsert() {
	 * 
	 * BoardVO board = new BoardVO(); board.setTitle("새로운 글");
	 * board.setContent("내용입니다."); board.setWriter("user01"); mapper.insert(board);
	 * 
	 * log.info(board); }
	 * 
	 * 
	 * 
	 * @Test public void testRead() {
	 * 
	 * BoardVO board = mapper.read(5L);
	 * 
	 * log.info(board);
	 * 
	 * }
	 * 
	 * 
	 * 
	 * @Test public void testDelete() { log.info("Delete Count : " +
	 * mapper.delete(3L)); }
	 * 
	 * 
	 * @Test public void testUpdate() { BoardVO board = new BoardVO();
	 * 
	 * board.setBno(61L); board.setTitle("수정합니다 61");
	 * board.setContent("내용 수정입니다. 61"); board.setWriter("user61");
	 * 
	 * int count = mapper.update(board); log.info("update count : " + count); }
	 */
	
	/*
	 * @Test public void testPaging() { Criteria cri = new Criteria();
	 * cri.setPageNum(2); cri.setAmount(10); List<BoardVO> list =
	 * mapper.getListWithPaging(cri); list.forEach(board ->
	 * log.info(board.getBno())); }
	 */
	  @Test
	  public void testSearch() {

	    Criteria cri = new Criteria();
	    cri.setKeyword("수정");
	    cri.setType("TC");

	    List<BoardVO> list = mapper.getListWithPaging(cri);

	    list.forEach(board -> log.info(board));
	  }

	

}
