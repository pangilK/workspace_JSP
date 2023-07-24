package service;

import java.util.ArrayList;
import java.util.List;

import beans.MemberVO;
import jakarta.servlet.http.HttpServletRequest;
import repositories.ManagementDAO;
import repositories.ManagementDAOImpl;
import util.Criteria;
import util.PageMaker;

public class ManagementServiceImpl implements ManagementService{
	
	ManagementDAOImpl dao = new ManagementDAOImpl();
	
	@Override
	public ArrayList<MemberVO> getMemberList(HttpServletRequest request) {
		String page = request.getParameter("page");
		int pageNum = 1;
		if(page != null) {
			pageNum = Integer.parseInt(page);
		}
		
		Criteria cri = new Criteria(1,5);
		cri.setPage(pageNum);
		ArrayList<MemberVO> mlist = dao.getMemberList(cri);
		
		return mlist;
	}

	@Override
	public boolean updateMember(HttpServletRequest request) {
		MemberVO m = new MemberVO(
				request.getParameter("id"),
				request.getParameter("pass"),
				request.getParameter("name"),
				Integer.parseInt(request.getParameter("age")),
				request.getParameter("gender")
		);
		if(dao.updateMember(m) > 0) {
			return true;
		};
		return false;
	}

	@Override
	public boolean deleteMember(HttpServletRequest request) {
		int num = Integer.valueOf(request.getParameter("num"));
		if(dao.deleteMember(num) > 0) {
			return true;
		}
		return false;
	}
	
	public MemberVO getMember(int num) {
		MemberVO m = dao.getMember(num);
		return m;
	}
	
	public PageMaker getPm(int pageNum) {
		PageMaker pm = new PageMaker();
		Criteria cri = new Criteria(1,5);
		cri.setPage(pageNum);
		pm.setCri(cri);
		pm.setTotalCount(dao.getMemberTotalCount());
		return pm;
	}
}
