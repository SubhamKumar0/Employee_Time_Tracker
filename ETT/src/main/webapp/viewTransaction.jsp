<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.Task"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Task Status - SB ENTERPRISES</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

canvas {
	max-width: 100%;
	height: auto;
}
</style>
</head>
<body>
	<div class="container">
		<h2>View Task Status</h2>
		<div class="task-header">
			<h3>Task Details</h3>
			<button onclick="downloadPDF()">Download PDF</button>
		</div>
		<div id="tasks-container">
			<!-- Task details will be populated here -->
			<%
                List<Task> tasks = (List<Task>) request.getAttribute("tasks");
                if (tasks != null && !tasks.isEmpty()) {
                    for (Task task : tasks) {
            %>
			<div class="task-details">
				<label>Employee Id</label> <input type="text"
					value="<%= task.getUsername() %>" readonly> <label>Date</label>
				<input type="text" value="<%= task.getDate() %>" readonly> <label>Day</label>
				<input type="text" value="<%= task.getDay() %>" readonly> <label>Time</label>
				<input type="text" value="<%= task.getTime() %>" readonly> <label>Duration</label>
				<input type="text" value="<%= task.getDuration() %> hours" readonly>
				<label>Description</label> <input type="text"
					value="<%= task.getDescription() %>" readonly>
			</div>
			<%
                    }
                } else {
            %>
			<p>No tasks available.</p>
			<%
                }
            %>
		</div>
		<canvas id="taskChart"></canvas>
	</div>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
	<script>
	function downloadPDF() {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        doc.setFontSize(16);
        doc.text("Task Status Report", 20, 20);
        doc.setFontSize(12);

        const tasksContainer = document.getElementById('tasks-container');
        const taskDetails = tasksContainer.getElementsByClassName('task-details');
        let y = 30; // Initial vertical position for text

        for (let i = 0; i < taskDetails.length; i++) {
            const inputs = taskDetails[i].getElementsByTagName('input');
            for (let j = 0; j < inputs.length; j++) {
                doc.text(inputs[j].previousElementSibling.innerText + ": " + inputs[j].value, 20, y);
                y += 10;
            }
            y += 10; // Extra space between tasks
        }

        doc.save("task_status_report.pdf");
    }

    document.addEventListener("DOMContentLoaded", function() {
        const ctx = document.getElementById('taskChart').getContext('2d');
        const tasksJson = '<%= request.getAttribute("tasksJson") %>';
        const tasks = JSON.parse(tasksJson);

        const labels = tasks.map(task => "Employee " + task.username);
        const data = tasks.map(task => task.duration);

        new Chart(ctx, {
            type: 'pie',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Task Duration (hours)',
                    data: data,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    title: {
                        display: true,
                        text: 'Task Duration per Employee'
                    }
                }
            }
        });
    });
	</script>
</body>
</html>
