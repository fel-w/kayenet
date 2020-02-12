<%-- If user has not yet logged in --%>
<%
    if(session.getAttribute("SalesName")==null){
        session.setAttribute("firstLogin","User not logged in, Please Login!");
        response.sendRedirect("login"); 
    }
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
    <style>
        .edit-product{
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
    </style>
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
                <%
                 String branchName= (String)session.getAttribute("branchName"); 
                    String id = request.getParameter("purchase");           
                    String SQL = "SELECT * FROM "+branchName+" WHERE BagID ='"+id+"';"; 
                    Statement stmt = con.createStatement();
                   ResultSet rs = stmt.executeQuery(SQL);
                  if(rs.next()){
                             
                %>
            <!-- Content section -->
            <form action="edit-single-single.jsp">
            <div class="content-section">
               <div class="special-card edit-product">
                    <div class="top-section">
                        <div class="back-section"><a href="modify-products"><div class="back"><span class="fa fa-chevron-left"></span> Back</div></a></div> 
                        <div class="create-card-header">Edit Product</div>
                    </div>
                    
                    <div class="change-info">
                        <span class="fa fa-info-circle"></span>
                        You may change the Quantity and/or Price of the Product
                    </div>
                    <div class="product-image img-area">
                        <img width="100%" height="100%"  src="uploads/<%=rs.getString(5) %>"/>
                    </div>
                    <div class="product-detail-area">
                        <div class="detail-name">Bag ID</div>
                        <div class="detail-value"><%= rs.getString(2) %></div>
                    </div>
                    <div class="product-detail-area">
                        <div class="detail-name">Name</div>
                        <div class="detail-value"><%= rs.getString(3)%></div>
                    </div>
                    <div class="product-detail-area ">
                        <div class="detail-name">Current Stock</div>
                        <div class="detail-value exception">
                            <input type="text" name="qty" value="<%= rs.getString(7)%>" placeholder="Enter New Quantity">
                        </div>
                    </div>
                    <div class="product-detail-area ">
                        <div class="detail-name">Current Price</div>
                        <div class="detail-value exception">
                            <input type="text" name="price" value="<%= rs.getString(6)%>" placeholder="Enter New Price">
                        </div>
                    </div>
                    <div class="product-detail-area">
                        <div class="detail-name">Description</div>
                        <div class="detail-value"><%= rs.getString(4)%></div>
                    </div>
                    <%
                  }
                  session.setAttribute("id",id);
                    %>
                <div class="button" style="margin-top:6%;">
                    <input type="submit" name="submit"/>
                </div>
                </div>
                </form>
            </div>
            <!-- End of Content section -->
        </div>
        <!-- End of Main main side -->
    </div>
    <!-- End of wrapping column -->
</body>
</html>
