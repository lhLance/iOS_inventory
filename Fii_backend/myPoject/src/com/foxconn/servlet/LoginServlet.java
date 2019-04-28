package com.foxconn.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.foxconn.loginClient.LoginImpl;
import com.foxconn.loginClient.LoginImplService;

@WebServlet(urlPatterns={"/login"})
public class LoginServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String userName = req.getParameter("userName");
		String password = req.getParameter("password");
		LoginImplService service = new LoginImplService();
		LoginImpl loginImpl = service.getLoginImplPort();
		String result = loginImpl.checkLogin(userName, password);
		if(result.equals("success")) {
			System.out.println("===========用户名密码正确==========");
		}else if(result.equals("fail")) {
			System.out.println("===========用户名密码错误\n请重新登录：");
		}else {
			System.out.println("===========数据库出错\n请重新登录：");
		}
		
		/*PrintWriter out = resp.getWriter();
		out.println(result);
		out.flush();
		out.close();*/
		req.setAttribute("result",result);
		resp.setCharacterEncoding("utf-8");
		req.getRequestDispatcher("/login.jsp").forward(req, resp);
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
}
