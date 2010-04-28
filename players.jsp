<%
query = "SELECT name, nflteam, position, totalpoints from players " +
"where availability=0;";
rs = srs.executeQuery(query);
rsmd = rs.getMetaData();
%>
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
    <% while(rs.next()) { %>
    <tr>
      <% for(int i=1; i <= rsmd.getColumnCount(); ++i) { %>
      <td><%= rs.getString(i) %></td>
      <% } %>
    </tr>
    <% } %>
