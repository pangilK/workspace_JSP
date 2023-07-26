package repositories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import beans.BoardVO;
import util.Criteria;
import util.DBCPUtil;

public class QNABoardDAOImpl implements QNABoardDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	@Override
	public int getListCount() {
		String sql = "SELECT count(*) FROM qna_board WHERE qna_delete = 'N'";
		int result = 0;
		
		conn = DBCPUtil.getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql);
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
	public ArrayList<BoardVO> getBoardList(Criteria cri) {
		String sql = "SELECT * FROM qna_board ORDER BY qna_re_ref desc,qna_re_seq asc LIMIT ?,?";
		ArrayList<BoardVO> list = new ArrayList<>();
		
		conn = DBCPUtil.getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cri.getStartRow());
			pstmt.setInt(2, cri.getPerPageNum());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardVO vo = new BoardVO(
						rs.getInt("qna_num"),
						rs.getString("qna_name"),
						rs.getString("qna_title"),
						rs.getString("qna_content"),
						rs.getInt("qna_re_ref"),
						rs.getInt("qna_re_lev"),
						rs.getInt("qna_re_seq"),
						rs.getInt("qna_writer_num"),
						rs.getInt("qna_readCount"),
						rs.getString("qna_delete").charAt(0),
						rs.getDate("qna_date")
				);
				list.add(vo);
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
	public void boardWrite(BoardVO board) {

		String sql = "INSERT INTO qna_board " + "VALUES(null,?,?,?,0,0,0,?,0,'N',now())";
		try {
			conn = DBCPUtil.getConnection();
			conn.setAutoCommit(false);

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getQna_name());
			pstmt.setString(2, board.getQna_title());
			pstmt.setString(3, board.getQna_content());
			pstmt.setInt(4, board.getQna_writer_num());
			pstmt.executeUpdate();

			sql = "SELECT LAST_INSERT_ID()";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int qna_num = 0;
			if (rs.next()) {
				qna_num = rs.getInt(1);
			}
			System.out.println("삽입된 원본글 번호 : " + qna_num);

			sql = "UPDATE qna_board SET qna_re_ref = ? " + " WHERE qna_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qna_num);
			pstmt.setInt(2, qna_num);
			pstmt.executeUpdate();
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
			}
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
			}
			DBCPUtil.close(rs, pstmt, conn);
		}
		
	}

	@Override
	public BoardVO getBoardVO(int board_num) {
		String sql = "SELECT * FROM qna_board WHERE qna_num = ?";
		BoardVO vo = new BoardVO();
		conn = DBCPUtil.getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setQna_num(rs.getInt("qna_num"));
				vo.setQna_content(rs.getString("qna_content"));
				vo.setQna_date(rs.getDate("qna_date"));
				vo.setQna_name(rs.getString("qna_name"));
				vo.setQna_re_lev(rs.getInt("qna_re_lev"));
				vo.setQna_re_ref(rs.getInt("qna_re_ref"));
				vo.setQna_re_seq(rs.getInt("qna_re_seq"));
				vo.setQna_readcount(rs.getInt("qna_readcount"));
				vo.setQna_title(rs.getString("qna_title"));
				vo.setQna_writer_num(rs.getInt("qna_writer_num"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBCPUtil.close(rs,pstmt,conn);
		}
		
		return vo;
	}

	@Override
	public void updateReadCount(int board_num) {
		String sql = "UPDATE qna_board SET qna_readcount = qna_readcount + 1 WHERE qna_num = ?";
		
		conn = DBCPUtil.getConnection(); 
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBCPUtil.close(pstmt,conn);
		}
	
	}

	@Override
	public void boardReplySubmit(BoardVO board) {
		String sql = "UPDATE qna_board SET qna_re_seq = qna_re_seq + 1" +
				" WHERE qna_re_ref = ? AND qna_re_seq > ?";
		
		conn = DBCPUtil.getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board.getQna_re_ref());
			pstmt.setInt(2, board.getQna_re_seq());
			pstmt.executeUpdate();
			
			sql = "INSERT INTO qna_board VALUES(null,?,?,?,?,?,?,?,0,'N',now())";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getQna_name());
			pstmt.setString(2, board.getQna_title());
			pstmt.setString(3, board.getQna_content());
			pstmt.setInt(4, board.getQna_re_ref());
			pstmt.setInt(5, board.getQna_re_lev()+1);
			pstmt.setInt(6, board.getQna_re_seq()+1);
			pstmt.setInt(7,board.getQna_writer_num());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBCPUtil.close(pstmt,conn);
		}
		
	}

	@Override
	public void boardUpdate(BoardVO board) {
		String sql = "UPDATE qna_board SET qna_title = ? , qna_content = ? WHERE qna_num = ?";
		
		conn = DBCPUtil.getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getQna_title());
			pstmt.setString(2, board.getQna_content());
			pstmt.setInt(3, board.getQna_num());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBCPUtil.close(pstmt,conn);
		}
	}

	@Override
	public boolean boardDelete(int board_num, int qna_writer_num) {
		String sql = "UPDATE qna_board SET qna_delete = 'Y' WHERE qna_num = ?";
		int result = 0;
		conn = DBCPUtil.getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,board_num);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBCPUtil.close(pstmt,conn);
		}
		
		return result > 0;
	}

}
