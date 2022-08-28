package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
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
	public void showlist(Model model) {
		service.showlist();
		model.addAttribute("list",service.showlist());
		log.info("리스트");	
	}
	@GetMapping("/get")
//	public void get(@RequestParam("bno") Long bno, Model model) {
	// Page316 14.4.1 조회 페이지에서 다시 목록 페이지로 이동 : 페이지 번호 유지
	// @ModelAttribute 어노테이션은 자동으로 Model에 데이터를 지정한 이름으로 담아줍니다
	// @ModelAttribute 어노테이션을 사용하지 않아도 Controller에서 화면으러
	// 파라미터가 된 객체는 전달이 되지만, 좀더 명시적으로 이름을 지정하기 위해 사용합니다
	public void get(@RequestParam("pno") Long pno,Model model) {
		log.info("/get or modify");
//		log.info("/get 조회  처리");
		model.addAttribute("board",service.get(pno));
	}
	
	
}
