package com.findYou.login.web;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.findYou.common.utils.AuthHpNumberUtils;
import com.findYou.common.utils.CookieUtils;
import com.findYou.exception.BizNotFoundException;
import com.findYou.login.service.ILoginService;
import com.findYou.login.vo.UserVO;
import com.findYou.member.service.MemberServiceImpl;
import com.findYou.member.vo.MemberVO;

@Controller
public class LoginController {

	// 예외처리 메서드
	// NotFoundException
//	public String notFoundProc() {
//		
//	}
//	

	@Inject
	@Qualifier("loginServiceImpl")
	ILoginService loginService;
	
	@Inject
	@Qualifier("memberServiceImpl")
	MemberServiceImpl memberServiceImpl;
	

	// 로그인 겟으로 받을시
	@GetMapping(value = "/login/normalLogin.wow")
	public String normalLogin_get(Locale locale, Model model, String memRole // 일반,사업자 분류 파라미터
	) {
		
		return "login/normalLogin";
	}
	
	@GetMapping(value = "/login/businessLogin.wow")
	public String businessLogin_get(Locale locale, Model model, String memRole // 일반,사업자 분류 파라미터
	) {
		return "login/businessLogin";
	}

	// 로그인 포스트로 받을 시
	@ResponseBody
	@PostMapping(value = "/login/normalLogin.wow", produces="application/text;charset=utf-8")
	public String login_post(Model model, HttpServletRequest req, HttpServletResponse resp, @RequestParam(value="rememberMe", required = false) String rememberMe) throws BizNotFoundException, UnsupportedEncodingException{
		HttpSession session = req.getSession();

		String id=req.getParameter("memId");
		String pw=req.getParameter("memPass");
		String save_id=req.getParameter("rememberMe");
		System.out.println("memId = " + id);
		System.out.println("pw = " + pw);
		System.out.println("save_id = " + rememberMe);
		CookieUtils cookieUtils=new CookieUtils(req);
		if(save_id==null){
			if(cookieUtils.exist("SAVE_ID")){
				Cookie cookie=CookieUtils.createCookie("SAVE_ID",id,"/",0);
				resp.addCookie(cookie);
			}
			save_id="";
		}
		if((id==null||id.isEmpty() )|| (pw==null||pw.isEmpty())){	
			if(cookieUtils.exist("SAVE_ID")) {
				String memId = cookieUtils.getValue("SAVE_ID");
				model.addAttribute("memId", memId);
			}
			return "아이디 또는 비밀번호를 입력하지 않았습니다.";
			//return "redirect:/login/normalLogin.wow?msg="+ URLEncoder.encode("입력안함","utf-8");
		}

		MemberVO member = memberServiceImpl.getMember(id);
		UserVO user = new UserVO();
		if(member==null){
			if(cookieUtils.exist("SAVE_ID")) {
				String memId = cookieUtils.getValue("SAVE_ID");
				model.addAttribute("memId", memId);
			}
			return "아이디 또는 비밀번호를 잘못 입력 하셨습니다.";
			//return "redirect:/login/normalLogin.wow?msg="+ URLEncoder.encode("아이디 또는 비번 확인","utf-8");
		}else{ //id맞았을때 
			
			if(member.getMemRole().equals("business")) {
				return "아이디 또는 비밀번호를 잘못 입력 하셨습니다.";
			}
			
			if(member.getMemPass().equals(pw)){//다 맞는경우
				if(save_id.equals("Y")){
					resp.addCookie(
							CookieUtils.createCookie("SAVE_ID", id,"/",3600*24*7));
				}
				
				//로그인 성공시
				user.setUserId(member.getMemId());
				user.setUserName(member.getMemName());
				user.setUserRole(member.getMemRole());
				user.setUserChatNo(member.getMemChatNo());
				session.setAttribute("user",user);
				return "success";
				//return "redirect:/";
			}else{//  비번만 틀린경우
				if(cookieUtils.exist("SAVE_ID")) {
					String memId = cookieUtils.getValue("SAVE_ID");
					System.out.println("비번 틀릴 경우 memId = " + memId);
					model.addAttribute("memId", memId);
				}
				return "아이디 또는 비밀번호를 잘못 입력 하셨습니다.";
				//return "redirect:/login/normalLogin.wow?msg="+ URLEncoder.encode("아이디 또는 비번 확인","utf-8");
			}
		}

	}
	
