<%@page language="java" import="java.sql.*"%>
<%
    ;
String message = null; // Error message to display to user.
String redirect = null; // Where to send the user.
Cookie cookie = null;
String user = request.getParameter("uname");
String password = request.getParameter("pword");
String password2 = request.getParameter("pword2");

/* Initialize the sql connection. */
Driver drs = (Driver)Class.forName("org.gjt.mm.mysql.Driver").newInstance();
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/ljl",
					      "ljl","fanball");
String command = "{call register(?,?)}";
CallableStatement cs = conn.prepareCall(command);
ResultSet rs = null;

/* Add the user to the database. */
if((user!="") && (user!=null)) {
if(password.equals(password2)) {
    cs.setString(1, user);
    cs.setString(2, password);
    rs = cs.executeQuery();
    rs.first();
    if(rs.getString(1).equals("")) {
      redirect = "user.jsp";
      cookie = new Cookie("uname", user);
      response.addCookie(cookie);
      cookie = new Cookie("password", password);
      response.addCookie(cookie);
    }
    else
      message = rs.getString(1);
  }
  else
    message = "Error: passwords do not match";
}

/* Display the login page. */
if (redirect == null) {
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="style.css" />
<title>Fantasy Football</title>
</head>

<body>
<div align="center">
  <form action="register.jsp" method="post">
  <table>
    <tr>
      <td align="center" colspan="2">
	<h3>Register for Fantasy Football</h3>
      </td>
    </tr>
    <%if(message != null) {%>
      <tr>
	<td align="center" colspan="2"><r><%= message %></r></td>
      </tr>
    <%}%>
    <tr>
      <td>Username:</td>
      <td>
	<%if(user == null) {%>
	  <input type="text" name="uname" size="60" style="width: 256px"/>
	<%} else {%>
	  <input type="text" name="uname" value="<%= user %>"
	  size="60" style="width: 256px"/>
	<%}%>
      </td>
    </tr>
    <tr>
      <td>Password:</td>
      <td>
	<input type="password" name="pword" size="60" style="width: 256px"/>
      </td>
    </tr>
    <tr>
      <td>Confirm Password:</td>
      <td>
	<input type="password" name="pword2" size="60" style="width: 256px"/>
      </td>
    </tr>
    <tr>
      <td><a href="<%= request.getRequestURL() %>">refresh</a></td>
      <td><input type="submit" value="Select" /></td>
    </tr>
  </table>
  </form>
</div>
</body>
</html>
<%
} else {
/* Display a redirect page. */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Refresh" content="5; URL=<%= redirect %>" />
<link rel="stylesheet" type="text/css" href="style.css" />
<title>Fantasy Football</title>
</head>

<body>
<div align="center">
  Registration successful!  Click <a href="<%= redirect %>">here</a>
  if your browser does not redirect you.
</div>
</body>
</html>
<%}%>
