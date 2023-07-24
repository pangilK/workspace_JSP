package service;

import java.io.IOException;

import beans.MemberVO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import repositories.MemberDAOImpl;

public class MemberServiceImpl implements MemberService {

	MemberDAOImpl mdao = new MemberDAOImpl();
	String alert = null;
	RequestDispatcher rd;
	@Override
	public void memberJoin(HttpServletRequest request, HttpServletResponse response) {
		
		MemberVO joinM = new MemberVO(
				request.getParameter("id"),
				request.getParameter("pass"),
				request.getParameter("name"),
				Integer.parseInt(request.getParameter("age")),
				request.getParameter("gender")
		);
		
		RequestDispatcher rd;
		// 회원가입 성공 실패시
		if(mdao.memberJoin(joinM)) {
			alert = "회원가입 성공!";
		}else {
			alert = "회원가입 실패!";
		}
		
		if(alert != null) {
			if(alert.equals("joinSuccess")) {
				rd = request.getRequestDispatcher("/member/login.jsp");
				request.setAttribute("alert", alert);
			}else {
				rd = request.getRequestDispatcher("/member/join.jsp");
				request.setAttribute("alert", alert);
			}
			
			try {
				rd.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			} 
		}
		
	}

	@Override
	public boolean memberLogin(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		String login = request.getParameter("login");
		MemberVO loginM = mdao.memberLogin(id,pass);
		if(loginM != null) {
			request.getSession().setAttribute("member",loginM);
			alert = "로그인 성공!";
			request.setAttribute("alert", alert);
			if(login != null) {
				Cookie cookie = new Cookie("id",loginM.getId());
				cookie.setPath("/");
				cookie.setMaxAge(60*60*24*7);
				response.addCookie(cookie);
			}
			return true;
		}else {
			alert = "로그인 실패!";
			request.setAttribute("alert", alert);			
		}
		return false;
	}

	@Override
	public void memberUpdate(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void logOut(HttpServletRequest request, HttpServletResponse response) {
		request.getSession().removeAttribute("member");
		Cookie cookie = new Cookie("id","");
		cookie.setPath("/");
		cookie.setMaxAge(0);
		response.addCookie(cookie);
		rd = request.getRequestDispatcher("/member/login.jsp");
		alert = "로그아웃 완료";
		request.setAttribute("alert", alert);
		try {
			rd.forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		} 
	}

	@Override
	public void withDraw(HttpServletRequest request, HttpServletResponse response) {
		MemberVO m = (MemberVO) request.getSession().getAttribute("member");
		System.out.println(m);
		if(m.getPass().equals(request.getParameter("tempPass"))) {
			if(mdao.withDrawMember(m.getNum())) {
				rd = request.getRequestDispatcher("/H_home.mc");
				alert = "회원탈퇴가 완료되셨습니다.";
				request.getSession().removeAttribute("member");
			}
		} else {
			rd = request.getRequestDispatcher("/H_withdraw.mc");
			alert = "비밀번호가 틀리셨습니다.";
		}
		try {
			request.setAttribute("alert", alert);
			rd.forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
		
	}

}