	@ResponseBody
	@PostMapping(value = "/login/businessLogin.wow", produces="application/text;charset=utf-8")
	public String b2b_login_post(Model model, HttpServletRequest req, HttpServletResponse resp, @RequestParam(value="rememberMe", required = false) String rememberMe) throws BizNotFoundException, UnsupportedEncodingException{
		HttpSession session = req.getSession();

		String id=req.getParameter("memId");
		String pw=req.getParameter("memPass");
		String save_id=req.getParameter("rememberMe");
		System.out.println("memId = " + id);
		System.out.println("pw = " + pw);
		System.out.println("save_id = " + rememberMe);
		CookieUtils cookieUtils=new CookieUtils(req);
		if(save_id==null){
			if(cookieUtils.exist("SAVE_ID")){
				Cookie cookie=CookieUtils.createCookie("SAVE_ID",id,"/",0);
				resp.addCookie(cookie);
			}
			save_id="";
		}
		if((id==null||id.isEmpty() )|| (pw==null||pw.isEmpty())){	
			if(cookieUtils.exist("SAVE_ID")) {
				String memId = cookieUtils.getValue("SAVE_ID");
				model.addAttribute("memId", memId);
			}
			return "입력하세요.";
			//return "redirect:/login/normalLogin.wow?msg="+ URLEncoder.encode("입력안함","utf-8");
		}

		MemberVO member = memberServiceImpl.getMember(id);
		
		//권한
		
		UserVO user = new UserVO();
		if(member==null){
			if(cookieUtils.exist("SAVE_ID")) {
				String memId = cookieUtils.getValue("SAVE_ID");
				model.addAttribute("memId", memId);
			}
			return "아이디 또는 비밀번호를 잘못 입력 하셨습니다.";
			//return "redirect:/login/normalLogin.wow?msg="+ URLEncoder.encode("아이디 또는 비번 확인","utf-8");
		}else{ //id맞았을때 
			
			if(member.getMemRole().equals("normal")) {
				return "아이디 또는 비밀번호를 잘못 입력 하셨습니다.";
			}
			
			if(member.getMemPass().equals(pw)){//다 맞는경우
				if(save_id.equals("Y")){
					resp.addCookie(
							CookieUtils.createCookie("SAVE_ID", id,"/",3600*24*7));
				}
				
				//로그인 성공시
				user.setUserId(member.getMemId());
				user.setUserName(member.getMemName());
				user.setUserRole(member.getMemRole());
				user.setUserChatNo(member.getMemChatNo());
				session.setAttribute("user",user);
				return "success";
				//return "redirect:/";
			}else{//  비번만 틀린경우
				if(cookieUtils.exist("SAVE_ID")) {
					String memId = cookieUtils.getValue("SAVE_ID");
					System.out.println("비번 틀릴 경우 memId = " + memId);
					model.addAttribute("memId", memId);
				}
				return "아이디 또는 비밀번호를 잘못 입력 하셨습니다.";
				//return "redirect:/login/normalLogin.wow?msg="+ URLEncoder.encode("아이디 또는 비번 확인","utf-8");
			}
		}

	}
	
	
	

	// 로그아웃
	@RequestMapping(value = "/login/logout.wow")
	public String logOut(Model model, HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		session.removeAttribute("user");
		
		String uri = req.getHeader("REFERER"); 
		
		//23번째 부터
		//http:localhost:8080/
		//http:192.168.20.35:8080/
		System.out.println("before logout uri = " + uri);
		uri = uri.substring(22);
		
		if(uri.contains("?")) {
			String[] temp = uri.split("\\?");
			System.out.println("split uri = " + temp[0]);
		}
		
		System.out.println("after logout uri = " + uri);
		
		return "redirect:/" + uri;
	}
	//세션 전체 초기
	@RequestMapping(value = "/login/removeSession.wow")
	public String removeSession(HttpSession session) {

		session.invalidate();
		return "redirect:/";

	}
	
	// 아이디,비밀번호 찾기 일반,사업자 선택 화면
	@RequestMapping(value = "/login/loginFind.wow")
	public String loginFind(Locale locale, Model model, String memRole // 일반,사업자 분류 파라미터
			, String category// Id,Pass 찾기 분류 파라미터
	) {
		model.addAttribute("memRole", memRole);
		model.addAttribute("category", category);
	
		return "login/loginFind";
	}
	// 찾는 정보 입력 화면

