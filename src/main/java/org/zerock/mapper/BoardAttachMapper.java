package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.AttachImageVO;

public interface BoardAttachMapper {
	// page552~523 BoardAttachMapper인터페이스의 경우 첨부파일의 수정이라는 개념이 존재하지 않기 때문에
	// insert()와 delete()작업만을 등록 처리 합니다. 특정 게시물의 번호로 첨부파일을 찾는 작업이 필요하므로 findByPno()메소드를 정의했습니다.
	public void insert(AttachImageVO vo); 
	public void delete(String uuid);
	public List<AttachImageVO> findByPno(Long pno);
	
	public void deleteAll(Long pno);
	
	// page600 getOldFiles()추상 메소드 정의
	public List<AttachImageVO> getOldFiles();
}
