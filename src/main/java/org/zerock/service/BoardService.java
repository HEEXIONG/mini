package org.zerock.service;


import java.util.List;

import org.zerock.domain.AttachImageVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;


public interface BoardService {
	
	 void register(BoardVO vo);
	 
	 public List<BoardVO> getList(Criteria cri);
	 public int getTotal(Criteria cri);	
	 
	 BoardVO get (Long pno);
	 
	 public boolean modify(BoardVO board);
	 
	 public boolean remove(Long pno);
	 
	 //===================================이미지========================================
	 
	public List<AttachImageVO> getAttachList(Long pno);
	
	

}
