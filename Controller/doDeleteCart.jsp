<%@ include file="connect.jsp" %>
<%
	int addstock=0;
	String idDel = request.getParameter("cartDelete");
	String currentProduct = request.getParameter("productId");
	int quantity = Integer.parseInt(request.getParameter("qty").toString());

	String currentstock = "SELECT stock FROM products WHERE product_id="+currentProduct;
	ResultSet rs = st.executeQuery(currentstock);
	
	if(rs.next()){
		addstock = rs.getInt(1) + quantity;
	}
	String updatestock = "UPDATE products SET stock="+addstock+" WHERE product_id="+currentProduct;
	st2.executeUpdate(updatestock);

	String deletecart = "DELETE FROM carts WHERE product_id =" + currentProduct;
	st3.executeUpdate(deletecart);
	
	String deletedetail = "DELETE FROM details WHERE product_id =" + currentProduct;
	st4.executeUpdate(deletedetail);
	
	response.sendRedirect("../cart.jsp");
%>
