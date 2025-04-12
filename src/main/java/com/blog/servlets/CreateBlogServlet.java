package com.blog.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/CreateBlogServlet")
@MultipartConfig
public class CreateBlogServlet extends HttpServlet {

    private static final String CSV_FILE_PATH = "C:/Users/Admin/Desktop/MCA/java/project/src/blogs.csv"; // change to actual path
    private static final String IMAGE_UPLOAD_DIR = "C:/path/to/your/project/webapp/images/"; // change to actual path

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        Part imagePart = request.getPart("image");

        String imageFileName = "";

        // Save the uploaded image if it exists
        if (imagePart != null && imagePart.getSize() > 0) {
            String originalFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            imageFileName = System.currentTimeMillis() + "_" + originalFileName;
            File imageFile = new File(IMAGE_UPLOAD_DIR + imageFileName);
            imagePart.write(imageFile.getAbsolutePath());
        }

        // Format blog entry
        String timestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        String blogEntry = String.format("\"%s\",\"%s\",\"%s\",\"%s\"\n",
                title.replace("\"", "\"\""),
                content.replace("\"", "\"\""),
                imageFileName,
                timestamp);

        // Write to CSV
        try (FileWriter fw = new FileWriter(CSV_FILE_PATH, true);
             BufferedWriter bw = new BufferedWriter(fw)) {
            bw.write(blogEntry);
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Redirect after submission
        response.sendRedirect("index.jsp"); // or any confirmation page
    }
}
