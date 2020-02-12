<%-- If user has not yet logged in --%>
<%
    if(session.getAttribute("SalesName")==null){
        session.setAttribute("firstLogin","User not logged in, Please Login!");
        response.sendRedirect("login"); 
    }
%>

<%@ page import="java.sql.*"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
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
 <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/kayenet" user = "root"  password = ""/>
      <c:set var="mi" value="${sessionScope.BRANCH}" />
      <c:set var="nak" value="NAK" /> 
      <c:set var="kaw" value="KAW" />
      <c:set var="men" value="MEN" />
      <c:if test = "${mi == nak}"> 
      <sql:query dataSource = "${snapshot}" var = "result">
         SELECT * from nak_pdts;
      </sql:query>
      </c:if>
       <c:if test = "${mi == kaw}"> 
     <sql:query dataSource = "${snapshot}" var = "result">
         SELECT * from kaw_pdts;
      </sql:query>
      </c:if>
       <c:if test = "${mi == men}"> 
      <sql:query dataSource = "${snapshot}" var = "result">
         SELECT * from men_pdts;
      </sql:query>
      </c:if>
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
                        <a href="monthly-sales-shop"><div class="tabs sales-tabs"><span class="fa tab-icon fa-calendar"></span><span class="tab-name">Monthly</span></div></a>
                        <div class="tabs sales-tabs sales-selected-tab"><span class="fa tab-icon fa-credit-card"></span><span class="tab-name">Transact</span></div>
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
                <div>
                    <div class="all-stock transaction">
                        <div class="default-card-header">
                            Make a Transaction
                        </div>
                    </div>
                    <div class="special-card transact-table">
                    <div>
                    <%
                        if(session.getAttribute("successTransactMessage")!=null){
                            out.print("<div class='success-message success-message-special'><span class='fa fa-check-circle'></span> &nbsp;"+session.getAttribute("successTransactMessage")+"</div>");
                            //Remove Unlogged in attribute to prevent continuous promption
                            session.removeAttribute("successTransactMessage");
                        }
                    %>
                    </div>
                    <form action="transacting">
                        <div class="table-section sales-table">
                            <table>
                                <tr class="header-tr">
                                    <th>Image</th>
                                    <th>Bag ID</th>
                                    <th>Name</th>
                                    <th>Available Stock</th>
                                    <th>Price</th>
                                    <th>Quantity Taken</th>
                                    <th></th>
                                </tr>
                                    <c:forEach var = "row" items = "${result.rows}">
                                <tr>
                                    <td class="table-image"><img width="50px" height="50px"  src="uploads/${row.Image}"/></td>
                                    <td><c:out value = "${row.BagID}"/></td>
                                    <td><c:out value = "${row.Name}"/></td>
                                    <td><c:out value = "${row.Quantity}"/></td>
                                    <td><c:out value = "${row.Price}"/></td>
                                    <td style="width:24%;">
                                    <%-- If statement to check if quantity is 0 --%>
                                    <c:if test = "${row.Quantity == 0 || row.Quantity < 0}"> 
                                        <input type = "text" disabled placeholder="Out of Stock">
                                    </c:if>
                                    <c:if test = "${row.Quantity > 0}"> 
                                        <input type = "text" name = "${row.BagID}" placeholder="Quantity to be sold">
                                    </c:if>
                                    </td>
                                    <td>
                                        <c:if test = "${row.Quantity == 0 || row.Quantity < 0}"> 
                                            <button class="table-button sales-t-button" type="button" disabled>Sell</button>
                                        </c:if>
                                        <c:if test = "${row.Quantity > 0}"> 
                                            <button class="table-button sales-t-button" type="submit" value="${row.BagID}" name="purchase">Sell</button>
                                        </c:if>
                                    </td>
                                    <input type="hidden" name="quantity" value="${row.Quantity}">
                                </tr>
                                   </c:forEach>
                            </table>
                        </div>
                    </form>
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