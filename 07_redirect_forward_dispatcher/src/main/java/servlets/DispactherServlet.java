package servlets;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/dispatcher")
public class DispactherServlet extends HttpServlet {

	private static final long serialVersionUID = -3682676234839852232L;
	

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		System.out.println("request param : " + id);
		req.setAttribute("id", id);
		req.setAttribute("dispatcher", "SAMPLE data");
		RequestDispatcher rd = req.getRequestDispatcher("dispatcher.jsp");
		rd.forward(req, resp);
	}
	
	/*
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String method = req.getMethod();
		System.out.println("요청 전송 방식 " + method);
		String id = req.getParameter("id");
		System.out.println("parameter : " + id);
		req.setAttribute("response", "sample data");
		RequestDispatcher dispatcher = req.getRequestDispatcher("response.jsp");
		dispatcher.forward(req,resp);
		super.service(req, resp);
	}
	 */

	
	
}
