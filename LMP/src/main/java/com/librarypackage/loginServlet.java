package com.librarypackage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public loginServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
 
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/libdetailsdb", "root", "root");
            PreparedStatement ps = conn.prepareStatement("SELECT username, password FROM details WHERE username = ? AND password = ?");
            ps.setString(1, username);
            ps.setString(2, password);
            
            ResultSet rst = ps.executeQuery();
            int rowCount = 0;
            while (rst.next()) {
                rowCount++;
            }
            if (rowCount >= 1) {
            	request.getRequestDispatcher("library.jsp").forward(request, response);

            } else {
            	request.getRequestDispatcher("login_error.jsp").forward(request, response);

                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    
    }
}
