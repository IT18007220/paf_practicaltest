package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.Date;
import util.dbconnect;

import org.apache.tomcat.jni.Time;

import util.dbconnect;

public class Appointment {

	dbconnect obj = new dbconnect();

	// Inserting Appointments
	public String insertAppoinment(String date, String time, int patId, int doctorID, int payId) {
		String output = "";
		try {
			Connection con = obj.connect();
			if (con == null) {
				return "Error while connecting to the database for inserting.";
			}
			String query = "INSERT INTO appointment (`date`, `time`,`patientID`, `doctorID`,`paymentID`)  VALUES (?, ?, ?, ?, ?)";
			PreparedStatement preparedStmt = con.prepareStatement(query);

			preparedStmt.setString(1, date);
			preparedStmt.setString(2, time);
			preparedStmt.setInt(3, patId);
			preparedStmt.setInt(4, doctorID);
			preparedStmt.setInt(5, payId);

			preparedStmt.execute();
			con.close();
			output = "Inserted successfully";

		} catch (Exception e) {
			output = "Error while inserting the Appoinment.";
			System.err.println(e.getMessage());
		}
		return output;
	}

	// View Appointment details by passing the appointment ID
	public String GetSAppointments(String appointmentID) {
		String output = "";

		try {
			Connection con = obj.connect();
			if (con == null) {
				return "Error while connecting to the database for Get Appointments.";
			}

			output = "<table border=\"1\"><tr><th>Appointment ID</th><th>Date</th><th>Time</th>"
					+ "<th>patientID</th><th>doctorID</th><th>paymentID </th><th>Status</th></tr>";
			String query = "select * from appointment where appointmentID="+appointmentID;
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);

		

			while (rs.next()) {
				String AppID = Integer.toString(rs.getInt("appointmentID"));
				String date = rs.getString("date");
				String time = rs.getString("time");
				String patientID = rs.getString("patientID");
				String doctorID = rs.getString("doctorID");
				String paymentID = Integer.toString(rs.getInt("paymentID"));
				String Status = rs.getString("appointmentStatus");

				output += "<tr><td>" + AppID + "</td>";
				output += "<td>" + date + "</td>";
				output += "<td>" + time + "</td>";
				output += "<td>" + patientID + "</td>";
				output += "<td>" + doctorID + "</td>";
				output += "<td>" + paymentID + "</td>";
				output += "<td>" + Status + "</td>";
			}

			con.close();
			output += "</table>";
			return output;
		} catch (Exception e) {
			output = "Error while GetAll Appointments.";
	
			System.err.println(e.getMessage());
		}
		return output;
	}
	
	
	
	//View appointment details
	public String GetAllAppoinments() {
		String output = "";

		try {
			Connection con = obj.connect();
			if (con == null) {
				return "Error while connecting to the database for GetAll Appointments.";
			}

			output = "<table border=\"1\"><tr><th>Appointment ID</th><th>Date</th><th>Time</th>"
					+ "<th>patientID</th><th>doctorID</th><th>paymentID </th><th>Status</th></tr>";
			String query = "select * from appointment";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);

		

			while (rs.next()) {
				String AppID = Integer.toString(rs.getInt("appointmentID"));
				String date = rs.getString("date");
				String time = rs.getString("time");
				String patientID = rs.getString("patientID");
				String doctorID = rs.getString("doctorID");
				String paymentID = Integer.toString(rs.getInt("paymentID"));
				String Status = rs.getString("appointmentStatus");

				output += "<tr><td>" + AppID + "</td>";
				output += "<td>" + date + "</td>";
				output += "<td>" + time + "</td>";
				output += "<td>" + patientID + "</td>";
				output += "<td>" + doctorID + "</td>";
				output += "<td>" + paymentID + "</td>";
				output += "<td>" + Status + "</td>";
			}

			con.close();
			output += "</table>";
			return output;
		} catch (Exception e) {
			output = "Error while GetAll Appointments.";
	
			System.err.println(e.getMessage());
		}
		return output;
	}


	// update Appointments
	public String updateAppoinment(String appointmentID, String date, String time, String patientID, String doctorID,
			String paymentID, String appointmentStatus) {
		String output = "";
		try {
			Connection con = obj.connect();
			if (con == null) {
				return "Error while connecting to the database for updating.";
			}
			String query = "UPDATE appointment SET date = ? ,time=?,patientID=?,doctorID=?,paymentID=?,appointmentStatus=? WHERE appointmentID=?";
			PreparedStatement preparedStmt = con.prepareStatement(query);

			// binding values
			preparedStmt.setString(1, date);
			preparedStmt.setString(2, time);
			preparedStmt.setInt(3, Integer.parseInt(patientID));
			preparedStmt.setInt(4, Integer.parseInt(doctorID));
			preparedStmt.setInt(5, Integer.parseInt(paymentID));
			preparedStmt.setString(6, appointmentStatus);
			preparedStmt.setInt(7, Integer.parseInt(appointmentID));
			preparedStmt.execute();
			con.close();
			output = "Updated successfully";
		} catch (Exception e) {
			output = "Error while Updating the item.";
			System.err.println(e.getMessage());
		}
		return output;
	}

	// Delete Appointment
	public String DeleteAppoinment(String appointmentID) {
		String output = "";
		try {
			Connection con = obj.connect();
			if (con == null) {
				return "Error while connecting to the database for Deleting.";
			}
			String query = "delete from appointment where appointmentID=?";
			PreparedStatement preparedStmt = con.prepareStatement(query);
			preparedStmt.setInt(1, Integer.parseInt(appointmentID));
			preparedStmt.execute();
			con.close();
			output = "Deleted successfully";
		} catch (Exception e) {
			output = "Error while deleting the Appointment.";
			System.err.println(e.getMessage());
		}
		return output;
	}

}
