<%@page language="java" import="java.sql.*"%>
<%
    ;
String message = null;
boolean redirect = false;
String user = request.getParameter("uname");
String password = request.getParameter("pword");

// What to do if the user has entered a username/password combination
if((user != "") && (user != null)) {
  if(password == "" || password == null)
    message = "Invalid username or password";
  else {
    // Initialize everything sql-related
    Driver drs =
      (Driver)Class.forName("org.gjt.mm.mysql.Driver").newInstance();
    Connection Conn = DriverManager.getConnection("jdbc:mysql://localhost/ljl",
						  "ljl","fanball");
    Statement srs = Conn.createStatement();
    String query = new String("select * from USER where username = '");
    query = query.concat(user).concat("' and password = '");
    query = query.concat(password).concat("';");
    ResultSet rs = srs.executeQuery(query);

    /* If the username/password combination is valid, store them as
     * cookies and redirect to the site proper.
     */
    if (rs.isBeforeFirst()) {
      redirect = true; // We want to redirect instead of displaying this page.
      Cookie nomnomnom = new Cookie("uname", user);
      response.addCookie(nomnomnom);
      nomnomnom = new Cookie("password", password);
      response.addCookie(nomnomnom);
    }
    else message = "Invalid username or password";
  }
}

// Display the login page.
if (!redirect) {
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
//The user is logged in.  Redirect to the league list page.
} else {
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Refresh" content="5; URL=list_leagues.jsp" />
<link rel="stylesheet" type="text/css" href="style.css" />
<title>Fantasy Football</title>
</head>

<body>
<div align="center">
Click <a href="style.css">here</a> if your browser does not redirect you.
</div>
</body>
</html>
<%}%>
