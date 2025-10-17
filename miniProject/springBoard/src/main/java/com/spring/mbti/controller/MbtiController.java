package com.spring.mbti.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.board.vo.BoardVo;
import com.spring.common.CommonUtil;
import com.spring.mbti.service.MbtiService;
import com.spring.mbti.vo.MbtiVo;
import com.spring.mbti.vo.PageVo;

@Controller("mbtiController")
public class MbtiController {
	
	@Autowired 
	MbtiService mbtiService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/mbti/mbtiList.do", method = RequestMethod.GET)
	public String mbtiList(Locale locale, Model model,PageVo pageVo) throws Exception{
		
		List<MbtiVo> mbtiList = new ArrayList<MbtiVo>();
		// MBTI 질문 전부 불러오기
		mbtiList = mbtiService.selectList(pageVo);
		
		Map<String, List<MbtiVo>> mbtiMap = new LinkedHashMap<>();
		mbtiMap.put("EI", new ArrayList<>()); //mbtiMap.put("IE", new ArrayList<>());
		mbtiMap.put("NS", new ArrayList<>()); //mbtiMap.put("SN", new ArrayList<>());
		mbtiMap.put("FT", new ArrayList<>()); //mbtiMap.put("TF", new ArrayList<>());
		mbtiMap.put("JP", new ArrayList<>()); //mbtiMap.put("PJ", new ArrayList<>());
		
		// boardType에 따라 분류 후 model에 저장
		for(MbtiVo mbtiVo : mbtiList) {
			String type = mbtiVo.getBoardType();
			
			if("EI".equals(type) || "IE".equals(type)) {
				mbtiMap.get("EI").add(mbtiVo);
			}
			else if ("NS".equals(type) || "SN".equals(type)) {
				mbtiMap.get("NS").add(mbtiVo);
			}
			else if ("FT".equals(type) || "TF".equals(type)) {
				mbtiMap.get("FT").add(mbtiVo);
			}
			else if ("JP".equals(type) || "PJ".equals(type)) {
				mbtiMap.get("JP").add(mbtiVo);
			}
			
//			if("EI".equals(type)) {
//				mbtiMap.get("EI").add(mbtiVo);
//			}
//			else if("IE".equals(type)) {
//				mbtiMap.get("IE").add(mbtiVo);
//			}
//			else if ("NS".equals(type)) {
//				mbtiMap.get("NS").add(mbtiVo);
//			}
//			else if ("SN".equals(type)) {
//				mbtiMap.get("SN").add(mbtiVo);
//			}
//			else if ("FT".equals(type)) {
//				mbtiMap.get("FT").add(mbtiVo);
//			}
//			else if ("TF".equals(type)) {
//				mbtiMap.get("TF").add(mbtiVo);
//			}
//			else if ("JP".equals(type)) {
//				mbtiMap.get("JP").add(mbtiVo);
//			}
//			else if ("PJ".equals(type)) {
//				mbtiMap.get("PJ").add(mbtiVo);
//			}
		}
		model.addAttribute("mbtiMap", mbtiMap);
		System.out.println("mbtiMap EI의 첫번째 객체의 boardNum ::" + mbtiMap.get("EI").get(0).getBoardNum());

		
		int page = 1;
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
		System.out.println("현재 페이지 넘버 : " + pageVo.getPageNo());
		
		int totalCnt = mbtiList.get(0).getTotalCnt();
		System.out.println("총 게시물 수 : " + totalCnt);
		int totalPage = (int) Math.ceil(totalCnt / 5.0);
		System.out.println("총 페이지 수 : " + totalPage);
		
		model.addAttribute("pageNo", pageVo.getPageNo());
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("totalPage", totalPage);
		
		
		return "mbti/mbtiList";
	}
	
	@RequestMapping(value = "/mbti/resultMBTI.do", method = RequestMethod.POST)
	public String resultMBTI(Locale locale, HttpServletRequest request, Model model) throws Exception{
		
		// 전체 파라미터를 담은 Map
		Map<String, String[]> paramMap = request.getParameterMap();
		// 서비스 함수 호출
		String result = mbtiService.calculateMbtiResult(paramMap);
		
		model.addAttribute("result", result);
		
		
		return "mbti/resultMBTI";
	}
	
}
