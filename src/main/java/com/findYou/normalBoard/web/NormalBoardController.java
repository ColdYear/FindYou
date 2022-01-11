package com.findYou.normalBoard.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import javax.validation.groups.Default;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.findYou.attach.service.AttachServiceImpl;
import com.findYou.attach.vo.AttachVO;
import com.findYou.blackList.service.BlackListServiceImpl;
import com.findYou.blackList.vo.BlackListVO;
import com.findYou.code.service.CodeServiceImpl;
import com.findYou.code.vo.CodeVO;
import com.findYou.common.utils.StudyAttachUtils;
import com.findYou.exception.BizException;
import com.findYou.exception.BizNotEffectedException;
import com.findYou.exception.BizNotFoundException;
import com.findYou.login.vo.UserVO;
import com.findYou.member.service.MemberServiceImpl;
import com.findYou.member.vo.MemberVO;
import com.findYou.normalBoard.service.NormalBoardServiceImpl;
import com.findYou.normalBoard.vo.NormalBoardVO;
import com.findYou.normalBoard.vo.NormalSearchBoardVO;
import com.findYou.participation.service.ParticipationServiceImpl;
import com.findYou.participation.vo.ParticipationVO;
import com.findYou.score.service.ScoreServiceImpl;
import com.findYou.score.vo.ScoreVO;

@Controller
public class NormalBoardController {

	@Inject
	CodeServiceImpl codeServiceImpl;

	@Inject
	NormalBoardServiceImpl normalBoardServiceImpl;

	@Inject
	MemberServiceImpl memberServiceImpl;

	@Inject
	StudyAttachUtils attachUtils;

	@Inject
	AttachServiceImpl attachServiceImpl;

	@Inject
	ParticipationServiceImpl participationServiceImpl;
	
	@Inject
	ScoreServiceImpl scoreServiceImpl;
	
	@Inject
	BlackListServiceImpl blackListServiceImpl;
	
	@ModelAttribute("foodList")
	public List<CodeVO> getFoodList(){
		return codeServiceImpl.getCodeListByParent("FD00");
	}
	
	@ModelAttribute("hobbyList")
	public List<CodeVO> getHobbyList(){
		return codeServiceImpl.getCodeListByParent("HB00");
	}
	
