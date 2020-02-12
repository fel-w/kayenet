<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>
    <%
    try{
    String SQL = "SELECT * FROM  upload_image ";
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery(SQL);
     while(rs.next()){
    %>
    <img src="uploads/<%=rs.getString(1) %>"/>
    <%
     }
     }catch (Exception ex) {
             out.write("error"+ex.getMessage()); 
         }
    %>
    
</body>
</html>