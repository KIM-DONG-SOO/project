package com.spring.join.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

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
import com.spring.board.service.comCodeService;
import com.spring.comCode.vo.ComCodeVo;
import com.spring.join.service.JoinService;
import com.spring.user.vo.UserVO;

@Controller("joinController")
public class JoinController {
	
	@Autowired
	JoinService joinService;
	@Autowired
	comCodeService comCodeService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/join/joinForm.do", method = RequestMethod.GET)
	public String joinForm(Locale locale, Model model) throws Exception{
		
		// DB에서 ComCodeVo 조회해서 가져오기
		List<ComCodeVo> comCodeVOList = comCodeService.phoneCodeList();
		
		model.addAttribute("comCodeVOList", comCodeVOList);
		
		return "join/joinForm";
	}
	
	
	
	@RequestMapping(value = "/join/joinIdCheckAction.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> joinIdCheckAction(Locale locale,
												@RequestBody UserVO userVO) throws Exception{
		
		//디버깅
		System.out.println("joinIdCheckAction 호출됨..");
		
		//디버깅
		System.out.println("userVO에 담긴 userId" + userVO.getUserId() );
		
		//반환값 타입 선언 및 초기화
		Map<String, String> result = new HashMap<String, String>();
		
		//userVO에 담겨서 넘어온 userId
		String userId = userVO.getUserId();
		
		//UserVO 하나를 가져와서 userId 비교하기
		UserVO VO = joinService.selectOneUser(userVO);
		
		//똑같은 ID로 가져온 데이터가 있다면 "Y", 아니면 "N"
		result.put("flag", (VO!=null) ? "Y" : "N");
		
		
		return result;
	}
	
	
	
	
	@RequestMapping(value = "/join/joinAction.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> joinAction(Locale locale,
							@RequestBody UserVO userVO) throws Exception{
		
		//디버깅
		System.out.println("joinAction 호출됨");
		//디버깅
		System.out.println("AJAX요청받은 회원가입 id정보::" + userVO.getUserId());
		
		//성공하면 1, 실패하면 0을 반환
		int resultNum = joinService.userInsert(userVO);
		
		String flag = resultNum==1 ? "success" : "fail";
		
		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("flag", flag);
		
		//디버깅
		System.out.println("AJAX 응답 resultMap::" + resultMap);
		
		return resultMap;
	}
	
	
}
