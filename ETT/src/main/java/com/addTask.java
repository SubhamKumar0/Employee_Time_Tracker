package com;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/addTask")
public class addTask extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String date = request.getParameter("date");
        String day = request.getParameter("day");
        String time = request.getParameter("time");
        String taskDescription = request.getParameter("task");
        int durationHours = Integer.parseInt(request.getParameter("duration"));
        int employeeId = Integer.parseInt(request.getParameter("employeeId")); 

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ett", "root", "Ashapawan");

            String query = "INSERT INTO tasks (employee_id, date, day, time, task_description, duration_hours) VALUES (?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(query);
            ps.setInt(1, employeeId);
            ps.setString(2, date);
            ps.setString(3, day);
            ps.setString(4, time);
            ps.setString(5, taskDescription);
            ps.setInt(6, durationHours);

            ps.executeUpdate();

       
            response.sendRedirect("admin_dashboard.html");

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        
        
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
