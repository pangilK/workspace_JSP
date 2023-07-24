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
		
		
	}

	@Override
	public BoardVO getBoardVO(HttpServletRequest request) {
		
		return null;
	}

	@Override
	public void updateReadCount(HttpServletRequest request) {
		
		
	}

	@Override
	public BoardVO boardReply(HttpServletRequest request) {
		
		return null;
	}

	@Override
	public void boardReplySubmit(HttpServletRequest request) {
		
		
	}

	@Override
	public BoardVO getBoardVOByUpdate(HttpServletRequest request) {
		
		return null;
	}

	@Override
	public void boardUpdate(HttpServletRequest request, HttpServletResponse response) {
		
		
	}

	@Override
	public void boardDelete(HttpServletRequest request, HttpServletResponse response) {
		
		
	}

}
