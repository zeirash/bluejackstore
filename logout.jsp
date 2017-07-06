<%
	session.invalidate();
	int online=Integer.parseInt((String)application.getAttribute("online"));
	if(online<=0)
		online=0;
	else
		online-=1;
	
	application.setAttribute("online",online+"");	
	response.sendRedirect("index.jsp");
	
%>
