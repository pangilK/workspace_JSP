package repositories;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import beans.MemberVO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import util.DBCPUtil;

public class MemberDAOImpl implements MemberDAO{

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	@Override
	public boolean memberJoin(MemberVO member) {
		String sql = "INSERT INTO mvc_member(id,pass,name,age,gender)" + 
					 " VALUES(?,?,?,?,?)";
		
		conn = DBCPUtil.getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPass());
			pstmt.setString(3, member.getName());
			pstmt.setInt(4, member.getAge());
			pstmt.setString(5, member.getGender());
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
	public MemberVO memberLogin(String id, String pass) {
		String sql = "SELECT * FROM mvc_member WHERE id = ? AND pass = ?";
		MemberVO loginM = null;
		conn = DBCPUtil.getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("joinYN").equals("Y"))
				loginM = new MemberVO(
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
		} finally {
			DBCPUtil.close(rs,pstmt,conn);
		}
		return loginM;
	}

	@Override
	public boolean memberUpdate(MemberVO member) {
		return false;
	}

	@Override
	public MemberVO getMemberById(String id) {		
		String sql = "SELECT * FROM mvc_member WHERE id = ?";
		MemberVO loginM = null;
		conn = DBCPUtil.getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("joinYN").equals("Y"))
				loginM = new MemberVO(
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
		} finally {
			DBCPUtil.close(rs,pstmt,conn);
		}
		return loginM;
	}

	@Override
	public boolean withDrawMember(int num) { 
		String sql = "UPDATE mvc_member SET joinYN = 'N' WHERE num = ?";
		conn = DBCPUtil.getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			int result = pstmt.executeUpdate();
			
			if(result > 0) return true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBCPUtil.close(pstmt,conn);
		}
		return false;
	}

}
