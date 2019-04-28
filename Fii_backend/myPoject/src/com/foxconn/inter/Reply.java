package com.foxconn.inter;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;

@WebService
public interface Reply {
	
	@WebMethod
	public @WebResult String getReply(@WebParam String input);
}
