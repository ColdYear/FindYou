package com.findYou.member.web;



import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.findYou.b2bParticipation.service.B2bParticipationService;
import com.findYou.blackList.service.BlackListServiceImpl;
import com.findYou.blackList.vo.BlackListVO;
import com.findYou.businessBoard.service.BusinessBoardServiceImpl;
import com.findYou.common.utils.AuthHpNumberUtils;
import com.findYou.common.utils.CrawlingUtils;
import com.findYou.exception.BizNotEffectedException;
import com.findYou.exception.BizNotFoundException;
import com.findYou.login.service.ILoginService;
import com.findYou.login.vo.UserVO;
import com.findYou.member.service.IMemberService;
import com.findYou.member.service.MemberServiceImpl;
import com.findYou.member.vo.MemberVO;
import com.findYou.message.service.MessageServiceImpl;
import com.findYou.normalBoard.service.NormalBoardServiceImpl;
import com.findYou.normalBoard.vo.NormalBoardVO;
import com.findYou.participation.service.ParticipationServiceImpl;
import com.findYou.participation.vo.ParticipationVO;
import com.findYou.score.service.ScoreServiceImpl;
import com.findYou.score.vo.ScoreVO;

import edu.emory.mathcs.backport.java.util.Arrays;

@Controller
@SessionAttributes("member")
public class JoinController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Inject
	@Qualifier("memberServiceImpl")
	IMemberService memberService;

	@Inject
	@Qualifier("loginServiceImpl")
	ILoginService loginService;

	@Inject
	@Qualifier("participationServiceImpl")
	ParticipationServiceImpl participationServiceImpl;

	@Inject
	@Qualifier("b2bParticipationService")
	B2bParticipationService b2bparticipationService;

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
	MessageServiceImpl messageServiceImpl;
	
	@Inject
	BlackListServiceImpl BlackListServiceImpl;
	
	@Inject
	@Qualifier("memberServiceImpl")
	MemberServiceImpl memberServiceImpl;

	@ModelAttribute("member")
	public MemberVO memberSession() {
		return new MemberVO();
	}

	@RequestMapping("/join/normalJoinForm.wow")
	public String normalJoin(Model model, @ModelAttribute("member") MemberVO member) {

		CrawlingUtils crawlingUtils = new CrawlingUtils();
		try{
			String text = crawlingUtils.getCriminalInfo(member.getMemHp());
		}catch(InterruptedException e) {
			e.printStackTrace();
		}
		
		return "join/normalJoinForm";
	}

	@RequestMapping("/join/businessJoinForm.wow")
	public String businessJoin(Model model, @ModelAttribute("member") MemberVO member) {

		return "join/businessJoinForm";

	}

	@RequestMapping("/mypage/normalMyPage.wow")
	public String normalMyPage(Model model, @ModelAttribute("member") MemberVO member) {

		return "mypage/normalMyPage";

	}

	@RequestMapping("/mypage/businessMyPage.wow")
	public String businessMyPage(Model model, @ModelAttribute("member") MemberVO member) {

		return "mypage/businessMyPage";

	}

	@RequestMapping("/mypage/myPage.wow")
	public String myPage(Model model, HttpSession session) {

		UserVO user = (UserVO) session.getAttribute("user");
		String userId = user.getUserId();

		try {
			MemberVO member = memberService.getMember(userId);
			
			//블랙리스트체크
			BlackListVO blackMember = BlackListServiceImpl.getBlackList(member.getMemId());
			if(blackMember != null) {
				member.setMemGender('적');
				model.addAttribute("gender", "criminal");
			}else {
				if(member.getMemGender() == '남') {					
					model.addAttribute("gender", "man");
				}else {
					model.addAttribute("gender", "woman");
				}
			}
			
			
			//평점
			double temp_score = scoreServiceImpl.getScoreById(member.getMemId());
			String score = String.format("%.1f", temp_score);
			model.addAttribute("score", score);
			
			model.addAttribute("member", member);

			ParticipationVO part = new ParticipationVO();
			part.setNormalPartId(userId);

			List<String> partList = participationServiceImpl.getBoardNumberListById(part);
			List<String> titleList = new ArrayList<String>();

			for (int i = 0; i < partList.size(); i++) {
				NormalBoardVO board = normalBoardServiceImpl.getNormalBoard(partList.get(i));
				titleList.add(board.getNormalBoardTitle());
			}

			logger.info("titleList = {}", titleList);
			model.addAttribute("partList", partList);
			model.addAttribute("titleList", titleList);
			
			//내가 만든 모임 리스트
			List<NormalBoardVO> normalBoardList= normalBoardServiceImpl.myPageMeetingList(userId);
			model.addAttribute("normalBoardList", normalBoardList);
			
			
			
			
			
		} catch (BizNotFoundException e) {
			e.printStackTrace();
		}
		return "mypage/myPage";
	}
	
	
	
	@ResponseBody
	@RequestMapping("/myPage/evaluateYN")
	public Map<String, Object> evaluateYN(
			@RequestParam(value = "normalBoardNum", required = false) String[] normalBoardNum,
			@RequestParam(value = "memberScoreTester") String id) {
		Map<String, Object> map = new HashMap<String, Object>();

		if (normalBoardNum != null) {

			logger.info("boardNum = {}", Arrays.asList(normalBoardNum));
			logger.info("memberScoreTester = {}", id);

			// 평가하기 버튼 존재 유무 로직
			List<String> boolList = boolCheck(normalBoardNum, id);
			map.put("boolList", boolList);

			// 활동 내역 가져오기...
			try {
				ParticipationVO part = new ParticipationVO();
				part.setNormalPartId(id);

				List<String> partList = participationServiceImpl.getBoardNumberListById(part);
				List<String> titleList = getTitleList(partList);

				logger.info("titleList = {}", titleList);
				map.put("titleList", titleList);
				map.put("partList", partList);
				map.put("length", boolList.size());
				logger.info("titleList.size = {}", titleList.size());
				logger.info("partList.size = {}", partList.size());
				logger.info("boolList.size = {}", boolList.size());
				
				//쪽지 읽었는지 여부 결정 -> 쪽지함 버튼에 new표시 여부 결정
				int readCount = messageServiceImpl.checkReadYn();
				//쪽지를 이미 다 읽은 상태
				if(readCount <= 0) {
					map.put("checkRead", true);
				}else {
					map.put("checkRead", false);
				}
			} catch (BizNotFoundException e) {
				e.printStackTrace();
			}
		}

		return map;
	}

