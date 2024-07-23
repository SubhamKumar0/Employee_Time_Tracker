package com;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.Task;
import com.google.gson.Gson;
@WebServlet("/viewTasks")
public class TaskDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<Task> tasks = new ArrayList<>();

        try {
            // Load the MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish the connection to the database
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ett", "root", "Ashapawan");

            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM tasks");

            while (rs.next()) {
                Task task = new Task();
                task.setUsername(rs.getInt("employee_id"));
                task.setDate(rs.getString("date"));
                task.setDay(rs.getString("day"));
                task.setTime(rs.getString("time"));
                task.setDuration(rs.getInt("duration_hours"));
                task.setDescription(rs.getString("task_description"));
                tasks.add(task);
            }
            request.setAttribute("tasks", tasks);
            String tasksJson = new Gson().toJson(tasks);
            request.setAttribute("tasksJson", tasksJson);
            request.getRequestDispatcher("viewTransaction.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
