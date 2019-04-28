package com.foxconn.util;

import java.sql.*;
import java.util.ArrayList;
import java.util.Random;

import com.foxconn.util.SqlUtil;
import com.foxconn.util.StaticData;

public class ReplyUtil {
	
	public static String getRobotReply(String input) {
		ArrayList<String> results = new ArrayList<String>();
		//获取数据库连接
		Connection conn = SqlUtil.getConn(StaticData.url, StaticData.user, StaticData.pwd);
		PreparedStatement pst = null;
		String sql = "select answer from robotreply where inquiry=?";
		
		ResultSet rs = null;
		String reply = null;
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, input);
			rs = pst.executeQuery();
			//计数结果条数
			int count = 0;
			//是否查出标识
			boolean findFlag = false; 
				
			while(rs.next()){
				findFlag = true;
				reply = rs.getString("answer");
				results.add(reply);
				count++;
			}
			//如果找到，则随机选择一条返回
			if(findFlag){
				//取随机回复
				Random random = new Random();
				int index = random.nextInt(count);
				return results.get(index); 
			}else{
				return "请求不明确，请联系管理员！";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			SqlUtil.closeResultSet(rs);
			SqlUtil.closePst(pst);
			SqlUtil.closeConn(conn);
		}
		return reply;
	}
}
