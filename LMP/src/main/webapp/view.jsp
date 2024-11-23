<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Library Books</title>
    <style>
    body {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
        background-image: url('<%= request.getContextPath() %>/images/lib.jpeg');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        color: #4e342e;
    }
        .container {
            max-width: 80%;
            margin: 50px auto;
            padding: 20px;
            background-color: rgba(255, 248, 240, 0.9);
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #795548;
            color: white;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #795548;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #5d4037;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Library Books</h1>
        
        <!-- Display the Books Table -->
        <h2>Available Books</h2>
        <table>
            <tr>

                <th>Title</th>
                <th>Author</th>
                <th>book id</th>
                <th>Available</th>
               
            </tr>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/libdetailsdb", "root", "root");

                    stmt = conn.createStatement();
                    String sqlBooks = "SELECT * FROM books";
                    rs = stmt.executeQuery(sqlBooks);
                    
                    while (rs.next()) {

                        String bookname = rs.getString("bookname");
                        String author = rs.getString("author");
                        String bookid = rs.getString("bookid");
                        String available = rs.getString("available");
            %>
            <tr>

                <td><%= bookname %></td>
                <td><%= author %></td>
                <td><%= bookid %></td>
                <td><%= available %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
            <tr>
                <td colspan="4">Error retrieving data from books table.</td>
            </tr>
            <%
                } finally {
                    try {
                        if (rs != null) rs.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </table>

        <!-- Display the Borrowed Books Table -->
        <h2>Borrowed Books</h2>
        <table>
            <tr>
                <th>Book ID</th>
                <th>Borrowed By</th>
            </tr>
            <%
                try {
                    // Query for borrowed table
                    stmt = conn.createStatement();
                    String sqlBorrowed = "SELECT * FROM borrowed1";
                    rs = stmt.executeQuery(sqlBorrowed);
                    
                    while (rs.next()) {
                        String bookId = rs.getString("bookid");
                        String borrowedBy = rs.getString("borrowed_by");
                        
            %>
            <tr>
                <td><%= bookId %></td>
                <td><%= borrowedBy %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
            <tr>
                <td colspan="4">Error retrieving data from borrowed table.</td>
            </tr>
            <%
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </table>
        <button onclick="window.location.href='<%= request.getContextPath() %>/library.jsp'">Back to Library</button>
    </div>
</body>
</html>