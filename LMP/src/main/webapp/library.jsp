<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Library Management</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('images/lib.jpeg');
            background-size: cover;
            background-position: center;
            color: #4e342e;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            background-color: rgba(255, 248, 240, 0.9); 
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        h1 {
            text-align: center;
            color: #4e342e;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button, input[type="submit"], .view-books {
            width: 100%;
            padding: 10px;
            background-color: #795548;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            display: inline-block;
            text-decoration: none;
        }
        button:hover, input[type="submit"]:hover, .view-books:hover {
            background-color: #5d4037;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Library Management</h1>
    <div style="text-align: center; margin: 20px;">
    <a href="view.jsp">
        <button style="padding: 10px 20px; background-color: #795548; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer;">
            Go to View Books
        </button>
    </a>
</div>

    <!-- Form to add a book -->
    <form action="LibraryServlet" method="post">
        <input type="hidden" name="action" value="add">
        <h2>Add a Book</h2>
        <div class="form-group">
            <label for="bookname">Book Name:</label>
            <input type="text" id="bookname" name="bookname" required>
        </div>
        <div class="form-group">
            <label for="bookid">Book ID:</label>
            <input type="text" id="bookid" name="bookid" required>
        </div>
        <div class="form-group">
            <label for="author">Author:</label>
            <input type="text" id="author" name="author" required>
        </div>
        <div class="form-group">
            <label for="count">Count:</label>
            <input type="number" id="count" name="count" required>
        </div>
        <button type="submit">Add Book</button>
    </form>

    <!-- Form to remove a book -->
    <form action="LibraryServlet" method="post">
        <input type="hidden" name="action" value="remove">
        <h2>Remove a Book</h2>
        <div class="form-group">
            <label for="removeBookid">Book ID:</label>
            <input type="text" id="removeBookid" name="bookid" required>
        </div>
        <div class="form-group">
            <label for="removeCount">Count:</label>
            <input type="number" id="removeCount" name="count" required>
        </div>
        <button type="submit">Remove Book</button>
    </form>

    <!-- Form to borrow a book -->
    <form action="LibraryServlet" method="post">
        <input type="hidden" name="action" value="borrow">
        <h2>Borrow a Book</h2>
        <div class="form-group">
            <label for="borrowBookid">Book ID:</label>
            <input type="text" id="borrowBookid" name="bookid" required>
        </div>
        <div class="form-group">
            <label for="borrower">Borrower Name:</label>
            <input type="text" id="borrower" name="borrower" required>
        </div>
        <button type="submit">Borrow Book</button>
    </form>

    <!-- Form to return a book -->
    <form action="LibraryServlet" method="post">
        <input type="hidden" name="action" value="return">
        <h2>Return a Book</h2>
        <div class="form-group">
            <label for="returnBookid">Book ID:</label>
            <input type="text" id="returnBookid" name="bookid" required>
        </div>
        <div class="form-group">
            <label for="returner">Returner Name:</label>
            <input type="text" id="returner" name="borrower" required>
        </div>
        <button type="submit">Return Book</button>
    </form>
</div>

</body>
</html>
