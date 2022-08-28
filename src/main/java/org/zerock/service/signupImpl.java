package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Repository
@Service
@Log4j
@RequiredArgsConstructor
public class signupImpl implements singupService{

	
	private final MemberMapper mapper;
	
	
	
	
	@Override
	public void insertMember(MemberVO memVo) {
		mapper.insertMember(memVo);
		
	}

	
	
}
