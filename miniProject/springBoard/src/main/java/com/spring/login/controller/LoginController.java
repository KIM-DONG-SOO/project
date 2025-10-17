package com.spring.login.controller;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.login.service.LoginService;
import com.spring.user.vo.UserVO;

@Controller("loginController")
public class LoginController {
	
	@Autowired
	LoginService loginService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/login/login.do", method = RequestMethod.GET)
	public String login(Locale locale, Model model,
							UserVO userVO, HttpSession session) throws Exception{
		
		return "/login/login";
	}
	
	
	@RequestMapping(value = "/login/loginAction.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> loginAction(Locale locale, @RequestBody UserVO userVO
											,HttpSession session) throws Exception{
		
		//디버깅
		System.out.println("loginAction 호출됨");
		
		//디버깅
		System.out.println("로그인 요청한 id와 pw::" + userVO.getUserId() + "," + userVO.getUserPw() );
		
		//반환값 타입 선언 및 초기화
		Map<String, String> result = new HashMap<String, String>();
		
		//selectOne으로 유저 정보 가져오기
		UserVO VO = loginService.selectOneUser(userVO);
		
		//null 방지
		if(VO != null) {
			//디버깅
			System.out.println("DB에서 조회한 userVO데이터::" + VO.getUserId() + "," + VO.getUserPw());
			
			//만약에 DB정보와 같다면
			if(userVO.getUserId().equals(VO.getUserId()) && 
					userVO.getUserPw().equals(VO.getUserPw())) {
				
				//세션에 저장
				session.setAttribute("loginUser", VO);
				
				result.put("flag", "success");
			}
			else {
				result.put("flag", "fail");			
			}
		}
		else {
			result.put("flag", "null");			
		}
		
		
		return result;
	}
	
	
	
	
}
