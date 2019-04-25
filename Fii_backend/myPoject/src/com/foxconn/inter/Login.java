package com.foxconn.inter;

import javax.jws.WebMethod;
import javax.jws.WebService;

@WebService
public interface Login {
	
	@WebMethod
	public String checkLogin(String userName,String password); //µÇÂ¼Ð£Ñé
	
	@WebMethod 
	public String register(String userName,String password); //×¢²á
}
