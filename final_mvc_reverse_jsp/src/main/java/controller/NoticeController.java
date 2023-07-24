package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.NoticeServiceImpl;

@WebServlet("*.do")
public class NoticeController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	// 공지 사항 관련 요청을 처리할 클래스
	NoticeServiceImpl ns = new NoticeServiceImpl();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String command = request.getRequestURI().substring(request.getContextPath().length() + 1);
		System.out.println("NoticeController 요청 : " + command);

		String view = null;

		boolean isSuccess = false;

		String suc = "/board/notice/notice_success.jsp";
		String fail = "/board/notice/notice_fail.jsp";

		switch(command) {
			case "notice.do" :
				ns.noticeList(request);
				view = "/board/notice/notice_list.jsp";
				break;
				
			case "detailNotice.do" :
				ns.noticeDetail(request);
				view = "/board/notice/notice_detail.jsp";
				break;
			
			case "updateNoticeInfo.do" :
				ns.noticeDetail(request);
				view = "/board/notice/notice_update.jsp";
				break;
				
			case "updateNotice.do" :
				if(ns.noticeUpdate(request)) {
					ns.noticeDetail(request);					
				}
				view = "/board/notice/notice_detail.jsp";
				break;
				
			case "deleteNotice.do" :
				ns.noticeDelete(request);
				view = "notice.do";
				break;
			
			case "writeNoticeInfo.do" :
				view = "/board/notice/notice_write.jsp";
				break;
				
			case "writeNotice.do" :
				ns.noticeWrite(request);
				view = "notice.do";
				break;
				
			default :
				view = "H_home.mc";
				break;
		}

		if (view != null && !view.equals("")) {
			request.getRequestDispatcher(view).forward(request, response);
		} else {
			request.getRequestDispatcher(fail).forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
