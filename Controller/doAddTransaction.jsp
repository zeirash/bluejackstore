<%@ include file="connect.jsp" %>
<%
	String userId="";
	if(session.getAttribute("idSession")!=null){
		userId = session.getAttribute("idSession").toString();
	}

	
	
	String allcart = "SELECT * FROM carts WHERE user_id="+userId;
	ResultSet rs = st.executeQuery(allcart);
	
	if(!rs.next()){
		response.sendRedirect("../cart.jsp?err=You have no item in your cart");
	}
	else {
		String query = "INSERT INTO transactions VALUES(null, "+userId+", 'Waiting for Approval', null)";
		st2.executeUpdate(query);
		
		String latesttransaction = "SELECT MAX(transaction_id) FROM transactions";
		ResultSet rs2 = st3.executeQuery(latesttransaction);
		if(rs5.next()){
			String allcart2 = "SELECT * FROM carts WHERE user_id="+userId;
			ResultSet rs5 = st.executeQuery(allcart2);
			while(rs5.next()){
				int cartid = rs3.getInt(1);
				String updatetransaction = "UPDATE carts SET transaction_id="+rs2.getInt(1)+" WHERE cart_id="+cartid;
				st4.executeUpdate(updatetransaction);
				
				String updatedetail = "UPDATE details SET transaction_id="+rs2.getInt(1)+" WHERE cart_id="+cartid;
				st5.executeUpdate(updatedetail);
			}
		
			//remove everything from cart
			String removecart = "DELETE FROM carts WHERE transaction_id="+rs2.getInt(1);
			st5.executeUpdate(removecart);
		}
		
		response.sendRedirect("../product.jsp");
	}
%>