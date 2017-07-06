<%@ include file="connect.jsp" %>
<%
	String quantity = request.getParameter("quantity");
	String productId = request.getParameter("data-productid");
	String userId = request.getParameter("data-userid");
	String currentpage = request.getParameter("currentpage");
	
	String query = "SELECT * FROM products WHERE product_id="+productId;
	ResultSet rs = st.executeQuery(query);
	rs.next();
	int currentStock = rs.getInt(5);
	
	//validate number quantity
	boolean isNum = false;
	for(int i=0;i<quantity.length();i++){
		if(quantity.charAt(i) < 48 || quantity.charAt(i) >57){
			isNum = false;
			break;
		}
		else{
			isNum = true;
		}
	}
	
	if(request.getParameter("quantity")==null || request.getParameter("quantity")==""){
		response.sendRedirect("../product.jsp?errmessage=Quantity must be filled&pageid="+currentpage+"#openModalError");
	}
	else if(!isNum){
		response.sendRedirect("../product.jsp?errmessage=Quantity must be a number&pageid="+currentpage+"#openModalError");
	}
	else{
		int qtyInt = Integer.parseInt(quantity);
		
		if(qtyInt<=0){
			response.sendRedirect("../product.jsp?errmessage=Quantity must be bigger than 0&pageid="+currentpage+"#openModalError");
		}
		else if(qtyInt>currentStock){
			response.sendRedirect("../product.jsp?errmessage=Quantity must be lesser or equal from stocks&pageid="+currentpage+"#openModalError");
		}
		else{
			int updateStock = currentStock - qtyInt;
			String insertcart = "INSERT INTO carts VALUES(null, null, "+productId+", "+userId+", "+qtyInt+")";
			st.executeUpdate(insertcart);
			//get latest cart input
			String latestcart = "SELECT MAX(cart_id) FROM carts";
			ResultSet rs2 = st4.executeQuery(latestcart);
			rs2.next();
			
			String insertdetail = "INSERT INTO details VALUES(null, "+rs2.getInt(1)+", null, "+productId+", "+userId+", "+qtyInt+")";
			st3.executeUpdate(insertdetail);
			
			String updatestock = "UPDATE products SET stock="+updateStock+" WHERE product_id="+productId;
			st2.executeUpdate(updatestock);
			response.sendRedirect("../product.jsp?pageid="+currentpage);
		}
	}
%>
