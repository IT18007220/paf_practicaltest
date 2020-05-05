<%@page import="com.Appointment"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Appointment Management</title>
		<link rel="stylesheet" href="Views/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script src="Components/Appointment.js"></script>
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
 					<input id="patientID" name="patientID" type="text" class="form-control form-control-sm"> <br> 
 					Doctor ID:
 					<input id="doctorID" name="doctorID" type="text" class="form-control form-control-sm"> <br>
 					Payment ID:
 					<input id="paymentID" name="paymentID" type="text" class="form-control form-control-sm"> <br>
 					Status:
 					<input id="appointmentStatus" name="appointmentStatus" type="text" class="form-control form-control-sm"> <br>
 					<input id="btnSave" name="btnSave" type="button" value="Save" class="btn btn-primary">
 					<input type="hidden" id="hidAppointmentSave" name="hidAppointmentSave" value="">
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