package com.foxconn.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.foxconn.replyClient.Reply;
import com.foxconn.replyClient.ReplyImplService;

@WebServlet(urlPatterns={"/reply"})
public class ReplyServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String input = req.getParameter("input");
		ReplyImplService service = new ReplyImplService();
		Reply reply = service.getReplyImplPort();
		String message = reply.getReply(input);
		req.setAttribute("message", " ¿Í·þ ====>  " + message);
		resp.setCharacterEncoding("utf-8");
		//req.getRequestDispatcher("/index.jsp").forward(req, resp);
		
		PrintWriter out = resp.getWriter();
		out.print(message);
		out.flush();
		out.close();
	}
}
