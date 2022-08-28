package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.zerock.domain.MemberVO;
import org.zerock.service.singupService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {

	@Setter(onMethod_ = @Autowired)
	BCryptPasswordEncoder pwdEncoder;
	
	
//	  @GetMapping("/accessError")
//	  public void accessDenied(Authentication auth, Model model) {
//	  
//	  log.info("access Denied : " + auth);
//	  
//	  model.addAttribute("msg", "Access Denied"); 
//	  }
	 

	  @GetMapping("/customLogin") 
	  public void loginInput(String error, String
	  logout, Model model) {
	  
	  log.info("error: " + error); log.info("logout: " + logout);
	  
	  if (error != null) { model.addAttribute("error",
	  "Login Error Check Your Account"); }
	  
	  if (logout != null) { model.addAttribute("logout", "Logout!!"); 
	  }
	  
	 }
	  
	  @GetMapping("/customLogout") public void logoutGET() {
	  
	  log.info("custom logout"); }
//	  
//	  @PostMapping("/customLogout") public void logoutPost() {
//	  
//	  log.info("post custom logout"); }
	 
	  @Setter(onMethod_ = @Autowired)
	  private singupService signupService;
		
		@GetMapping(value = "/joinForm")
		public void signupGET() {
			
		}
		
		
		 @PostMapping(value = "/joinForm")
		 public String signupPOST(MemberVO memVo) throws Exception {
		 
			 String rawPW ="";
			 String encodePW="";
			 
			 rawPW = memVo.getUserpw();
			 encodePW = pwdEncoder.encode(rawPW);
			 memVo.setUserpw(encodePW);
			 
			 
			 
			 
		  signupService.insertMember(memVo);
		  
		  
		  return "index";
		  
		 }
		 
		
	  
	 
}
