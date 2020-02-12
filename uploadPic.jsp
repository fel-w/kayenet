<%-- 
    Document   : uploadPic
    Created on : Apr 18, 2019, 1:46:55 PM
    Author     : KPaul
--%>

<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>

         
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.io.output.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="javax.servlet.ServletInputStream"%>
<%@ page import="java.io.File"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
String s = request.getSession().getServletContext().getRealPath("/uploads");
   //if(request.getParameter("submit")!=null){
        try {
             String branchName = (String)session.getAttribute("branchName");
             String imageName = (String)session.getAttribute("imageName");
                String bagName  = request.getParameter("bagName");
                String description = request.getParameter("description");
                String image = request.getParameter("image");
                String quantity= request.getParameter("quantity");
                String price= request.getParameter("price");
                String branch = (String)session.getAttribute("BRANCH");
                String bagID = "";
                

                 //select to get id from the database
                String SQL = "INSERT into "+branchName+" (BagID,Name,Description,Image,Price,Quantity) VALUES (?,?,?,?,?,?)"; 
                // String SQL1 = "UPDATE sales_person SET No = ? WHERE Username=?"; 
                PreparedStatement check = con.prepareStatement(SQL);
                check.setString(1, branch);
                check.setString(2, bagName);
                check.setString(3, description);
                check.setString(4, imageName);
                check.setString(5, price);
                check.setString(6, quantity);
                int success = check.executeUpdate();
                if (success > 0){
                    String SQLSelect = "SELECT MAX(No) AS MaxNo FROM "+branchName+"";
                    Statement pickNo = con.createStatement();
                    ResultSet selectResult = pickNo.executeQuery(SQLSelect);
                    int productNo = 1;
                    if (selectResult.next()){
                        productNo = selectResult.getInt(1);
                        String productNostring =Integer.toString(productNo);
                        bagID = branch+"-"+productNostring;
                        String SQLUpdate = "UPDATE "+branchName+" SET BagID = '"+bagID+"' WHERE No = '"+productNo+"'";
                        Statement updateId = con.createStatement();
                        int updateSuccess = updateId.executeUpdate(SQLUpdate);
                    }
                }
                response.sendRedirect("new.jsp");
            //7.query and insert values in the database
        
         } catch (Exception ex) {
             out.write("error"+ex.getMessage());
            
         }
     
      
      
   
%>
<%-- String SQL = "INSERT INTO upload_image VALUES('"+imageName+"')";
        Statement stmt = con.createStatement();
       stmt.executeUpdate(SQL); --%>