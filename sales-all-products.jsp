<%-- If user has not yet logged in --%>
<%
    if(session.getAttribute("SalesName")==null){
        session.setAttribute("firstLogin","User not logged in, Please Login!");
        response.sendRedirect("login"); 
    }
%>
<%@ page import = "java.time.LocalDate"%>
<%
    request.getSession(true);
    String branch= (String)session.getAttribute("BRANCH");  
    String branchName ="";
    String branchSales = "";
    String NAK = "NAK";
    String KAW = "KAW";
    String MEN = "MEN";
    if (NAK.equals(branch)){
        branchName = "nak_pdts";
        branchSales = "nak_sales";
    }
    if (MEN.equals(branch)){
        branchName = "men_pdts";
        branchSales = "men_sales";
    }
    if (KAW.equals(branch)){
        branchName = "kaw_pdts";
        branchSales = "kaw_sales";
    }
    session.setAttribute("branchName",branchName);
    session.setAttribute("branchSales",branchSales);    
    //Setting the current date session value
    LocalDate myObj = LocalDate.now();
    String today = myObj.toString();
    session.setAttribute("today",today);
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
                    <div class="account-type"><span class="fa fa-users tab-icon"></span><span class="account-name">Sales Person</span></div>
                    <div class="links sales-links">
                        <div class="section-account-name"><span class="fa tab-icon fa-user"></span><span class="tab-name"><%=session.getAttribute("SUserName")%></span></div>
                        <div class="section"> <span class="fa tab-icon fa-shopping-cart"></span> <span class="section-name"> Products</span></div>
                        <div class="tabs sales-tabs sales-selected-tab"><span class="fa tab-icon fa-list"></span><span class="tab-name">All</span></div>
                        <a href="modify-products"><div class="tabs sales-tabs"><span class="fa tab-icon fa-edit"></span><span class="tab-name">Edit</span></div></a>
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
            <%-- Displaying temporary welcome message --%>
            <%
                if(session.getAttribute("tempWelcome")!=null){
                    out.print("<div class='welcome-section special-card'>"+session.getAttribute("tempWelcome")+" <span>"+session.getAttribute("SalesName")+"</span></div>");
                    //Remove attribute to prevent continuous displayy
                    session.removeAttribute("tempWelcome");
                }
            %>
                <div class="all-stock">
                    <div class="default-card-header">All Products</div>
                    <div class="all-stock-details">
                     <%
                        String id = request.getParameter("purchase");           
                        String SQL = "SELECT * FROM "+branchName; 
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery(SQL);
                        while(rs.next()){
                                    
           %>
                        <div class="special-card">
                            <div class="img-area">
                                <img width="100%" height="100%"  src="uploads/<%=rs.getString(5) %>"/>
                            </div>
                            <div class="inner-section all-stock-section">
                                <div class="inner-name">Bag ID</div>
                                <div class="inner-detail"><%= rs.getString(2) %></div>
                            </div>
                            <div class="inner-section all-stock-section">
                                <div class="inner-name">Name</div>
                                <div class="inner-detail"><%= rs.getString(3) %></div>
                            </div>
                            <div class="inner-section all-stock-section">
                                <div class="inner-name">Price</div>
                                <div class="inner-detail"><%= rs.getString(6) %></div>
                            </div>
                            <div class="inner-section all-stock-section">
                                <div class="inner-name">In-stock</div>
                                <div class="inner-detail inner-detail-number"><%= rs.getString(7) %></div>
                            </div>
                        </div>
                        <%
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