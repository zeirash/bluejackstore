<%@ include file="connect.jsp" %>
<%@ page import="java.util.regex.*" %>
<%
	String fullname = request.getParameter("fullname");
	String phone = request.getParameter("phone");
	String regemail = request.getParameter("regemail");
	String regpassword = request.getParameter("regpassword");
	String regconfpassword = request.getParameter("regconfpassword");
	String gender = request.getParameter("gender");
	String dob = request.getParameter("dobdate");
	String address = request.getParameter("address");
	String image = request.getParameter("image");
	String imageExtension="";
	if(image!=null && image!=""){
		imageExtension = image.substring(image.length()-4);
	}
	//========================================================== Validating ===================================================
	//validate phone number
	boolean isNum = false;
	for(int i=0;i<phone.length();i++){
		if(phone.charAt(i) < 48 || phone.charAt(i) >57){
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
	matcherEmail = patternEmail.matcher(regemail);
		
	if(matcherEmail.matches()) validateEmail=true;
	else validateEmail=false;
	
	//validate dob format
	 boolean dateFormat=false;
	 String tempWord=dob.trim();
	 
	 if(tempWord.length() != 10) dateFormat=false;
	 else{
	 	if(tempWord.charAt(4) != '/' || tempWord.charAt(7) != '/') dateFormat=false;
		else{
			String date[] = dob.split("/");
			int day=0, month=0, year=0;
			try{
				year=Integer.parseInt(date[0]);
				month=Integer.parseInt(date[1]);
				day=Integer.parseInt(date[2]);
			}
			catch(Exception e){dateFormat=false;}
			if(day<1||day>31) dateFormat=false;
			else if(month<1||month>12) dateFormat=false;
			else if(year>2016) dateFormat=false;
			else dateFormat=true;
		}
	 }
	 
	//validate alphanumeric password
	boolean isNumberPass = false, isAlphaPass=false;
	for(int i=0;i<regpassword.length();i++){
		if(regpassword.charAt(i) < 48 || regpassword.charAt(i) >57){
			isAlphaPass = true;
		}
		else{
			isNumberPass = true;
		}
	}
	 
	//========================================================================================================================	
	if(fullname == null || fullname == "" ){
		response.sendRedirect("../register.jsp?err=Name Cannot be empty");
	}
	else if(phone == null || phone == "" ){
		response.sendRedirect("../register.jsp?err=Phone Cannot be empty");
	}
	else if(isNum == false){
		response.sendRedirect("../register.jsp?err=Phone must be number");
	}
	else if(regemail == null || regemail == "" ){
		response.sendRedirect("../register.jsp?err=Email Cannot be empty");
	}
	else if(!validateEmail){
		response.sendRedirect("../register.jsp?err=Wrong email format");
	}
	else if(regpassword == null || regpassword == "" ){
		response.sendRedirect("../register.jsp?err=Password Cannot be empty");
	}
	else if(!isNumberPass || !isAlphaPass ){
		response.sendRedirect("../register.jsp?err=Password must contained number and alphabet");
	}
	else if(regconfpassword == null || regconfpassword == "" ){
		response.sendRedirect("../register.jsp?err=Confirm Password Cannot be empty");
	}
	else if(!regpassword.equals(regconfpassword)){
		response.sendRedirect("../register.jsp?err=Password and confirm password is not same");
	}
	else if(gender == null || gender == "" ){
		response.sendRedirect("../register.jsp?err=Gender must be checked");
	}
	else if(dob == null || dob == "" ){
		response.sendRedirect("../register.jsp?err=Date Of Birth Cannot be empty");
	}
	else if(!dateFormat){
		response.sendRedirect("../register.jsp?err=Wrong Date Of Birth format");
	}
	else if(address == null || address == "" ){
		response.sendRedirect("../register.jsp?err=Address Cannot be empty");
	}
	else if(image == null || image == ""){
		response.sendRedirect("../register.jsp?err=Image Cannot be empty");
	}
	else if(!imageExtension.equals(".png") && !imageExtension.equals(".jpg")){
		response.sendRedirect("../register.jsp?err=File must be .jpg or .png");
	}
	else{
		image = "Images/" + request.getParameter("image");
		String query = "INSERT INTO users VALUES(null,'"+fullname+"','"+phone+"','"+regemail+"','"+regpassword+"','"+gender+"','"+dob+"','"+address+"','"+image+"',2)";

		st.executeUpdate(query);
		con.close();
		response.sendRedirect("../login.jsp");
	}
	
	
%>
