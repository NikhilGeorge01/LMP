<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style.css">
<title>Login Error</title>
<script type="text/javascript">
    function goBack() {
        // Redirect to login.jsp
        window.location.href = "login.jsp";
    }
</script>
</head>
<body>
	<div class="container">
		<font size="40">Invalid Credentials</font>
		<br><br><br>
		<br><br><br>
		<br><br><br>
		<div class="goback">
			<button onclick="goBack()">Go Back</button>	
		</div>	
	</div>
</body>
</html>
