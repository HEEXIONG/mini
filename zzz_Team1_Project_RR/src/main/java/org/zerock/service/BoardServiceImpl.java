package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.BoardVO;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.ToString;
import lombok.extern.log4j.Log4j;
@Service
@Log4j
@RequiredArgsConstructor
@ToString
public class BoardServiceImpl implements BoardService {
	
	
	private final BoardMapper mapper;

	@Override
	public void register(BoardVO vo) {
		
		mapper.insert(vo);	
		
		if(vo.getImageList() == null || vo.getImageList().size() <= 0) {
			return;
		}
		
		vo.getImageList().forEach(attach ->{
			attach.setPno(vo.getPno());
			mapper.imageinsert(attach);
		});
		
	}

	@Override
	public BoardVO get(Long pno) {
		return mapper.read(pno);
	}
	
	@Override
	public List<BoardVO> showlist() {
		List<BoardVO> list = mapper.getlist();
		list.forEach(pd ->{
			Long pdId = pd.getPno();
			List<AttachImageVO> imageList = mapper.getAttachList(pdId);
			pd.setImageList(imageList);
		});
		return list;
	}

	
	
	//========================================================이미지=========================================
	@Override
	public List<AttachImageVO> getAttachList(Long pno) {
		return mapper.getAttachList(pno);
	}
	
	

}
