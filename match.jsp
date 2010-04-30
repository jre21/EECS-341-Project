<%
query = "select * from schedule;";
rs = srs.executeQuery(query);
rsmd = rs.getMetaData();
week = request.getParameter("week");
%>
  <form action="<%=request.getRequestURL()%>" method="get">
  <input type=hidden name="show" value="<%=show%>" />
    <tr>
      <td colspan="6" align="center">
	<select name="week">
	  <option value="">Select a week</option>
    <%for(int i=2; i <= rsmd.getColumnCount(); ++i) {%>
	  <option value="<%= rsmd.getColumnName(i) %>" <%
	    if(rsmd.getColumnName(i).equals(week)){%>selected<%}%>>
	    <%= rsmd.getColumnName(i) %>
	  </option>
    <%}%>
	</select>
	<input type="submit" value="submit" />
      </td>
    </tr>
<%
    if(week != null) {
      boolean error=false;
      query="select * from schedule;";
      rs=srs.executeQuery(query);
      try {rs.findColumn(week);}
      catch (SQLException e) {error=true;}
      if(!error) {
    query="select position, name, weekpoints from players "+
	  "where owner='"+user+"';";
	rs = srs.executeQuery(query);
	rsmd = rs.getMetaData();
%>
    <tr>
      <td align="center" colspan="<%= rsmd.getColumnCount() %>">
	<b>My team</b>
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
        <% } %>
    </tr>
    <%
	query="select position, name, weekpoints from players where "+
	  "owner=(select "+week+" from schedule where username='"+user+"');";
	rs = srs.executeQuery(query);
	rsmd = rs.getMetaData();
    %>
    <tr>
      <td align="center" colspan="<%= rsmd.getColumnCount() %>">
	<b>Opposing team</b>
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
  </form>
<%
        }
      }
    }
%>