	boolean a =false;
	@RequestMapping("/login/infoFind.wow") // 아이디 비밀번호 찾기 컨틀롤러
	public String infoFind(Model model, HttpServletRequest req, String memRole // 일반,사업자 분류 파라미터
			, String category// Id,Pass 찾기 분류 파라미터
			, @RequestParam(value = "Hp", required = false) String hp,
			@RequestParam(value = "Id", required = false) String Id, HttpSession session, HttpServletResponse response)
			throws Exception {
		
		session.removeAttribute("susses");
		model.addAttribute("memRole", memRole);
		model.addAttribute("category", category);
		List<MemberVO> memberList = loginService.getMemberList(null);


		if (Id == "undefined" || Id==null ) {
			for (MemberVO memberVO : memberList) {
				if (memberVO.getMemHp().equals(hp)) {
					if (memberVO.getMemRole().equals(memRole)) {
						String auth = AuthHpNumberUtils.Auth(hp); //핸드폰 번호 받기 
						session.setAttribute("auth", auth);
						session.setAttribute("hp", hp);
						session.setAttribute("Id", memberVO.getMemId());
						session.setAttribute("re_check","check");
						session.setAttribute("message", "인증번호를 확인해주세요.");
						System.out.println(memberVO.getMemId());
						System.out.println(session.getAttribute("message"));
						System.out.println("인증키값 " + auth);
						System.out.println("번호 " + hp);
						return "login/infoFind";
					}
				}
			}
		}
		
		if (Id !=  "undefined" &&Id != null) {
			for (MemberVO memberVO : memberList) {
				if (memberVO.getMemHp().equals(hp)) {
					if (memberVO.getMemId().equals(Id)) {
						if (memberVO.getMemRole().equals(memRole)) {
							String auth = AuthHpNumberUtils.Auth(hp);
							session.setAttribute("auth", auth);
							session.setAttribute("hp", hp);
							session.setAttribute("Id", Id);
							session.setAttribute("re_check","check");
							session.setAttribute("message", "인증번호를 확인해주세요.");
							System.out.println(Id);
							System.out.println("인증키값 " + auth);
							System.out.println("번호 " + hp);
							a= true;
							return "login/infoFind";
						}
					}
				}
				
			}
		}
//		System.out.println("세션"+session.getAttribute("x"));
//		System.out.println("세션"+session.getAttribute("hp"));
//		System.out.println("세션"+session.getAttribute("Id"));
//		System.out.println("세션"+session.getAttribute("auth"));
		
		
		return "login/infoFind";
		
	}

	
	@ResponseBody
	@RequestMapping("/login/confirm.wow") // 인증확인 컨트롤러
	public String confirm(Model model, String memRole // 일반,사업자 분류 파라미터
			, String category// Id,Pass 찾기 분류 파라미터
			, HttpSession session, @RequestParam(value = "Auth", required = false) String auth_reconfirm,
			@RequestParam(value = "Count", required = false) int count // 인증번호 실패 5회시 홈으로 세션삭제
			, @RequestParam(value = "Id", required = false) String Id // 인증번호 실패 5회시 홈으로 세션삭제
	) {

		session.removeAttribute("auth_reconfirm");
		System.out.println("확인" + auth_reconfirm);
		session.setAttribute("auth_reconfirm", auth_reconfirm);
		if (count == 5) {
			session.removeAttribute("hp");
			session.removeAttribute("auth");
		}
		List<MemberVO> memberList = loginService.getMemberList(null);
		for (MemberVO memberVO : memberList) {
			if (memberVO.getMemHp().equals(session.getAttribute("hp"))) { // 번호에 맞는 인증키 인증
				if (session.getAttribute("auth").equals(session.getAttribute("auth_reconfirm"))) { 
					session.setAttribute("susses", "susses");
					System.out.println("컨펌 아이디" + session.getAttribute("Id"));
					if (Id == null) { // 아이디 완료 세션삭제			
						session.removeAttribute("message");
						session.removeAttribute("auth_reconfirm");
						session.removeAttribute("auth");
						session.removeAttribute("susses");
						session.removeAttribute("hp");
						session.removeAttribute("Id");	
						String sussce= "fail";
						return sussce; // 정상진행
					}
				}
				
				 else {
						String sussce= "fail";
						return sussce; // 정상진행
				}
			}
		}
		String sussce= "fail";
		return sussce; // 오류발생
	
	}
	@ResponseBody
	@RequestMapping("login/loginModify.wow") // 수정 컨트롤러
	public String findModify(Model model, @RequestParam("memHp") String memHp, @RequestParam("memPass") String memPass,
			HttpSession session) {

	
		MemberVO member_hp = loginService.getMember_Hp(memHp);
		System.out.println(memPass);
		member_hp.setMemPass(memPass);
		loginService.memberModify(member_hp);
	
		// 비밀번호 완료 세션삭제
		session.removeAttribute("message");
		session.removeAttribute("auth_reconfirm");
		session.removeAttribute("auth");
		session.removeAttribute("susses");
		session.removeAttribute("hp");
		session.removeAttribute("Id");
		
		return "";
	}

}
