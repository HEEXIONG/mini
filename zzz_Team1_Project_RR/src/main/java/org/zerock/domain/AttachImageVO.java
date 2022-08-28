package org.zerock.domain;

import lombok.Data;

@Data
public class AttachImageVO {
	
	private String uploadPath;
	
	/* uuid */
	private String uuid;
	
	/* 파일 이름 */
	private String fileName;
	
	/* 상품 id */
	private Long pno;
}
