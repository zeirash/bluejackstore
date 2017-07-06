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
</head>

<%
	String currentUsername = (String) session.getAttribute("usernameSession");
	String currentPassword = (String) session.getAttribute("passwordSession");
	String currentId = "";
	String updateUsername = (String) application.getAttribute("afterUpdateUsername");
	String updatePassword = (String) application.getAttribute("afterUpdatePassword");
	String userId="";
	if(session.getAttribute("idSession")!=null){
		userId = session.getAttribute("idSession").toString();
	}
	int currid;
	
	if(request.getParameter("currentId")!=null && request.getParameter("currentId")!=""){
		currentId = request.getParameter("currentId");
	} 
	
	if(updateUsername!="" && updateUsername!=null){
		currentUsername = updateUsername;
		currentPassword = updatePassword;
	}
	String queryprofile = "SELECT * FROM users WHERE user_id="+userId;
	ResultSet rs;
	rs =  st.executeQuery(queryprofile);
%>

<body>

	<%@ include file="status.jsp" %>
	<%@ include file="header.jsp" %>
	<div class="body-container">
        
        <div class="profile-container">
        	<div class="content-page">
<%
				if(request.getParameter("currentId")==null){	//kalo user gk klik update button di profile page
%>
            		<div class="title-text">Profile</div>
<%
				}
				else if(request.getParameter("currentId")!=null){	//kalo user pilih update button di profile page
%>
            	<div class="title-text">Update Profile</div>
<%
				}
%>
                <div class="profile-picture">
<%
					if(rs.next()){
						currid = rs.getInt(1);
%>
                        <img src="<%= rs.getString(9) %>" />

            	</div>
                <hr color="#4371FA" width="100%"/>
                <div class="profile-detail">
                	<table>
<%
						
						if(request.getParameter("currentId")==null){	//kalo user gk klik update button di profile page
%>
                            <tr>
                                <td width="120rem"><div class="normal-text -alignleft">Name</div></td>
                                <td width="50rem"><div class="normal-text">:</div></td>
                                <td><div class="normal-text -alignleft"><%= rs.getString(2) %></div></td>
                            </tr>
                            <tr>
                                <td ><div class="normal-text -alignleft">Phone</div></td>
                                <td><div class="normal-text">:</div></td>
                                <td><div class="normal-text -alignleft"><%= rs.getString(3) %></div></td>
                            </tr>
                            <tr>
                                <td><div class="normal-text -alignleft">Email</div></td>
                                <td><div class="normal-text">:</div></td>
                                <td><div class="normal-text -alignleft"><%= rs.getString(4) %></div></td>
                            </tr>
                            <tr>
                                <td><div class="normal-text -alignleft">Gender</div></td>
                                <td><div class="normal-text">:</div></td>
                                <td><div class="normal-text -alignleft"><%= rs.getString(6) %></div></td>
                            </tr>
                            <tr>
                                <td><div class="normal-text -alignleft">Date of Birth</div></td>
                                <td><div class="normal-text">:</div></td>
                                <td><div class="normal-text -alignleft"><%= rs.getString(7) %></div></td>
                            </tr>
                            <tr>
                                <td><div class="normal-text -alignleft">Address</div></td>
                                <td><div class="normal-text">:</div></td>
                                <td><div class="normal-text -alignleft"><%= rs.getString(8) %></div></td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <div class="profile-row">
                                        <a href="profile.jsp?currentId=<%=currid%>"><div class="button">Update</div></a>
                                    </div>
                                </td>
                            </tr>
<%
						}
						else if(request.getParameter("currentId")!=null){	//kalo user pilih update button di profile page
%>
                            <form action="Controller/doUpdateProfile.jsp" method="post">
                                <tr>
                                    <td width="120rem"><div class="normal-text -alignleft">Old Password</div></td>
                                    <td width="50rem"><div class="normal-text">:</div></td>
                                    <td><div class="normal-text -alignleft"><input type="password" name="oldpassword" placeholder="Old Password" /></div></td>
                                </tr>
                                <tr>
                                    <td ><div class="normal-text -alignleft">New Password</div></td>
                                    <td><div class="normal-text">:</div></td>
                                    <td><div class="normal-text -alignleft"><input type="password" name="newpassword" placeholder="New Password" /></div></td>
                                </tr>
                                <tr>
                                    <td><div class="normal-text -alignleft">Confirm New Password</div></td>
                                    <td><div class="normal-text">:</div></td>
                                    <td><div class="normal-text -alignleft"><input type="password" name="confirmpassword" placeholder="Confirm New Password" /></div></td>
                                </tr>
                                <tr>
                                    <td><div class="normal-text -alignleft">Phone</div></td>
                                    <td><div class="normal-text">:</div></td>
                                    <td><div class="normal-text -alignleft"><input type="text" name="updatephone" placeholder="Phone" /></div></td>
                                </tr>
                                <tr>
                                    <td><div class="normal-text -alignleft">Email</div></td>
                                    <td><div class="normal-text">:</div></td>
                                    <td><div class="normal-text -alignleft"><input type="text" name="updateemail" placeholder="Email" /></div></td>
                                </tr>
                                <tr>
                                    <td><div class="normal-text -alignleft">Address</div></td>
                                    <td><div class="normal-text">:</div></td>
                                    <td><div class="normal-text -alignleft"><input type="text" name="updateaddress" placeholder="Address" /></div></td>
                                </tr>
                                <tr>
                                    <td><div class="normal-text -alignleft">Photo</div></td>
                                    <td><div class="normal-text">:</div></td>
                                    <td><div class="normal-text -alignleft"><input type="file" onchange="loadFile(event);" name="updateimage" accept=".jpg, .png" /></div></td>
                                </tr>
                                <tr>
                                    <td colspan="3"><input type="hidden" name="idToUpdate" id="pass-data" value="<%=currid%>" /></td>
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
                                        <input type="submit" class="button" value="Confirm" />
                                    </td>
                                </tr>
                            </form>
<%
                        }
                    }
%>
                    </table>
                </div>
            </div>
            
        </div>
        
	</div>

	<%@ include file="footer.jsp" %>
</body>
</html>
