<%@ include file="connect.jsp" %>
<%
	String currentProduct = request.getParameter("data-productid");
	String commentId = request.getParameter("data-commentid");
	String comment = request.getParameter("comment");
	String rating = request.getParameter("rating");
	
	//validation
	if(comment==null || comment==""){
		response.sendRedirect("../reviewProduct.jsp?error=Comment must be filled&productId="+currentProduct+"#openModal2");
	}
	else if(comment.length()<1 || comment.length()>255){
		response.sendRedirect("../reviewProduct.jsp?error=Comment maximal length is 255 characters&productId="+currentProduct+"#openModal2");
	}
	else if(rating==null || rating==""){
		response.sendRedirect("../reviewProduct.jsp?error=Rating must be choose&productId="+currentProduct+"#openModal2");
	}
	else{
		String query = "UPDATE comments SET comment='"+comment+"', rating="+rating+" WHERE id="+commentId;
		st.executeUpdate(query);
		con.close();
		response.sendRedirect("../reviewProduct.jsp?productId="+currentProduct);
	}
%>
