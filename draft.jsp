<%
String player=null, pos=null;
if(request.getParameter("player") != null) {
  player = request.getParameter("player");
  pos = request.getParameter(player);
  command = "{call draft(?,?,?)}";
  cs = conn.prepareCall(command);
  cs.setString(1, user);
  cs.setString(2, player);
  cs.setString(3, pos);
  cs.executeQuery();
}

String needsQB = "";
String needsRB = "";
String needsWR = "";
String needsTE = "";
String needsDEF = "";
String needsK = "";
String needsBN = "";

query = "select t.* from user u, teamroster t where u.username = '"
  +user+"' and u.teamname = t.teamname";
rs = srs.executeQuery(query);
rs.next();
if(rs.getString("QB") == null) needsQB = "QB";
if(rs.getString("RB1") == null) needsRB = "RB1";
else if(rs.getString("RB2") == null) needsRB = "RB2";
if(rs.getString("WR1") == null) needsWR = "WR1";
else if(rs.getString("WR2") == null) needsWR = "WR2";
else if(rs.getString("WR3") == null) needsWR = "WR3";
if(rs.getString("TE") == null) needsTE = "TE";
if(rs.getString("DEF") == null) needsDEF = "DEF";
if(rs.getString("K") == null) needsK = "K";
if(rs.getString("BN1") == null) needsBN = "BN1";
else if(rs.getString("BN2") == null) needsBN = "BN2";
else if(rs.getString("BN3") == null) needsBN = "BN3";
else if(rs.getString("BN4") == null) needsBN = "BN4";
else if(rs.getString("BN5") == null) needsBN = "BN5";

query = "select t.* from teamroster t where t.teamname="+
  "(select u.teamname from user u where u.username='"+user+"');";
rs = srs.executeQuery(query);
rsmd = rs.getMetaData();
%>
    <tr>
      <td align="center" colspan="<%= rsmd.getColumnCount() %>">
	<b>My Roster</b>
      </td>
    </tr>
    <% rs.next();%>
    <% for(int i=2; i <= rsmd.getColumnCount(); ++i) { %>
    <tr>
      <td />
      <td><%= rsmd.getColumnName(i) %></td>
      <td colspan=2><%= rs.getString(i) == null ? "" : rs.getString(i) %></td>
    </tr>
    <% } %>
<%

query = "select name, nflteam, position from players where availability=0;";
rs = srs.executeQuery(query);
rsmd = rs.getMetaData();
%>
<tr><td><br /></td></tr>
<tr>
  <td align="center" colspan="<%= rsmd.getColumnCount() %>">
    <b>Available Players</b>
  </td>
</tr>
<tr>
  <% for(int i=1; i <= rsmd.getColumnCount(); ++i) { %>
  <td><%= rsmd.getColumnName(i) %></td>
  <% } %>
</tr>
<form action="<%=request.getRequestURL()%>" method="post">
<input type=hidden name="show" value="<%=show%>" />
<% while(rs.next()) { %>
<tr>
  <% for(int i=1; i <= rsmd.getColumnCount(); ++i) { %>
  <td><%= rs.getString(i) %></td>
  <% } %>
  <td>
<%
if (rs.getString("position").equals("QB") && !needsQB.equals("")) {%>
    <input type="hidden" name="<%=rs.getString("name")%>" value="<%=needsQB%>" />
    <input type="submit" name="player" value="<%=rs.getString("name")%>" />
<%}
else if (rs.getString("position").equals("RB") && !needsRB.equals("")) {%>
    <input type="hidden" name="<%=rs.getString("name")%>" value="<%=needsRB%>" />
    <input type="submit" name="player" value="<%=rs.getString("name")%>" />
<%}
else if (rs.getString("position").equals("WR") && !needsWR.equals("")) {%>
    <input type="hidden" name="<%=rs.getString("name")%>" value="<%=needsWR%>" />
    <input type="submit" name="player" value="<%=rs.getString("name")%>" />
<%}
else if (rs.getString("position").equals("TE") && !needsTE.equals("")) {%>
    <input type="hidden" name="<%=rs.getString("name")%>" value="<%=needsTE%>" />
    <input type="submit" name="player" value="<%=rs.getString("name")%>" />
<%}
else if (rs.getString("position").equals("DEF") && !needsDEF.equals("")) {%>
    <input type="hidden" name="<%=rs.getString("name")%>" value="<%=needsDEF%>" />
    <input type="submit" name="player" value="<%=rs.getString("name")%>" />
<%}
else if (rs.getString("position").equals("K") && !needsK.equals("")) {%>
    <input type="hidden" name="<%=rs.getString("name")%>" value="<%=needsK%>" />
    <input type="submit" name="player" value="<%=rs.getString("name")%>" />
<%}
else if (!needsBN.equals("")) {%>
    <input type="hidden" name="<%=rs.getString("name")%>" value="<%=needsBN%>" />
    <input type="submit" name="player" value="<%=rs.getString("name")%>" />
<%}
%>
  </td>
</tr>
<% } %>
</form>
