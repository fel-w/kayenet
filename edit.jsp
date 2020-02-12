<%-- If user has not yet logged in --%>
<%
    if(session.getAttribute("SalesName")==null){
        session.setAttribute("firstLogin","User not logged in, Please Login!");
        response.sendRedirect("login"); 
    }
%>

<%

try{

    String branchName = (String)session.getAttribute("branchName");
    
        String SQL = "SELECT * FROM "+branchName;
 
        Statement stmt = con.createStatement();
       ResultSet rs = stmt.executeQuery(SQL);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Sales Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" media="screen" href="css/all.css">
    <link rel="stylesheet" type="text/css" media="screen" href="css/layout.css">
    <link rel="stylesheet" type="text/css" media="screen" href="css/sales.css">
    <script src="js/all.js"></script>
    <script src="js/main.js"></script>
</head>
<body>
    <!-- The wrapping column -->
    <div class="main-row">
        
        <!-- Navigation side -->
        <div class="nav-side sales-nav">
            
            <!-- Navigation Hamburger -->
            <input type="checkbox" class="toggler">
            <div class="hamburger"><div></div></div>
            <!-- End of Navigation Hamburger -->
            
            <!-- Wrapping menu -->
            <div class="menu">
                <!-- Menu Contents -->
                <div>
                    <div class="account-type"><span class="fa fa-users"></span><span class="account-name">Sales Person</span></div>
                    <div class="links sales-links">
                        <div class="section-account-name"><span class="fa tab-icon fa-user"></span><span class="tab-name"><%=session.getAttribute("SUserName")%></span></div>
                        <div class="section"> <span class="fa tab-icon fa-shopping-cart"></span> <span class="section-name"> Products</span></div>
                        <a href="shop-products"><div class="tabs sales-tabs"><span class="fa tab-icon fa-list"></span><span class="tab-name">All</span></div></a>
                        <div class="sales-selected-tab"><span class="fa tab-icon fa-edit"></span><span class="tab-name">Edit</span></div>
                        <div class="section"> <span class="fa tab-icon fa-money-bill"></span> <span class="section-name">Sales</span></div>
                        <a href="daily-sales-shop"><div class="tabs sales-tabs"><span class="fa tab-icon fa-calendar-day"></span><span class="tab-name">Daily</span></div></a>
                        <a href="weekly-sales-shop"><div class="tabs sales-tabs"><span class="fa tab-icon fa-calendar-week"></span><span class="tab-name">Weekly</span></div></a>
                        <a href="monthly-sales-shop"><div class="tabs sales-tabs"><span class="fa tab-icon fa-calendar"></span><span class="tab-name">Monthly</span></div></a>
                        <a href="transact"><div class="tabs sales-tabs"><span class="fa tab-icon fa-credit-card"></span><span class="tab-name">Transact</span></div></a>
                        <a href="logout"><div class="tabs special-logout-tab sales-tabs"><span class="fa tab-icon fa-sign-out-alt"></span><span class="tab-name">Logout</span></div></a>
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
                <div class="card">
                    <div class="default-card-header">Modify Products</div>
                    <div>
                    <%
                        if(session.getAttribute("successUpdateMessage")!=null){
                            out.print("<div class='success-message success-message-special'><span class='fa fa-check-circle'></span> &nbsp;"+session.getAttribute("successUpdateMessage")+"</div>");
                            //Remove Unlogged in attribute to prevent continuous promption
                            session.removeAttribute("successUpdateMessage");
                        }
                    %>
                    </div>
                    <div class="modify-detail-area">
                        <div class="detail">
                            <div class="detail-box"> 
                                <div class="detail-name"><span class="fa fa-bars"></span> Total Products</div> 
                                <%
                                    int countRows = 0;
                                    while(rs.next()){
                                        countRows = countRows + 1;
                                    }                                
                                %>
                                <div class="number-output"><%=countRows%></div> 
                            </div>
                        </div>
                        <a href="new-product">
                            <div class="new-button"><span class="fa fa-plus"></span> New</div>
                        </a>
                    </div>
                    <div class="table-section sales-table">
                        <table>
                            <tr class="header-tr">
                                <th>Image</th>
                                <th>Bag ID</th>
                                <th>Name</th>
                                <th>Quantity</th>
                                <th>Price</th>
                                <th>Description</th>
                                <th></th>
                                <th></th>
                            </tr>
                            <form action="edit-single.jsp">
                                                <% 
                        rs = stmt.executeQuery(SQL);
                        while(rs.next()){
                             
                             
                             %>
                            <tr>
                                <td class="table-image"><img width="50px" height="50px"  src="uploads/<%=rs.getString(5) %>"/></td>
                                <td><%= rs.getString("BagID")  %></td>
                                <td><%= rs.getString("Name")  %></td>
                                <td><%= rs.getString("Quantity")  %></td>
                                <td><%= rs.getString("Price")  %></td>
                                <td><%= rs.getString("Description")  %></td>
                                <td><button  class="edit-row" type="submit" value="<%= rs.getString("BagID")  %>" name="purchase"><span class="fa fa-edit"></span></button></td>
                                <td><button type="button" onclick="confirmDelete()" class="delete-row"><span class="fa fa-trash"></span></button></td>
                            </tr>
                            <%
                                }
                                    
        }catch(Exception e){
            //TODO handle execeptions 
            out.print("error"+e.getMessage());
        }
                            %>
                            
                        </form>
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
