package org.zerock.mapper;

import org.apache.ibatis.annotations.Select;

public interface mapperTest {

	@Select("select sysdate from dual")
	String getttime();
}
