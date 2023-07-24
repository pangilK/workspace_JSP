package repositories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import beans.MemberVO;
import util.Criteria;
import util.DBCPUtil;

public class ManagementDAOImpl implements ManagementDAO{

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	@Override
	public ArrayList<MemberVO> getMemberList(Criteria cri) {
		ArrayList<MemberVO> mList = new ArrayList<>();
		String sql = "SELECT * FROM mvc_member WHERE id != 'admin' AND joinYN = 'Y'"
				+ " ORDER BY num desc LIMIT ? , ?";
		
		conn = DBCPUtil.getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cri.getStartRow());
			pstmt.setInt(2, cri.getPerPageNum());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberVO m = new MemberVO(
						rs.getInt("num"),
						rs.getString("id"),
						rs.getString("pass"),
						rs.getString("name"),
						rs.getInt("age"),
						rs.getString("gender"),
						rs.getString("joinYN").charAt(0),
						rs.getDate("regdate"),
						rs.getDate("updatedate")
				);
				mList.add(m);
			}
		} catch (SQLException e) {
			mList.clear();
			e.printStackTrace();
		} finally {
			DBCPUtil.close(rs,pstmt,conn);
		}
		return mList;
	}

	@Override
	public int getMemberTotalCount() {
		String sql = "SELECT count(*) FROM mvc_member WHERE id != 'admin' AND joinYN = 'Y'";
		conn = DBCPUtil.getConnection();
		int result = 0;
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
	public int updateMember(MemberVO vo) {
		String sql = "UPDATE mvc_member SET pass = ? , age = ? , gender = ? , updatedate = now()"
				+ "WHERE id = ?";
		conn = DBCPUtil.getConnection();
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getPass());
			pstmt.setInt(2, vo.getAge());
			pstmt.setString(3, vo.getGender());
			pstmt.setString(4, vo.getId());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBCPUtil.close(pstmt,conn);
		}
		
		return result;
	}

	@Override
	public int deleteMember(int num) {
		String sql = "UPDATE mvc_member SET joinYN = 'N', updatedate = now()"
				+ "WHERE num = ? ";
		conn = DBCPUtil.getConnection();
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBCPUtil.close(pstmt,conn);
		}
		
		return result;
	}

	public MemberVO getMember(int num) {
		String sql = "SELECT * FROM mvc_member WHERE num = ?";
		MemberVO m = null;
		conn = DBCPUtil.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				m = new MemberVO(
						rs.getInt("num"),
						rs.getString("id"),
						rs.getString("pass"),
						rs.getString("name"),
						rs.getInt("age"),
						rs.getString("gender"),
						rs.getString("joinYN").charAt(0),
						rs.getDate("regdate"),
						rs.getDate("updatedate")
				);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return m;
	}
}