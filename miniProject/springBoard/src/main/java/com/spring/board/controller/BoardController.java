package com.spring.board.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.service.comCodeService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.comCode.vo.ComCodeVo;
import com.spring.common.CommonUtil;

@Controller("boardController")
public class BoardController {
	
	@Autowired 
	boardService boardService;
	@Autowired 
	comCodeService comCodeService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,PageVo pageVo, ComCodeVo comCodeVo) throws Exception{
		
		
		//디버깅
		System.out.println("pageVo안에 담긴 boardType[] ::" + Arrays.toString(pageVo.getBoardType()));
		
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		
		int page = 1;
		int totalCnt = 0;
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);;
		}
		System.out.println("현재 페이지 넘버 : " + pageVo.getPageNo());
		
		
		boardList = boardService.SelectBoardList(pageVo);
		totalCnt = boardService.selectBoardCnt(pageVo);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);
		
		
		// DB에서 ComCodeVo 조회해서 가져오기
		List<ComCodeVo> comCodeList = comCodeService.selectComCodeList();
		
		model.addAttribute("comCodeList", comCodeList);
		
		return "board/boardList";
	}
	
	// AJAX 응답 메서드
	@RequestMapping(value = "/board/boardListAction.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> boardListAction(Locale locale, @RequestBody PageVo pageVo) throws Exception{
		
		Map<String, Object> result = new HashMap<>();
		
		// 디버깅
		String[] boardType = pageVo.getBoardType();
		System.out.println("AJAX 요청이 pageVo에 잘 담겨있나 확인" + Arrays.toString(boardType));
		
		List<BoardVo> boardList = boardService.SelectBoardList(pageVo);
		System.out.println("boardListAction에서 boardList 사이즈" + boardList.size());
		int totalCnt = boardService.selectBoardCnt(pageVo);
		
		result.put("boardList", boardList);
		result.put("totalCnt", totalCnt);
		
		return result;
	}
	
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum
			,@RequestParam(defaultValue="1") String pageNo) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		model.addAttribute("pageNo", pageNo);
		
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model,
						@RequestParam(defaultValue="1") String pageNo) throws Exception{
		
		System.out.println("쓰기 페이지로 넘어온 pageNo = " + pageNo);
		
		return "board/boardWrite";
	}
	
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale,BoardVo boardVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardInsert(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardUpdate.do", method = RequestMethod.GET)
	public String boardUpdate(Locale locale, Model model
						,@PathVariable("boardType")String boardType
						,@PathVariable("boardNum")int boardNum
						,@RequestParam(defaultValue="1") String pageNo) throws Exception{
		
		BoardVo boardVo = boardService.selectBoard(boardType, boardNum);
		
		model.addAttribute("board", boardVo);
		
		System.out.println("boardNum확인하기 = " + boardVo.getBoardNum());
		
		return "board/boardUpdate";
	}
	
	@RequestMapping(value = "/board/boardUpdateAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardUpdateAction(Locale locale,BoardVo boardVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardUpdate(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardDelete.do", method = RequestMethod.GET)
	public String boardDelete(Locale locale, Model model
					,@PathVariable("boardType")String boardType
					,@PathVariable("boardNum")int boardNum) throws Exception{
		
		// select 쿼리문 없이 Delete쿼리문으로만 삭제 진행.
		int result = boardService.boardDelete(boardType, boardNum);
		
		// 반환할 뷰 경로를 변수로 설정
		String view;
		
		// 예외처리
		if (result == 0) {
			model.addAttribute("errorMsg", "error.deleted");
			view = "board/errorPage";
		}
		else {
			view = "redirect:/board/boardList.do";
		}
		
		return view;
	}
	
}
