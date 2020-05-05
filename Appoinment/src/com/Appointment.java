/**
 * 
 */
package com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;


public class Appointment {
	private Connection connect() {
		
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/paf_project?useTimezone=true&serverTimezone=UTC", "root", "");
			
			// For testing
			System.out.print("Successfully connected");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}

	public String insertAppointment(String date, String time,String patientID, String doctorID, String paymentID, String appointmentStatus)
	{
		String output = "";
			 
		try
		{
			Connection con = connect();
			
			if (con == null)
			{
				return "Error while connecting to the database for inserting.";
			}
			 
			// create a prepared statement
			String query = " insert into appointment (`appointmentID`,`date`,`time`,`patientID`,`doctorID`,`paymentID`,`appointmentStatus`)"
			 + " values (?, ?, ?, ?, ?, ?, ?)";
			 
			PreparedStatement preparedStmt = con.prepareStatement(query);
			 
			// binding values
			preparedStmt.setInt(1, 0);
			preparedStmt.setString(2, date);
			preparedStmt.setString(3, time);
			preparedStmt.setString(4, patientID);
			preparedStmt.setString(5, doctorID);
			preparedStmt.setString(6, paymentID);
			preparedStmt.setString(7, appointmentStatus);
			 
			// execute the statement
			preparedStmt.execute();
			con.close();
			 
			String newItems = readAppointment();
			output = "{\"status\":\"success\", \"data\": \"" + newItems + "\"}";
		}
		catch (Exception e)
		{
			output = "{\"status\":\"error\", \"data\": \"Error while inserting the item.\"}";
			 
			System.err.println(e.getMessage());
			 
		}
			 
		return output;
			
	} 

	public String readAppointment()
	{
		String output = "";
	
		try
		{
			Connection con = connect();
	 
			if (con == null)
			{
				return "Error while connecting to the database for reading.";
			}
	 
			// Prepare the html table to be displayed
			output = "<table border='1'><tr><th>Date</th><th>Time</th><th>Patient ID</th>"
					 + "<th>Doctor ID</th><th>Payment ID</th><th>Appointment Status</th><th>Update</th><th>Remove</th></tr>"; 
			
			String query = "select * from appointment";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
	 
			// iterate through the rows in the result set
			while (rs.next())
			{
				String appointmentID = Integer.toString(rs.getInt("appointmentID"));
				String date = rs.getString("date");
				String time = rs.getString("time");
				String patientID = rs.getString("patientID");
				String doctorID = rs.getString("doctorID");
				String paymentID = rs.getString("paymentID");
				String appointmentStatus = rs.getString("appointmentStatus");
				
	
				// Add into the html table
				output += "<tr><td><input id='hidItemIDUpdate' name='hidItemIDUpdate' type='hidden' value='" + appointmentID + "'>" + date + "</td>";
				output += "<td>" + time + "</td>";
				output += "<td>" + patientID + "</td>";
				output += "<td>" + doctorID + "</td>";
				output += "<td>" + paymentID + "</td>";
				output += "<td>" + appointmentStatus + "</td>";
	 
				// buttons
				output += "<td><input name='btnUpdate' type='button'value='Update'class='btnUpdate btn btn-secondary'></td> "
						+ "<td><input name='btnRemove' type='button' value='Remove'class='btnRemove btn btn-danger' data-appointment='" + appointmentID + "'>" + "</td></tr>";
			}
	 
			con.close();
	 
			// Complete the html table
			output += "</table>";
		}
		catch (Exception e)
		{
			output = "Error while reading the items.";
			System.err.println(e.getMessage());
		}
		return output;
	}

	public String updateAppointment(String appointmentID, String date, String time,String patientID, String doctorID,String paymentID,String appointmentStatus)
	{
			 
		String output = "";
			 
		try
		{
			Connection con = connect();
			
			if (con == null)
			{
				return "Error while connecting to the database for updating.";
			}
			 
			// create a prepared statement
			String query = "UPDATE appointment SET date=?,time=?,patientID=?,doctorID=?,paymentID=?,appointmentStatus=? WHERE appointmentID=?";
			 
			PreparedStatement preparedStmt = con.prepareStatement(query);
			 
			// binding values
			preparedStmt.setString(1, date);
			preparedStmt.setString(2, time);
			preparedStmt.setString(3, patientID);
			preparedStmt.setString(4, doctorID);
			preparedStmt.setString(5, paymentID);
			preparedStmt.setString(6, appointmentStatus);
			preparedStmt.setInt(7, Integer.parseInt(appointmentID));
			 
			// execute the statement
			preparedStmt.execute();
			con.close();
			 
			String newItems = readAppointment();
			output = "{\"status\":\"success\", \"data\": \"" +
			newItems + "\"}";
			 
		}
		catch (Exception e)
		{
			output = "{\"status\":\"error\", \"data\": \"Error while updating the item.\"}";
			 
			System.err.println(e.getMessage());
		}
			
		return output;
			 
	} 
	
	public String deleteAppointment(String appointmentID)
	{
		String output = "";
	 
		try
		{
			Connection con = connect();
			
			if (con == null)
			{
				return "Error while connecting to the database for deleting.";
			} 
	
			// create a prepared statement
			String query = "delete from appointment where appointmentID=?";
			
			PreparedStatement preparedStmt = con.prepareStatement(query);
	 
			// binding values
			preparedStmt.setInt(1, Integer.parseInt(appointmentID));
	 
			// execute the statement
			preparedStmt.execute();
			con.close();
	
			String newItems = readAppointment();
			output = "{\"status\":\"success\", \"data\": \"" + 
			newItems + "\"}";
	 
		}
		catch (Exception e)
		{
			output = "{\"status\":\"error\", \"data\":\"Error while deleting the item.\"}";
			System.err.println(e.getMessage());
	 
		}
	 
		return output;
	 
	}
	


}
