<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page import="com.AppointmentServices" %>
	<%@ page import="model.Appointment" %>
	
	<% 
		//Save---------------------------------
		if (request.getParameter("date") != null) {
			Appointment App = new Appointment();
			String stsMsg = "";
			//Insert------------------------------
			if (request.getParameter("AppointmentIDsave") == "") {
				stsMsg = App.insertAppoinment(request.getParameter("date"),
						request.getParameter("time"), 
						request.getParameter("patientID"), 
						request.getParameter("doctorID"), 
						request.getParameter("paymentID")); 
						
				
			} else//Update----------------------
			{
				stsMsg = App.updateAppoinment(request.getParameter("AppointmentIDsave"),
								request.getParameter("date"),
								request.getParameter("time"), 
								request.getParameter("patientID"),
								request.getParameter("doctorID"), 
								request.getParameter("appointmentStatus"),
								request.getParameter("paymentID")); 
								
			}
			session.setAttribute("statusMsg", stsMsg);
		}
		//Delete-------------------------------------------
		if (request.getParameter("hidAppointmentIDDelete") != null) {
			Appointment App = new Appointment();
			String
			stsMsg = App.DeleteAppoinment(request.getParameter("hidAppointmentIDDelete"));
			session.setAttribute("statusMsg", stsMsg);
		}
	%>
	
	
	
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Appointment Handling</title>
 <link rel="stylesheet" href="Views/bootstrap.min.css">
  
</head>
<body>


	<form id="formAppointment" name="formAppointment" method="post" action="Appointment.jsp">
		Date: <input id="date" name="date" type="text"
			class="form-control form-control-sm" required> <br> 
			
		Time: <input id="time" name="time" type="text"
			class="form-control form-control-sm" required> <br> 
			
		Patient ID: <input id="patientID" name="patientID" type="text"
			class="form-control form-control-sm" required> <br> 
			
		Doctor ID: <input id="doctorID" name="doctorID" type="text"
			class="form-control form-control-sm" required> <br> 
			
		Status: <input id="appointmentStatus" name="appointmentStatus" type="text"
			class="form-control form-control-sm" required> <br>	
			
		Payment ID: <input id="paymentID" name="paymentID" type="text"
			class="form-control form-control-sm" required> <br>	
			
		
			
			<input id="btnSave" name="btnSave" type="submit" value="Save" class="btn btn-primary"> 
			
			<input type="hidden" id="AppointmentIDsave" name="AppointmentIDsave" value="">
	</form>
	
	
	<div id"alertSuccess" class="alert alert-success">
		<%
		out.print(session.getAttribute("statusMsg"));
		%>
		</div>
	
	
	

	<% 
	     Appointment App=new Appointment();
	     out.print(App.GetAllAppoinments());
	     %>
	     
	     
	     <br><br>
	     
	     
	    
	     
	     
	     
	     
</body>
</html>