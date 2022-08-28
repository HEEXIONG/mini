package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.AttachImageVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/board/*")
@Log4j
public class BoardController {
	
	@Autowired
	private final BoardService service;
	
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void registerget() {
		
		
	}
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(BoardVO vo, RedirectAttributes rttr) {
		
		service.register(vo);
		log.info("board 등록 : "+vo);
		return "redirect:/board/list";
	}
	@GetMapping("/list")  
	public void list(Criteria cri, Model model) {
		log.info("list : " + cri);
		model.addAttribute("list", service.getList(cri));
		int total = service.getTotal(cri);
		log.info("total : 전체 카운트 개수 = " + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	@GetMapping({"/get", "/modify"})
//	public void get(@RequestParam("bno") Long bno, Model model) {
	// Page316 14.4.1 조회 페이지에서 다시 목록 페이지로 이동 : 페이지 번호 유지
	// @ModelAttribute 어노테이션은 자동으로 Model에 데이터를 지정한 이름으로 담아줍니다
	// @ModelAttribute 어노테이션을 사용하지 않아도 Controller에서 화면으러
	// 파라미터가 된 객체는 전달이 되지만, 좀더 명시적으로 이름을 지정하기 위해 사용합니다
	public void get(@RequestParam("pno") Long pno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("/get or modify");
//		log.info("/get 조회  처리");
		model.addAttribute("board",service.get(pno));
	}
	
	@PreAuthorize("principal.username == #board.celler")
	@PostMapping("/modify")
	public String modify(BoardVO board, Criteria cri, RedirectAttributes rttr) {
		log.info("modify: 수정 처리 " + board);
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}	
		
		return "redirect:/board/list" + cri.getListLink();
	}
	
	@PreAuthorize("principal.username == #celler")
	@PostMapping("/remove")
	public String remove(@RequestParam("pno") Long pno, Criteria cri, RedirectAttributes rttr, String celler) {
		log.info("remove: 삭제 처리 " + pno);
		List<AttachImageVO> attachList = service.getAttachList(pno);
		if (service.remove(pno)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}	
		return "redirect:/board/list" + cri.getListLink();
	}
	
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody // @ResponseBody를 적용해서 JSON데이터를 반환하도록 처리합니다.
	public ResponseEntity<List<AttachImageVO>> getAttachList(Long pno) {
		log.info("getAttachList " + pno);
		return new ResponseEntity<>(service.getAttachList(pno), HttpStatus.OK);
	}
	
	private void deleteFiles(List<AttachImageVO> attachList) {
	       
	       if(attachList == null || attachList.size() == 0) {
	         return;
	       }
	       
	       log.info("delete attach files...................");
	       log.info(attachList);
	       
	       attachList.forEach(attach -> {
	         try {        
	           Path file  = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\" + attach.getUuid()+"_"+ attach.getFileName());
	           
	           Files.deleteIfExists(file);
	           
	           if(Files.probeContentType(file).startsWith("image")) {
	           
	             Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_" + attach.getUuid()+"_"+ attach.getFileName());
	             
	             Files.delete(thumbNail);
	           }
	   
	         }catch(Exception e) {
	           log.error("delete file error" + e.getMessage());
	         }//end catch
	       });//end foreachd
		}
}
