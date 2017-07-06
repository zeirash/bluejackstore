<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*, java.text.*" errorPage="" %>
<%@ include file="Controller/connect.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<link href="style.css" type="text/css" rel="stylesheet" />
<%
	if(session.getAttribute("usernameSession")==null){
%>
		<jsp:forward page="logout.jsp"/>
<%
	}
%>

<%
	int counter=0;
	int paging=0;
	int start=0;

	String search = request.getParameter("search");
	
	ResultSet rs;
	
	if(search!=null){
		String querysearch = "SELECT * FROM users WHERE name LIKE '%"+search+"%' AND role=2";
		rs = st.executeQuery(querysearch);
	}
	else{
		String query = "SELECT * FROM users WHERE role=2";
		rs = st.executeQuery(query);
	}

%>

</head>

<body>

	<%@ include file="status.jsp" %>
	<%@ include file="header.jsp" %>
    <div class="body-container">
    
    	<div class="title-container">
        	<div class="title-content">
            	<div class="title-text">All Active Member</div>
            </div>
            <div class="title-content">
                <div class="search-container">
                	<form action="member.jsp" method="post">
                        <div class="search-bar"><input type="text" name="search" placeholder="Search" /></div>
                        <div class="search-bar"><input type="submit" class="button" value="search" /></div>
                    </form>
                </div>
            </div>
        </div>
        
<%
		while(rs.next()){
			int idUser = rs.getInt(1);    
%>
        	<div class="item-container parent-absolute">
                <div class="member-layout">
                    <div class="member-image"><img src="<%= rs.getString(9) %>" /></div>
                </div>
                
                <div class="member-layout">
                    <div class="member-detail">
                    
                        <table>
        
                            <tr>
                                <td><strong><%= rs.getString(2) %></strong></td>
                            </tr>
                            <tr>
                                <td><%= rs.getString(3) %></td>
                            </tr>
                            <tr>
                                <td><%= rs.getString(4) %></td>
                            </tr>
                            <tr>
                                <td><%= rs.getString(7) %></td>
                            </tr>
                            <tr>
                                <td><%= rs.getString(8) %></td>
                            </tr>
                        </table>
                        
                    </div>
                </div>
            </div>
<%
		}
%>
    
    </div>
	<%@ include file="footer.jsp" %>
</body>
</html>
