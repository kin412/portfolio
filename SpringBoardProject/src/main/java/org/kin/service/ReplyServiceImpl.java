package org.kin.service;

import java.util.List;

import org.kin.domain.Criteria;
import org.kin.domain.ReplyVO;
import org.kin.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Override
	public int register(ReplyVO vo) {
		log.info("register...." + vo);
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long bno) {
		log.info("get....." + bno);
		return mapper.read(bno);
	}

	@Override
	public int modify(ReplyVO vo) {
		log.info("modify....." + vo);
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno) {
		log.info("delete...." + rno);
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("getReplyList....." + bno);
		return mapper.getListWithPaging(cri, bno);
	}

}
