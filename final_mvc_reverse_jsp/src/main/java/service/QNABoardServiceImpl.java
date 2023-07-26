package service;

import java.util.ArrayList;

import beans.BoardVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import repositories.QNABoardDAOImpl;
import util.Criteria;
import util.PageMaker;

public class QNABoardServiceImpl implements QNABoardService{
	
	QNABoardDAOImpl dao = new QNABoardDAOImpl();
	
	@Override
	public ArrayList<BoardVO> getBoardList(HttpServletRequest request) {
		PageMaker pm = new PageMaker();
		Criteria cri = new Criteria();
		
		if(request.getParameter("page") != null) {
			cri.setPage(Integer.valueOf(request.getParameter("page")));
		}
		
		pm.setCri(cri);
		pm.setTotalCount(dao.getListCount());
		request.setAttribute("pm", pm);
		return dao.getBoardList(cri);
	}

	@Override
	public void boardWrite(HttpServletRequest request) {
		BoardVO vo = new BoardVO(
				request.getParameter("qna_name"),
				request.getParameter("qna_title"),
				request.getParameter("qna_content"),
				Integer.valueOf(request.getParameter("qna_writer_num"))
		);
		dao.boardWrite(vo);
	}

	@Override
	public BoardVO getBoardVO(HttpServletRequest request) {
		int num = Integer.valueOf(request.getParameter("num"));
		return dao.getBoardVO(num);
	}

	@Override
	public void updateReadCount(HttpServletRequest request) {
		int num = Integer.valueOf(request.getParameter("num"));
		dao.updateReadCount(num);
	}

	@Override
	public BoardVO boardReply(HttpServletRequest request) {
		int num = Integer.valueOf(request.getParameter("num"));
		return dao.getBoardVO(num);
	}

	@Override
	public void boardReplySubmit(HttpServletRequest request) {
		int num = Integer.valueOf(request.getParameter("num"));
		BoardVO vo = new BoardVO();
		vo.setQna_name(request.getParameter("qna_name"));
		vo.setQna_title(request.getParameter("qna_title"));
		vo.setQna_content(request.getParameter("qna_content"));
		vo.setQna_re_ref(Integer.valueOf(request.getParameter("qna_re_ref")));
		vo.setQna_re_lev(Integer.valueOf(request.getParameter("qna_re_lev")));
		vo.setQna_re_seq(Integer.valueOf(request.getParameter("qna_re_seq")));
		vo.setQna_writer_num(Integer.valueOf(request.getParameter("qna_writer_num")));
		request.setAttribute("alert","답글 작성 완료");
		dao.boardReplySubmit(vo);
	}

	@Override
	public BoardVO getBoardVOByUpdate(HttpServletRequest request) {
		int num = Integer.valueOf(request.getParameter("num"));
		return dao.getBoardVO(num);
	}

	@Override
	public void boardUpdate(HttpServletRequest request, HttpServletResponse response) {
		int num = Integer.valueOf(request.getParameter("num"));
		BoardVO vo = dao.getBoardVO(num);
		vo.setQna_title(request.getParameter("qna_title"));
		vo.setQna_content(request.getParameter("qna_content"));
		dao.boardUpdate(vo);
		request.setAttribute("alert", num+"번 게시물 수정완료");
	}

	@Override
	public void boardDelete(HttpServletRequest request, HttpServletResponse response) {
		int num = Integer.valueOf(request.getParameter("num"));
		if(dao.boardDelete(num, 0)) {
			request.setAttribute("alert",num+"번 게시물 삭제 완료");
		}else {
			request.setAttribute("alert",num+"번 게시물 삭제 실패");			
		}
	}

}
