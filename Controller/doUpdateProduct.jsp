<%@ include file="connect.jsp" %>
<%
	String productName = request.getParameter("productName");
	String productPrice = request.getParameter("productPrice");
	String productWeight = request.getParameter("productWeight");
	String productStock = request.getParameter("productStock");
	String productImage = request.getParameter("productImage");
	String imageExtension="";
	if(productImage!=null && productImage!=""){
		imageExtension = productImage.substring(productImage.length()-4);
	}
	String idToUpdate = request.getParameter("idToUpdate");
	String currentpage = request.getParameter("currentpage");
	int price=0, stock=0;
	float weight=0;
	
	//validate price
	boolean isNumPrice=false;
	for(int i=0;i<productPrice.length();i++){
		if(productPrice.charAt(i) < 48 || productPrice.charAt(i) >57){
			isNumPrice = false;
		}
		else{
			isNumPrice = true;
		}
	}
	
	//validate weight
	boolean isNumWeight=false;
	for(int i=0;i<productWeight.length();i++){
		if(productWeight.charAt(i) < 48 || productWeight.charAt(i) >57){
			isNumWeight = false;
		}
		else{
			isNumWeight = true;
		}
	}
	
	//validate stock
	boolean isNumStock=false;
	for(int i=0;i<productStock.length();i++){
		if(productStock.charAt(i) < 48 || productStock.charAt(i) >57){
			isNumStock = false;
		}
		else{
			isNumStock = true;
		}
	}
	
	if(productStock!=null && !productStock.isEmpty() && isNumStock){
		stock = Integer.parseInt(productStock.trim());
	}

	//============================================================================================================
	
	if(productName == null || productName == ""){
		response.sendRedirect("../product.jsp?err=Product name must be filled&pageid="+currentpage+"&type=update&idUpdate="+idToUpdate+"#openModal");
	}
	else if(productPrice == null || productPrice == ""){
		response.sendRedirect("../product.jsp?err=Product price must be filled&pageid="+currentpage+"&type=update&idUpdate="+idToUpdate+"#openModal");
	}
	else if(!isNumPrice){
		response.sendRedirect("../product.jsp?err=Price must be numeric&pageid="+currentpage+"&type=update&idUpdate="+idToUpdate+"#openModal");
	}
	else if(productWeight == null || productWeight == ""){
		response.sendRedirect("../product.jsp?err=Product weight must be filled&pageid="+currentpage+"&type=update&idUpdate="+idToUpdate+"#openModal");
	}
	else if(!isNumWeight){
		response.sendRedirect("../product.jsp?err=Weight must be numeric&pageid="+currentpage+"&type=update&idUpdate="+idToUpdate+"#openModal");
	}
	else if(productStock == null || productStock == ""){
		response.sendRedirect("../product.jsp?err=Product stock must be filled&pageid="+currentpage+"&type=update&idUpdate="+idToUpdate+"#openModal");
	}
	else if(!isNumStock){
		response.sendRedirect("../product.jsp?err=Stock name must be numeric&pageid="+currentpage+"&type=update&idUpdate="+idToUpdate+"#openModal");
	}
	else if(stock<=0){
		response.sendRedirect("../product.jsp?err=Stock must be larger than 0&pageid="+currentpage+"&type=update&idUpdate="+idToUpdate+"#openModal");
	}
	else if(productImage == null || productImage == ""){
		response.sendRedirect("../product.jsp?err=Image must be chosen&type=update&pageid="+currentpage+"&idUpdate="+idToUpdate+"#openModal");
	}
	else if(!imageExtension.equals(".png") && !imageExtension.equals(".jpg")){
		response.sendRedirect("../product.jsp?err=File must be .jpg or .png&type=update&pageid="+currentpage+"&idUpdate="+idToUpdate+"#openModal");
	}
	else{
		int myId = Integer.parseInt(idToUpdate);
		price = Integer.parseInt(productPrice.trim());
		weight = Float.parseFloat(productWeight.trim());
		productImage = "Images/" + request.getParameter("productImage");
		String query = "UPDATE products SET productName='"+productName+"',price="+price+",weight="+weight+",stock="+stock+",imagePath='"+productImage+"' WHERE product_id="+myId;
		
		st.executeUpdate(query);
		con.close();
		response.sendRedirect("../product.jsp?pageid="+currentpage);

	}
%>

