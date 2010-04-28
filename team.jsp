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
<tr style="font-size:80%">
<%for(int i=1; i <= 8; ++i) {%>
  <td><%= rsmd.getColumnName(i) %></td>
<%}%>
</tr>
<%while(rs.next()) {%>
<tr style="font-size:80%">
  <% for(int i=1; i <= 8; ++i) { %>
  <td><%= rs.getString(i) %></td>
  <% } %>
</tr>
<% } %>
<tr><td><br /></td></tr>
<tr style="font-size:80%">
<% for(int i=1; i <= 3; ++i) { %>
  <td><%= rsmd.getColumnName(i) %></td>
<% } %>
<% for(int i=9; i <= 13; ++i) { %>
  <td><%= rsmd.getColumnName(i) %></td>
<% } %>
</tr>
<% while(rs.next()) { %>
<tr style="font-size:80%">
  <% for(int i=1; i <= 3; ++i) { %>
  <td><%= rs.getString(i) %></td>
  <% } %>
  <% for(int i=9; i <= 13; ++i) { %>
  <td><%= rs.getString(i) %></td>
  <% } %>
</tr>
<% } %>
<tr><td><br /></td></tr>
<tr style="font-size:80%">
<% for(int i=1; i <= 3; ++i) { %>
  <td><%= rsmd.getColumnName(i) %></td>
<% } %>
<% for(int i=14; i <= 18; ++i) { %>
  <td><%= rsmd.getColumnName(i) %></td>
<% } %>
</tr>
<% while(rs.next()) { %>
<tr style="font-size:80%">
  <% for(int i=1; i <= 3; ++i) { %>
  <td><%= rs.getString(i) %></td>
  <% } %>
  <% for(int i=14; i <= 18; ++i) { %>
  <td><%= rs.getString(i) %></td>
  <% } %>
</tr>
<% } %>
<tr><td><br /></td></tr>
<tr style="font-size:80%">
<% for(int i=1; i <= 3; ++i) { %>
  <td><%= rsmd.getColumnName(i) %></td>
<% } %>
<% for(int i=19; i <= 23; ++i) { %>
  <td><%= rsmd.getColumnName(i) %></td>
<% } %>
</tr>
<% while(rs.next()) { %>
<tr style="font-size:80%">
  <% for(int i=1; i <= 3; ++i) { %>
  <td><%= rs.getString(i) %></td>
  <% } %>
  <% for(int i=19; i <= 23; ++i) { %>
  <td><%= rs.getString(i) %></td>
  <% } %>
</tr>
<% }%>
