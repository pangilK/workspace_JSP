package service;

import beans.NoticeVO;
import jakarta.servlet.http.HttpServletRequest;
import repositories.NoticeDAOImpl;
import util.SearchCriteria;
import util.SearchPageMaker;

public class NoticeServiceImpl implements NoticeService{
	
	NoticeDAOImpl dao = new NoticeDAOImpl();
	
	@Override
	public boolean noticeWrite(HttpServletRequest request) {
		NoticeVO vo = new NoticeVO(
				request.getParameter("notice_category"),
				request.getParameter("notice_author"),
				request.getParameter("notice_title"),
				request.getParameter("notice_content")
		);
		String alert = "";
		
		if(dao.noticeWrite(vo)) {
			alert = "작성 완료";
			request.setAttribute("alert", alert);
			return true;
		}
		alert = "작성 실패";
		request.setAttribute("alert", alert);
		return false;
	}

	@Override
	public void noticeList(HttpServletRequest request) {
		SearchPageMaker pm = new SearchPageMaker();
		SearchCriteria cri = new SearchCriteria();
		
		if(request.getParameter("page") != null) {
			cri.setPage(Integer.valueOf(request.getParameter("page")));
		}
	
		if(request.getParameter("perPageNum") != null) {
			cri.setPerPageNum(Integer.valueOf(request.getParameter("perPageNum")));
		}
		
		if(request.getParameter("searchType") != null) {
			cri.setSearchType(request.getParameter("searchType"));
		}
		
		if(request.getParameter("searchValue") != null) {
			cri.setSearchValue(request.getParameter("searchValue"));
		}
		
		pm.setCri(cri);
		pm.setTotalCount(dao.getTotalCount(cri));
		request.setAttribute("noticeList",dao.noticeList(cri));
		request.setAttribute("pm",pm);
	}

	@Override
	public void noticeDetail(HttpServletRequest request) {
		int num = Integer.valueOf(request.getParameter("notice_num"));
		request.setAttribute("notice", dao.noticeDetail(num));
	}

	@Override
	public boolean noticeUpdate(HttpServletRequest request) {
		int num = Integer.valueOf(request.getParameter("notice_num"));
		String alert = "";
		NoticeVO notice = new NoticeVO(
				request.getParameter("notice_category"),
				request.getParameter("notice_author"),
				request.getParameter("notice_title"),
				request.getParameter("notice_content")
		);
		notice.setNotice_num(num);
		if(dao.noticeUpdate(notice)) {
			alert = num+"번 게시물 수정 완료";
			request.setAttribute("alert", alert);
			return true;
		}
		alert = "수정 실패";
		request.setAttribute("alert", alert);
		return false;
	}

	@Override
	public boolean noticeDelete(HttpServletRequest request) {
		int num = Integer.valueOf(request.getParameter("notice_num"));
		String alert = "";
		if(dao.noticeDelete(num)) {
			alert = num+"번 게시물 삭제 완료";
			request.setAttribute("alert", alert);
			return true;
		}
		alert = "삭제 실패";
		request.setAttribute("alert", alert);
		return false;
	}

}
