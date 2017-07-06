<navbar>
	<a href="index.jsp"><div class="menu -left">Home</div></a>
<%
		if(session.getAttribute("usernameSession")==null){
			out.print(""
				+"<a href=\"register.jsp\"><div class=\"menu -right\">Register</div></a>"
				+"<a href=\"login.jsp\"><div class=\"menu -right\">Login</div></a>"
			);
		}
		else if(session.getAttribute("usernameSession")!=null){
			out.print(""
				+"<a href=\"product.jsp\"><div class=\"menu -left\">Product</div></a>"
				+"<a href=\"member.jsp\"><div class=\"menu -left\">Member</div></a>"
				+"<a href=\"transaction.jsp\"><div class=\"menu -left\">Transaction</div></a>"
			);
			out.print(""
				+"<a href=\"logout.jsp\"><div class=\"menu -right\">Logout</div></a>"
				+"<a href=\"profile.jsp\"><div class=\"menu -right\">Profile</div></a>"
			);
			if(!session.getAttribute("roleSession").equals("1")){
				out.print("<a href=\"cart.jsp\"><div class=\"menu -right\">Cart</div></a>");		
			}
		}
%>
	
</navbar>