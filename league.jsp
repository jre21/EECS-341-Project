<%
query = "select Teamname, windata, lossdata from user "
+"order by windata desc;";
rs = srs.executeQuery(query);
rsmd = rs.getMetaData();
%>
    <tr>
      <td align="center" colspan="<%= rsmd.getColumnCount() %>">
	<b>Active Teams</b>
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
  </table>
  <br />
  <table>
<%
    query = "select Teamname, windata, lossdata " +
    "from user order by windata desc;";
    rs = srs.executeQuery(query);
    rsmd = rs.getMetaData();
%>
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
