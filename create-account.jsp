<%@page import="encryption.MD5"%>
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
    <script src="js/main.js"></script>
</head>
<body>
<%
    if(request.getParameter("reg-submit")!=null){
        try{
            String firstName = request.getParameter("firstName");
            String lastName= request.getParameter("lastName");
            String userName = request.getParameter("userName");
            String address = request.getParameter("address");
            String phone = request.getParameter("telephone");
            String password = request.getParameter("password");
            String confirmPass = request.getParameter("confirmPass");
            String branch = request.getParameter("branch");
            String referee = request.getParameter("referee");;


            //Ensuring no one else has the same username
            String checkQ = "SELECT UserName FROM sales_person WHERE Username=?"; 
            String checkQAdmin = "SELECT UserName FROM admin WHERE Username=?"; 
            PreparedStatement check = con.prepareStatement(checkQ);
            PreparedStatement checkAdmin = con.prepareStatement(checkQAdmin);
            check.setString(1, userName);
            checkAdmin.setString(1, userName);
            ResultSet result = check.executeQuery();
            ResultSet resultAdmin = checkAdmin.executeQuery();
            if(result.next()){
                //If there already exists a sales_person with the same username
                request.setAttribute("userTaken","Username is already taken, Please pick another");
            }
            
            else {
                if(resultAdmin.next()){
                    //If admin has the same username
                    request.setAttribute("userTaken","Username is already taken, Please pick another");
                }
                else{
                    //If passwords match
                    if (confirmPass.equals(password)){
                        //Encrypt password
                        password = MD5.getMD5(password);

                        //Entering values in the database
                        String insertQ = "INSERT into sales_person (FirstName,LastName,Username,Password,Address,ReferencePerson,Branch,PhoneNumber) VALUES (?,?,?,?,?,?,?,?)";
                        PreparedStatement pstatement = con.prepareStatement(insertQ);
                        pstatement.setString(1, firstName);
                        pstatement.setString(2, lastName);
                        pstatement.setString(3, userName);
                        pstatement.setString(4, password);
                        pstatement.setString(5, address);
                        pstatement.setString(6, referee);
                        pstatement.setString(7, branch);
                        pstatement.setString(8, phone);
                        pstatement.executeUpdate();
                        request.setAttribute("successMessage","New Account Created successfully");
                    }
                    else{
                        request.setAttribute("passNomatch","Please Enter matching passwords before proceeding");
                    }
                }
            }
            con.close();
        }catch(Exception e){
            out.print(e);
        }

    }
%>
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
                        <div class="admin-selected-tab"><span class="fa tab-icon fa-users"></span><span class="tab-name">Accounts</span></div>
                        <a href="all-products"><div class="tabs"><span class="fa tab-icon fa-shopping-cart"></span><span class="tab-name">Products</span></div></a>
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
                <div class="card">
                    <div class="top-section">
                        <div class="back-section"><a href="sales-persons"><div class="back"><span class="fa fa-chevron-left"></span>Back</div></a></div> 
                        <div class="create-card-header">Create Account</div>
                    </div>
                    <br>
                    <form action="" method="POST" name="create-account.jsp">
                        <div class="info-display-wrap">
                            <div class="star-field">The fields marked <span style="color:red;">*</span> are compulsory</div>
                            <div class="success-message-area">
                                <%-- Displaying a success message --%>
                                <%
                                    if(request.getAttribute("successMessage")!=null){
                                        out.println("<div class='success-message'><span class='fa fa-check-circle'></span> &nbsp;"+request.getAttribute("successMessage")+"</div>");
                                    }
                                %>
                            </div>
                        </div>
                        <br>
                        <div class="register">
                            <div class="form-left">
                                <label>First Name &nbsp;<span>*</span></label><br><input type="text" name="firstName" required><br><br>
                                <label>User Name &nbsp;<span>*</span></label><br><input type="text" name="userName" required>
                                <div class="error-notification"><div id="usernameError">
                                <%-- Displaying Already taken username --%>
                                <%
                                    if(request.getAttribute("userTaken")!=null){
                                        out.println(request.getAttribute("userTaken"));
                                    }
                                %>
                                </div></div><br>
                                <label>Email</label><br><input type="email" name="email"><br><br>
                                <label>Branch</label><br>
                                     <select name="branch">
                                        <option value="NAK">Nakawa</option>
                                        <option value="MEN">Mengo</option>
                                        <option value="KAW">Kawempe</option>
                                    </select><br><br>
                                <div class="error-notification"><div id="passwordError"></div></div>                                       
                                <label>Password &nbsp;<span>*</span></label><br><input type="password" name="password" required><br><br>
                                <div class="error-notification"><div id="passwordError2">
                                <%-- Displaying persistent error password message --%>
                                <%
                                    if(request.getAttribute("passNomatch")!=null){
                                        out.println(request.getAttribute("passNomatch"));
                                    }
                                %>
                                </div></div> 
                            </div>
                            <div class="form-right l-space">
                                <label>Last Name &nbsp;<span>*</span></label><input type="text" name="lastName" required><br><br>
                                <label>Telephone &nbsp;<span>*</span></label><br><input type="text" name="telephone" required><br><br>
                                <label>Physical Address &nbsp;<span>*</span></label><br><input type="text" name="address" required><br><br>
                                <label>Reference's Name &nbsp;<span>*</span></label><br><input type="text" name="referee" required><br><br>
                                <label>Confirm Password &nbsp;<span>*</span></label><br><input type="password" name="confirmPass" onchange="passwordValidate();" required><br><br>
                            </div>
                        </div>
                        <div class="button"><input type="submit" name="reg-submit" value="Submit"></div>
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
