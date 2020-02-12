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
                <div class="card">
                    <div class="top-section">
                        <div class="back-section"><a href="all-sales-info"><div class="back"><span class="fa fa-chevron-left"></span>Back</div></a></div> 
                        <div class="create-card-header">Nakawa Sales Today</div>
                    </div>
                    <div class="manage-accounts">
                        <div class="detail display-sales">
                            <div class="detail-box"> 
                                <div class="detail-name"><span class="fa fa-bars"></span> Number Sold</div> 
                                <div class="number-accounts">30</div> 
                            </div>
                        </div>
                        <div class="row-left-space column-space-above"></div>
                        <div class="detail display-sales">
                            <div class="detail-box "> 
                                <div class="detail-name"><span class="fa fa-money-bill"></span> Cash</div> 
                                <div class="number-accounts">5300000</div> 
                            </div>
                        </div>
                    </div>
                    <div class="table-section admin-table admin-products">
                        <table>
                            <tr class="header-tr">
                                <th>Image</th>
                                <th>Bag ID</th>
                                <th>Name</th>
                                <th>Quantity Sold</th>
                                <th>Price</th>
                                <th>Description</th>
                            </tr>
                            <tr>
                                <td class="table-image">icon</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>  
                            </tr>
                            <tr>
                                <td class="table-image">icon</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>                            
                            <tr>
                                <td class="table-image">icon</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
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