<%
    //If a user has already been logged in, redirect them to the welcome page
    if (session.getAttribute("AdminName")!=null){
        response.sendRedirect("all-products");
    }
    else{
        if(session.getAttribute("SalesName")!=null){
            response.sendRedirect("shop-products");
        }
    }
%>

<%@ page import="encryption.MD5"%>
<%@ page import="java.sql.*"%>
<% 
    if(request.getParameter("log-submit")!=null){
        //1.get Username and password
        String Username = request.getParameter("userName");
        String Password = MD5.getMD5(request.getParameter("password"));
        try{
            String SQL = "SELECT * FROM admin WHERE Username='"+Username+"' AND Password='"+Password+"';";
            Statement stmt = con.createStatement();
            ResultSet resultSet = stmt.executeQuery(SQL);
            //5.check if RESULT ie resultset contains any row: if TRUE->redirect to dashboard,if FALSE->reprompt 
            if(resultSet.next()){//checks admin table  first if it has this record
                //redirect to admin dashboard
                session.setAttribute("AdminName",resultSet.getString("FirstName"));
                session.setAttribute("AUserName",resultSet.getString("Username"));
                session.setAttribute("tempWelcome","Welcome");
                response.sendRedirect("all-products");
            }else{//else check sales database
                String SQL1 = "SELECT * FROM sales_person WHERE Username='"+Username+"' AND Password='"+Password+"';";
                ResultSet rs =  stmt.executeQuery(SQL1);
            
                if(rs.next()){
                    //1.get the branch where this person is working 
                    String branchName = rs.getString(8);
                    //2.set asession or redirect to the sales page
                    session.setAttribute("BRANCH",rs.getString("Branch"));
                    session.setAttribute("SalesName", rs.getString("FirstName"));                
                    session.setAttribute("SUserName", rs.getString("Username"));
                    session.setAttribute("tempWelcome","Welcome");
                    response.sendRedirect("shop-products");
                    //redirect to sales dashboard
                }else{
                    //reprompt to login.jsp
                    request.setAttribute("loginError","Invalid Username or Password, Try Again");
                }
            }
        }catch(SQLTimeoutException e){
            out.print("timeout error caused by drivermanager:"+e.getMessage());
        }catch(SQLException e){
            out.println("query error caused by statement:"+e.getMessage());
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Login</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="css/all.css">
        <link rel="stylesheet" type="text/css" media="screen" href="css/login.css">
        <script src="js/all.js"></script>
    </head>
    <body>
        <div class="container">
            <div class="login-logo">Kayenet</div>
            <span class="fa fa-users"></span>
            <div class="login">Login <span class="fa fa-sign-in-alt"></span></div>
            <form action="" method="POST">
                <div class="wrong-details-area">
                    <div id="wrongDetails">
                        <%-- Invalid user credentials --%>
                        <%
                            if(session.getAttribute("firstLogin")!=null){
                                out.println("<p>"+session.getAttribute("firstLogin")+"</p>");
                                //Remove Unlogged in attribute to prevent continuous promption
                                session.removeAttribute("firstLogin");
                            }
                            if(request.getAttribute("loginError")!=null){
                                out.println("<p>"+request.getAttribute("loginError")+"</p>");  
                            }
                        %>
                    </div>
                </div>
                <div class="input-area">
                    <input type="text" name="userName" placeholder="Username" required>
                    <span class="placeholder-icon fa fa-user"></span>
                </div>
                <div class="input-area">
                    <input type="password" name="password" placeholder="Password" required>
                    <span class="placeholder-icon fa fa-lock"></span>
                </div>
                <div class="button"><input type="submit" name="log-submit" value="Login"></div>
                <div class="clr"></div>
            
            </form>
        </div>
    </body>
</html>