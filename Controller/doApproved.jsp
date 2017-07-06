<%@ include file="connect.jsp" %>
<%@ page import="java.util.Date, java.text.*" %>
<%
	String transactionId = request.getParameter("transactionid");
	String checkapproval = "SELECT * FROM transactions WHERE transaction_id="+transactionId;
	String currentpage = request.getParameter("pageid");
	ResultSet rs = st2.executeQuery(checkapproval);
	rs.next();
	
	Date time = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String newdate = sdf.format(time);
	
	if(rs.getString(3).equals("Completed")){
		response.sendRedirect("../transaction.jsp?pageid="+currentpage);
	}
	else{
		String updatetransaction = "UPDATE transactions SET status='Completed', dateApproval='"+newdate+"' WHERE transaction_id="+transactionId;

		st.executeUpdate(updatetransaction);
		response.sendRedirect("../transaction.jsp?pageid="+currentpage);
	}
%>