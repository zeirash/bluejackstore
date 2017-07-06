<%@ include file="connect.jsp" %>
<%
	String currentUser = request.getParameter("data-userid");
	String currentProduct = request.getParameter("data-productid");
	String comment = request.getParameter("comment");
	String rating = request.getParameter("rating");
	
	//validation
	if(comment==null || comment==""){
		response.sendRedirect("../reviewProduct.jsp?err=Comment must be filled&productId="+currentProduct);
	}
	else if(comment.length()<1 || comment.length()>255){
		response.sendRedirect("../reviewProduct.jsp?err=Comment maximal length is 255 characters&productId="+currentProduct);
	}
	else if(rating==null || rating==""){
		response.sendRedirect("../reviewProduct.jsp?err=Rating must be choose&productId="+currentProduct);
	}
	else{
		String query = "INSERT INTO comments VALUES(null, "+currentProduct+", "+currentUser+", '"+comment+"', "+rating+")";
		st.executeUpdate(query);
		
		response.sendRedirect("../reviewProduct.jsp?productId="+currentProduct);
	}
%>
