<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.protocol.Resultset"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.Appointment"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@page import="util.dbconnect" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Appointment Management</title>
		<link rel="stylesheet" href="Views/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script src="Components/Appointment.js"></script>
		
<%
	Class.forName("com.mysql.jdbc.Driver");

	dbconnect con = new dbconnect();

	//Connection connection = con.connect();
	Connection connection = con.connect();
	
	String query1 = "SELECT Doctor_ID,D_Name from hospital_docters";	
	Statement stmt1 = connection.createStatement();
	ResultSet rs1 = stmt1.executeQuery(query1);


%>
	</head>
	<body>
		<div class="container">
			<div class="row">
				<div class="col-6">
					<h1>Appointment Management</h1>
					<form id="formAppointment" name="formAppointment">
 					Date:
 					<input id="date" name="date" type="date" class="form-control form-control-sm"> <br> 
 					Time:
 					<input id="time" name="time" type="time" class="form-control form-control-sm"> <br> 
 					Patient ID:
 					<input id="patientID" name="patientID" type="number" class="form-control form-control-sm"> <br> 
 					Doctor ID:
<!--  					<input id="doctorID" name="doctorID" type="text" class="form-control form-control-sm"> <br> -->
					<select
								class="form-control select2" id="doctorID" name="doctorID">
								<%
									while (rs1.next()) {
								%>
								<option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option>
								<%
									}
								%>
							</select> <br>
 					Payment ID:
 					<input id="paymentID" name="paymentID" type="number" class="form-control form-control-sm"> <br>
					
						
 					Status:
 					<!--  <input id="appointmentStatus" name="appointmentStatus" type="text" class="form-control form-control-sm">-->
 					<select id="appointmentStatus" name="appointmentStatus" class="form-control form-control-sm">
 						<option value="pending">pending</option>
 						<option value="confirmed">confirmed</option>
 						<option value="cancelled">cancelled</option>
 					
 					</select>
 					<br>
 					 <br>
 					<input id="btnSave" name="btnSave" type="button" value="Save" class="btn btn-primary">
 					<input type="hidden" id="hidAppointmentSave" name="hidAppointmentSave" value="">
 					<br>
					</form>
					<div id="alertSuccess" class="alert alert-success"></div>
					<div id="alertError" class="alert alert-danger"></div>
					<br>
						<div id="divAppGrid">
							 <%
							Appointment AppObj = new Appointment();
							 out.print(AppObj.readAppointment());
							 %>
						</div>
				</div>
 			</div>
		</div>

	</body>
</html>