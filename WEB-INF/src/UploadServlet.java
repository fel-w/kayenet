import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import javafx.scene.shape.Path;
import java.io.*;
import java.nio.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@WebServlet("/uploads")
@MultipartConfig

// Annotations above to recognize and support multipart requests
public class UploadServlet extends HttpServlet{
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String table = request.getParameter("table");
        String bagName  = request.getParameter("bagName");
        String description = request.getParameter("description");
        String quantity= request.getParameter("quantity");
        String price= request.getParameter("price");
        String branch = request.getParameter("branch");
        String bagID = "";

        Part filePart = request.getPart("image"); //To retrieve the image from the form
        File uploads = new File("/uploads"); //Obtaining the folder to upload to
        
        // Not sure about this part
        try(InputStream input = filePart.getInputStream()){
            Files.copy(input, uploads.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
        

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.print(table);
        out.print("<br>");
        out.print(bagName);
        out.print("<br>");
        out.print(description);
        out.print("<br>");
        out.print(branch);out.print("<br>");
        out.print(bagID);
        out.print("<br>");
        
        out.print(price);
        out.print("<br>");
        out.print(quantity);
        out.print("<br>");
        out.print(table);
        out.print("<br>");
        
        String inputS = uploads.getName();
        out.print(inputS);
        out.print("<br>");
        
    }
}