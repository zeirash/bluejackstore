<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*, java.text.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<link href="style.css" type="text/css" rel="stylesheet" />
</head>
<%
	if(session.getAttribute("usernameSession")!=null){
%>
		<jsp:forward page="index.jsp"/>
<%
	}
%>
<%
	Cookie [] myCookie = request.getCookies();
	String username="";
	String password="";
	String checking="";
	
	for(int i=0 ; i<myCookie.length ; i++){
		if(myCookie[i].getName().equals("usernameCookie")){
			username=myCookie[i].getValue();
		}
		else if(myCookie[i].getName().equals("passwordCookie")){
			password=myCookie[i].getValue();
		}
		else if(myCookie[i].getName().equals("checkedCookie")){
			checking=myCookie[i].getValue();
		}
	}
%>
<body>

    <%@ include file="status.jsp" %>
	<%@ include file="header.jsp" %>
	<div class="body-container">
        
        <div class="login-container">
            <form action="Controller/doLogin.jsp" method="post">
            
                <div class="content-page">
                    <div class="title-text">Login</div>
                    <div class="table">
                        <div class="login-row">
                            <input type="text" name="username" placeholder="email" value="<%= username %>" />
                        </div>
                        <div class="login-row">
                            <input type="text" name="password" placeholder="password" value="<%= password %>" />
                        </div>
                        <div class="login-row">
                        	<div class="checkbox-container">
                                <div class="checkbox-remember">
                                    <input type="checkbox" name="remember" value="remembered" 
<%
                                        if(checking.equals("remembered")) out.print("checked");
                                        else if(checking==""||checking==null) out.print("");
%>
                                    />
                                </div>
                                <div class="checkbox-remember">
                                    <div class="normal-text">Remember me</div>
                                </div>
                        	</div>
                        </div>
                        <div class="login-row">
                            <div id="errorMessage">
                                <div class="normal-text -red">
<%
                                    String err = request.getParameter("err");
                                    if(err != null) out.print(err);
%>
                                </div>
                            </div>
                        </div>
                        <div class="login-row">
                            <div id="loginInfo">
                                <a href="register.jsp">
                                    <div class="normal-text -underline">Don't have and account? Register here</div>
                                </a>
                            </div>
                        </div>
                        <div class="login-row">
                            <div class="button-container">
                                <input type="submit" value="Login" class="button" />
                            </div>
                        </div>
                    </div>
                </div>
                
            </form>
    	</div>
            
	</div>

</body>
</html>