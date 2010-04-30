<%
query = "SELECT p.position, p.name, p.totalpoints, t.* " +
"FROM players p, totalstats t where p.owner='"+user+"' and t.name=p.name;";
rs = srs.executeQuery(query);
rsmd = rs.getMetaData();
%>
<tr>
  <td align="center" colspan="<%= rsmd.getColumnCount() %>">
    <b>My Team</b>
  </td>
</tr>
<tr>
  <td><%= rsmd.getColumnName(1) %></td>
  <td><%= rsmd.getColumnName(2) %></td>
  <td><%= rsmd.getColumnName(23) %></td>
</tr>
<%while(rs.next()) {%>
<tr>
  <td><%= rs.getString(1) %></td>
  <td><%= rs.getString(2) %></td>
  <td align="right"><%= rs.getString(23) %></td>
</tr>
<% }%>
