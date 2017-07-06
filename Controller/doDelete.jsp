<%@ include file="connect.jsp" %>
<%
	int idDel = Integer.parseInt(request.getParameter("id").toString());
	String currentpage = request.getParameter("pageid");
	
	String query = "DELETE FROM products WHERE product_id =" + idDel;
	st.executeUpdate(query);
	
	response.sendRedirect("../product.jsp?pageid="+currentpage);
%>