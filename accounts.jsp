<% 
    //If user has not yet logged in
    if(session.getAttribute("AdminName")==null){
        session.setAttribute("firstLogin","User not logged in, Please Login!");
        response.sendRedirect("login"); 
    }
    //If user is logged in then unset not logged in message
    String SQL = "SELECT * FROM sales_person";
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery(SQL);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Administrator Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" media="screen" href="css/all.css">
    <link rel="stylesheet" type="text/css" media="screen" href="css/layout.css">
    <link rel="stylesheet" type="text/css" media="screen" href="css/shared.css">
    <script src="js/all.js"></script>
    <script src="js/main.js"></script>
</head>
<body>
    <!-- The wrapping column -->
    <div class="main-row">
        
        <!-- Navigation side -->
        <div class="nav-side">
            
            <!-- Navigation Hamburger -->
            <input type="checkbox" class="toggler">
            <div class="hamburger"><div></div></div>
            <!-- End of Navigation Hamburger -->
            
            <!-- Wrapping menu -->
            <div class="menu">
                <!-- Menu Contents -->
                <div>
                    <div class="account-type"><span class="fa fa-user-circle"></span><span class="account-name">Administrator</span></div>
                    <div class="links">
                        <div class="section-account-name admin-welcome-section"><span class="fa tab-icon fa-user"></span><span class="tab-name"><%=session.getAttribute("AUserName")%></span></div>
                        <div class="admin-selected-tab"><span class="fa tab-icon fa-users"></span><span class="tab-name">Accounts</span></div>
                        <a href="all-products"><div class="tabs"><span class="fa tab-icon fa-shopping-cart"></span><span class="tab-name">Products</span></div></a>
                        <a href="all-sales-info"><div class="tabs"><span class="fa tab-icon fa-money-bill"></span><span class="tab-name">Sales</span></div></a>
                        <a href="logout"><div class="tabs"><span class="fa tab-icon fa-sign-out-alt"></span><span class="tab-name">Logout</span></div></a>
                    </div>
                </div>
                <!-- End of Menu Contents -->
            </div>
            <!-- End of Wrapping Menu -->
        </div>
        <!-- End of Navigation side -->

        <!-- Main main side -->
        <div class="main-side">
            
            <!-- Logo section -->
            <div class="logo-section">
                <div class="logo-icon"><span class="fa fa-shopping-bag"></span></div>
                <span class="logo-name">Kayenet</span>
            </div>
            <!-- End of Logo section -->

            <!-- Content section -->
            <div class="content-section">
                <div class="card accounts-table-section">
                    <div class="default-card-header">Sales Personnel</div>
                    <div class="manage-accounts">
                        <a href="create-sales-account"><div class="account-button"><span class="fa fa-plus"></span>&nbsp; Create New</div></a>
                    </div>
                    <div class="table-section admin-table">
                        <table style="margin-top:3%;">
                         <form action="delete-admin.jsp">
                            <tr class="header-tr">
                                <th>&nbsp;&nbsp;&nbsp;</th>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Username</th>
                                <th>Phone Number</th>
                                <th>Address</th>
                                <th>Reference's Name</th>
                                <th>Branch</th>
                                <th></th>
                                
                            </tr>
                             <% 
                                    while(rs.next()){
                                    String p = rs.getString(1);
                                                %>
                                                    
                  
                            <tr>
                                <td><input type='checkbox' name='selected' value='<%= p %>'></td>
                                <td><%=rs.getString(2)%></td>
                                <td><%=rs.getString(3)%></td>
                                <td><%=rs.getString(4)%></td>
                                <td><%=rs.getString(9)%></td>
                                <td><%=rs.getString(6)%></td>
                                <td><%=rs.getString(7)%></td>
                                <td><%=rs.getString(8)%></td>
                                <td><button  class="delete-row" type='submit' onclick="confirmDelete()" value = '<%=p%>' name='delete'><span class="fa fa-trash"></button></td></tr>
                                
                            </tr>
                             <%
                                        }
                              
                                                
                    %>
                            
                        </table>
                        <div class="button" style="margin-top:2%;">
                            <input type="submit"  value="Delete Selected" onclick="confirmDelete()">
                        </div>
                    </div>
                </div>
            </div>
            <!-- End of Content section -->
        </div>
        <!-- End of Main main side -->
    </div>
    <!-- End of wrapping column -->
</body>
</html>
