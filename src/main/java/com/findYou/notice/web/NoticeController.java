package com.findYou.notice.web;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.findYou.exception.BizNotEffectedException;
import com.findYou.notice.service.NoticeServiceImpl;
import com.findYou.notice.vo.NoticeVO;

@Controller
public class NoticeController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	@Qualifier("noticeServiceImpl")
	NoticeServiceImpl noticeService;
	
	@RequestMapping(value="managerBoard/noticeBoardList.wow")
	public String noticeList(Model model) {
		List<NoticeVO> list = noticeService.getNoticeList();
		model.addAttribute("list", list);
		
		return "/managerBoard/noticeBoardList";
	}
	
	
	
	@RequestMapping(value="managerBoard/noticeBoardRegist.wow")
	public String noticeBoardRegist(Model model) {
		
		return "/managerBoard/noticeBoardRegist";
	}
	
	@RequestMapping(value="/managerBoard/noticeBoardView.wow")
	public String noticeBoardView(Model model, HttpServletRequest req) {
		String noticeBoardIndex = req.getParameter("noticeBoardIndex");
		NoticeVO notice = noticeService.getNotice(noticeBoardIndex);
		model.addAttribute("notice", notice);
		return "/managerBoard/noticeBoardView";
	}
	
	@RequestMapping(value="/managerBoard/noticeBoardEdit.wow")
	public String noticeBoardEdit(Model model, HttpServletRequest req) {
		String noticeBoardIndex = req.getParameter("noticeBoardIndex");
		NoticeVO notice = noticeService.getNotice(noticeBoardIndex);
		model.addAttribute("notice", notice);
		
		
		return "/managerBoard/noticeBoardEdit";
	}
	@RequestMapping(value="/noticeBoard/noticeBoardModify.wow")
	public String noticeBoardModify(NoticeVO notice) {
		try {
			noticeService.updateNotice(notice);
		} catch (BizNotEffectedException e) {
			e.printStackTrace();
		}
		
		return "redirect:/managerBoard/noticeBoardList.wow";
	}
	
	@RequestMapping(value="/noticeBoard/noticeBoardDelete.wow")
	public String noticeBoardDelete(NoticeVO notice) {
		try {
			noticeService.deleteNotice(notice);
		} catch (BizNotEffectedException e) {
			e.printStackTrace();
		}
		
		return "redirect:/managerBoard/noticeBoardList.wow";
	}

	@RequestMapping("/managerBoard/noticeRegistDB.wow")
	public String joinDB(@ModelAttribute("member")NoticeVO notice) {
		logger.info("조인 : noticeVO notice={}", notice);
		System.out.println("조인컨트롤러"+notice);
		try {
			noticeService.insertNoticeBoard(notice);
		} catch (BizNotEffectedException e) {
			e.printStackTrace();
		}
		
		return "redirect:/managerBoard/noticeBoardList.wow";
	}
	
	
	@ResponseBody
	@RequestMapping(value="/notice/noticeContent", produces="applictaion/text; charset=utf-8")
	public String getNoticeContent(@RequestParam("noticeBoardIndex") String noticeBoardIndex) {
		String text = "";
		NoticeVO notice = noticeService.getNotice(noticeBoardIndex);
		if(notice != null) {			
			text = notice.getNoticeBoardContent();
		}
		return text;
	}
	
	
	
}
