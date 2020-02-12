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

<%!
 private final String UPLOAD_DIRECTORY = "./uploads";    
%>
<% 
String s = request.getSession().getServletContext().getRealPath("/uploads");

    out.write("hello");
   //if(request.getParameter("submit")!=null){
        try {
            String imageName = "";
                     out.write("hello");
        DiskFileItemFactory  factory = new  DiskFileItemFactory();
        ServletFileUpload servletFileUplaod = new ServletFileUpload(factory);
             List<FileItem>multiparts = servletFileUplaod.parseRequest(request);
             for(FileItem item: multiparts){
                 if(!item.isFormField()){
                     String name = new File(item.getName()).getName();
                     item.write(new File(s + File.separator + name));
                    imageName = name;
                 }
             }
             out.write( "file uploaded sussefully");
             out.print(imageName);
             session.setAttribute("imageName",imageName);
        
             response.sendRedirect("new.jsp");

         } catch (Exception ex) {
             out.write("error"+ex.getMessage());
            
         } 
%>
<%-- String SQL = "INSERT INTO upload_image VALUES('"+imageName+"')";
        Statement stmt = con.createStatement();
       stmt.executeUpdate(SQL); --%>