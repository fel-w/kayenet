<%
//If user has not yet logged in
    if(session.getAttribute("AdminName")==null){
        session.setAttribute("firstLogin","User not logged in, Please Login!");
        response.sendRedirect("login"); 
    }
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
                        <a href="sales-persons"><div class="tabs"><span class="fa tab-icon fa-users"></span><span class="tab-name">Accounts</span></div></a>
                        <div class="admin-selected-tab"><span class="fa tab-icon fa-shopping-cart"></span><span class="tab-name">Products</span></div>
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
            <%-- Displaying temporary welcome message --%>
            <%
                if(session.getAttribute("tempWelcome")!=null){
                    out.print("<div class='welcome-section special-card' style='margin-bottom:1%;'>"+session.getAttribute("tempWelcome")+" <span>"+session.getAttribute("AdminName")+"</span></div>");
                    //Remove attribute to prevent continuous displayy
                    session.removeAttribute("tempWelcome");
                }
            %>
                <div class="card">
                    <div class="default-card-header">All Products</div>
                    <% 
        String table,table1,table2;
                table = "nak_pdts";
                table1 = "men_pdts";
                table2 = "kaw_pdts";
                Statement count1 = con.createStatement();
                String countQ1 = "SELECT COUNT(*) AS TotalProducts FROM "+table;
                ResultSet countResult1 = count1.executeQuery(countQ1);
                if (countResult1.next()){
                %>
                    <div class="shop-cards">
                    
                        <div class="shop shop-first nak">
                            <div class="shop-name">Nakawa</div>
                            <div class="number-shop"><%= countResult1.getInt(1) %></div>
                        </div>
                <%
                }
                Statement count2 = con.createStatement();
                String countQ2 = "SELECT COUNT(*) AS TotalProducts FROM "+table2;
                ResultSet countResult2 = count1.executeQuery(countQ2);
                if (countResult2.next()){
                %>                    
                        <div class="shop kaw">
                            <div class="shop-name">Kawempe</div>
                            <div class="number-shop"><%= countResult2.getInt(1) %></div>
                        </div>
                <%
                }
                Statement count3 = con.createStatement();
                String countQ3 = "SELECT COUNT(*) AS TotalProducts FROM "+table1;
                ResultSet countResult3 = count1.executeQuery(countQ3);
                if (countResult3.next()){
                %>                    
                        <div class="shop men">
                            <div class="shop-name">Mengo</div>
                            <div class="number-shop"><%= countResult3.getInt(1) %></div>
                        </div>
                <%
                }
                %>
                    </div>
                    <div class="table-section admin-table admin-products">
                        <table>
                            <tr class="header-tr">
                                <th>Image</th>
                                <th>Bag ID</th>
                                <th>Name</th>
                                <th>Branch</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Description</th>
                            </tr>
                                <%
                                Statement stmt = con.createStatement();
                                String SQL = "SELECT * FROM "+table; 
                                ResultSet rs = stmt.executeQuery(SQL);
                                while(rs.next()){
                                %>

                            <tr>
                                <td class="table-image"><img width="45px" height="45px"  src="uploads/<%=rs.getString(5) %>"/></td>
                                <td><%=rs.getString(2)%></td>
                                <td><%=rs.getString(3)%></td>
                                <td><div class="shop-column nak">Nakawa</div></td>
                                <td><%=rs.getString(6)%></td>
                                <td><%=rs.getString(7)%></td>
                                <td><%=rs.getString(4)%></td>
                                <%
                                }
                                 stmt = con.createStatement();
                                 SQL = "SELECT * FROM "+table2; 
                                 rs = stmt.executeQuery(SQL);
                                while(rs.next()){
                                %>
                                
                                
                            </tr>
                            <tr>
                                 <td class="table-image"><img width="45px" height="45px"  src="uploads/<%=rs.getString(5) %>"/></td>
                                <td><%=rs.getString(2)%></td>
                                <td><%=rs.getString(3)%></td>
                                <td><div class="shop-column kaw">Kawempe</div></td>
                                <td><%=rs.getString(6)%></td>
                                <td><%=rs.getString(7)%></td>
                                <td><%=rs.getString(4)%></td>
                                
                            </tr> 
                             <%
                                }
                                stmt = con.createStatement();
                                 SQL = "SELECT * FROM "+table1; 
                                 rs = stmt.executeQuery(SQL);
                                while(rs.next()){
                                %>                           
                            <tr>
                                <td class="table-image"><img width="45px" height="45px"  src="uploads/<%=rs.getString(5) %>"/></td>
                                <td><%=rs.getString(2)%></td>
                                <td><%=rs.getString(3)%></td>
                                <td><div class="shop-column men">Mengo</div></td>
                                <td><%=rs.getString(6)%></td>
                                <td><%=rs.getString(7)%></td>
                                <td><%=rs.getString(4)%></td>
                                
                                
                            </tr>
                            <%
                                }
                                con.close();
                                %>
                        </table>
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