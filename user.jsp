<%@page language="java" import="java.sql.*"%>
<%
    ;
String redirect = null; // Where to send the user.
boolean hasCookie = false;
Cookie cookie = null;
String user = "";
String password = "";
String show = request.getParameter("show");
if(show==null) show = "";

/* Initialize the sql connection. */
Driver drs = (Driver)Class.forName("org.gjt.mm.mysql.Driver").newInstance();
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/jlj",
					      "jlj","fanball");
String command = "{call isUser(?,?)}";
CallableStatement cs = conn.prepareCall(command);
ResultSet rs = null;

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
  String query[][];
  Statement srs = conn.createStatement();
  if(show.equals("team")) {
    query = new String[1][14];
    query[0][0] = "select as position, p.name as 'player name', " +
      "p.weekpoints as 'week points', p.totalpoints as 'total points'" + 
      "from USER u, TEAMROSTER t, PLAYERS p where u.username = "
      + user + " and u.Teamname = t.teamname and (t.QB = p.name or " + 
      "t.RB1 = p.name or t.RB2 = p.name or t.WR1 = p.name or " +
      "t.WR2 = p.name or t.WR3 = p.name or t.TE = p.name or " +
      "t.DEF = p.name or t.K = p.name or t.BN1 = p.name or t.BN2 = p.name " +
      "or t.BN3 = p.name or t.BN4 = p.name or t.BN5 = p.name)";
  }
  else if(show.equals("match")) {
  }
  else if(show.equals("players")) {
  }
  else if(show.equals("draft")) {
  }
  else if(show.equals("roster")) {
  }
  else if(show.equals("other_match")) {
  }
  else {
    query0="select Teamname, windata, lossdata from USER order by " +
      "windata desc";
    query1="";
  }
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
      <td align="center" colspan="2"><h3>Fantasy Football</h3></td>
    </tr>
    <tr>
      <td>
	<table border cellpadding=8>
	  <tr>
	    <td><a href="user.jsp">League Statistics</a></td>
	    <td><a href="user.jsp?show=team">My Team</a></td>
	    <td><a href="user.jsp?show=match">My Matchup</a></td>
	    <td><a href="user.jsp?show=players">Available Players</a></td>
	  </tr>
	  <tr>
	    <td><a href="user.jsp?show=draft">Draft Players</a></td>
	    <td><a href="user.jsp?show=roster">Other Rosters</a></td>
	    <td><a href="user.jsp?show=other_match">Other Matchups</a></td>
	    <td><a href="logout.jsp">logout</a></td>
	  </tr>
	</table>
      </td>
    </tr>
    <% if(show.equals("team")) { %>
    <% } else if(show.equals("match")) { %>
    <% } else if(show.equals("players")) { %>
    <% } else if(show.equals("draft")) { %>
    <% } else if(show.equals("roster")) { %>
    <% } else if(show.equals("other_match")) { %>
    <% } else { %>
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