	@ModelAttribute("clubList")
	public List<CodeVO> getClubList(){
		return codeServiceImpl.getCodeListByParent("CB00");
	}


	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = "/normalBoard/normalBoardList.wow")
	public String normalBoardlist_post(Model model, NormalSearchBoardVO search) {
		logger.info("NormalBoardSearchVO = {}", search);

		model.addAttribute("normalBoardSearchVO", search);
		List<NormalBoardVO> normalList = normalBoardServiceImpl.getNormalBoardList(search);
		List<AttachVO> attachList = new ArrayList<AttachVO>();
		if (normalList.size() != 0) {
			logger.info("normalList - FISRT - COLOR : {}", normalList.get(0).getNormalBoardColor());
			AttachVO attach = null;
			AttachVO temp = new AttachVO();
			for (NormalBoardVO list : normalList) {
				int parentNo = list.getNormalBoardIndex();
				temp.setAtchCategory("NORMAL");
				temp.setAtchParentNo(parentNo);
				try {
					attach = attachServiceImpl.getAttachByParentNo(temp);
					attachList.add(attach);
				} catch (BizNotFoundException ebf) {
					ebf.printStackTrace();
				}
			}
			logger.info("attachList = {}", attachList);
		}
		model.addAttribute("normalList", normalList);
		model.addAttribute("attachList", attachList);
		return "normalBoard/normalBoardList";
	}

	@RequestMapping(value = "/normalBoard/normalBoardView.wow")
	public String normalBoardView(Model model,
			@RequestParam(value = "normalBoardIndex", required = false) String index) {
		try {
			NormalBoardVO normalBoardVO = normalBoardServiceImpl.getNormalBoard(index);
			logger.info("NormalBoardVO = {}", normalBoardVO);
			AttachVO attach = new AttachVO();
			try {
				attach.setAtchCategory("NORMAL");
				attach.setAtchParentNo(Integer.parseInt(index));
				List<AttachVO> attachList = attachServiceImpl.getAttaches(attach);
				model.addAttribute("attachList", attachList);

				int cnt = participationServiceImpl.joinMemberCount(Integer.parseInt(index));
				model.addAttribute("cnt", cnt);

				MemberVO member = memberServiceImpl.getMember(normalBoardVO.getNormalBoardWriter());
				char gender = member.getMemGender();
				
				//사진판단
				BlackListVO blackMember = blackListServiceImpl.getBlackList(normalBoardVO.getNormalBoardWriter());
				logger.info("blackmember = {}", blackMember);
				
				if(blackMember != null) {
					model.addAttribute("gender", "criminal");
				}else {					
					if (gender == '남') {
						model.addAttribute("gender", "man");
					} else {
						model.addAttribute("gender", "woman");
					}
				}
				
				
				
				
				List<ScoreVO> scoreVO = scoreServiceImpl.checkMemberYn(normalBoardVO.getNormalBoardWriter());
				logger.info("scoreVO.size = {}", scoreVO.size());
				double temp_score = 0.0;
				String score = "";
				if(scoreVO.size() > 0) {
					temp_score = scoreServiceImpl.getScoreById(normalBoardVO.getNormalBoardWriter());
					score = String.format("%.1f", temp_score); 
				}else {
					score = "0";
				}
								
				model.addAttribute("score", score);

			} catch (BizException e) {
				e.printStackTrace();
			}

			model.addAttribute("normalBoardVO", normalBoardVO);
		} catch (BizNotFoundException ebf) {
			ebf.printStackTrace();
		}
		return "normalBoard/normalBoardView";
	} // normalBoardView

	@RequestMapping(value = "/normalBoard/normalBoardTemplate.wow")
	public String normalBoardTemplate() {

		return "normalBoard/normalBoardTemplate";
	}

	@RequestMapping(value = "/normalBoard/normalBoardForm.wow")
	public String normalBoardForm(Model model, String category, @ModelAttribute("normalBoardVO") NormalBoardVO normalBoardVO) {
		logger.info("category = {}", category);
		//getCodeList(model, category);
		
		model.addAttribute("normalBoardTemplate", category); // HB00 , CB00, FD00
		return "normalBoard/normalBoardForm";

	}

	@RequestMapping(value = "/normalBoard/normalBoardEdit.wow")
	public String normalBoardEdit(Model model, @RequestParam("normalBoardIndex") String index) {

		try {
			NormalBoardVO normalBoardVO = normalBoardServiceImpl.getNormalBoard(index);
			model.addAttribute("normalBoardVO", normalBoardVO);
			logger.info("NormalBoardVO = {}", normalBoardVO);
			getCodeList(model, normalBoardVO.getNormalBoardTemplate());
			AttachVO attach = new AttachVO();
			try {
				attach.setAtchCategory("NORMAL");
				attach.setAtchParentNo(Integer.parseInt(index));
				List<AttachVO> attachList = attachServiceImpl.getAttaches(attach);
				model.addAttribute("attachList", attachList);
			} catch (BizException e) {
				e.printStackTrace();
			}

		} catch (BizNotFoundException ebf) {
			ebf.printStackTrace();
		}
		return "normalBoard/normalBoardEdit";
	}

	@RequestMapping(value = "/normalBoard/normalBoardModify.wow")
	public String normalBoardModify(NormalBoardVO normalBoardVO, @RequestParam("boFiles") MultipartFile[] boFiles,
			@RequestParam(value = "atchDelNo", required = false) int[] atchDelNo, HttpSession session)
			throws IOException {
		try {
			normalBoardVO = settingNormalBoardVO(normalBoardVO);
			UserVO user = (UserVO) session.getAttribute("user");
			normalBoardVO.setNormalBoardWriter(user.getUserId());
			logger.info("NormalBoardVO = {}", normalBoardVO);

			if (boFiles != null) {
				List<AttachVO> attachList = attachUtils.getAttachListByMultiparts(boFiles, "NORMAL", "normal");
				normalBoardVO.setAttaches(attachList);
			}
			normalBoardServiceImpl.modifyNormalBoard(normalBoardVO, atchDelNo);
		} catch (BizNotEffectedException ebe) {
			ebe.printStackTrace();
		}
		return "redirect:/normalBoard/normalBoardView.wow?normalBoardIndex=" + normalBoardVO.getNormalBoardIndex();
	}

	@RequestMapping(value = "/normalBoard/normalBoardDelete.wow")
	public String normalBoardDelete(String normalBoardIndex) {
		try {
			normalBoardServiceImpl.removeNormalBoard(normalBoardIndex);
			participationServiceImpl.foreverDelete(normalBoardIndex);
			logger.info("normalBoardIndex = {}", normalBoardIndex);
		} catch (BizNotEffectedException ebe) {
			ebe.printStackTrace();
		}
		return "redirect:/normalBoard/normalBoardList.wow";
	}

	@RequestMapping(value = "/normalBoard/normalBoardRegist.wow")
	public String normalBoardRegist(Model model,
			@RequestParam(value = "boFiles", required = false) MultipartFile[] boFiles,
			HttpSession req,
			@Validated(value = { Default.class }) @ModelAttribute("normalBoardVO") NormalBoardVO normalBoardVO,
			BindingResult error) throws IOException {
		
		logger.info("before if NormalBoardVO = {}", normalBoardVO);
		
		if (error.hasErrors()) {
			String template = normalBoardVO.getNormalBoardTemplate();
			if(template.contains(",")) {				
				String[] temp = template.split(",");
				normalBoardVO.setNormalBoardTemplate(temp[1]);
			}
			logger.info("after if NormalBoardVO = {}", normalBoardVO);
			model.addAttribute("normalBoardVO",normalBoardVO);
			return "normalBoard/normalBoardForm";
		}

		logger.info("NormalBoardVO = {}", normalBoardVO);

		try {
			if (boFiles != null) {
				List<AttachVO> attachList = attachUtils.getAttachListByMultiparts(boFiles, "NORMAL", "normal");
				normalBoardVO.setAttaches(attachList);
			}
			UserVO user = (UserVO) req.getAttribute("user");
			logger.info("@@사용자 정보@@ = {}", user);
			normalBoardVO.setNormalBoardWriter(user.getUserId());
			logger.info("normalBoard = {}", normalBoardVO);
			String template = normalBoardVO.getNormalBoardTemplate();
			if(template.contains(",")) {				
				String[] temp = template.split(",");
				normalBoardVO.setNormalBoardTemplate(temp[1]);
			}
			normalBoardServiceImpl.insertNormalBoard(normalBoardVO);

			// 활동내역 테이블에 삽입
			ParticipationVO joinMember = settingParticipationVO(normalBoardVO);
			participationServiceImpl.modifyJoinMember(joinMember);
		} catch (BizNotEffectedException | BizNotFoundException ebe) {
			ebe.printStackTrace();
		}
		return "redirect:/normalBoard/normalBoardList.wow";
	}

	@ResponseBody
	@RequestMapping(value = "/normalBoard/increaseNormalBoardHit")
	public void increaseNormalBoardHit(String normalBoardIndex) {
		logger.info("조회수 증가 normalBoardIndex = {}", normalBoardIndex);

		try {
			normalBoardServiceImpl.increaseNormalBoardHit(normalBoardIndex);
		} catch (BizNotEffectedException ebe) {
			ebe.printStackTrace();
		}
	}

	public NormalBoardVO settingNormalBoardVO(NormalBoardVO normalBoardVO) {
		try {
			NormalBoardVO tempBoardVO = normalBoardServiceImpl
					.getNormalBoard(Integer.toString(normalBoardVO.getNormalBoardIndex()));
			tempBoardVO.setNormalBoardTitle(normalBoardVO.getNormalBoardTitle());
			tempBoardVO.setNormalBoardCategory(normalBoardVO.getNormalBoardCategory());
			tempBoardVO.setNormalBoardDeadlineNumber(normalBoardVO.getNormalBoardDeadlineNumber());
			tempBoardVO.setNormalBoardRoadAddress(normalBoardVO.getNormalBoardRoadAddress());
			tempBoardVO.setNormalBoardDetailedAddr(normalBoardVO.getNormalBoardDetailedAddr());
			tempBoardVO.setNormalBoardDate(normalBoardVO.getNormalBoardDate());
			tempBoardVO.setNormalBoardHour(normalBoardVO.getNormalBoardHour());
			tempBoardVO.setNormalBoardContent(normalBoardVO.getNormalBoardContent());
			tempBoardVO.setNormalBoardCost(normalBoardVO.getNormalBoardCost());

			return tempBoardVO;
		} catch (BizNotFoundException ebf) {
			ebf.printStackTrace();
		}
		return null;
	}

	public ParticipationVO settingParticipationVO(NormalBoardVO normalBoardVO) {
		ParticipationVO tempPartVO = new ParticipationVO();
		tempPartVO.setNormalPartId(normalBoardVO.getNormalBoardWriter());
		tempPartVO.setNormalPartBoardNumber(normalBoardVO.getNormalBoardIndex());
		tempPartVO.setNormalPartAddr(
				normalBoardVO.getNormalBoardRoadAddress() + " " + normalBoardVO.getNormalBoardDetailedAddr());
		tempPartVO.setNormalPartMemberCount(0);
		return tempPartVO;
	}

	public void getCodeList(Model model, String category) {
		List<CodeVO> codeList = null;
		codeList = codeServiceImpl.getCodeListByParent(category);
		model.addAttribute("codeList", codeList);
	}
	
	
	
	
	
	

}
