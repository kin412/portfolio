package org.kin.mapper;

import org.kin.domain.MemberVO;

public interface MemberMapper {
	
	public MemberVO read(String userid);
	
	public void signUp(MemberVO member);
	
	public void auth(MemberVO member);
	
	public int idCheck(String userid);
	
}
