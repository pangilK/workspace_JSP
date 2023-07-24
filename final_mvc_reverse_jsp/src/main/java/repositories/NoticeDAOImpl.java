package repositories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import beans.NoticeVO;
import util.DBCPUtil;
import util.SearchCriteria;

public class NoticeDAOImpl implements NoticeDAO{

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	@Override
	public boolean noticeWrite(NoticeVO vo) {
		String sql = "INSERT INTO notice_board(notice_category,notice_author,notice_title,notice_content)"
				+    " VALUES(?,?,?,?)";
		
		conn = DBCPUtil.getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getNotice_category());
			pstmt.setString(2, vo.getNotice_author());
			pstmt.setString(3, vo.getNotice_title());
			pstmt.setString(4, vo.getNotice_content());
			int result = pstmt.executeUpdate();
			if(result > 0) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBCPUtil.close(pstmt,conn);
		}
		
		return false;
	}

	@Override
	public ArrayList<NoticeVO> noticeList(SearchCriteria cri) {
		ArrayList<NoticeVO> list = new ArrayList<>();
		String sql = "SELECT * FROM notice_board";
		
		if (cri.getSearchValue() != null) {
			if (cri.getSearchType() == null || cri.getSearchType().equals("title")) {
				sql += " WHERE notice_title LIKE ?";
			}else {
				sql += " WHERE notice_content LIKE ?";
			}
		}
	
		sql += " ORDER BY notice_num desc LIMIT ?,?";
		
		conn = DBCPUtil.getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql);
			if(cri.getSearchValue() != null) {
				pstmt.setString(1,"%" + cri.getSearchValue() + "%");
				pstmt.setInt(2, cri.getStartRow());
				pstmt.setInt(3, cri.getPerPageNum());
			}else {
				pstmt.setInt(1, cri.getStartRow());
				pstmt.setInt(2, cri.getPerPageNum());
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				NoticeVO n = new NoticeVO(
						rs.getInt("notice_num"),
						rs.getString("notice_category"),
						rs.getString("notice_author"),
						rs.getString("notice_title"),
						rs.getString("notice_content"),
						rs.getDate("notice_date")
				);
				list.add(n);
			}
		} catch (SQLException e) {
			list.clear();
			e.printStackTrace();
		} finally {
			DBCPUtil.close(rs,pstmt,conn);
		}
		
		return list;
	}

	@Override
	public int getTotalCount(SearchCriteria cri) {
		String sql = "SELECT count(*) FROM notice_board";
		
		if (cri.getSearchValue() != null) {
			if (cri.getSearchType() == null || cri.getSearchType().equals("title")) {
				sql += " WHERE notice_title LIKE ?";
			}else {
				sql += " WHERE notice_content LIKE ?";
			}
		}
		
		conn = DBCPUtil.getConnection();
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			if(cri.getSearchValue() != null) {
				pstmt.setString(1,"%"+ cri.getSearchValue() + "%");
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBCPUtil.close(rs,pstmt,conn);
		}
		
		return result;
	}

	@Override
	public NoticeVO noticeDetail(int notice_num) {
		String sql = "SELECT * FROM notice_board WHERE notice_num = ?";
		NoticeVO n = new NoticeVO();
		conn = DBCPUtil.getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, notice_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				n.setNotice_num(rs.getInt("notice_num"));
				n.setNotice_category(rs.getString("notice_category"));
				n.setNotice_author(rs.getString("notice_author"));
				n.setNotice_title(rs.getString("notice_title"));
				n.setNotice_content(rs.getString("notice_content"));
				n.setNotice_date(rs.getDate("notice_date"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBCPUtil.close(rs,pstmt,conn);
		}
		
		return n;
	}

	@Override
	public boolean noticeUpdate(NoticeVO vo) {
		// 카테고리 오더 타이틀 콘텐트
		String sql = "UPDATE notice_board SET notice_title = ? , notice_category = ? , notice_content = ?"
				+ " WHERE notice_num = ?";
		int result = 0;
		conn = DBCPUtil.getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getNotice_title());
			pstmt.setString(2, vo.getNotice_category());
			pstmt.setString(3, vo.getNotice_content());
			pstmt.setInt(4, vo.getNotice_num());
			result = pstmt.executeUpdate();
			if(result > 0) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBCPUtil.close(pstmt,conn);
		}
		return false;
	}

	@Override
	public boolean noticeDelete(int notice_num) {
		String sql = "DELETE FROM notice_board WHERE notice_num = ?";
		int result = 0;
		conn = DBCPUtil.getConnection();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, notice_num);
			result = pstmt.executeUpdate();
			if(result > 0) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBCPUtil.close(pstmt,conn);
		}
		return false;
	}
	

}
