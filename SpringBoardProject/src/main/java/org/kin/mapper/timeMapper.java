package org.kin.mapper;

import org.apache.ibatis.annotations.Select;

public interface timeMapper {
	
	@Select("select sysdate from dual")
	public String getTime();
	
	public String getTime2();
}
