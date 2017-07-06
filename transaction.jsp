<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*, java.text.*" errorPage="" %>
<%@ include file="Controller/connect.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
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
	
	String userId="", currentpage="";
	if(session.getAttribute("idSession")!=null){
		userId = session.getAttribute("idSession").toString();
	}
	
	ResultSet rs, rs2, rs3;
	if(session.getAttribute("roleSession").equals("2")){
		String transactionmember = "SELECT DISTINCT t.transaction_id, t.status, u.name, t.dateApproval FROM transactions t JOIN details d ON t.transaction_id=d.transaction_id JOIN users u ON t.user_id=u.user_id WHERE t.user_id="+userId;
		rs = st.executeQuery(transactionmember);
		while(rs.next()) counter++;
		paging = counter/5+1;

		if(request.getParameter("pageid")!=null && request.getParameter("pageid")!=""){
			start=Integer.parseInt(request.getParameter("pageid").toString())-1;
			currentpage = request.getParameter("pageid");
		}
		String querypaging="SELECT DISTINCT t.transaction_id, t.status, u.name, t.dateApproval FROM transactions t JOIN details d ON t.transaction_id=d.transaction_id JOIN users u ON t.user_id=u.user_id WHERE t.user_id="+userId+" LIMIT "+start*5+",5";
		rs3 = st.executeQuery(querypaging);
	}
	else{
		String transactionadmin = "SELECT DISTINCT t.transaction_id, t.status, u.name, t.dateApproval FROM transactions t JOIN details d ON t.transaction_id=d.transaction_id JOIN users u ON t.user_id=u.user_id";
		rs = st.executeQuery(transactionadmin);
		while(rs.next()) counter++;
		paging = counter/5+1;
		
		if(request.getParameter("pageid")!=null && request.getParameter("pageid")!=""){
			start=Integer.parseInt(request.getParameter("pageid").toString())-1;
			currentpage = request.getParameter("pageid");
		}
		String querypaging="SELECT DISTINCT t.transaction_id, t.status, u.name, t.dateApproval FROM transactions t JOIN details d ON t.transaction_id=d.transaction_id JOIN users u ON t.user_id=u.user_id LIMIT "+start*5+",5";
		rs3 = st.executeQuery(querypaging);
	}
%>
</head>

<body>
	<%@ include file="status.jsp" %>
	<%@ include file="header.jsp" %>
    
	<div class="body-container">
    
    	<div class="title-container">
        	<div class="title-content">
            	<div class="title-text">Transaction</div>
            </div>
        </div>
<%
	while(rs3.next()){
		int number=0, total=0;
		int transactionid = rs3.getInt(1);
%>
<%
		if(session.getAttribute("roleSession").equals("1") && rs3.getString(2).equals("Waiting for Approval")){
%>
		<a href="Controller/doApproved.jsp?pageid=<%= currentpage %>&transactionid=<%= transactionid %>">
    		<div class="item-container parent-absolute approved-button">
<%
		}
		else{
%>
			<div class="item-container parent-absolute">
<%
		}
%>
<%
			if(rs3.getString(2).equals("Completed")){
%>
				<div class="approval"><img src="Images/approved.png" /></div>
            	<div class="approval-date">Approved at: <%= rs3.getString(4) %></div>
<%
			}
%>
        		<div class="transaction-layout">
            		<div class="transaction-header">
                    	<div class="transaction-id">Transaction ID: <%= rs3.getInt(1) %></div>
                    <div class="transaction-status">Status: <%= rs3.getString(2) %></div>
                    </div>
                    <div class="transaction-inline">
                        <div class="transaction-by">By <%= rs3.getString(3) %></div>
                    </div>
                    <div class="transaction-inline">
<%
					String detailquery = "SELECT detail_id, p.productName, SUM(d.quantity), SUM(d.quantity)*p.price, p.price FROM details d JOIN products p ON d.product_id=p.product_id WHERE d.transaction_id="+rs3.getInt(1)+" GROUP BY d.product_id";
					rs2 = st2.executeQuery(detailquery);
					
					while(rs2.next()){
						number++;
						total += rs2.getInt(4);
%>
						<div class="transaction-detail"><%= number %>. <%= rs2.getString(2) %> - Rp. <%= rs2.getInt(4) %> (Rp. <%= rs2.getInt(5) %> x <%= rs2.getInt(3) %>pcs)</div>
<%
					}
%>
                        <div class="transaction-price title-text -red ">Rp. <%= total %></div>
                        
                    </div>
                </div>
            </div>
<%
		if(session.getAttribute("roleSession").equals("1") && rs3.getString(2).equals("Waiting for Approval")){
%>
		</a>
<%
		}
%>
<%
	}
%>
		<div class="page-footer">
            <div class="page-container">
<%
			for(int i=0; i<paging; i++){
%>
                <a href="transaction.jsp?pageid=<%= i+1 %>"><div class="paging"><%= i+1 %></div></a>
<%
			}
%>
            </div>
        </div>


    </div>
    
	<%@ include file="footer.jsp" %>
</body>
</html>
