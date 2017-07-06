<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*, java.text.*" errorPage="" %>
<%@ include file="Controller/connect.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<script>
var loadFile = function(event) {
	var preview = document.getElementById('preview');
	preview.src = URL.createObjectURL(event.target.files[0]);
};
</script>
<link href="style.css" type="text/css" rel="stylesheet" />
<%
	if(session.getAttribute("usernameSession")==null){
%>
		<jsp:forward page="logout.jsp"/>
<%
	}
%>
<%
	int counter=0;
	int paging=0;
	int start=0;
	
	String type="", idUpdate="", userId="", currentadmin="", currentpage="";
	if(session.getAttribute("idSession")!=null){
		userId = session.getAttribute("idSession").toString();
	}
	String search = request.getParameter("search");
	
	ResultSet rs, rs2, rs3;
	
	if(search!=null){
		String querysearch = "SELECT * FROM products where productName LIKE '%"+search+"%'";
		rs = st.executeQuery(querysearch);
		while(rs.next()) counter++;
		paging = counter/5+1;
		
		if(request.getParameter("pageid")!=null && request.getParameter("pageid")!=""){
			start=Integer.parseInt(request.getParameter("pageid").toString())-1;
			currentpage = request.getParameter("pageid");
		}
		String querypaging="SELECT * FROM products WHERE productName LIKE '%"+search+"%' LIMIT "+start*5+",5";
		rs3 = st.executeQuery(querypaging);
	}
	else{
		String query = "SELECT * FROM products";
		rs = st.executeQuery(query);
		while(rs.next()) counter++;
		paging = counter/5+1;
		
		if(request.getParameter("pageid")!=null && request.getParameter("pageid")!=""){
			start=Integer.parseInt(request.getParameter("pageid").toString())-1;
			currentpage = request.getParameter("pageid");
		}
		String querypaging="SELECT * FROM products LIMIT "+start*5+",5";
		rs3 = st.executeQuery(querypaging);
	}
	
	if(request.getParameter("type")!=null && request.getParameter("type")!=""){
		type = request.getParameter("type");
	}
	if(request.getParameter("idUpdate")!=null && request.getParameter("idUpdate")!=""){
		idUpdate = request.getParameter("idUpdate");
	}
	
	String getadminname = "SELECT * FROM users WHERE role=1";
	ResultSet rs4 = st2.executeQuery(getadminname);
	if(rs4.next()){
		currentadmin = rs4.getString(2);
	}
%>

</head>

<body>
    <%@ include file="status.jsp" %>
	<%@ include file="header.jsp" %>
    <div class="body-container">
        
        <div class="title-container">
        	<div class="title-content">
            	<div class="title-text">Product List</div>
            </div>
            <div class="title-content">
                <div class="search-container">
                	<form action="product.jsp" method="post">
                        <div class="search-bar"><input type="text" name="search" placeholder="Search" /></div>
                        <div class="search-bar"><input type="submit" class="button" value="search" /></div>
                    </form>
                </div>
            </div>
        </div>
