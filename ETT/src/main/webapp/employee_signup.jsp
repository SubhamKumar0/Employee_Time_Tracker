<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Employee Registration - SB ENTERPRISES</title>
<style>
/* Global Styles */
body, html {
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100%;
	font-family: 'Arial', sans-serif;
}

.background {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: url('https://wallpaperaccess.com/full/656670.jpg') no-repeat
		center center fixed;
	background-size: cover;
	filter: blur(8px);
	z-index: -1;
}

.container {
	max-width: 400px;
	margin: 0 auto;
	padding: 20px;
	position: relative;
	top: 50%;
	transform: translateY(-50%);
}

.registration-form {
	background: rgba(255, 255, 255, 0.8);
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
}

.registration-form h3 {
	margin-top: 0;
	text-align: center;
	font-size: 1.5em;
}

.registration-form input {
	width: 100%;
	padding: 10px;
	margin-bottom: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-sizing: border-box;
}

.registration-form button {
	width: 100%;
	padding: 10px;
	border: none;
	border-radius: 5px;
	background: #333;
	color: white;
	cursor: pointer;
}

.registration-form button:hover {
	background: #555;
}
</style>
</head>
<body>
	<div class="background"></div>
	<div class="container">
		<div class="registration-form">
			<h3>New Employee Registration</h3>
			<form action="RegisterServlet" method="post">
				<input type="text" placeholder="First Name" name="firstName"
					required> <input type="text" placeholder="Last Name"
					name="lastName" required> <input type="text"
					placeholder="Role" name="role" required> <input
					type="email" placeholder="Email" name="email" required>
				<button type="submit">Register</button>
			</form>
		</div>
	</div>
</body>
</html>
