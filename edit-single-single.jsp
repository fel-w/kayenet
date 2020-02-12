<%-- If user has not yet logged in --%>
<%
    if(session.getAttribute("SalesName")==null){
        session.setAttribute("firstLogin","User not logged in, Please Login!");
        response.sendRedirect("login"); 
    }
%>

<%
   String branchName= (String)session.getAttribute("branchName"); 
   String id = (String)session.getAttribute("id"); 
   int successRows = 0;
    if(request.getParameter("qty")==null && request.getParameter("price")==null){
        response.sendRedirect("modify-products");
    }else{
        if(request.getParameter("qty")!=null && request.getParameter("price")!=null){
                String SQL = "UPDATE "+branchName+" SET Quantity = ?, Price = ? WHERE BagID ='"+id+"';"; 
                PreparedStatement stm = con.prepareStatement(SQL);
                stm.setString(1,request.getParameter("qty"));
                stm.setString(2,request.getParameter("price"));
                successRows = stm.executeUpdate();
                if (successRows > 0){
                    session.setAttribute("successUpdateMessage","Product Updated Successfully");
                    response.sendRedirect("modify-products");
                }
        }else{
            if(request.getParameter("qty")!=null){
                    String SQL = "UPDATE "+branchName+" SET Quantity = ? WHERE BagID ='"+id+"';"; 
                    PreparedStatement stm = con.prepareStatement(SQL);
                    stm.setString(1,request.getParameter("qty"));
                    successRows = stm.executeUpdate();
                    if (successRows > 0){
                            session.setAttribute("successUpdateMessage","Product Updated Successfully");
                            response.sendRedirect("modify-products");
                    }
            }
            else{
                if(request.getParameter("price")!=null){
                    String SQL = "UPDATE "+branchName+" SET Price = ? WHERE BagID ='"+id+"';"; 
                    PreparedStatement stm = con.prepareStatement(SQL);
                    stm.setString(1,request.getParameter("price"));
                    successRows = stm.executeUpdate();
                    if (successRows > 0){
                        session.setAttribute("successUpdateMessage","Product Updated Successfully");
                        response.sendRedirect("modify-products");
                    }
                }
            }
        }
    }

    
%>