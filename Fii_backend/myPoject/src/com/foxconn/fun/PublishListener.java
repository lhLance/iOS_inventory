package com.foxconn.fun;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.xml.ws.Endpoint;

@WebListener
public class PublishListener implements ServletContextListener {
	
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		//WebService的发布地址
		String address = "http://localhost:9003/talkService/getReply";
		//发布WebService，WebServiceImpl类是WebServie接口的具体实现类
		Endpoint.publish(address , new ReplyImpl());
		System.out.println("使用ServicePublishListener发布talkService成功!");	
		
		//WebService的发布地址
		String address1 = "http://localhost:9003/loginService/login";
		//发布WebService，WebServiceImpl类是WebServie接口的具体实现类
		Endpoint.publish(address1 , new LoginImpl());
		System.out.println("使用ServicePublishListener发布loginService成功!");	
	}
}
