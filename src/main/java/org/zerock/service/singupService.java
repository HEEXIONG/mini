package org.zerock.service;

import org.springframework.stereotype.Service;
import org.zerock.domain.MemberVO;

@Service
public interface singupService {
	
	void insertMember(MemberVO memVo);

}
