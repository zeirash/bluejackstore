<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/webprog_db","root","");
	Statement st = con.createStatement(1004,1008);
	Statement st2 = con.createStatement(1004,1008);
	Statement st3 = con.createStatement(1004,1008);
	Statement st4 = con.createStatement(1004,1008);
	Statement st5 = con.createStatement(1004,1008);
%>
