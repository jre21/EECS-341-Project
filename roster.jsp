<%
query = "select teamname from user;";
rs = srs.executeQuery(query);
team = request.getParameter("team");
%>
  <form action="<%=request.getRequestURL()%>" method="get">
  <input type=hidden name="show" value="<%=show%>" />
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
      <td><%= rsmd.getColumnName(1) %></td>
      <td><%= rsmd.getColumnName(2) %></td>
      <td><%= rsmd.getColumnName(23) %></td>
    </tr>
        <%while(rs.next()) {%>
    <tr style="font-size:80%">
      <td><%= rs.getString(1) %></td>
      <td><%= rs.getString(2) %></td>
      <td><%= rs.getString(23) %></td>
    </tr>
        <% } %>
  </form>
        <% 
      }
    }
%>
