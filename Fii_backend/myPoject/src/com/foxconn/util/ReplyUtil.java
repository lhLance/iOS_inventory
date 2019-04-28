package com.foxconn.util;

import java.sql.*;
import java.util.ArrayList;
import java.util.Random;

import com.foxconn.util.SqlUtil;
import com.foxconn.util.StaticData;

public class ReplyUtil {
	
	public static String getRobotReply(String input) {
		ArrayList<String> results = new ArrayList<String>();
		//��ȡ���ݿ�����
		Connection conn = SqlUtil.getConn(StaticData.url, StaticData.user, StaticData.pwd);
		PreparedStatement pst = null;
		String sql = "select answer from robotreply where inquiry=?";
		
		ResultSet rs = null;
		String reply = null;
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, input);
			rs = pst.executeQuery();
			//�����������
			int count = 0;
			//�Ƿ�����ʶ
			boolean findFlag = false; 
				
			while(rs.next()){
				findFlag = true;
				reply = rs.getString("answer");
				results.add(reply);
				count++;
			}
			//����ҵ��������ѡ��һ������
			if(findFlag){
				//ȡ����ظ�
				Random random = new Random();
				int index = random.nextInt(count);
				return results.get(index); 
			}else{
				return "������ȷ������ϵ����Ա��";
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
