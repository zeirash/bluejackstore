<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*, java.text.*" errorPage="" %>
<%@ include file="Controller/connect.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<link href="style.css" type="text/css" rel="stylesheet" />
<%
	if(session.getAttribute("usernameSession")==null || session.getAttribute("roleSession").equals("1")){
%>
		<jsp:forward page="logout.jsp"/>
<%
	}
	
	int total=0, idCart=0;
	String userId="";
	if(session.getAttribute("idSession")!=null){
		userId = session.getAttribute("idSession").toString();
	}
	String query = "SELECT c.cart_id, c.product_id, c.quantity, p.imagePath, p.productName, SUM(quantity), SUM(quantity)*p.price, p.price FROM carts c JOIN products p ON c.product_id=p.product_id WHERE user_id="+userId+" GROUP BY c.product_id";
	ResultSet rs = st.executeQuery(query);
%>
</head>

<body>
	<%@ include file="status.jsp" %>
	<%@ include file="header.jsp" %>
    
	<div class="body-container">
    
    	<div class="title-container">
        	<div class="title-content">
            	<div class="title-text">Your Active Cart</div>
            </div>
        </div>
<%
	while(rs.next()){
		int idProduct = rs.getInt(2);
		idCart = rs.getInt(1);
		total += rs.getInt(7);
%>
		<div class="item-container parent-absolute">
        	<div class="product-layout">
<%
				String getProductId = "PR" + Integer.toString(idProduct + 1000).substring(1,4);
%>
				<div class="product-id"><%= getProductId %></div>
				<div class="product-image"><img src="<%= rs.getString(4) %>" /></div>
			</div>
            
            <div class="product-layout">
                <div class="product-detail">
            
                    <table>
    
                        <tr>
                            <td>Name</td>
                            <td>:</td>
                            <td><%= rs.getString(5) %></td>
                        </tr>
                        <tr>
                            <td>Quantity</td>
                            <td>:</td>
                            <td><%= rs.getInt(6) %>pcs</td>
                        </tr>
                        <tr>
                            <td>Subtotal Price</td>
                            <td>:</td>
                            <td>Rp. <%= rs.getInt(7) %> (Rp.<%= rs.getInt(8) %> x <%= rs.getInt(6) %>pcs)</td>
                        </tr>
                    
                    </table>
                
                </div>
            </div>
            <a href="Controller/doDeleteCart.jsp?cartDelete=<%= idCart %>&productId=<%= idProduct %>&qty=<%= rs.getInt(6) %>">
            	<div class="delete-public"><strong>X</strong></div>
            </a>

        </div>
<%
	}
%>
		<div class="item-container parent-absolute -aligncenter">
        	<div class="payment-layout">
            	<div class="payment-text">
                    <div class="title-text">Total Transaction Price</div>
                </div>
                <div class="title-text -nodecoration">Rp. <%= total %></div>
                    <div class="cart-error">
                        <div class="normal-text -red">
<%
                        String err = request.getParameter("err");
                        if(err != null) out.print(err);
%>
                    </div>
                </div>
                <a href="Controller/doAddTransaction.jsp"><div class="button">Complete the Payment</div></a>
            </div>
        </div>
        
    </div>
    
    <%@ include file="footer.jsp" %>
</body>
</html>
