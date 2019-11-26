package org.kin.controller;

import java.util.HashMap;
import java.util.Map;

import org.kin.domain.MemberVO;
import org.kin.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("access Denied : " + auth);
		model.addAttribute("msg", "Access Denied");
	}
	
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		log.info("error:" + error);
		log.info("logout:" + logout);
		
		if(error != null) {
			model.addAttribute("error", "Login Error Check your Account");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "Logout");
		}
		
	}
	
	@GetMapping("/customLogout")
	public void logoutGET() {
		log.info("custom logout");
	}
	
	@GetMapping("/signUp")
	public void signUp() {
		
	}
	
	@PostMapping("/signUp")
	public String signUp(MemberVO member, RedirectAttributes rttr) {
		log.info("sign up---------------");
		log.info("member.getUserid() : "  + member.getUserid());
		log.info("member.getUserpw() : "  + member.getUserpw());
		log.info("member.getUserName() : "  + member.getUserName());
		BCryptPasswordEncoder pe = new BCryptPasswordEncoder();
		member.setUserpw(pe.encode(member.getUserpw()));
		mapper.signUp(member);
		mapper.auth(member);
		rttr.addFlashAttribute("result", "success");
		
		return "redirect:/customLogin";
	}
	
	@PostMapping("/idcheck")
	@ResponseBody
	public int idCheck(@RequestBody String userid) {
		log.info("idCheck---------------");
		log.info("userid : "  + userid);
		userid=userid.substring(0,userid.length()-1);
		log.info("substring userid :" + userid);
		
		return mapper.idCheck(userid);
	}
}
