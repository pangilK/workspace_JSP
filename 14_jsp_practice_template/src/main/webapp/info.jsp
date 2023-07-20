<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="vo.MemberVO"%>
<%@page import="java.lang.reflect.Field"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- info.jsp -->
<%
	MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
%>
<%!
	public List<String> field(Object o){
		Field[] fields = o.getClass().getDeclaredFields();
		List<String> list = new ArrayList<>();
		for(int x = 0 ; x < fields.length ; x++){
			fields[x].setAccessible(true);
	            try {
	                Object value = fields[x].get(o);
	                list.add((String) value);
	            }catch (IllegalAccessException e) {
	                e.printStackTrace();
	            }
			
		}
		return list;
	}

%>
<%
	List<String> memberInfo = field((Object) loginMember);
	System.out.println(memberInfo);
%>
<section>
    <table>
       <tr>
          <td colspan="2"><h1>회원정보</h1></td>
       </tr>
       <tr>
          <td>아이디</td>
          <td>
             <jsp:getProperty property="id" name="loginMember"/>
         </td>
       </tr>
       <tr>
          <td>비밀번호</td>
          <td>
             <jsp:getProperty property="pass" name="loginMember"/>
         </td>
       </tr>
       <tr>
          <td>이름</td>
          <td>
             <jsp:getProperty property="name" name="loginMember"/>
          </td>
       </tr>
       <tr>
          <td>주소</td>
          <td>
             <jsp:getProperty property="addr" name="loginMember"/>
          </td>
       </tr>
       <tr>
          <td>전화번호</td>
          <td>   
             <jsp:getProperty property="phone" name="loginMember"/>
          </td>
       </tr>
       <tr>
          <td>성별</td>
          <td>
             <label>
                <input type="radio" <%= loginMember.getGender().equals("남성") ? "checked" : "disabled" %>/> 남성
             </label>
             <label>
                <input type="radio" <%= loginMember.getGender().equals("여성") ? "checked" : "disabled" %>/> 여성
             </label>
          </td>
       </tr>
       <tr>
          <td>나이</td>
          <td>
             <jsp:getProperty property="age" name="loginMember"/>
          </td>
       </tr>
       <tr>
          <td colspan="2">
             <button onclick="location.href='index.jsp';">메인으로</button> 
             <button onclick="withdraw();">회원탈퇴</button>
          </td>
       </tr>
    </table>   
</section>
<script>
   function withdraw(){
      let result = confirm("정말로 탈퇴 하시겠습니까?");   
      if(result){
         location.href="withdraw.jsp";   
      }
   }
</script>












 	
 	
 	
 	
 	
 	