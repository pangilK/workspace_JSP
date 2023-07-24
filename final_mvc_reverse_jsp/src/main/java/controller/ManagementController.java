package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.ManagementServiceImpl;
import util.Criteria;
import util.PageMaker;

@WebServlet("*.mgc")
public class ManagementController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	ManagementServiceImpl ms = new ManagementServiceImpl();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String command = request.getRequestURI().substring(request.getContextPath().length() + 1);
		System.out.println("Management 요청 : " + command);

		String view = null;
		
		
		switch(command) {
			case  "managementPage.mgc" :
				int pageNum = 1;
				if(request.getParameter("page") != null) {
					pageNum = Integer.valueOf(request.getParameter("page"));
				}
				request.setAttribute("memberList", ms.getMemberList(request));
				PageMaker pm = ms.getPm(pageNum);
				request.setAttribute("pm",pm);
				view = "/management/member.jsp?page="+pageNum;
				break;
				
			case  "updateInfo.mgc" :
				int num = Integer.valueOf(request.getParameter("num"));
				request.setAttribute("updateMember", ms.getMember(num));
				view = "/management/memberUpdate.jsp";
				break;
				
			case "updateMember.mgc" :
				if(ms.updateMember(request)) {
					request.setAttribute("alert", request.getParameter("id")+"님의 정보 수정 완료");
				}else {
					request.setAttribute("alert", request.getParameter("id")+"님의 정보 수정 실패");
				}
				view = "managementPage.mgc";
				break;
				
			case "delete.mgc" :
				if(ms.deleteMember(request)) {
					request.setAttribute("alert", "삭제 완료");
				}else {
					request.setAttribute("alert", "삭제 실패");
				}
				view = "managementPage.mgc";
				break;
			
			default : 
				view = "H_home.mc";
				break;
		}
		
		
		if (view != null && !view.trim().equals("")) {
			request.getRequestDispatcher(view).forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
