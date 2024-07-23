package com;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

/**
 * Servlet implementation class Employee_login
 */
@WebServlet("/employee_login")
public class Employee_login extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String empId = request.getParameter("emp_id");
		String username = request.getParameter("username");
		 Connection conn = null;
	        PreparedStatement stmt = null;
	        ResultSet rs = null;
	        Employee emp = null;
		 try {
	            // Load the MySQL driver
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            // Establish the connection to the database
	            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ett", "root", "Ashapawan");           
	            
	            stmt = conn.prepareStatement("SELECT * FROM employee_details where id = ? and firstname = ?");
	            stmt.setString(1,"empId");
	            stmt.setString(2, "username");
	            rs = stmt.executeQuery();
	            
	            if (rs.next()) {
	                emp = new Employee();
	                emp.setId(rs.getInt("id"));
	                emp.setFirstname("firstname");
	                emp.setLastname("lastname");
	                emp.setRole("role");
	                emp.setEmail("email");
	            }
	            
	            if(emp.getFirstname().equals(empId) )
	            {
	            	 request.getRequestDispatcher("viewTransaction.jsp").forward(request, response);
	            	 return;
	            }
	           
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
