<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
/* String result = (String) request.getAttribute("result");
System.out.println("result=" + result); */
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>登录界面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  
  <body onload="init()">
    <h1 style="text-align:center">用户登录</h1>
    <form action="login" method="post">
    <table align="center">
    	<tr>
    		<td>用户名：</td>
    		<td><input type="text" name="userName"/></td>
    	</tr>
    	<tr>
    		<td>密    码：</td>
    		<td><input type="password" name="password"/></td>
    	</tr>
    	<tr>
    		<td colspan="2" style="text-align:center">
    			<input type="submit" value="登录"/>
    			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    			<input type="reset" />
    		</td>
    	</tr>
    </table>
   </form>
  </body>
  <script type="text/javascript">
	  function init() {
	      var result = '${result}';
		  if(result!=null && result!='') {
		  	if(result=="success"){
		  		alert("验证成功");
		  	}else if(result=="fail"){
		  		alert("验证失败");
		  	}
		  }
	  }
  </script>
</html>
