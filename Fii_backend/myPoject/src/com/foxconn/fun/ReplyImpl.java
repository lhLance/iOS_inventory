package com.foxconn.fun;

import javax.jws.WebMethod;
import javax.jws.WebService;

import com.foxconn.inter.Reply;
import com.foxconn.util.ReplyUtil;

@WebService(endpointInterface="com.foxconn.inter.Reply")
public class ReplyImpl implements Reply {
	
	@WebMethod
	public String getReply(String input) {
		/*TalkUtil util = new TalkUtil();
		return util.getMessage(input);*/
		return ReplyUtil.getRobotReply(input);
	}

}
