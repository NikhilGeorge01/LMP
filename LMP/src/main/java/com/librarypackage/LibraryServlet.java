package com.librarypackage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/LibraryServlet")
public class LibraryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Connection conn;

    public LibraryServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	String action = request.getParameter("action");
    	try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/libdetailsdb", "root", "root");
        } catch (Exception e) {
            e.printStackTrace();
        }
        

        try {
            if ("add".equals(action)) {
                addBook(request, response);
            } else if ("remove".equals(action)) {
                removeBook(request, response);
            } else if ("borrow".equals(action)) {
                borrowBook(request, response);
            } else if ("return".equals(action)) {
                returnBook(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Database operation failed.");
        }
    }

    private void addBook(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        String bookname = request.getParameter("bookname");
        String bookid = request.getParameter("bookid");
        String author = request.getParameter("author");
        String count = request.getParameter("count");

        int availableCount = Integer.parseInt(count);
        PreparedStatement ps = conn.prepareStatement("SELECT available FROM books WHERE bookid = ?");
        ps.setString(1, bookid);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            int currentAvailable = rs.getInt("available");
            int newAvailable = currentAvailable + availableCount;
            PreparedStatement ps1 = conn.prepareStatement("UPDATE books SET available = ? WHERE bookid = ?");
            ps1.setInt(1, newAvailable);
            ps1.setString(2, bookid);
            ps1.executeUpdate();
            ps1.close();
        } else {
            PreparedStatement ps2 = conn.prepareStatement("INSERT INTO books (bookname, bookid, author, available) VALUES (?, ?, ?, ?)");
            ps2.setString(1, bookname);
            ps2.setString(2, bookid);
            ps2.setString(3, author);
            ps2.setInt(4, availableCount);
            ps2.executeUpdate();
            ps2.close();
        }

        rs.close();
        ps.close();

        request.getRequestDispatcher("library.jsp").forward(request, response);
    }

    private void removeBook(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        String bookid = request.getParameter("bookid");
        String count = request.getParameter("count");

        int removeCount = Integer.parseInt(count);
        PreparedStatement ps = conn.prepareStatement("SELECT available FROM books WHERE bookid = ?");
        ps.setString(1, bookid);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            int currentAvailable = rs.getInt("available");

            if (currentAvailable >= removeCount) {
                int newAvailable = currentAvailable - removeCount;

                if (newAvailable > 0) {
                    PreparedStatement ps1 = conn.prepareStatement("UPDATE books SET available = ? WHERE bookid = ?");
                    ps1.setInt(1, newAvailable);
                    ps1.setString(2, bookid);
                    ps1.executeUpdate();
                    ps1.close();
                } else {
                    PreparedStatement ps2 = conn.prepareStatement("DELETE FROM books WHERE bookid = ?");
                    ps2.setString(1, bookid);
                    ps2.executeUpdate();
                    ps2.close();
                }
            }
        }

        rs.close();
        ps.close();

        request.getRequestDispatcher("library.jsp").forward(request, response);
    }

    private void borrowBook(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        String bookid = request.getParameter("bookid");
        String borrower = request.getParameter("borrower");
        PreparedStatement ps = conn.prepareStatement("SELECT available FROM books WHERE bookid = ?");
        ps.setString(1, bookid);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            int availableCount = rs.getInt("available");
            if (availableCount > 0) {
                PreparedStatement ps1 = conn.prepareStatement("INSERT INTO borrowed1 (bookid, borrowed_by) VALUES (?, ?)");
                ps1.setString(1, bookid);
                ps1.setString(2, borrower);
                ps1.executeUpdate();
                ps1.close();

                PreparedStatement ps2 = conn.prepareStatement("UPDATE books SET available = available - 1 WHERE bookid = ?");
                ps2.setString(1, bookid);
                ps2.executeUpdate();
                ps2.close();
            }
        }

        rs.close();
        ps.close();

        request.getRequestDispatcher("library.jsp").forward(request, response);
    }

    private void returnBook(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        String bookid = request.getParameter("bookid");
        String username = request.getParameter("borrower");

        PreparedStatement ps = conn.prepareStatement("SELECT * FROM borrowed1 WHERE bookid = ? AND borrowed_by = ?");
        ps.setString(1, bookid);
        ps.setString(2, username);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            PreparedStatement ps1 = conn.prepareStatement("DELETE FROM borrowed1 WHERE bookid = ? AND borrowed_by = ?");
            ps1.setString(1, bookid);
            ps1.setString(2, username);
            ps1.executeUpdate();
            ps1.close();

            PreparedStatement ps2 = conn.prepareStatement("UPDATE books SET available = available + 1 WHERE bookid = ?");
            ps2.setString(1, bookid);
            ps2.executeUpdate();
            ps2.close();
        }

        rs.close();
        ps.close();

        request.getRequestDispatcher("library.jsp").forward(request, response);
    }
}
