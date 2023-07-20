package first;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/choiceFruit")
public class ChoiceFruitServlet extends HttpServlet{

	private static final long serialVersionUID = 7882660958722358053L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String[] fruits = request.getParameterValues("fruit");
		
		
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(fruits != null) {
			for(String fruit : fruits) {
				out.println("Choice Fruit : " + fruit + "<br/>");
				out.println("<img src='resources/img/"+ fruit +"' /> <br/>");
				System.out.println(fruit);
			}
		}else {
			System.out.println("선택된 과일 없음");
			out.println("<script>");
			out.println("alert('선택된 과일이 없습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
		}
	}
	
}
