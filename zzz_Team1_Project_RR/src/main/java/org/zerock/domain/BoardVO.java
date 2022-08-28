package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	
	private Long pno;
	private String title;
	private String pinfo;
	private String celler;
	private Date regdate;
	private Date updatedate;
	private int price;
	private List<AttachImageVO> imageList;



	

}
