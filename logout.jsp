<%-- Destroying the session information --%>
<% 
    session.invalidate(); 
    response.sendRedirect("login");
%>