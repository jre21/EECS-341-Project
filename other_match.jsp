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
        query = "select * from schedule;";
        rs = srs.executeQuery(query);
        rsmd = rs.getMetaData();
        week = request.getParameter("week");
%>
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
          error=false;
          query="select * from schedule;";
          rs=srs.executeQuery(query);
          try {rs.findColumn(week);}
          catch (SQLException e) {error=true;}
          if(!error) {
	    query="select position, name, weekpoints from players "+
	      "where owner='"+alt_user+"';";
	    query1="select position, name, weekpoints from players where "+
	      "owner=(select "+week+" from schedule where username='"+
              alt_user+"');";
	    rs = srs.executeQuery(query);
	    rs1 = srs1.executeQuery(query1);
	    rsmd = rs.getMetaData();
	    rsmd1 = rs1.getMetaData();
%>
    <tr>
      <td align="center" colspan="<%= rsmd.getColumnCount() %>">
	<b><%=team%></b>
      </td>
      <td align="center" colspan="<%= rsmd1.getColumnCount() %>">
	<b>Opposing team</b>
      </td>
    </tr>
    <tr>
            <% for(int i=1; i <= rsmd.getColumnCount(); ++i) { %>
      <td><%= rsmd.getColumnName(i) %></td>
            <% } %>
            <% for(int i=1; i <= rsmd1.getColumnCount(); ++i) { %>
      <td><%= rsmd1.getColumnName(i) %></td>
            <% } %>
    </tr>
            <% while(rs.next()) { %>
    <tr>
              <% for(int i=1; i <= rsmd.getColumnCount(); ++i) { %>
      <td><%= rs.getString(i) %></td>
              <% } %>
              <% for(int i=1; i <= rsmd1.getColumnCount(); ++i) { %>
      <td><%= rs.getString(i) %></td>
              <% } %>
    </tr>
  </form>
<%
            }
          }
        }
      }
    }
%>
