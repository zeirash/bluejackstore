<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*, java.text.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<link href="style.css" type="text/css" rel="stylesheet" />

<script>
var loadFile = function(event) {
	var preview = document.getElementById('preview');
	preview.src = URL.createObjectURL(event.target.files[0]);
};
</script>
<%
	if(session.getAttribute("usernameSession")!=null){
%>
		<jsp:forward page="index.jsp"/>
<%
	}
%>
<%
		String getImage = request.getParameter("image");
%>
</head>

<body> 

    <%@ include file="status.jsp" %>
	<%@ include file="header.jsp" %>
	<div class="body-container">
		<div class="register-container">    

            <form action="Controller/doRegister.jsp" method="post">
                <div class="content-page">
                    <div class="title-text">Register</div>
                    
                    <table>
                    
                        <tr>
                            <td>
                                <div class="normal-text -alignleft">Full Name</div>
                            </td>
                            <td><div class="normal-text">:</div></td>
                            <td>
                                <div class="input"><input type="text" name="fullname" placeholder="Full Name"/></div>
                            </td>
                        </tr>
                        <tr>
                        	<td>
                            	<div class="normal-text -alignleft">Phone</div>
                            </td>
                            <td><div class="normal-text">:</div></td>
                            <td>
                            	<div class="input"><input type="text" name="phone" placeholder="Phone Number"/></div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            	<div class="normal-text -alignleft">Email</div>
                            </td>
                            <td><div class="normal-text">:</div></td>
                            <td>
                            	<div class="input"><input type="text" name="regemail" placeholder="Email"/></div>
                            </td>
                        </tr>
                        <tr>
                        	<td>
                            	<div class="normal-text -alignleft">Password</div>
                            </td>
                            <td><div class="normal-text">:</div></td>
                            <td>
                            	<div class="input"><input type="password" name="regpassword" placeholder="Password"/></div>
                            </td>
                        </t>
                        <tr>
                        	<td>
                            	<div class="normal-text -alignleft">Confirm Password</div>
                            </td>
                            <td><div class="normal-text">:</div></td>
                            <td>
                            	<div class="input"><input type="password" name="regconfpassword" placeholder="Confirm Password"/></div>
                            </td>
                        </tr>
                        <tr>
                        	<td>
                            	<div class="normal-text -alignleft">Gender</div>
                            </td>
                            <td><div class="normal-text">:</div></td>
                            <td>
                                <div class="center-items">
                                	<div class="radio-inline">
                                    	<div class="radiotext-inline">
                                    		<input type="radio" name="gender" value="male" />
                                        </div>
                                        <div class="radiotext-inline">
                                        	<div class="normal-text">Male</div>
                                        </div>
                                    </div>
                                    <div class="radio-inline">
                                    	<div class="radiotext-inline">
                                    		<input type="radio" name="gender" value="female" />
                                        </div>
                                        <div class="radiotext-inline">
                                        	<div class="normal-text">Female</div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                        	<td>
                            	<div class="normal-text -alignleft">Date of Birth</div>
                            </td>
                            <td><div class="normal-text">:</div></td>
                            <td>
                            	<div class="input"><input type="text" name="dobdate" placeholder="yyyy/MM/dd"/></div>
                            </td>
                        </tr>
                        <tr>
                        	<td>
                            	<div class="normal-text -alignleft">Address</div>
                            </td>
                            <td><div class="normal-text">:</div></td>
                            <td>
                            	<div class="input"><input type="text" name="address" placeholder="Address"/></div>
                            </td>
                        </tr>
                        <tr>
                        	<td>
                            	<div class="normal-text -alignleft">Photo</div>
                            </td>
                            <td><div class="normal-text">:</div></td>
                            <td>
                                <div class="input">
                                    <input type="file" onchange="loadFile(event);" name="image" accept=".jpg, .png" id="image-file" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                        	<td colspan="3"><div class="image-output"><img id="preview" /></div></td>
                        </tr>
                        <tr>
                        	<td colspan="3">
                                <div id="error">
                                    <div class="normal-text -red">
<%
                                        String err = request.getParameter("err");
                                        if(err != null) out.print(err);
%>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                        	<td colspan="3">
                                <div class="register-row">
                                    <div class="button-container"><input type="submit" value="Register" class="button" /></div>
                                </div>
                            </td>
                        </tr>
                        
                    </table>
                    
                </div>
            </form>
            
    	</div>        
	</div>
    
        
</body>
</html>
