<%
query = "select teamname from user;";
rs = srs.executeQuery(query);
team = request.getParameter("team");
%>
    <tr>
      <td colspan="8" align="center">
	<select name="team">
	  <option value="">Select a team</option>
      <%while(rs.next()) {%>
	  <option value="<%= rs.getString(1) %>" <%
	    if(rs.getString(1).equals(team)){%>selected<%}%>>
	    <%= rs.getString(1) %>
	  </option>
      <%}%>
	</select>
	<input type="submit" value="submit" />
      </td>
    </tr>
<%
    if(team != null) {
      boolean error=false;
      query="select username from user where teamname='"+team+"';";
      rs=srs.executeQuery(query);
      if(rs.next()) {
        alt_user=rs.getString(1);
        query = "SELECT p.position, p.name, p.totalpoints, t.* " +
          "FROM players p, totalstats t where p.owner='"+
          alt_user+"' and t.name=p.name;";
        rs = srs.executeQuery(query);
        rsmd = rs.getMetaData();
%>
    <tr>
      <td align="center" colspan="<%= rsmd.getColumnCount() %>">
	<b><%=team%></b>
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
        <% }
      }
    }
%>
