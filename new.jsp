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
</head>
<body>

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
                    <div class="top-section">
                        <div class="back-section"><a href="modify-products"><div class="back"><svg class="svg-inline--fa fa-chevron-left fa-w-10" aria-hidden="true" focusable="false" data-prefix="fa" data-icon="chevron-left" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M34.52 239.03L228.87 44.69c9.37-9.37 24.57-9.37 33.94 0l22.67 22.67c9.36 9.36 9.37 24.52.04 33.9L131.49 256l154.02 154.75c9.34 9.38 9.32 24.54-.04 33.9l-22.67 22.67c-9.37 9.37-24.57 9.37-33.94 0L34.52 272.97c-9.37-9.37-9.37-24.57 0-33.94z"></path></svg><!-- <span class="fa fa-chevron-left"></span> -->Back</div></a></div> 
                        <div class="create-card-header">New Product</div>
                    </div>
                    <br>
                    <form action="uploadPic.jsp" method="post" >
                        <div class="info-display-wrap">
                            <div class="star-field">The fields marked <span style="color:red;">*</span> are compulsory. First Upload the image</div>
                            <div class="success-message-area">
                                <%-- Displaying a success message --%>
                                <%
                                    if(request.getAttribute("successMessage")!=null){
                                        out.println("<div class='success-message'><span class='fa fa-check-circle'></span> &nbsp;"+request.getAttribute("successMessage")+"</div>");
                                    }
                                %>
                            </div>
                        </div><br>
                        <div class="register">
                            <div class="form-left">
                                <label>Bag Name &nbsp;<span>*</span></label><br><input type="text" name="bagName" required=""><br><br>
                                <label>Description &nbsp;<span>*</span></label><br><input type="text" name="description" required=""><br><br>
                                <label>Image</label>&nbsp;<a href="uploadPicture.html"><span class="fa fa-upload"></span></a><br><br>
                                <!-- Temporal image feild -->
                                <!-- <label>Image &nbsp;<span>*</span></label><br><input type="text" name="image" required=""><br><br> -->
                            </div>
                            <div class="form-right l-space">
                                <label>Quantity &nbsp;<span>*</span></label><input type="text" name="quantity" required=""><br><br>
                                <label>Price &nbsp;<span>*</span></label><br><input type="text" name="price" required=""><br><br>
                            </div>
                            <%-- Hiden Form Fields to carry the Branch and Shoptable Parameters --%>
                            <input type="hidden" name="table" value="<%=session.getAttribute("branchName")%>">
                            <input type="hidden" name="branch" value="<%=session.getAttribute("BRANCH")%>">
                        </div>
                        <div class="button"><input type="submit" name="product-submit" value="Submit"></div>
                    </form>
                </div>
            </div>
            <!-- End of Content section -->
        </div>
        <!-- End of Main main side -->
    </div>
    <!-- End of wrapping column -->
</body>
</html>