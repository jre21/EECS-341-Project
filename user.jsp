<%@page language="java" import="java.sql.*"%>
<%
String redirect = null; // Where to send the user.
boolean hasCookie = false;
Cookie cookie = null;
String user = "";
String password = "";
String team = "";
String week = "";
String alt_user = "";
String show = request.getParameter("show");
if(show==null) show = "";

/* Initialize the sql connection. */
Driver drs = (Driver)Class.forName("org.gjt.mm.mysql.Driver").newInstance();
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/jlj",
					      "jlj","fanball");
String command = "{call isUser(?,?)}";
CallableStatement cs = conn.prepareCall(command);
ResultSet rs = null;
ResultSet rs1 = null;
ResultSetMetaData rsmd = null;
ResultSetMetaData rsmd1 = null;

/* Parse cookies for username and password */
Cookie[] cookies = request.getCookies();
if(cookies != null) {
  for(int i=0; i<cookies.length; i++) {
    cookie = cookies[i];
    if(cookie.getName().equals("uname"))
      if(cookie.getValue() != "")
	user = cookie.getValue();
    if(cookie.getName().equals("password"))
      if(cookie.getValue() != "")
	password = cookie.getValue();
  }
}

if((user != "") && (password != "")) {
  cs.setString(1, user);
  cs.setString(2, password);
  rs = cs.executeQuery();
  rs.first();
  if(rs.getString(1).equals("0")) {
    cookie = new Cookie("uname", "");
    response.addCookie(cookie);
    cookie = new Cookie("password", "");
    response.addCookie(cookie);
    redirect = "login.jsp";
  }
}
else redirect = "login.jsp";

if(redirect == null) {
  String query;
  String query1;
  Statement srs = conn.createStatement();
  Statement srs1 = conn.createStatement();
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
  <table>
    <tr>
      <td align="center"><h3>Fantasy Football</h3></td>
    </tr>
  </table>
  <table border cellpadding=8>
    <tr>
      <td><a href="user.jsp">League Statistics</a></td>
      <td><a href="user.jsp?show=team">My Team</a></td>
      <td><a href="user.jsp?show=match">My Matchup</a></td>
      <td><a href="user.jsp?show=players">Available Players</a></td>
    </tr>
    <tr>
      <td><a href="logout.jsp">logout</a></td>
      <td><a href="user.jsp?show=roster">Other Rosters</a></td>
      <td><a href="user.jsp?show=other_match">Other Matchups</a></td>
      <td><a href="user.jsp?show=draft">Draft Players</a></td>
    </tr>
  </table>
  <br />
  <table>
<%if(show.equals("team")) {%>
<%@include file="team.jsp"%>
<%} else if(show.equals("match")) {%>
<%@include file="match.jsp"%>
<%} else if(show.equals("players")) {%>
<%@include file="players.jsp"%>
<%} else if(show.equals("draft")) {%>
<%@include file="draft.jsp"%>
<%} else if(show.equals("roster")) {%>
<%@include file="roster.jsp"%>
<%} else if(show.equals("other_match")) {%>
<%@include file="other_match.jsp"%>
<%} else {%>
<%@include file="league.jsp"%>
  <% } %>
  </table>
</div>
</body>
</html>
<%
} else {
/* Display a redirect page */
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
<% } %>
