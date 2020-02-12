<%-- If user has not yet logged in --%>
<%
    if(session.getAttribute("SalesName")==null){
        session.setAttribute("firstLogin","User not logged in, Please Login!");
        response.sendRedirect("login"); 
    }
%>


<%@page import="java.sql.*"%>
<% 
    String bagID = request.getParameter("purchase");
    String purchasedValue = request.getParameter(bagID);
         try{
        String table,table1;
        String sess = (String)session.getAttribute("BRANCH");
        //Getting the current date session value
        String today= (String)session.getAttribute("today");
        switch(sess){
            case "KAW":
                table = "kaw_sales";
                table1 = "kaw_pdts";
                break;
            case "MEN":
                table = "men_sales";
                table1 = "men_pdts";
                break;
            case "NAK":
                table = "nak_sales";
                table1 = "nak_pdts";
                break;
            default:
            table = "";
            table1 = "";
        }
        String allQuery = "SELECT * FROM "+table1+" WHERE BagID = '"+bagID+"'";
        Statement allDetails = con.createStatement();
        ResultSet allResults = allDetails.executeQuery(allQuery);
        if (allResults.next()){
            String SQL = "INSERT INTO " + table + "(BagID,Name,Description,Image,Price,Quantity,QuantitySold,DateSold,TotalAmount) VALUES (?,?,?,?,?,?,?,?,?)";
            String SQL2 = "UPDATE " + table1 + " SET Quantity = ? WHERE BagID = ?";
            PreparedStatement  stmt = con.prepareStatement(SQL);
            PreparedStatement stmt2 = con.prepareStatement(SQL2);
            if(bagID !=null){
                int initQuantityValue = allResults.getInt("Quantity");
                int purchasedAmount = Integer.parseInt(purchasedValue);
                int remainingValue = (initQuantityValue - purchasedAmount);
                int price = allResults.getInt("Price");
                int totalCost = purchasedAmount * price;
                stmt.setString(1, bagID);
                stmt.setString(2, allResults.getString("Name"));
                stmt.setString(3, allResults.getString("Description"));
                stmt.setString(4, allResults.getString("Image"));
                stmt.setInt(5, price);
                stmt.setInt(6, initQuantityValue);
                stmt.setInt(7, purchasedAmount);
                stmt.setString(8, today);
                stmt.setInt(9, totalCost);
                stmt.executeUpdate();
                
                stmt2.setInt(1, remainingValue);
                stmt2.setString(2, bagID);
                stmt2.executeUpdate();
                session.setAttribute("successTransactMessage","Transaction Successful");
                response.sendRedirect("transact");
            }
            
        }
     }catch(Exception e){
         out.print("error"+e.getMessage());
     }

%>
