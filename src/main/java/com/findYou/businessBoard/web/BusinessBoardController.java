package com.findYou.businessBoard.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.findYou.attach.service.AttachServiceImpl;
import com.findYou.attach.vo.AttachVO;
import com.findYou.b2bParticipation.service.B2bParticipationService;
import com.findYou.b2bParticipation.vo.B2bParticipationVO;
import com.findYou.businessBoard.service.BusinessBoardServiceImpl;
import com.findYou.businessBoard.vo.BusinessBoardVO;
import com.findYou.businessBoard.vo.BusinessSearchBoardVO;
import com.findYou.code.vo.CodeVO;
import com.findYou.common.utils.StudyAttachUtils;
import com.findYou.exception.BizException;
import com.findYou.exception.BizNotEffectedException;
import com.findYou.exception.BizNotFoundException;
import com.findYou.member.service.MemberServiceImpl;
import com.findYou.member.vo.MemberVO;
import com.findYou.message.service.MessageServiceImpl;
import com.findYou.message.vo.MessageVO;
import com.findYou.reply.service.ReplyServiceImpl;

@Controller
public class BusinessBoardController {

	@Inject
	@Qualifier("businessBoardServiceImpl")
	BusinessBoardServiceImpl businessBoardServiceImpl;
	
	@Inject
	@Qualifier("replyServiceImpl")
	ReplyServiceImpl replyServiceImpl;
	
	@Inject
	@Qualifier("b2bParticipationService")
	B2bParticipationService b2bParticipation;
	
	@Inject
	@Qualifier("memberServiceImpl")
	MemberServiceImpl memberServiceImpl;
	
	@Inject
	@Qualifier("attachServiceImpl")
	AttachServiceImpl attachServiceImpl;

	
	@Inject
	StudyAttachUtils studyAttachUtils;
	
