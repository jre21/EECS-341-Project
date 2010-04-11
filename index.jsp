<%@page language="java" import="java.sql.*"%>
<%
    ;
String message = null; // Error message to display to user.
String redirect = null; // Where to send the user.
boolean hasCookie = false;
Cookie cookie = null;
String user = request.getParameter("uname");
String password = request.getParameter("pword");

/* Initialize the sql connection. */
Driver drs = (Driver)Class.forName("org.gjt.mm.mysql.Driver").newInstance();
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/ljl",
					      "ljl","fanball");
String command = "{call isUser(?,?)}";
CallableStatement cs = conn.prepareCall(command);
ResultSet rs = null;

/* Try to parse the user's cookies */
Cookie[] cookies = request.getCookies();
if(cookies != null) {
  for(int i=0; i<cookies.length; i++) {
    cookie = cookies[i];
    if(cookie.getName().equals("uname"))
      if(cookie.getValue() != "") {
	user = cookie.getValue();
	hasCookie = true;
      }
    if(cookie.getName().equals("password"))
      if(cookie.getValue() != "") {
	password = cookie.getValue();
	hasCookie = true;
      }
  }
}
/* Check whether uname/password combination is in database */
if(hasCookie && (user!="") && (user!=null) && (password!="")
   && (password!=null)) {
  cs.setString(1, user);
  cs.setString(2, password);
  rs = cs.executeQuery();
  rs.first();
  if(rs.getString(1).charAt(0) != '0')
    redirect = "user.jsp";
  else {
    cookie = new Cookie("uname", "");
    response.addCookie(cookie);
    cookie = new Cookie("password", "");
    response.addCookie(cookie);
  }
}

/* What to do if the user has entered a username/password combination */
if(!hasCookie) {
  if((user!="") && (user!=null) && (password!="") && (password!=null)) {
    /* Check the database for username/password combination.  If so,
     * store them as cookies and redirect to the site proper. */
    cs.setString(1, user);
    cs.setString(2, password);
    rs = cs.executeQuery();
    rs.first();
    if(rs.getString(1).charAt(0) != '0') {
      redirect = "user.jsp";
      cookie = new Cookie("uname", user);
      response.addCookie(cookie);
      cookie = new Cookie("password", password);
      response.addCookie(cookie);
    }
    else message = "Invalid username or password";
  }
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
  <form action="index.jsp" method="post">
  <table>
    <tr>
      <td align="center" colspan="2"><h3>Fantasy Football</h3></td>
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
      <td><a href="<%= request.getRequestURL() %>">refresh</a></td>
      <td><input type="submit" value="Select" /></td>
    </tr>
    <tr>
      <td align="center" colspan="2">
	Not a member?  <a href="register.jsp">register</a>
      </td>
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
  Click <a href="<%= redirect %>">here</a> if your browser does not redirect
  you.
</div>
</body>
</html>
<%}%>