<%
		while(rs3.next()){
			int idProduct = rs3.getInt(1);    
%>
        	<div class="item-container parent-absolute">
        
        		<div class="product-layout">
<%
					String getProductId = "PR" + Integer.toString(idProduct + 1000).substring(1,4);
%>
            		<div class="product-id"><%= getProductId %></div>
            		<div class="product-image"><img src="<%= rs3.getString(6) %>" /></div>
            	</div>
            
            	<div class="product-layout">
                	<div class="product-detail">
                
                        <table>
        
                            <tr>
                                <td>Name</td>
                                <td>:</td>
                                <td><%= rs3.getString(2) %></td>
                            </tr>
                            <tr>
                                <td>Price</td>
                                <td>:</td>
                                <td>Rp. <%= rs3.getInt(3) %></td>
                            </tr>
                            <tr>
                                <td>Weight</td>
                                <td>:</td>
                                <td><%= rs3.getFloat(4) %>kg</td>
                            </tr>
                            <tr>
                                <td>Stock</td>
                                <td>:</td>
                                <td><%= rs3.getInt(5) %>pcs</td>
                            </tr>
                            <tr>
                                <td colspan="3"><em>Inserted by <%= currentadmin %></em></td>
                            </tr>
                            <tr>
                                <td colspan="3"><a href="reviewProduct.jsp?productId=<%= idProduct %>"><u>View Product Review</u></a></td>
                            </tr>
                        </table>
                    
                    </div>
                </div>
            
            	<div class="product-layout">
            
<%
				//admin
				if(session.getAttribute("roleSession").equals("1")){      
%>	
                    <div class="product-button">
                        <div class="admin-button">
                            <a href="?pageid=<%= currentpage %>&type=update&idUpdate=<%= idProduct %>#openModal"><div class="button">Update</div></a>
                        </div>
                        <div class="admin-button">
                            <a href="Controller/doDelete.jsp?id=<%= idProduct %>&pageid=<%= currentpage %>"><div class="button">Delete</div></a>
                        </div>
                    </div>
<%		
				}
				//customer
				else{
%>
                    <form action="Controller/doAddCart.jsp" method="post">
                        <div class="qty-textbox">
                            <input type="text" name="quantity" placeholder="Qty" />
                        </div>
                        <div class="just-passing"><input type="text" name="data-userid" value="<%= userId %>" /></div>
                        <div class="just-passing"><input type="text" name="data-productid" value="<%= idProduct %>" /></div>
                        <input type="hidden" name="currentpage" value="<%= currentpage %>" />
                        <div class="cart-button">
                            <input type="submit" value="Add to Cart" class="button" />
                        </div>
                    </form>
<%
				}
%> 
                
                </div>
                
            </div>
        	<!------------------------------------------ For Error Message Modal Dialog ---------------------------------------->
            <div id="openModalError" class="modalDialog">
                <div class="modal-container">
                    <a href="#close" title="Close" class="close">X</a>
                    <h2>Error Message</h2>
                    <div class="modal-content">
                        <div class="error-message">
                            <div class="normal-text -red">
<%
                                String errmessage = request.getParameter("errmessage");
                                if(errmessage != null) out.print("<h3>"+errmessage+"</h3>");
%>
                            </div>
                        </div>
                `	</div>
                </div>
            </div>
            <!------------------------------------------- For Update Insert Modal Dialog ---------------------------------------->
            <div id="openModal" class="modalDialog">
                <div class="modal-container">
                    <a href="#close" title="Close" class="close">X</a>
                
<%
					if(type.equals("update")){
					//String queryProduct = "SELECT * FROM products WHERE id =" + idProduct;
						String queryProduct = "SELECT * FROM products WHERE product_id =" + idUpdate;
						rs2 = st2.executeQuery(queryProduct);
						if(rs2.next()){
%>
                            <h2>Update product</h2>
                            <div class="modal-content">
                                <form action="Controller/doUpdateProduct.jsp" method="post">
                                    <div class="table">
                                        <div class="product-row">
                                            <div class="input-text">
                                                <input type="text" name="productName" placeholder="Product name" value="<%= rs2.getString(2) %>" />
                                            </div>
                                        </div>
                                        <div class="product-row">
                                            <div class="input-text">
                                                <input type="text" name="productPrice" placeholder="Price" value="<%= rs2.getInt(3) %>" />
                                            </div>
                                        </div>
                                        <div class="product-row">
                                            <div class="input-text input-inline">
                                                <input type="text" name="productWeight" placeholder="Weight" value="<%= rs2.getFloat(4) %>" />
                                            </div>
                                            <div class="input-text input-inline">
                                                <input type="text" name="productStock" placeholder="Stock" value="<%= rs2.getInt(5) %>" />
                                            </div>
                                        </div>
                                        <div class="product-row">
                                            <div class="input-text">
                                                <input type="file" onchange="loadFile(event);" name="productImage" accept=".jpg, .png" />
                                            </div>
                                        </div>
                                        <div class="image-output"><img id="preview" /></div>
                                        <div class="product-row">
                                            <div id="error">
                                                <div class="normal-text -red">
                                                <%
                                                    String err = request.getParameter("err");
                                                    if(err != null) out.print(err);
                                                %>
                                                </div>
                                            </div>
                                        </div>
                                        <input type="hidden" name="currentpage" value="<%= currentpage %>" />
                                        <div class="product-row">
                                            <input type="text" name="idToUpdate" id="pass-data" value="<%=idUpdate%>" />
                                        </div>
                                        <div class="product-row">
                                            <div class="button-insert">
                                                <input type="submit" value="Update" class="button" />
                                            </div>
                                        </div>
                                    </div>        
                                </form>
                            </div>
<%		
						}
					}
					else if(type.equals("insert")){
%>
						<h2>Insert New product</h2>
                        <div class="modal-content">
                            <form action="Controller/doInsert.jsp" method="post">
                                <div class="table">
                                    <div class="product-row">
                                        <div class="input-text">
                                            <input type="text" name="productName" placeholder="Product name" />
                                        </div>
                                    </div>
                                    <div class="product-row">
                                        <div class="input-text">
                                            <input type="text" name="productPrice" placeholder="Price" />
                                        </div>
                                    </div>
                                    <div class="product-row">
                                        <div class="input-text input-inline">
                                            <input type="text" name="productWeight" placeholder="Weight" />
                                        </div>
                                        <div class="input-text input-inline">
                                            <input type="text" name="productStock" placeholder="Stock" />
                                        </div>
                                    </div>
                                    <div class="product-row">
                                        <div class="input-text">
                                            <input type="file" onchange="loadFile(event);" name="productImage" accept=".jpg, .png" />
                                        </div>
                                    </div>
                                    <div class="product-row">
                                        <div class="image-output"><img id="preview" /></div>
                                    </div>
                                    <div class="product-row">
                                        <div id="error">
                                        	<div class="normal-text -red">
<%
                                                String err = request.getParameter("err");
                                                if(err != null) out.print(err);
%>
                                            </div>
                                        </div>
                                    </div>
                                    <input type="hidden" name="currentpage" value="<%= currentpage %>" />
                                    <div class="product-row">
                                        <div class="button-insert">
                                            <input type="submit" value="Insert" class="button" />
                                        </div>
                                    </div>
                                </div>        
                            </form>
                        </div>
<%
					}
%>
               
                
                </div>
                
            </div>
        
<%
		}
%>
        
        <div class="page-footer">
            <div class="page-container">
<%
			for(int i=0; i<paging; i++){
%>
                <a href="product.jsp?pageid=<%= i+1 %>"><div class="paging"><%= i+1 %></div></a>
<%
			}
%>
            </div>
        </div>
<%
    if(session.getAttribute("roleSession").equals("1")){
%>
    	<a href="?pageid=<%= currentpage %>&type=insert#openModal">
    		<div class="addbutton-container">
            	<div class="content-button">
                	<div class="add-button">+</div>
                </div>
            </div>
        </a>
        
<%
    }
%>
        
        
	</div>
   	<%@ include file="footer.jsp" %>
</body>
</html>
