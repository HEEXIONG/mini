package org.zerock.service;

import java.util.ArrayList;
import java.util.List;

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
public class BoardServiceImplTests {
	
	@Autowired
	private BoardService service;
	
	
	  @Test 
	  public void testinsert1(){ 
	 BoardVO vo = new BoardVO();
	  vo.setTitle("서비스 테스트1"); vo.setPinfo("서비스 테스트1"); vo.setCeller("판매자");
	  vo.setPrice(1000); service.register(vo); log.info(vo);
	  }
	
	@Test
	public void testinsert2() {
		BoardVO vo = new BoardVO();
		vo.setTitle("서비스 테스트 3");
		vo.setPinfo("서비스 테스트 3");
		vo.setCeller("판매자 3");
		vo.setPrice(1000);
	
		List<AttachImageVO> imagelist = new ArrayList<AttachImageVO>();
		
		AttachImageVO image1 = new AttachImageVO();
		
		
		image1.setFileName("test Image 3");
		image1.setUploadPath("test image 3");
		image1.setUuid("test31");
		
		//image2.setFileName("test Image 2");
		//image2.setUploadPath("test image 2");
		//image2.setUuid("test");
		
		imagelist.add(image1);
		//imagelist.add(image2);
		
		vo.setImageList(imagelist);
		
		service.register(vo);
		log.info("서비스등록테스트 : "+vo);
	}

}
