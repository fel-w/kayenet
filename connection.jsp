<%-- 
    Document   : connection
    Created on : Apr 17, 2019, 6:54:27 PM
    Author     : KPaul
--%>
<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
     //variables for db connection
    String dbUrl= "jdbc:mysql://localhost:3306/kayenet"; 
    String dbUser = "root";
    String dbPassword = "";  

    //4.load the driver
        Class.forName("com.mysql.jdbc.Driver");     
    //5.connect to the database
        Connection con = DriverManager.getConnection(dbUrl,dbUser,dbPassword);
     
%>
