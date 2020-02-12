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
                        <div class="tabs sales-tabs sales-selected-tab"><span class="fa tab-icon fa-calendar-week"></span><span class="tab-name">Weekly</span></div>
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
                    <div class="default-card-header">Week's Sales</div>
<%
    try{
        
        String today = (String)session.getAttribute("today");
        String salesTable= (String)session.getAttribute("branchSales"); 
        //Get the date 7 days back
        String weekQuery = "SELECT DATE_SUB(DateSold,INTERVAL 7 DAY) AS Week FROM "+salesTable;
        Statement weekBack = con.createStatement();
        ResultSet weekResult = weekBack.executeQuery(weekQuery);
            if(weekResult.next()){
                String sevenDays = weekResult.getString(1);
                String dateDiffQuery = "SELECT * FROM "+salesTable+" WHERE DateSold >= '"+sevenDays+"' AND DateSold <='"+today+"'";
                String dateDiffValuesQuery = "SELECT COUNT(*) AS NoSales, SUM(TotalAmount) AS TotalRevenue FROM "+salesTable+" WHERE DateSold >= '"+sevenDays+"' AND DateSold <='"+today+"'";
                Statement sevenRange = con.createStatement();
                Statement sevenRangeValues = con.createStatement();
                ResultSet sevenRangeValuesResult = sevenRangeValues.executeQuery(dateDiffValuesQuery);
                if (sevenRangeValuesResult.next()){
                
%>
                    <div class="shop-sales-area">
                        <div class="detail detail-shop-sales">
                            <div class="detail-box"> 
                                <div class="detail-name"><span class="fa fa-bars"></span> Number Sold</div> 
                                <div class="number-output"><%= sevenRangeValuesResult.getInt(1)%></div> 
                            </div>
                        </div>
                        <div class="row-left-space column-space-above"></div>
                        <div class="detail detail-shop-sales">
                            <div class="detail-box "> 
                                <div class="detail-name"><span class="fa fa-money-bill"></span> Cash</div> 
                                <div class="number-output"><%= sevenRangeValuesResult.getInt(2)%>/-</div> 
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
            ResultSet sevenRangeResult = sevenRange.executeQuery(dateDiffQuery); 
            while (sevenRangeResult.next()){
%>                            
                            <tr>
                                <td class="table-image"><img width="50px" height="50px"  src="uploads/<%=sevenRangeResult.getString(5) %>"/></td>
                                <td><%=sevenRangeResult.getString("BagID")%></td>
                                <td><%=sevenRangeResult.getString("Name")%></td>
                                <td><%=sevenRangeResult.getString("Description")%></td>
                                <td><%=sevenRangeResult.getString("QuantitySold")%></td>
                                <td><%=sevenRangeResult.getString("DateSold")%></td>
                                <td><%=sevenRangeResult.getString("Price")%></td>
                                <td><%=sevenRangeResult.getString("TotalAmount")%></td>
                            </tr>
<%
        }
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