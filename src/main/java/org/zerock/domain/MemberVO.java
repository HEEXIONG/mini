package org.zerock.domain;

import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	
	private String userid;
	private String userpw;
	private String USER_CODE;
	private String EMAIL;
	private String NAME;
	private String BIRTH;
	private String PHONE_CD;
	private String PHONE_NUM;
	private String POST_NUM;
	private String ADDRESS;
	private String DT_ADDRESS;
	private boolean enabled;
	
	private List<AuthVO> authList;

}
