<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,util.*,java.sql.*,vo.*"%>
<!DOCTYPE html>
<!-- memberUpdateForm.jsp -->
<%
	String sql = "SELECT * FROM test_member WHERE num = ?";
	int num = Integer.valueOf(request.getParameter("num"));
	
	Connection conn = DBCPUtil.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	MemberVO vo = new MemberVO();
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1,num);
	rs = pstmt.executeQuery();
	
	List<String> fields = new ArrayList<>();
	
	if(rs.next()){
		for(int i = 1 ; i < 9 ; i++){
			if(i == 1 || i == 8){
				fields.add(String.valueOf(rs.getInt(i)));
			} else {
				fields.add(rs.getString(i));
			}
		}
	}
	
	MemberVO.setMember(vo,fields);
	System.out.println(vo.toString());
%>

<form action="memberUpdate.jsp" method="POST">
	<input type="hidden" name="num" value='<%=num%>'/>
	<table>
		<tr>
			<td colspan="2"><h1>회원정보수정</h1></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td>
				<input type="text" name="id" data-msg="아이디" />
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>
				<input type="password" name="pass" data-msg="비밀번호" />
			</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>
				<input type="text" name="name" data-msg="이름" />
			</td>
		</tr>
		<tr>
			<td>주소</td>
			<td>
				<input type="text" name="addr" data-msg="주소" />
			</td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td>
				<input type="text" name="phone" data-msg="전화번호" />
			</td>
		</tr>
		<tr>
			<td>성별</td>
			<td>
				<label>
				<input type="radio" name="gender" value="남성" checked />
				남성
				</label>
				<label>
				<input type="radio" name="gender" value="여성" />
				여성
				</label>
			</td>
		</tr>
		<tr>
			<td>나이</td>
			<td>
				<input type="number" name="age" data-msg="나이"/>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<button>수정완료</button>
			</td>
		</tr>
	</table>
</form>
<% for(int i = 0 ; i < fields.size() ; i++){ %>
<script>
	(function() {
		const trE = document.querySelectorAll("tr");
		let input = trE[<%=i%>].querySelector("input");
		input.value = '<%=fields.get(i)%>';
	})();
</script>
<%  } %>