package org.zerock.mapper;


import java.util.List;

import org.zerock.domain.AttachImageVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {
	
	void insert(BoardVO vo);
	
	public List<BoardVO> getList(); 
	
	public List<BoardVO> getListWithPaging(Criteria cri);

	public BoardVO read(Long pno);
	
	public int delete(Long pno);
	
	public int update(BoardVO board);
	
	public int getTotalCount(Criteria cri);	
	
	//============================================이미지=========================================
	void imageinsert(AttachImageVO vo);
	
	List<AttachImageVO> getAttachList(Long pno);
	
	

}
