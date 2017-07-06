<%@ include file="connect.jsp" %>
<%
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String remember = request.getParameter("remember");
	
	int online=0;
	
	if(username==null || username=="")
		response.sendRedirect("../login.jsp?err=email cannot be empty");
	else if(password==null || password=="")
		response.sendRedirect("../login.jsp?err=password cannot be empty");
	else{
		String query = "SELECT * FROM users WHERE email = '" + username + "' AND password = '"+ password +" ' ";
		ResultSet rs;
		rs =  st.executeQuery(query);
		
		
		if(rs.next()){
			String i = (String) application.getAttribute("online");
			String getName = rs.getString(2);
			int getRole = rs.getInt(10);
			String role = Integer.toString(getRole);
			
			if(i==null || i=="")
				application.setAttribute("online", "1");
			else {
				online = Integer.parseInt(i);
				online++;
				application.setAttribute("online", online+"");
			}
			
			session.setAttribute("usernameSession", username);
			session.setAttribute("passwordSession", password);
			session.setAttribute("getNameSession", getName);
			session.setAttribute("roleSession", role);
			session.setAttribute("idSession", rs.getInt(1));
			
			if(remember!=null){
				Cookie userCookie = new Cookie("usernameCookie", username);
				Cookie passCookie = new Cookie("passwordCookie", password);
				Cookie checkCookie = new Cookie("checkedCookie", "remembered");
				
				userCookie.setMaxAge(3600);
				passCookie.setMaxAge(3600);
				checkCookie.setMaxAge(3600);
				userCookie.setPath("/");
				passCookie.setPath("/");
				checkCookie.setPath("/");
				
				response.addCookie(userCookie);
				response.addCookie(passCookie);
				response.addCookie(checkCookie);
			}
			
			response.sendRedirect("../index.jsp");
		}
		else {
			response.sendRedirect("../login.jsp?err=email or password are invalid");
		}
		
	}
%>