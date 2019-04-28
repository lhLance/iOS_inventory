package com.foxconn.fun;

import java.sql.*;
import javax.jws.WebMethod;
import javax.jws.WebService;

import com.foxconn.inter.Login;
import com.foxconn.util.SqlUtil;
import com.foxconn.util.StaticData;

@WebService(endpointInterface="com.foxconn.inter.Login")
public class LoginImpl implements Login {
	
	@WebMethod
	@Override
	public String checkLogin(String userName, String password) {
		Connection conn = SqlUtil.getConn(StaticData.url, StaticData.user, StaticData.pwd);
		
		PreparedStatement pst  = null;
		ResultSet rs = null;
		try{
			//Ԥ����
			String sql = "select user_id as userId from user where user_name=? and password=? ";
			pst = conn.prepareStatement(sql);
			pst.setString(1, userName);
			pst.setString(2, password);
			//ִ�в�ѯ����
			rs = pst.executeQuery();
	        // �ӵ�¼�û��������˺�����������ѯ�����ݿ�����Ƿ������ͬ���˺�����
	        if (rs.next()) {
	            return "success";
	        } else {
	            return "fail";
	        }
		} catch(SQLException e) {
			System.out.println("��ȡ���ݿ����ӳɹ���");
		} finally {
			SqlUtil.closeResultSet(rs);
			SqlUtil.closePst(pst);
			SqlUtil.closeConn(conn);
		}
		
		return null;
	}

	@Override
	public String register(String userName, String password) {
		return null;
	}

}
