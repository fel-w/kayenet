<%
//If user has not yet logged in
    if(session.getAttribute("AdminName")==null){
        session.setAttribute("firstLogin","User not logged in, Please Login!");
        response.sendRedirect("login"); 
    }
%>
<%@ page import = "java.time.LocalDate"%>

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
                        <a href="all-products"><div class="tabs"><span class="fa tab-icon fa-shopping-cart"></span><span class="tab-name">Products</span></div></a>
                        <div class="admin-selected-tab"><span class="fa tab-icon fa-money-bill"></span><span class="tab-name">Sales</span></div>
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
                <div class="admin-sales-first-row">
                    <div class="special-card daily-sales">
                        <div class="admin-sales-card-header">Today's Sales</div>
                        <div class="daily-sales-info">

            <%
                try{
                    LocalDate myObj = LocalDate.now();
                    String today = myObj.toString();
                    session.setAttribute("today",today);
                    //Summing totals
                    Statement sumnakToday = con.createStatement();
                    ResultSet sumnakTodayResult = sumnakToday.executeQuery("SELECT SUM(TotalAmount) AS SumToday FROM nak_sales WHERE DateSold ='"+today+"'");   
                    Statement summenToday = con.createStatement(); 
                    ResultSet summenTodayResult= summenToday.executeQuery("SELECT SUM(TotalAmount) AS SumToday FROM men_sales WHERE DateSold ='"+today+"'");
                    Statement sumkawToday = con.createStatement();
                    ResultSet sumkawTodayResult = sumkawToday.executeQuery("SELECT SUM(TotalAmount) AS SumToday FROM kaw_sales WHERE DateSold ='"+today+"'");
                    int todayRevenue = 0;
                    int tempRevenue = 0; 
                    if (sumnakTodayResult.next()){
                        tempRevenue = sumnakTodayResult.getInt(1);
                        todayRevenue += tempRevenue;
                    }
                    if (summenTodayResult.next()){
                        tempRevenue = summenTodayResult.getInt(1);
                        todayRevenue += tempRevenue;
                    }
                    if (sumkawTodayResult.next()){
                        tempRevenue = sumkawTodayResult.getInt(1);
                        todayRevenue += tempRevenue;
                    }

                    //Counting Today's Records
                    Statement countnakToday = con.createStatement();
                    ResultSet countnakTodayResult = countnakToday.executeQuery("SELECT COUNT(*) AS AllTodays FROM nak_sales WHERE DateSold ='"+today+"'");   
                    Statement countmenToday = con.createStatement(); 
                    ResultSet countmenTodayResult= countmenToday.executeQuery("SELECT COUNT(*) AS AllTodays FROM men_sales WHERE DateSold ='"+today+"'");
                    Statement countkawToday = con.createStatement();
                    ResultSet countkawTodayResult = countkawToday.executeQuery("SELECT COUNT(*) AS AllTodays FROM kaw_sales WHERE DateSold ='"+today+"'");
                    int nakDvalue, kawDvalue, menDvalue, highestDvalue, totalDvalue;
                    totalDvalue = highestDvalue = nakDvalue = kawDvalue = menDvalue = 0;
                    if(countnakTodayResult.next()){
                        nakDvalue = countnakTodayResult.getInt(1);
                    }
                    if(countkawTodayResult.next()){
                        kawDvalue = countkawTodayResult.getInt(1);
                    }
                    if(countmenTodayResult.next()){
                        menDvalue = countmenTodayResult.getInt(1);
                    }

                    String shopDvalue = "";
                    if (nakDvalue > highestDvalue){
                        highestDvalue = nakDvalue;
                        totalDvalue = totalDvalue + nakDvalue;
                        shopDvalue = "Nakawa";
                    }
                    if (kawDvalue > highestDvalue){
                        highestDvalue = kawDvalue;
                        totalDvalue = totalDvalue + kawDvalue;
                        shopDvalue = "Kawempe";
                    }
                    if (menDvalue > highestDvalue){
                        totalDvalue = totalDvalue + menDvalue;
                        highestDvalue = menDvalue;
                        shopDvalue = "Mengo";
                    }
            %>



                            <span>Shop with Top Total Sales</span>
                            <div class="daily-sales-info-inner">
                                <div class="sales-shop-name"><%= shopDvalue %></div>
                                <div class="sales-shop-number"><%= highestDvalue %></div>
                            </div>
                        </div>
                        <%-- <div class="click-to-view"><span class="fa fa-info-circle"></span> Click on shop to view</div> --%>
                        <a href="">
                            <div class="nak-blue-grad shop-sales-info">
                                <div class="shop-sales-info-inner">
                                    <div class="sales-shop-name">Nakawa</div>
                                    <div class="sales-shop-number"><%= nakDvalue %></div>
                                </div>
                            </div>
                        </a>                        
                        <a href="">
                            <div class="kaw-blue-grad shop-sales-info">
                                <div class="shop-sales-info-inner">
                                    <div class="sales-shop-name">Kawempe</div>
                                    <div class="sales-shop-number"><%= kawDvalue %></div>
                                </div>
                            </div>    
                        </a>
                        <a href=""">
                            <div class="men-blue-grad shop-sales-info">
                                <div class="shop-sales-info-inner">
                                    <div class="sales-shop-name">Mengo</div>
                                    <div class="sales-shop-number"><%= menDvalue %></div>
                                </div>
                            </div>
                        </a>
                        <div class="bottom daily-sales-info">
                            <div class="daily-sales-info-inner">
                                <div class="overall-total">Overall Total</div>
                                <div class="overall-number"><%= totalDvalue %></div>
                            </div>
                        </div>
                    </div>
            <%
                //Getting the date 7 days ago
                int weekRevenue;
                weekRevenue= totalDvalue = highestDvalue = nakDvalue = kawDvalue = menDvalue = tempRevenue = 0;
                Statement weekBacknak = con.createStatement();
                ResultSet weekResultnak = weekBacknak.executeQuery("SELECT DATE_SUB(DateSold,INTERVAL 7 DAY) AS Week FROM nak_sales");
                Statement weekBackkaw = con.createStatement();
                ResultSet weekResultkaw = weekBackkaw.executeQuery("SELECT DATE_SUB(DateSold,INTERVAL 7 DAY) AS Week FROM kaw_sales");
                Statement weekBackmen = con.createStatement();
                ResultSet weekResultmen = weekBackmen.executeQuery("SELECT DATE_SUB(DateSold,INTERVAL 7 DAY) AS Week FROM men_sales");
                
                if(weekResultnak.next()){
                    String sevenDaysnak = weekResultnak.getString(1);
                    Statement sevenRangenak = con.createStatement();
                    ResultSet sevenRangeResultnak = sevenRangenak.executeQuery("SELECT COUNT(*) AS WeekCount, SUM(TotalAmount) AS WeekAmount FROM nak_sales  WHERE DateSold >= '"+sevenDaysnak+"' AND DateSold <='"+today+"'"); 
                    if (sevenRangeResultnak.next()){
                        nakDvalue = sevenRangeResultnak.getInt(1);
                        tempRevenue = sevenRangeResultnak.getInt(2);
                        weekRevenue += tempRevenue;
                    }
                }
                if(weekResultkaw.next()){
                    String sevenDayskaw = weekResultkaw.getString(1);
                    Statement sevenRangekaw = con.createStatement();
                    ResultSet sevenRangeResultkaw = sevenRangekaw.executeQuery("SELECT COUNT(*) AS WeekCount, SUM(TotalAmount) AS WeekAmount FROM kaw_sales  WHERE DateSold >= '"+sevenDayskaw+"' AND DateSold <='"+today+"'"); 
                    if (sevenRangeResultkaw.next()){
                        kawDvalue = sevenRangeResultkaw.getInt(1);
                        tempRevenue = sevenRangeResultkaw.getInt(2);
                        weekRevenue += tempRevenue;
                    }
                }
                if(weekResultmen.next()){
                    String sevenDaysmen = weekResultmen.getString(1);
                    Statement sevenRangemen = con.createStatement();
                    ResultSet sevenRangeResultmen = sevenRangemen.executeQuery("SELECT COUNT(*) AS WeekCount, SUM(TotalAmount) AS WeekAmount FROM men_sales  WHERE DateSold >= '"+sevenDaysmen+"' AND DateSold <='"+today+"'"); 
                    if (sevenRangeResultmen.next()){
                        menDvalue= sevenRangeResultmen.getInt(1);
                        tempRevenue = sevenRangeResultmen.getInt(2);
                        weekRevenue += tempRevenue;
                    }
                }
                shopDvalue = "";
                if (nakDvalue > highestDvalue){
                    highestDvalue = nakDvalue;
                    totalDvalue = totalDvalue + nakDvalue;
                    shopDvalue = "Nakawa";
                }
                if (kawDvalue > highestDvalue){
                    highestDvalue = kawDvalue;
                    totalDvalue = totalDvalue + kawDvalue;
                    shopDvalue = "Kawempe";
                }
                if (menDvalue > highestDvalue){
                    totalDvalue = totalDvalue + menDvalue;
                    highestDvalue = menDvalue;
                    shopDvalue = "Mengo";
                }
            %>
                    <div class="special-card weekly-sales">
                        <div class="admin-sales-card-header">Week's Sales</div>
                        <div class="weekly-sales-info">
                            <div class="top-sales">
                                <span>Top Total Weekly Sales</span>
                                <div class="top-sales-inner">
                                    <div class="shop-name"><%= shopDvalue%></div>
                                    <div class="number-shop"><%=highestDvalue%></div>
                                </div>
                            </div>
                            <div class="weekly-overall">
                                <div class="top-sales-inner">
                                    <div class="overall-total">Overall Total</div>
                                    <div class="overall-number"><%=totalDvalue%></div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="info-sold-section">
                            <%-- <div class="click-to-view"><span class="fa fa-info-circle"></span> Click on shop to view</div> --%>
                            <a href="">
                                <div class="shop-week-sales nak-green-grad">
                                    <div class="shop-sales-info-inner">
                                        <div class="sales-shop-name">Nakawa</div>
                                        <div class="sales-shop-number"><%= nakDvalue%></div>
                                    </div>
                                </div>
                            </a>                        
                            <a href="">
                                <div class="shop-week-sales kaw-green-grad">
                                    <div class="shop-sales-info-inner">
                                        <div class="sales-shop-name">Kawempe</div>
                                        <div class="sales-shop-number"><%= kawDvalue%></div>
                                    </div>
                                </div>    
                            </a>
                            <a href="">
                                <div class="shop-week-sales men-green-grad">
                                    <div class="shop-sales-info-inner">
                                        <div class="sales-shop-name">Mengo</div>
                                        <div class="sales-shop-number"><%= menDvalue%></div>
                                    </div>
                                </div>
                            </a>
                        </div>                        
                    </div>
                </div>
            <%
                //Getting the date a month ago
                int monthRevenue;
                monthRevenue= totalDvalue = highestDvalue = nakDvalue = kawDvalue = menDvalue = tempRevenue = 0;
                Statement monthBacknak = con.createStatement();
                ResultSet monthResultnak = monthBacknak.executeQuery("SELECT DATE_SUB(DateSold,INTERVAL 1 MONTH) AS Month FROM nak_sales");
                Statement monthBackkaw = con.createStatement();
                ResultSet monthResultkaw = monthBackkaw.executeQuery("SELECT DATE_SUB(DateSold,INTERVAL 1 MONTH) AS Month FROM kaw_sales");
                Statement monthBackmen = con.createStatement();
                ResultSet monthResultmen = monthBackmen.executeQuery("SELECT DATE_SUB(DateSold,INTERVAL 1 MONTH) AS Month FROM men_sales");
                
                if(monthResultnak.next()){
                    String monthnak = monthResultnak.getString(1);
                    Statement monthRangenak = con.createStatement();
                    ResultSet monthRangeResultnak = monthRangenak.executeQuery("SELECT COUNT(*) AS WeekCount, SUM(TotalAmount) AS WeekAmount FROM nak_sales  WHERE DateSold >= '"+monthnak+"' AND DateSold <='"+today+"'"); 
                    if (monthRangeResultnak.next()){
                        nakDvalue = monthRangeResultnak.getInt(1);
                        tempRevenue = monthRangeResultnak.getInt(2);
                        monthRevenue += tempRevenue;
                    }
                }
                if(monthResultkaw.next()){
                    String monthkaw = monthResultkaw.getString(1);
                    Statement monthRangekaw = con.createStatement();
                    ResultSet monthRangeResultkaw = monthRangekaw.executeQuery("SELECT COUNT(*) AS WeekCount, SUM(TotalAmount) AS WeekAmount FROM kaw_sales  WHERE DateSold >= '"+monthkaw+"' AND DateSold <='"+today+"'"); 
                    if (monthRangeResultkaw.next()){
                        kawDvalue = monthRangeResultkaw.getInt(1);
                        tempRevenue = monthRangeResultkaw.getInt(2);
                        monthRevenue += tempRevenue;
                    }
                }
                if(monthResultmen.next()){
                    String monthmen = monthResultmen.getString(1);
                    Statement monthRangemen = con.createStatement();
                    ResultSet monthRangeResultmen = monthRangemen.executeQuery("SELECT COUNT(*) AS WeekCount, SUM(TotalAmount) AS WeekAmount FROM men_sales  WHERE DateSold >= '"+monthmen+"' AND DateSold <='"+today+"'"); 
                    if (monthRangeResultmen.next()){
                        menDvalue= monthRangeResultmen.getInt(1);
                        tempRevenue = monthRangeResultmen.getInt(2);
                        monthRevenue += tempRevenue;
                    }
                }
                shopDvalue = "";
                if (nakDvalue > highestDvalue){
                    highestDvalue = nakDvalue;
                    totalDvalue = totalDvalue + nakDvalue;
                    shopDvalue = "Nakawa";
                }
                if (kawDvalue > highestDvalue){
                    highestDvalue = kawDvalue;
                    totalDvalue = totalDvalue + kawDvalue;
                    shopDvalue = "Kawempe";
                }
                if (menDvalue > highestDvalue){
                    totalDvalue = totalDvalue + menDvalue;
                    highestDvalue = menDvalue;
                    shopDvalue = "Mengo";
                }
            %>
                <div class="special-card second-row-header admin-sales-card-header">Month's  Sales</div>
                <div class="admin-sales-second-row">
                    <div class="special-card view-month">
                        <%-- <div class="click-to-view"><span class="fa fa-info-circle"></span> Click on shop to view</div> --%>
                        <a href="">
                            <div class="shop-week-sales nak-red-grad">
                                <div class="shop-sales-info-inner">
                                    <div class="sales-shop-name">Nakawa</div>
                                    <div class="sales-shop-number"><%=nakDvalue%></div>
                                </div>
                            </div>
                        </a>                        
                        <a href="">
                            <div class="shop-week-sales kaw-red-grad">
                                <div class="shop-sales-info-inner">
                                    <div class="sales-shop-name">Kawempe</div>
                                    <div class="sales-shop-number"><%=kawDvalue%></div>
                                </div>
                            </div>    
                        </a>
                        <a href="">
                            <div class="shop-week-sales men-red-grad">
                                <div class="shop-sales-info-inner">
                                    <div class="sales-shop-name">Mengo</div>
                                    <div class="sales-shop-number"><%= menDvalue%></div>
                                </div>
                            </div>
                        </a>
                    </div>            
                    <div class="special-card monthly-info">
                        <div class="top-sales month-sales">
                            <span>Top Total Monthly Sales</span>
                            <div class="top-sales-inner">
                                <div class="shop-name"><%=shopDvalue%></div>
                                <div class="number-shop"><%= highestDvalue%></div>
                            </div>
                        </div>
                        <div class="monthly-overall">
                            <div class="top-sales-inner">
                                <div class="overall-total">Overall Total</div>
                                <div class="overall-number"><%= totalDvalue%></div>
                            </div>
                        </div>
                    </div>        
                </div>
                <div class="revenue-column">
                    <div class="special-card no-space revenue-details">
                        <div style="color:#459EDA;"><span class="fa fa-money-bill"></span> Today's Revenue</div>
                        <div><%= todayRevenue %>/-</div>
                    </div>
                    <div class="special-card revenue-details">
                        <div style="color:#60B864;"><span class="fa fa-money-bill"></span> Week's Revenue</div>
                        <div><%= weekRevenue%>/-</div>
                    </div>
                    <div class="special-card revenue-details">
                        <div style="color:#AE3E2E;"><span class="fa fa-money-bill"></span> Month's Revenue</div>
                        <div><%= monthRevenue%>/-</div>

            <%
                    con.close();
                }catch(Exception e){
                    out.print(e);
                }
            %>
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