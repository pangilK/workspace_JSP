package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.MemberService;
import service.MemberServiceImpl;

/**
 *  *. mc 요청 처리 
 */
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 회원 관련된 요청을 처리할 서비스 
	MemberServiceImpl ms;
	MemberService mss;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		// Cookie 정보 확인 - 자동 로그인
		MemberService.loginCheck(request);
		
		String requestUri = request.getRequestURI();
		System.out.println("requestUri : " + requestUri);
		
		String contextPath = request.getContextPath();
		System.out.println("contextPath : " + contextPath);
		
		String command = requestUri.substring(contextPath.length()+1);
		System.out.println("command : " + command);
		
		
		// 요청에 따른 처리 결과 화면 을 저장할 변수 
		String view = "";
		// 요청에 따라 데이터의 처리가 필요하다면 서비스로 처리 요청
		
		// 홈페이지 이동 요청
		if(command.startsWith("H_")) {
			switch(command) {
				case "H_join.mc" :
					view = "/member/join.jsp";
					break; 
				case "H_login.mc" :
					view = "/member/login.jsp";
					break; 
				case "H_qna.mc" :
					view = "/board/qna/qna_list.jsp";
					break; 
				case "H_info.mc" :
					view = "/member/info.jsp";
					break;
				case "H_withdraw.mc" :
					view = "/member/withdraw.jsp";
					break;
				case "H_home.mc" :
					view = "index.jsp";
					break;
				default:
			        view = "H_home.mc";
			        break;
			}
		}
		
		// MemberService 요청
		if(command.startsWith("M_")) {
			ms = new MemberServiceImpl();
			switch(command) {
				case "M_join.mc" :
					ms.memberJoin(request, response);
					break;
				case "M_login.mc" :
					if(ms.memberLogin(request, response)) view = "index.jsp";
					else view = "/member/login.jsp";
					break;
				case "M_logOut.mc" :
					ms.logOut(request, response);
					break;
				case "M_withdraw.mc" :
					ms.withDraw(request, response);
					break;
				default:
			        view = "H_home.mc";
			        break;
			}
		}

		// view 정보가 존재할 시 forward로 페이지 이동
		if (view != null && !view.equals("")) {
			request.getRequestDispatcher(view).forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		doGet(request, response);
	}

}
