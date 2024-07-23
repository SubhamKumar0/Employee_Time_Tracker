<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.Employee"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Employee Details - SB ENTERPRISES</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
/* Global Styles */
body, html {
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100%;
	font-family: 'Arial', sans-serif;
	background: #f8f9fa;
}

.container {
	max-width: 600px;
	margin: 50px auto;
	padding: 20px;
	background: white;
	border-radius: 10px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
}

h2 {
	text-align: center;
	margin-bottom: 20px;
	color: #333;
}

.task-details {
	margin: 20px 0;
	padding: 20px;
	border: 1px solid #ddd;
	border-radius: 5px;
	background: #f1f1f1;
}

.task-details label {
	display: block;
	margin: 10px 0 5px;
	font-weight: bold;
}

.task-details input {
	width: calc(100% - 20px);
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	margin-bottom: 15px;
	background: white;
}

button {
	width: 100%;
	padding: 10px;
	border: none;
	border-radius: 5px;
	background: #007bff;
	color: white;
	cursor: pointer;
	margin-top: 20px;
	transition: background 0.3s;
}

button:hover {
	background: #0056b3;
}

.task-header {
	display: flex;
	justify-content: space-between;
	border-bottom: 2px solid #007bff;
	padding-bottom: 10px;
	margin-bottom: 20px;
}

.task-header h3 {
	margin: 0;
}
</style>
</head>
<body>
	<div class="container">
		<h2>View Employee Details</h2>

		<div id="tasks-container">
			<%
				List<Employee> employees = (List<Employee>) request.getAttribute("employees");
				if (employees != null && !employees.isEmpty()) {
					for (Employee employee : employees) {
			%>
			<div class="task-details">
				<label>First Name:</label> <input type="text"
					value="<%= employee.getFirstname() %>" readonly> <label>Last
					Name:</label> <input type="text" value="<%= employee.getLastname() %>"
					readonly> <label>Role:</label> <input type="text"
					value="<%= employee.getRole() %>" readonly> <label>Email:</label>
				<input type="text" value="<%= employee.getEmail() %>" readonly>
			</div>
			<%
					}
				} else {
			%>
			<p>No employees available.</p>
			<%
				}
			%>
		</div>
	</div>
</body>
</html>
