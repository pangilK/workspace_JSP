package controller;

import java.io.IOException;
import java.util.ArrayList;

import beans.BoardVO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.QNABoardService;
import service.QNABoardServiceImpl;

@WebServlet("*.qna")
public class QNABoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	QNABoardServiceImpl qs = new QNABoardServiceImpl();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String command = request.getRequestURI().substring(request.getContextPath().length() + 1);
		System.out.println("command : " + command);

		String nextPage = null;
		
		switch(command) {
		
			case "boardList.qna" :
				ArrayList<BoardVO> list = qs.getBoardList(request);
				request.setAttribute("qnaList", list);
				nextPage = "/board/qna/qna_list.jsp";
				break;
				
			case "boardWrite.qna" :
				qs.boardWrite(request);
				nextPage = "boardList.qna";
				break;
				
			case "boardWriteInfo.qna" :
				nextPage = "/board/qna/qna_write.jsp";
				break;
				
			case "boardDetail.qna" :
				request.setAttribute("qna", qs.getBoardVO(request));
				qs.updateReadCount(request);
				nextPage = "/board/qna/qna_detail.jsp";
				break;
				
			case "boardUpdateInfo.qna" :
				request.setAttribute("qna", qs.getBoardVOByUpdate(request));
				nextPage = "board/qna/qna_update.jsp";
				break;
				
			case "boardUpdate.qna" :
				qs.boardUpdate(request, response);
				request.setAttribute("qna", qs.getBoardVO(request));
				nextPage = "board/qna/qna_detail.jsp";
				break;
			
			case "boardDelete.qna" :
				qs.boardDelete(request, response);
				nextPage = "boardList.qna";
				break;
			
			case "boardReplyInfo.qna" :
				request.setAttribute("qna",qs.boardReply(request));
				nextPage = "board/qna/qna_reply.jsp";
				break;
				
			case "boardReply.qna" :
				qs.boardReplySubmit(request);
				nextPage = "boardList.qna";
				break;
		}


		if (nextPage != null && !nextPage.trim().equals("")) {
			RequestDispatcher rd = request.getRequestDispatcher(nextPage);
			rd.forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
