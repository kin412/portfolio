package org.kin.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kin.domain.Criteria;
import org.kin.domain.ReplyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	private Long[] bnoArr = {633L, 632L, 631L};
	
	
	 //@Test public void testMapper() { log.info(mapper); }
	 
	
	/*
	 * @Test public void testCreate() { IntStream.range(1, 10).forEach(i -> {
	 * ReplyVO vo = new ReplyVO();
	 * 
	 * vo.setBno(bnoArr[i%3]); vo.setReply("댓글 테스트" + i); vo.setReplyer("replyer" +
	 * i);
	 * 
	 * mapper.insert(vo); }); }
	 */
	
	/*
	 * @Test public void testRead() { Long targetRno = 2L; ReplyVO vo =
	 * mapper.read(targetRno); log.info(vo); }
	 */
	
	/*
	 * @Test public void testDelete() { Long targetRno=1L; mapper.delete(targetRno);
	 * }
	 */
	
	/*
	 * @Test public void testUpdate() { Long targetRno=2L; ReplyVO vo =
	 * mapper.read(targetRno); vo.setReply("update reply"); int count =
	 * mapper.update(vo); log.info("update count : " + count); }
	 */
	
	@Test
	public void testList() {
		Criteria cri = new Criteria();
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[2]);
		replies.forEach(reply -> log.info(reply));
	}
	
}
