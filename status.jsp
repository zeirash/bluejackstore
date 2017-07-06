<%@ page import="java.util.Date" %>
<div class="status-info">
<%
	if (session.getAttribute("usernameSession")==null){
		out.print("Hello, Guest<br/>");
	}
	else if(session.getAttribute("usernameSession")!=null){
		out.print("Hello, " + session.getAttribute("getNameSession") + "<br/>");
	}
	
	if(application.getAttribute("online")==null)
		out.print("User Online : 0<br />");
	else
		out.print("User Online : " + application.getAttribute("online") + "<br />");
	
	Date time = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("MMMM dd, yyyy");
	out.print(sdf.format(time));
%> 
</div>
