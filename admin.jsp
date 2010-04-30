<%@page language="java" import="java.sql.*"%>
<%
String redirect = null; // Where to send the user.
boolean hasCookie = false;
Cookie cookie = null;
String user = "";
String password = "";
int week = 0;
if(request.getParameter("week") != null
   && !request.getParameter("week").equals(""))
  week = Integer.parseInt(request.getParameter("week"));
String show = request.getParameter("show");
if(show==null) show = "";

/* Initialize the sql connection. */
Driver drs = (Driver)Class.forName("org.gjt.mm.mysql.Driver").newInstance();
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/jlj",
					      "jlj","fanball");
String command = "{call isUser(?,?)}";
CallableStatement cs = conn.prepareCall(command);
ResultSet rs = null;
ResultSetMetaData rsmd = null;

/* Parse cookies for username and password */
Cookie[] cookies = request.getCookies();
if(cookies != null) {
  for(int i=0; i<cookies.length; i++) {
    cookie = cookies[i];
    if(cookie.getName().equals("uname"))
      if(!cookie.getValue().equals(""))
	user = cookie.getValue();
    if(cookie.getName().equals("password"))
      if(!cookie.getValue().equals(""))
	password = cookie.getValue();
  }
}

if(user.equals("admin") && !password.equals("")) {
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
else redirect = "user.jsp";

if(redirect == null) {
  String query;
  Statement srs = conn.createStatement();
  if(request.getParameter("do") != null) {
    if(request.getParameter("do").equals("schedule")) {
      schedule_jsp.makeSchedule();
    }
    else if(request.getParameter("do").equals("stats") && (week != 0)) {
      rs=srs.executeQuery("select teamname from user;");
      while(rs.next()) {
	String team=rs.getString(1);
	stats_jsp.randomStats(team);
      }
      stats_jsp.startNextWeek(week);
    }
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
    <tr>
      <td colspan=4 align="center">
	<a href="admin.jsp">Admin Control Panel</a>
      </td>
    </tr>
  </table>
  <br />
  <form action="<%=request.getRequestURL()%>" method="post">
  <table>
    <tr>
      <td colspan=2>Generate schedule:</td>
      <td align="right"><input type="submit" name="do" value="schedule" /></td>
    </tr>
    <tr>
      <td>Play a week:</td>
      <td align="right">
	<select name="week">
	  <option value="">Select a week</option>
	    <%
	    query = "select * from schedule;";
	    rs = srs.executeQuery(query);
	    rsmd = rs.getMetaData();
	    %>
    <%for(int i=2; i <= rsmd.getColumnCount(); ++i) {%>
	      <option value="<%= i-1 %>" <%if(week==i-1) {%>selected<%}%>>
	    <%= rsmd.getColumnName(i) %>
	  </option>
    <%}%>
	</select>
      </td>
      <td align="right"><input type="submit" name="do" value="stats" /></td>
    </tr>
  </table>
  </form>
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