//게시글 번호에 해당하는 사람들 중 내가 평가안한사람만 보여주게하기
	@ResponseBody
	@RequestMapping("/myPage/evaluate")
	public Map<String, Object> evaluate(@RequestParam("normalBoardNum") String normalBoardNum,
			@RequestParam String normalBoardId) {
		Map<String, Object> map = new HashMap<String, Object>();
		logger.info("normalBoardNum = {}", normalBoardNum);
		logger.info("normalBoardId = {}", normalBoardId);
		try {
			ScoreVO score = new ScoreVO();
			score.setMemberScoreBoardNumber(Integer.parseInt(normalBoardNum));
			score.setMemberScoreTester(normalBoardId);
			List<ScoreVO> scoreList = scoreServiceImpl.getScoreList(score);
			List<ParticipationVO> tempPartList = participationServiceImpl
					.getJoinMemberListByIndex(Integer.parseInt(normalBoardNum));
			logger.info("first scoreList = {}", scoreList);
			logger.info("before list = {}", tempPartList);

			// partList에서 normalBoardId(테스터)가 테스트한 사람은 제외시켜야 한다.
			List<ParticipationVO> finalList = new ArrayList<ParticipationVO>();
			int scoreLength = scoreList.size();

			if (scoreLength != 0) {
				for (int i = 0; i < scoreLength; i++) {
					String testedId = scoreList.get(i).getMemberScoreId();
					for (int j = 0; j < tempPartList.size(); j++) {
						String partListId = tempPartList.get(j).getNormalPartId();
						if (testedId.equals(partListId)) {
							tempPartList.remove(j);
						}
					}
				}
				logger.info("mid list = {}", tempPartList);

				// 자기 자신 빼면 된다.
				for (int i = 0; i < tempPartList.size(); i++) {
					if (!normalBoardId.equals(tempPartList.get(i).getNormalPartId())) {
						finalList.add(tempPartList.get(i));
					}
				}
			} else {
				for (int i = 0; i < tempPartList.size(); i++) {
					if (!normalBoardId.equals(tempPartList.get(i).getNormalPartId())) {
						finalList.add(tempPartList.get(i));
					}
				}
			}

			logger.info("after list = {}", finalList);
			map.put("length", finalList.size());
			map.put("list", finalList);
		} catch (NumberFormatException | BizNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/myPage/insertScore", produces = "application/json;charset=utf-8")
	public String insertScore(@RequestParam("memberScoreId") String[] id, @RequestParam("memberScore") Integer[] score,
			@RequestParam("memberScoreBoardNumber") int memberScoreBoardNumber,
			@RequestParam("memberScoreTester") String tester, HttpServletResponse response) {

		logger.info("@@id = {}", Arrays.asList(id));
		logger.info("@@score = {}", Arrays.asList(score));
		logger.info("@@tester = {}", tester);

		try {
			ScoreVO scoreVO = new ScoreVO();
			for (int i = 0; i < id.length; i++) {
				if (score[i] == 0) {
					continue;
				} else {
					scoreVO.setMemberScoreId(id[i]);
					scoreVO.setMemberScore(Integer.toString(score[i]));
					scoreVO.setMemberScoreBoardNumber(memberScoreBoardNumber);
					scoreVO.setMemberScoreTester(tester);
					scoreServiceImpl.insertScore(scoreVO);
				}
			}
			// 활동내역 셋팅하자..
		} catch (BizNotEffectedException ebe) {
			ebe.printStackTrace();
		}
		response.setCharacterEncoding("UTF-8");
		return "평가를 완료하였습니다.";
	}

	@RequestMapping("/join/joinStep1.wow")
	public String joinStep1(Model model) {
		return "join/joinStep1";

	}

	@RequestMapping("/join/joinStep2.wow")
	public String joinStep2(Model model, String memRole, @ModelAttribute("member") MemberVO member) {
		logger.info("step2 : memberVO member={}", member);
		model.addAttribute("member", member);
		model.addAttribute("memRole", memRole);

		return "join/joinStep2";

	}

	@RequestMapping("/join/joinStep3.wow")
	public String joinStep3(Model model, String memRole, @ModelAttribute("member") MemberVO member, String hp,
			HttpSession session) {
		logger.info("step3 : memberVO member={}", member);
		model.addAttribute("memRole", memRole);
//		String auth = AuthHpNumberUtils.Auth(hp);
//		session.setAttribute("auth", auth);
//		System.out.println(auth);
		
		return "join/joinStep3";
	}
	
	
	@ResponseBody
	@RequestMapping(value="/join/receiveAuthNumber.wow")
	public Map<String,Object> receiveAuthNumber(@RequestParam("Hp") String Hp, HttpSession session) {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		CrawlingUtils crawlingUtils = new CrawlingUtils();
		try {
			logger.info("hp = {}", Hp);
			String auth = AuthHpNumberUtils.Auth(Hp);
			session.setAttribute("auth", auth);
			System.out.println(auth);
			
			String res = crawlingUtils.getCriminalInfo(Hp);
			if(res.equals("최근 3개월 내 3건 이상 접수된 민원이 없습니다.")) {
				res = "가능";
			}else {
				res = "불가능";
			}
			map.put("hp", res);
			map.put("auth", auth);
			return map;
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	

	@ResponseBody
	@RequestMapping(value="/join/joinAuthcheck.wow", produces="application/text; charset=utf-8")
	public String joinAuthcheck(Model model, String memRole, @ModelAttribute("member") MemberVO member,
			String auth_reconF, String memName, String memEmail, String memHp, String memGender, HttpSession session) {
		logger.info("step3 : memberVO member={}", member);
		model.addAttribute("memRole", memRole);
		System.out.println(memName);
		if (session.getAttribute("auth").equals(auth_reconF)) {
			session.setAttribute("Sucess", "Sucess");
			session.setAttribute("memName", memName);
			session.setAttribute("memEmail", memEmail);
			session.setAttribute("memHp", memHp);
			session.setAttribute("memGender", memGender);
			session.setAttribute("auth_reconF", auth_reconF);
			session.setAttribute("re_check", "check");
			System.out.println("성공");
			return "인증 완료";
		}

		return "인증실패";

	}

//세션 전체 초기
	@RequestMapping(value = "/join/removeSession.wow")
	public String removeSession(HttpSession session) {

		session.invalidate();
		return "redirect:/";

	}

	@RequestMapping("/join/joinDB.wow")
	public String joinDB(@ModelAttribute("member") MemberVO member) {
		logger.info("조인 : memberVO member={}", member);
		System.out.println("조인컨트롤러" + member);
		memberService.insertMember(member);
		if (member.getMemRole().equals("business")) {
			return "redirect:/login/businessLogin.wow?";
		} else {
			return "redirect:/login/normalLogin.wow?";
		}
	}

	@RequestMapping("/join/modify.wow")
	public String modify(MemberVO member) {
		logger.info("수정 : memberVO member={}", member);
		memberService.modifyMember(member);

		return "redirect:/mypage/myPage.wow?userId=" + member.getMemId();
	}

	@ResponseBody
	@RequestMapping("/join/delete")
	public String delete(@RequestParam("id") String id, HttpSession session) {
		logger.info("아이디={}", id);
		session.invalidate();
		MemberVO member = new MemberVO();
		member.setMemId(id);
		memberService.removeMember(member);
		return "";
	}

	@ResponseBody
	@RequestMapping(value = "/join/idCheck.wow", produces = "application/json; charset=UTF-8")
	public Map<String, Object> idCheck(String memId) {
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("@@@@@memId=" + memId);
		List<MemberVO> temp = loginService.getMemberList(null);
		for (MemberVO member : temp) {
			System.out.println(member.getMemId());

			if (member.getMemId().equals(memId)) {
				System.out.println(member.getMemId());
				map.put("result", "check");
				map.put("text", "사용중인 아이디입니다.");
				return map;
			}
		}
		map.put("result", "check");
		map.put("text", "사용 가능한 아이디입니다.");
		return map;

	}

//평가하기 버튼 존재 유무 로직
	private List<String> boolCheck(String[] normalBoardNum, String id) {
		ScoreVO score = new ScoreVO();
		List<String> boolList = new ArrayList<String>();
		String text_num = "";
		for (int i = 0; i < normalBoardNum.length; i++) {
			if (normalBoardNum.length >= 2) {
				text_num = removeSpecialText(normalBoardNum[i]);
				score.setMemberScoreBoardNumber(Integer.parseInt(text_num));
			} else {
				text_num = removeSpecialText(normalBoardNum[i]);
				text_num = removeSpecialText(text_num);
				score.setMemberScoreBoardNumber(Integer.parseInt(text_num));
			}
			score.setMemberScoreTester(id);
			boolean flag = scoreServiceImpl.checkEvaluate(score);
			String check = Boolean.toString(flag);
			boolList.add(check);
		}
		return boolList;
	}

	private String removeSpecialText(String text) {
		String[] temp;
		String tempNum = "";
		if (text.contains("[")) {
			temp = text.split("\\[");
			tempNum = temp[1];
		} else if (text.contains("]")) {
			temp = text.split("\\]");
			tempNum = temp[0];
		} else {
			return text;
		}
		return tempNum;
	}

//활동 내역 가져오기...

//게시글 번호주면 게시글 제목으로 반환
	private List<String> getTitleList(List<String> partList) {
		List<String> titleList = new ArrayList<String>();
		NormalBoardVO board;
		try {
			for (int i = 0; i < partList.size(); i++) {
				board = normalBoardServiceImpl.getNormalBoard(partList.get(i));
				titleList.add(board.getNormalBoardTitle());
			}
		} catch (BizNotFoundException e) {
			e.printStackTrace();
		}

		return titleList;
	}

	//마이페이지에서 게시글에 해당하는 참여 목록 보기
		@ResponseBody
		@RequestMapping(value="/myPage/ParticipationList.wow")
		public Map<String, Object> mypageBoardParticipationList(int normalPartBoardIndex) {
			Map<String, Object> map = new HashMap<String, Object>();
			try {
				//참여목록 불러오기
				List<ParticipationVO> partVO= participationServiceImpl.getJoinMemberListByBoardIndex(normalPartBoardIndex);
				;
				
				//사진 파일 이름 불러오기
				String gender = null;
				int count = 0;
				for (int i = 0; i < partVO.size(); i++) {
					String partId = partVO.get(i).getNormalPartId();
					MemberVO member = memberServiceImpl.getMember(partId);
					char gen = member.getMemGender();
					String id = member.getMemId();
					
					List<BlackListVO> blackList= BlackListServiceImpl.businessGenderCheck();
					
					if(gen == '남') {
						partVO.get(i).setGender("man.png");
					}else {
						partVO.get(i).setGender("woman.png");
					}
					for (int j = 0; j < blackList.size(); j++) {
						if(blackList.get(j).getMemId().equals(id)) {
							partVO.get(i).setGender("criminal.png");
							count++;
						}
					}
				}
				map.put("count", count);
				map.put("partVO", partVO);
			} catch (BizNotFoundException e) {
				e.printStackTrace();
			}
			return map;
		}
		
			//브랙리스트 내보내기
			@ResponseBody
			@RequestMapping(value="/myPage/blackOut.wow")
			public void blackOut(ParticipationVO partVO) {
				try {
					participationServiceImpl.deleteParticipationMember(partVO);
				} catch (BizNotEffectedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
	
	
	
}