<%-- If user has not yet logged in --%>
<%
    if(session.getAttribute("SalesName")==null){
        session.setAttribute("firstLogin","User not logged in, Please Login!");
        response.sendRedirect("login"); 
    }
%>

<%@ page import = "java.time.LocalDate"%>
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
                        <a href="modify-products"><div class="tabs sales-tabs"><span class="fa tab-icon fa-edit"></span><span class="tab-name">Edit</span></div></a>
                        <div class="section"> <span class="fa tab-icon fa-money-bill"></span> <span class="section-name">Sales</span></div>
                        <a href="daily-sales-shop"><div class="tabs sales-tabs"><span class="fa tab-icon fa-calendar-day"></span><span class="tab-name">Daily</span></div></a>
                        <a href="weekly-sales-shop"><div class="tabs sales-tabs"><span class="fa tab-icon fa-calendar-week"></span><span class="tab-name">Weekly</span></div></a>
                        <div class="tabs sales-tabs sales-selected-tab"><span class="fa tab-icon fa-calendar"></span><span class="tab-name">Monthly</span></div>
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
                    <div class="default-card-header">Month's Sales</div>
<%
    try{
        
        String today = (String)session.getAttribute("today");
        String salesTable= (String)session.getAttribute("branchSales"); 
        //Get the date 30 days back
        String monthQuery = "SELECT DATE_SUB(DateSold,INTERVAL 30 DAY) AS Month FROM "+salesTable;
        Statement monthBack = con.createStatement();
        ResultSet monthResult = monthBack.executeQuery(monthQuery);
        if(monthResult.next()){
            String month = monthResult.getString(1);
            String dateDiffQuery = "SELECT * FROM "+salesTable+" WHERE DateSold >= '"+month+"' AND DateSold <='"+today+"'";
            Statement monthRange = con.createStatement();
            String dateDiffValuesQuery = "SELECT COUNT(*) AS NoSales, SUM(TotalAmount) AS TotalRevenue FROM "+salesTable+" WHERE DateSold >= '"+month+"' AND DateSold <='"+today+"'";
            Statement monthRangeValues = con.createStatement();
            ResultSet monthRangeValuesResult = monthRangeValues.executeQuery(dateDiffValuesQuery);
            if (monthRangeValuesResult.next()){

%>                        
                    <div class="shop-sales-area">
                        <div class="detail detail-shop-sales">
                            <div class="detail-box"> 
                                <div class="detail-name"><span class="fa fa-bars"></span> Number Sold</div> 
                                <div class="number-output"><%= monthRangeValuesResult.getInt(1) %></div> 
                            </div>
                        </div>
                        <div class="row-left-space column-space-above"></div>
                        <div class="detail detail-shop-sales">
                            <div class="detail-box "> 
                                <div class="detail-name"><span class="fa fa-money-bill"></span> Cash</div> 
                                <div class="number-output"><%= monthRangeValuesResult.getInt(2) %>/-</div> 
                            </div>
                        </div>
                    </div>
<%
            }
%>                    
                    <div class="table-section sales-table">
                        <table>
                            <tr class="header-tr">
                                <th>Image</th>
                                <th>Bag ID</th>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Quantity Sold</th>
                                <th>Date Sold</th>
                                <th>Price per one</th>
                                <th>Total Amount</th>
                            </tr>
<%
    
            ResultSet monthRangeResult = monthRange.executeQuery(dateDiffQuery); 
            while (monthRangeResult.next()){
%>                            
                            <tr>
                                <td class="table-image"><img width="50px" height="50px"  src="uploads/<%=monthRangeResult.getString(5) %>"/></td>
                                <td><%=monthRangeResult.getString("BagID")%></td>
                                <td><%=monthRangeResult.getString("Name")%></td>
                                <td><%=monthRangeResult.getString("Description")%></td>
                                <td><%=monthRangeResult.getString("QuantitySold")%></td>
                                <td><%=monthRangeResult.getString("DateSold")%></td>
                                <td><%=monthRangeResult.getString("Price")%></td>
                                <td><%=monthRangeResult.getString("TotalAmount")%></td>
                            </tr>
<%
        }
            //PreparedStatement todaySales =  con.prepareStatement(TodayQuery);
            //todaySales.setString(1,today);
            //Products this week
            //String ThismonthQuery = "SELECT * FROM"+salesTable+"WHERE ";

            con.close();
        }
    }catch(Exception e){
        out.print(e);
    }



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