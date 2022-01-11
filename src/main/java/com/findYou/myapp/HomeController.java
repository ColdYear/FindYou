package com.findYou.myapp;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.findYou.businessBoard.service.BusinessBoardServiceImpl;
import com.findYou.businessBoard.vo.BusinessBoardVO;
import com.findYou.businessBoard.vo.BusinessSearchBoardVO;
import com.findYou.normalBoard.service.NormalBoardServiceImpl;
import com.findYou.normalBoard.vo.NormalBoardVO;
import com.findYou.notice.service.NoticeServiceImpl;
import com.findYou.notice.vo.NoticeVO;
import com.findYou.reply.service.ReplyServiceImpl;
import com.findYou.reply.vo.ReplyVO;
import com.findYou.score.service.ScoreServiceImpl;
import com.findYou.score.vo.ScoreVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Inject
	@Qualifier("businessBoardServiceImpl")
	BusinessBoardServiceImpl businessBoardServiceImpl;

	@Inject
	@Qualifier("normalBoardServiceImpl")
	NormalBoardServiceImpl normalBoardServiceImpl;
	
	@Inject
	@Qualifier("scoreServiceImpl")
	ScoreServiceImpl scoreServiceImpl;
	
	@Inject
	@Qualifier("replyServiceImpl")
	ReplyServiceImpl replyServiceImpl;
	
	
	@Inject
	@Qualifier("noticeServiceImpl")
	NoticeServiceImpl noticeServiceImpl;
	
	
	@RequestMapping(value = "/")
	public String home(Locale locale, Model model, HttpSession session) {
		model.addAttribute("user", session.getAttribute("user"));
		
		//모임 게시판 리스트 불러오기 (1~4개)
		List<NormalBoardVO> normalBoardList14= normalBoardServiceImpl.homeNormalBoardList14();
		model.addAttribute("normalBoardList14",normalBoardList14);
		
		//모임 게시판 리스트 불러오기(5~8개)
		List<NormalBoardVO> normalBoardList58= normalBoardServiceImpl.homeNormalBoardList58();
		model.addAttribute("normalBoardList58",normalBoardList58);
		
		//조회수 랭킹 1~10위
		List<BusinessBoardVO> cntBestRankList= businessBoardServiceImpl.cutBestRank();
		model.addAttribute("cntBestRankList",cntBestRankList);
		
		//평점순 랭킹 1~10위
		List<ScoreVO> scoreBestRankList = scoreServiceImpl.socreBestRank();
		model.addAttribute("scoreBestRankList",scoreBestRankList);

		//댓글 많은 게시물 1~10위
		List<ReplyVO> replyBestRankList= replyServiceImpl.replyBestRank();
		model.addAttribute("replyBestRankList",replyBestRankList);
		 
		return "home";
	}
	
	
	
	@RequestMapping(value = "/common/top.wow")
	public String top() {
		return "common/top";
	}
	
	@ResponseBody
	@RequestMapping(value = "/homeB2bList.wow")
	public Map<String, Object> homeB2bList(Locale locale, Model model, HttpSession session) {
		model.addAttribute("user", session.getAttribute("user"));
		
		//사업자 게시판 리스트 불러오기 (1~4)
		List<BusinessBoardVO> businessBoardList14= businessBoardServiceImpl.homeBoardList14();
		//사업자 게시판 리스트 불러오기 (5~8번)
		List<BusinessBoardVO> businessBoardList58= businessBoardServiceImpl.homeBoardList58();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("businessBoardList14", businessBoardList14);
		map.put("businessBoardList58", businessBoardList58);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/homenormalList.wow")
	public Map<String, Object> homenormalList(Locale locale, Model model, HttpSession session) {
		model.addAttribute("user", session.getAttribute("user"));
		
		//모임 게시판 리스트 불러오기 (1~4개)
		List<NormalBoardVO> normalBoardList14= normalBoardServiceImpl.homeNormalBoardList14();
		model.addAttribute("normalBoardList14",normalBoardList14);
		
		//모임 게시판 리스트 불러오기(5~8개)
		List<NormalBoardVO> normalBoardList58= normalBoardServiceImpl.homeNormalBoardList58();
		model.addAttribute("normalBoardList58",normalBoardList58);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("normalBoardList14", normalBoardList14);
		map.put("normalBoardList58", normalBoardList58);
		return map;
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "/homeNoticeList.wow")
	public Map<String, Object> homeNoticeList(Locale locale, Model model, HttpSession session) {
		model.addAttribute("user", session.getAttribute("user"));
		
		//공지사항 게시판 리스트 불러오기 (1~4개)
		List<NoticeVO> noticeBoardList14= noticeServiceImpl.noticeBoardList14();
		model.addAttribute("noticeBoardList14",noticeBoardList14);
		
		//공지사항 게시판 리스트 불러오기(5~8개)
		List<NoticeVO> noticeBoardList58= noticeServiceImpl.noticeBoardList58();
		model.addAttribute("noticeBoardList58",noticeBoardList58);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noticeBoardList14", noticeBoardList14);
		map.put("noticeBoardList58", noticeBoardList58);
		return map;
	}

	
}
