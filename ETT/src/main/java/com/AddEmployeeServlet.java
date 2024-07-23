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

@WebServlet("/addEmployee")
public class AddEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String role = request.getParameter("role");
        String email = request.getParameter("email");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the database connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ett", "root", "Ashapawan");

            // Create the SQL query
            String query = "INSERT INTO employee_details (firstname, lastname, role, email) VALUES (?, ?, ?, ?)";

            // Create a prepared statement
            ps = conn.prepareStatement(query);
            ps.setString(1, firstname);
            ps.setString(2, lastname);
            ps.setString(3, role);
            ps.setString(4, email);

            // Execute the update
            ps.executeUpdate();

            // Redirect to a success page (you can customize this as needed)
            response.sendRedirect("admin_dashboard.html");

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            
        } finally {
            // Clean up the database resources
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
