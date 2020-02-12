<%
//If user has not yet logged in
    if(session.getAttribute("AdminName")==null){
        session.setAttribute("firstLogin","User not logged in, Please Login!");
        response.sendRedirect("login"); 
    }
%>



<%-- 
    Document   : delete1
    Created on : Apr 16, 2019, 7:26:44 PM
    Author     : KPaul
--%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%--<%@include file="connection.jsp" %>--%>

<% 
    String delete = request.getParameter("delete");
     

    String[] selected = request.getParameterValues("selected");
     try{
    //4.load the driver    
    //5.connect to the database
    //7.query and insert values in the database
        String SQL = "DELETE FROM sales_person WHERE No=?";
        PreparedStatement  stmt = con.prepareStatement(SQL);
      
    //get values in the array of selected checkboxes
    //and for each value delete the record from the database
            if(selected !=null){
                 for(String k: selected){
                      stmt.setString(1,k);
                      stmt.executeUpdate();
                }
                 response.sendRedirect("sales-persons");
            }
            //get the value(id) of the clicked button and
            //delete the row frow the table
            if(delete !=null){
            stmt.setString(1, delete);
            stmt.executeUpdate();
            out.println(delete);
                response.sendRedirect("sales-persons");
            }
            if(delete ==null || selected !=null){
                response.sendRedirect("sales-persons");
            }
     }catch(Exception e){
         out.print("error"+e.getMessage());
     }

%>


