package com.foxconn.inter;

import javax.jws.WebMethod;
import javax.jws.WebService;

@WebService
public interface Login {
	
	@WebMethod
	public String checkLogin(String userName,String password); //��¼У��
	
	@WebMethod 
	public String register(String userName,String password); //ע��
}
