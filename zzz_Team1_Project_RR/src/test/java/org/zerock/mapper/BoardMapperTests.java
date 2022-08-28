package org.zerock.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.BoardVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	
	@Autowired
	private BoardMapper boardMapper;
	
	@Test
	public void testInsert() {
		BoardVO vo = new BoardVO();
		vo.setTitle("테스트");
		vo.setPinfo("테스트");
		vo.setCeller("테스트");
		
		
		boardMapper.insert(vo);
		log.info(vo);
	}
	
	@Test
	public void imageEnrollTest() {
		
		AttachImageVO vo = new AttachImageVO();
		
		vo.setPno(22L);
		vo.setFileName("test");
		vo.setUploadPath("test");
		vo.setUuid("test2");
		
		boardMapper.imageinsert(vo);
		
	}
	@Test
	public void imageget() {
		Long pno = 37L;
		
		System.out.println("이미지 정보" + boardMapper.getAttachList(pno));
	}

}
