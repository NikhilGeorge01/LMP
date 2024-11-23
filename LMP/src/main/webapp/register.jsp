<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <div class="container">
        <h1>Register</h1>
        <form action="registerServlet" method="post">
            <label for="reg-username">Username:</label>
            <input type="text" id="reg-username" name="username" required>
            
            <label for="reg-password">Password:</label>
            <input type="password" id="reg-password" name="password" required>
            
            <label for="library-id">Library ID:</label>
            <input type="text" id="library-id" name="libraryId" required>
            
            <button type="submit">Register</button>
        </form>
        <div class="switch-btn">
            <form action="login.jsp" method="get">
                <button type="submit">Switch to Login</button>
            </form>
        </div>
    </div>
</body>
</html>
