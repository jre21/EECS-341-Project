<%@page language="java" import="java.sql.*"%>
<%
    ;
Cookie cookie = new Cookie("uname", "");
response.addCookie(cookie);
cookie = new Cookie("password", "");
response.addCookie(cookie);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Refresh" content="5; URL=login.jsp" />
<link rel="stylesheet" type="text/css" href="style.css" />
<title>Fantasy Football</title>
</head>

<body>
<div align="center">
  You have been logged out.  Click <a href="login.jsp">here</a>
  if your browser does not redirect you.
</div>
</body>
</html>