	@Inject
	MessageServiceImpl messageServiceImpl; 
	
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="businessBoard/businessBoardList.wow")
	public String businessBoardList(Model model,BusinessSearchBoardVO searchVO) {
		logger.info("BusinessSearchBoardVO={}", searchVO);
		model.addAttribute("searchVO",searchVO);
		List<BusinessBoardVO> businessBoardList= businessBoardServiceImpl.getBusinessBoardList(searchVO);
		AttachVO temp = new AttachVO();
		//게시글 당 1개의 첨부파일 이름을 리스트에 넣기위에 선언
		List<AttachVO> attach = new ArrayList<AttachVO>();
		try {
			for (int i = 0; i < businessBoardList.size(); i++) {
					
				temp.setAtchCategory("BUSINESS");
				temp.setAtchParentNo(businessBoardList.get(i).getB2bBoardIndex());
					AttachVO attachVO = attachServiceImpl.getAttachByParentNo(temp);
					attach.add(attachVO);
				 logger.info("+++++++++++++++++++++++++++++++=attach={}",attach.get(i).getAtchFileName());
				String color = businessBoardList.get(i).getB2bBoardTemplate();
				if(color.equals("CB00")) {
					businessBoardList.get(i).setB2bColor("#ffce67");
				}
				if(color.equals("DC00")) {
					businessBoardList.get(i).setB2bColor("#f3969a");
				}
			}
			model.addAttribute("attach", attach);
		} catch (BizNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		model.addAttribute("businessBoardList", businessBoardList);
		return "/businessBoard/businessBoardList";
	}
	
	
	@RequestMapping(value="businessBoard/businessBoardView.wow")
	public String businessBoardView(Model model, int b2bBoardIndex) {
		try{
			BusinessBoardVO getBoard = businessBoardServiceImpl.getBusinessBoard(b2bBoardIndex);
			MemberVO getMember = memberServiceImpl.getMember(getBoard.getB2bBoardWriter());
			model.addAttribute("getBoard", getBoard);
			model.addAttribute("getMember", getMember);
			int count = b2bParticipation.countPart(b2bBoardIndex);
			model.addAttribute("count", count);
			
			//첨부파일
			List<String> attachList = new ArrayList<String>();
			AttachVO attach = new AttachVO();
			attach.setAtchParentNo(b2bBoardIndex);
			attach.setAtchCategory("BUSINESS");
			List<AttachVO> tempList= attachServiceImpl.getAttaches(attach);
			for (int i = 0; i < tempList.size(); i++) {
				attachList.add(tempList.get(i).getAtchFileName());
			}
			model.addAttribute("attachList",attachList);
			
			
		}catch(BizNotFoundException e){
			e.printStackTrace();
		} catch (BizException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "/businessBoard/businessBoardView";
	}
	


	@ResponseBody
	@RequestMapping(value="/businessBoard/increseBusinessBoardHit.wow")
	public void increseBusinessBoardHit(@RequestParam("b2bBoardIndex") String b2bBoardIndex) {
		logger.info("BoardIndex={}", b2bBoardIndex);
		businessBoardServiceImpl.increseBusinessBoardHit(Integer.parseInt(b2bBoardIndex));
	}
	
	
	
	@RequestMapping(value="businessBoard/businessBoardEdit.wow")
	public String businessBoardEdit(Model model, int b2bBoardIndex, BusinessBoardVO businessBoard) {
		logger.info("b2bBoardIndex={}",b2bBoardIndex);
		BusinessBoardVO getBoard;
		try {
			getBoard = businessBoardServiceImpl.getBusinessBoard(b2bBoardIndex);
			logger.info("getBoard={}",getBoard);
			model.addAttribute("getBoard", getBoard);
			
			List<CodeVO> codeList= businessBoardServiceImpl.getCodeListByParent(getBoard.getB2bBoardTemplate());
			model.addAttribute("codeList", codeList);
			
			AttachVO attach = new AttachVO();
			attach.setAtchCategory("BUSINESS");
			attach.setAtchParentNo(b2bBoardIndex);
			List<AttachVO> attachVO= attachServiceImpl.getAttaches(attach);
			model.addAttribute("attachVO", attachVO);
			/*
			 * attachServiceImpl.b2bdeleteAttach(businessBoard.getAtchDelNo());
			 */
			
			
		} catch (BizNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch (BizException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}			
		
		return "/businessBoard/businessBoardEdit";
	}

	@RequestMapping(value="businessBoard/businessBoardModify.wow")
	public String updateBusinessBoard(Model model, BusinessBoardVO businessBoard,int[] atchDelNo
												,@RequestParam(value="boFiles", required = false) MultipartFile[] boFiles ) {
		BusinessBoardVO getBoard;
		try {
			List<AttachVO> tempList= null;
			List<AttachVO> attachList= new ArrayList<AttachVO>();
			getBoard = businessBoardServiceImpl.getBusinessBoard(businessBoard.getB2bBoardIndex());
			if(boFiles != null) {
			tempList= studyAttachUtils.getAttachListByMultiparts(boFiles, "BUSINESS", "business");
			for (int i = 0; i < tempList.size(); i++) {
				 AttachVO temp = tempList.get(i);
				 temp.setAtchParentNo(businessBoard.getB2bBoardIndex());
				 attachList.add(temp);
			}
			getBoard.setB2bAttaches(attachList);
			}
			getBoard.setB2bBoardTitle(businessBoard.getB2bBoardTitle());
			getBoard.setB2bBoardTemplate(businessBoard.getB2bBoardTemplate());
			getBoard.setB2bBoardCategory(businessBoard.getB2bBoardCategory()); 
			getBoard.setB2bBoardDeadlineNumber(businessBoard.getB2bBoardDeadlineNumber());
			getBoard.setB2bBoardZip(businessBoard.getB2bBoardZip());
			getBoard.setB2bBoardRoadAddress(businessBoard.getB2bBoardRoadAddress());
			getBoard.setB2bBoardDetailedAddr(businessBoard.getB2bBoardDetailedAddr());
			getBoard.setB2bBoardDate(businessBoard.getB2bBoardDate());
			getBoard.setB2bBoardHour(businessBoard.getB2bBoardHour());
			getBoard.setB2bBoardCost(businessBoard.getB2bBoardCost());
			getBoard.setB2bBoardContent(businessBoard.getB2bBoardContent());
			
			model.addAttribute("getBoard",getBoard);
			logger.info("getBoard={}",getBoard);
			int cnt = businessBoardServiceImpl.updateBusinessBoard(getBoard, atchDelNo);
			model.addAttribute("cnt", cnt);


			
			
			
		} catch (BizNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch(BizNotEffectedException e) {
			e.printStackTrace();
		}catch(IOException e) {
			e.printStackTrace();
		}
		  
		return "redirect:/businessBoard/businessBoardView.wow?b2bBoardIndex="+businessBoard.getB2bBoardIndex();
	}
	
	@RequestMapping(value="businessBoard/businessBoardDelete.wow")
	public String daleteBusinessBoard(Model model, BusinessBoardVO businessBoard) {
		BusinessBoardVO getBoard;
		try {
			getBoard = businessBoardServiceImpl.getBusinessBoard(businessBoard.getB2bBoardIndex());
			model.addAttribute("getBoard",getBoard);
			int cnt = businessBoardServiceImpl.deleteBusinessBoard(getBoard);
			
			int deleteCnt = b2bParticipation.deleteBusinessPartticipation(getBoard);
			
			int deleteAttachCnt = attachServiceImpl.deleteBusinessAttach(getBoard.getB2bBoardIndex());

			model.addAttribute("cnt", cnt);
		} catch (BizNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:/businessBoard/businessBoardList.wow";
	}
	
	@RequestMapping(value="businessBoard/businessBoardForm.wow")
	public String businessBoardForm(Model model, String b2bBoardTemplate) {
		model.addAttribute("b2bBoardTemplate", b2bBoardTemplate);
		List<CodeVO> codeList= businessBoardServiceImpl.getCodeListByParent(b2bBoardTemplate);
		model.addAttribute("codeList", codeList);
		return "businessBoard/businessBoardForm";
	}
	
	@RequestMapping(value="businessBoard/businessBoardTemplate.wow")
	public String templateBoard(Model model) {
		return "businessBoard/businessBoardTemplate";
	}
	
	
	@RequestMapping(value="businessBoard/businessBoardRegist.wow")
	public String insertbusinessBoard(Model model,BusinessBoardVO board, 
											@RequestParam(value="boFiles", required = false) MultipartFile[] boFiles ) {

		if(boFiles != null) {
			try {
				List<AttachVO>  attachList= studyAttachUtils.getAttachListByMultiparts(boFiles, "BUSINESS", "business");
				board.setB2bAttaches(attachList);
				
				businessBoardServiceImpl.insertBusinessBoard(board);
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}catch (BizNotEffectedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		
		return "redirect:/businessBoard/businessBoardList.wow";
	}
	
	@RequestMapping(value="/businessBoard/b2bUpDelButton.wow")
	public Map<String, Object> b2bUpDelButton(B2bParticipationVO partVO) {
		String b2bPartId = businessBoardServiceImpl.b2bUpDelButton(partVO);
		logger.info("======================b2bPartId={}", b2bPartId);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("data",b2bPartId);
		return map;
		
		
	}
	 
	@ResponseBody
	@RequestMapping(value="/businessBoard/b2bContent.wow")
	public Map<String, Object> b2bContent(@RequestParam("b2bBoardIndex") int b2bBoardIndex) {
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("/businessBoard/b2bContent.wow");
		 try {
			 logger.info("b2bBoardIndex={}", b2bBoardIndex);
			BusinessBoardVO getBoard = businessBoardServiceImpl.getBusinessBoard(b2bBoardIndex);
			String b2bContent = getBoard.getB2bBoardContent();
			map.put("b2bContent", b2bContent);
		} catch (BizNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return map;
	}
 
	
	//메세지 보내기
	@ResponseBody
	@RequestMapping(value="/businessBoard/businessBoardMessageSend.wow")
	public void messageInsert(MessageVO message) {
		try {
			messageServiceImpl.insertMessage(message);
		} catch (BizNotEffectedException e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	
	
	
}
