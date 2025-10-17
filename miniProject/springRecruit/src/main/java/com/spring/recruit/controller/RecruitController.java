package com.spring.recruit.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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

import com.spring.recruit.HomeController;
import com.spring.recruit.service.RecruitService;
import com.spring.recruit.vo.CareerVO;
import com.spring.recruit.vo.CertificateVO;
import com.spring.recruit.vo.EducationVO;
import com.spring.recruit.vo.RecruitVO;

@Controller("recruitController")
public class RecruitController {
	
	@Autowired 
	RecruitService recruitService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
	@RequestMapping(value = "/recruit/login.do", method = RequestMethod.GET)
	public String login(Locale locale, Model model) throws Exception{
		
		System.out.println("login 컨트롤러 함수 실행됨");
		
		
		return "recruit/login";
	}
	
	
	@RequestMapping(value = "/recruit/loginAction.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> loginAction(Locale locale, Model model, HttpSession session
								,RecruitVO recruitVO) throws Exception{
		
		System.out.println("recruitAction 함수 실행됨");
		
		System.out.println("VO안에 담긴 name과 phone::" + recruitVO.getName() + "," + recruitVO.getPhone());
		
		// 세션에 저장
		session.setAttribute("name", recruitVO.getName());
		session.setAttribute("phone", recruitVO.getPhone());
		
		Map<String, String> result = new HashMap<>();
		result.put("success", "success");
		
		
		return result;
	}
	
	
	@RequestMapping(value = "/recruit/main.do", method = RequestMethod.GET)
	public String main(Locale locale, Model model,HttpSession session) throws Exception{
		
		System.out.println("main 컨트롤러 함수 실행됨");
		
		// 세션에 있는 로그인 정보 가져오기
		String name = (String) session.getAttribute("name");
		String phone = (String) session.getAttribute("phone");
		
		System.out.println("세션에서 가져온 name::" + name);
		System.out.println("세션에서 가져온 phone::" + phone);
		
		model.addAttribute("name", name);
		model.addAttribute("phone", phone);
		
		// 희망 근무지 COM_CODE 테이블에서 가져오기
		List<RecruitVO> locList = recruitService.selectLocList();
		
		model.addAttribute("locList", locList);
		
		// 기존에 DB에 insert한적 있는 사용자 데이터만 아래 코드 실행
		
		
		// 로그인하면 DB에 있는 데이터 조회해서, main에 전달하기
		// 기준은 세션에 저장된 전화번호
		RecruitVO selectedRecruitVO = recruitService.selectRecruit(phone);
		if(selectedRecruitVO == null) {
			//기존에 한번도 저장된 데이터가 없으면 빈 List만 모델에 담아 넘기기.
			System.out.println("저장된 데이터가 없음");
			
		    // 빈 리스트 생성해서 JSP로 전달
		    model.addAttribute("eduList", new ArrayList<EducationVO>());
		    model.addAttribute("carList", new ArrayList<CareerVO>());
		    model.addAttribute("certList", new ArrayList<CertificateVO>());
		}
		else {
			// 기존에 저장된 데이터가 있다면,
			// 프론트로 전달하는 모델에 VO담기
			model.addAttribute("recruitVO", selectedRecruitVO);
			
			// 다른 데이터들도 프론트에 전달하기
			// 외래키 뽑아서 사용
			String seq = selectedRecruitVO.getSeq();
			
			List<EducationVO> selectedEduList = recruitService.selectEduList(seq);
			model.addAttribute("eduList", selectedEduList);
			List<CareerVO> selectedCarList = recruitService.selectCarList(seq);
			model.addAttribute("carList", selectedCarList);
			List<CertificateVO> selectedCertList = recruitService.selectCertList(seq);
			model.addAttribute("certList", selectedCertList);
		}
		
		
		return "recruit/main";
	}
	
	
	@RequestMapping(value = "/recruit/saveAction.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> saveAction(Locale locale, Model model
								,RecruitVO recruitVO) throws Exception{
		
		System.out.println("saveAction 함수 실행됨");
		
		Map<String,Object> result = new HashMap<>();
		
		// submit컬럼상태에 따라 insert와 update를 분기.
		try {
			if(recruitVO.getSubmit() == null || recruitVO.getSubmit().isEmpty()) {
				recruitService.insertRecruitAll(recruitVO);
			}
			else if(recruitVO.getSubmit().equals("N")) {
				recruitService.updateRecruitAll(recruitVO);
			}
			
			String success = "success";
			result.put("status", success);
			
			// recruit 데이터
			result.put("recruitVO", recruitVO);
			
			// education 데이터 List
			result.put("eduList", recruitVO.getEduList());
			
			// career 데이터 List
			if(recruitVO.getCarList() != null) {
				result.put("carList", recruitVO.getCarList());
			}
			
			// certificate 데이터 List
			if(recruitVO.getCertList() != null) {
				result.put("certList", recruitVO.getCertList());
			}
		}
		catch(Exception e) {
			result.put("status", "fail");
		}
		System.out.println("insert또는 update결과::" + result.get("status"));
		
		
		return result;
	}
	
	
	@RequestMapping(value = "/recruit/submitAction.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> submitAction(Locale locale, Model model
								,RecruitVO recruitVO) throws Exception{
		
		System.out.println("saveAction 함수 실행됨");
		
		Map<String,Object> result = new HashMap<>();
		
		// 사용자가 submit이 "N"일 경우에만 해당 함수를 호출하도록 했음.
		try {
			if(recruitVO.getSubmit().equals("N")) {
				// submit을 "Y"로 변경 후 update 진행.
				recruitVO.setSubmit("Y");
				recruitService.updateRecruitAll(recruitVO);
			}
			
			result.put("status", "success");
			
			// recruit 데이터
			result.put("recruitVO", recruitVO);
			
			// education 데이터 List
			result.put("eduList", recruitVO.getEduList());
			
			// career 데이터 List
			if(recruitVO.getCarList() != null) {
				result.put("carList", recruitVO.getCarList());
			}
			
			// certificate 데이터 List
			if(recruitVO.getCertList() != null) {
				result.put("certList", recruitVO.getCertList());
			}
		}
		catch(Exception e) {
			result.put("status", "fail");
		}
		System.out.println("insert또는 update결과::" + result.get("status"));
		
		
		return result;
	}
	
}
