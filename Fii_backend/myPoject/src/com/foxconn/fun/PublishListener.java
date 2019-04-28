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
		//WebService�ķ�����ַ
		String address = "http://localhost:9003/talkService/getReply";
		//����WebService��WebServiceImpl����WebServie�ӿڵľ���ʵ����
		Endpoint.publish(address , new ReplyImpl());
		System.out.println("ʹ��ServicePublishListener����talkService�ɹ�!");	
		
		//WebService�ķ�����ַ
		String address1 = "http://localhost:9003/loginService/login";
		//����WebService��WebServiceImpl����WebServie�ӿڵľ���ʵ����
		Endpoint.publish(address1 , new LoginImpl());
		System.out.println("ʹ��ServicePublishListener����loginService�ɹ�!");	
	}
}
