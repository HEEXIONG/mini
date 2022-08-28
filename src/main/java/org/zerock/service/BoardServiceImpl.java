package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardAttachMapper;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.log4j.Log4j;
@Service
@Log4j
@RequiredArgsConstructor
@ToString
public class BoardServiceImpl implements BoardService {
	
	
	private final BoardMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;

	@Transactional
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
	
	@Transactional
	@Override
	public boolean modify(BoardVO board) {
		log.info("modify... 게시글을 수정 처리 합니다!" + board);
		attachMapper.deleteAll(board.getPno());
		boolean modifyResult = mapper.update(board) == 1;
		if (modifyResult && board.getImageList() != null && board.getImageList().size() > 0) {
			board.getImageList().forEach(attach -> {
				attach.setPno(board.getPno());
				attachMapper.insert(attach);
			});
		}
		return modifyResult;
	}
	
	@Transactional
	@Override
	public boolean remove(Long pno) {
		
		log.info("remove... 게시글을 삭제 처리 합니다!" + pno);
		
		attachMapper.deleteAll(pno);		
		
		return mapper.delete(pno) == 1;
	}

	@Override
	public BoardVO get(Long pno) {
		return mapper.read(pno);
	}
	
	@Override
	public List<BoardVO> getList(Criteria cri) {
		List<BoardVO> list = mapper.getList();
		list.forEach(pd ->{
			Long pdId = pd.getPno();
			List<AttachImageVO> imageList = mapper.getAttachList(pdId);
			pd.setImageList(imageList);
		});
		// return list;
		log.info("getList with criteria : 페이징 기능 추가!" + cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count : 전체 개수 카운트!");
		return mapper.getTotalCount(cri);
	}

	
	
	//========================================================이미지=========================================
	@Override
	public List<AttachImageVO> getAttachList(Long pno) {
		return mapper.getAttachList(pno);
	}
	
	

}
