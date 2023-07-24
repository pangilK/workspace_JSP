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
		String sql = "SELECT * FROM qna_board ORDER BY qna_num asc LIMIT ?,?";
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
		
		
	}

	@Override
	public BoardVO getBoardVO(int board_num) {
		
		return null;
	}

	@Override
	public void updateReadCount(int board_num) {
		
		
	}

	@Override
	public void boardReplySubmit(BoardVO board) {
		
		
	}

	@Override
	public void boardUpdate(BoardVO board) {
		
		
	}

	@Override
	public boolean boardDelete(int board_num, int qna_writer_num) {
		
		return false;
	}

}
