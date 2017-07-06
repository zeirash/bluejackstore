<%@ include file="connect.jsp" %>
<%
	String idDel = request.getParameter("commentDelete");
	String currentProduct = request.getParameter("currentProduct");
	
	String query = "DELETE FROM comments WHERE id =" + idDel;
	st.executeUpdate(query);
	
	response.sendRedirect("../reviewProduct.jsp?productId="+currentProduct);
%>
