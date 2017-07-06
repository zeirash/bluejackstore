<%@ include file="connect.jsp" %>
<%@ page import="java.util.regex.*" %>
<%
	String oldPassword = request.getParameter("oldpassword");
	String newPassword = request.getParameter("newpassword");
	String confirmPassword = request.getParameter("confirmpassword");
	String updatePhone = request.getParameter("updatephone");
	String updateEmail = request.getParameter("updateemail");
	String updateAddress = request.getParameter("updateaddress");
	String updateImage = request.getParameter("updateimage");
	String imageExtension="";
	if(updateImage!=null && updateImage!=""){
		imageExtension = updateImage.substring(updateImage.length()-4);
	}
	String currid = request.getParameter("idToUpdate");
	String dbpassword="";
	
	String query = "SELECT * FROM users WHERE user_id =" + currid;
	ResultSet rs = st.executeQuery(query);
	while(rs.next()){
		dbpassword = rs.getString(5);
	}
	
	//========================================================== Validating ===================================================
	//validate phone number
	boolean isNum = false;
	for(int i=0;i<updatePhone.length();i++){
		if(updatePhone.charAt(i) < 48 || updatePhone.charAt(i) >57){
			isNum = false;
			break;
		}
		else{
			isNum = true;
		}
	}
	
	//validate email format
	Pattern patternEmail;
	Matcher matcherEmail;
	boolean validateEmail;
	String EMAIL_PATTERN = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[com]{3,})$";
	patternEmail = Pattern.compile(EMAIL_PATTERN);
	matcherEmail = patternEmail.matcher(updateEmail);
		
	if(matcherEmail.matches()) validateEmail=true;
	else validateEmail=false;
	
	//validate alphanumeric password
	boolean isNumberPass = false, isAlphaPass=false;
	for(int i=0;i<newPassword.length();i++){
		if(newPassword.charAt(i) < 48 || newPassword.charAt(i) >57){
			isAlphaPass = true;
		}
		else{
			isNumberPass = true;
		}
	}
	
	//============================================================================================================
	if(oldPassword == null || oldPassword == ""){
		response.sendRedirect("../profile.jsp?err=Old password Cannot be empty&currentId="+currid);
	}
	else if(!oldPassword.equals(dbpassword)){
		response.sendRedirect("../profile.jsp?err=Old Password is not same with current password&currentId="+currid);
	}
	else if(newPassword == null || newPassword == ""){
		response.sendRedirect("../profile.jsp?err=New password must be filled&currentId="+currid);
	}
	else if(!isNumberPass || !isAlphaPass ){
		response.sendRedirect("../profile.jsp?err=Password must contained number and alphabet&currentId="+currid);
	}
	else if(confirmPassword == null || confirmPassword == "" ){
		response.sendRedirect("../profile.jsp?err=Confirm Password Cannot be empty&currentId="+currid);
	}
	else if(!confirmPassword.equals(newPassword)){
		response.sendRedirect("../profile.jsp?err=Password and confirm password is not same&currentId="+currid);
	}
	else if(updatePhone == null || updatePhone == "" ){
		response.sendRedirect("../profile.jsp?err=Phone Cannot be empty&currentId="+currid);
	}
	else if(!isNum){
		response.sendRedirect("../profile.jsp?err=Phone must be numeric&currentId="+currid);
	}
	else if(updateEmail == null || updateEmail == ""){
		response.sendRedirect("../profile.jsp?err=Email must be filled&currentId="+currid);
	}
	else if(!validateEmail){
		response.sendRedirect("../profile.jsp?err=Wrong email format&currentId="+currid);
	}
	else if(updateAddress == null || updateAddress == ""){
		response.sendRedirect("../profile.jsp?err=Address must be filled&currentId="+currid);
	}
	else if(updateImage == null || updateImage == ""){
		response.sendRedirect("../profile.jsp?err=Images can not be empty&currentId="+currid);
	}
	else if(!imageExtension.equals(".png") && !imageExtension.equals(".jpg")){
		response.sendRedirect("../profile.jsp?err=File must be .jpg or .png&currentId="+currid);
	}
	else{
		updateImage = "Images/" + updateImage;
		String queryupdate = "UPDATE users SET phone='"+updatePhone+"',email='"+updateEmail+"',password='"+newPassword+"',address='"+updateAddress+"',image='"+updateImage+"' WHERE user_id="+currid;
			st2.executeUpdate(queryupdate);
			con.close();
			application.setAttribute("afterUpdateUsername", updateEmail);
			application.setAttribute("afterUpdatePassword", newPassword);
			response.sendRedirect("../profile.jsp");
	}
	
	
%>