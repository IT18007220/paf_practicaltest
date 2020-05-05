$(document).ready(function()
{
	$("#alertSuccess").hide();
	$("#alertError").hide();
});

//SAVE ============================================
$(document).on("click", "#btnSave", function(event)
{
	// Clear alerts---------------------
	$("#alertSuccess").text("");
	$("#alertSuccess").hide();
	$("#alertError").text("");
	$("#alertError").hide();

	// Form validation-------------------
	var status = validateAppointmentForm();
	if (status != true)
	{
		$("#alertError").text(status);
		$("#alertError").show();
		return;
	}

	// If valid------------------------
	var type = ($("#hidAppointmentSave").val() == "") ? "POST" : "PUT";

	$.ajax(
	{
		url : "AppointmentAPI",
		type : type,
		data : $("#formAppointment").serialize(),
		dataType : "text",
		complete : function(response, status)
		{
			 onAppointmentSaveComplete(response.responseText, status);
		}
	});
});

function onAppointmentSaveComplete(response, status)
{
	if (status == "success")
	{
		var resultSet = JSON.parse(response);
 
		if (resultSet.status.trim() == "success")
		{
			$("#alertSuccess").text("Successfully saved.");
			$("#alertSuccess").show();
			$("#divAppGrid").html(resultSet.data);
		} else if (resultSet.status.trim() == "error")
		{
			$("#alertError").text(resultSet.data);
			$("#alertError").show();
		}
	} else if (status == "error")
	{
		$("#alertError").text("Error while saving.");
		$("#alertError").show();
	} else
	{
		$("#alertError").text("Unknown error while saving..");
		$("#alertError").show();
	}
	$("#hidAppointmentSave").val("");
	$("#formAppointment")[0].reset();
}

//UPDATE==========================================
$(document).on("click", ".btnUpdate", function(event)
{
	$("#hidAppointmentSave").val($(this).closest("tr").find('#hidAppointmentUpdate').val());
	$("#date").val($(this).closest("tr").find('td:eq(0)').text());
	$("#time").val($(this).closest("tr").find('td:eq(1)').text());
	$("#patientID").val($(this).closest("tr").find('td:eq(2)').text());
	$("#doctorID").val($(this).closest("tr").find('td:eq(3)').text());
	$("#paymentID").val($(this).closest("tr").find('td:eq(4)').text());
	$("#appointmentStatus").val($(this).closest("tr").find('td:eq(5)').text());
}); 

//REMOVE==========================================
$(document).on("click", ".btnRemove", function(event)
		{
		 $.ajax(
		 {
		 url : "AppointmentAPI",
		 type : "DELETE",
		 data : "AppointmentID=" + $(this).data("appointment"),
		 dataType : "text",
		 complete : function(response, status)
		 {
		 onAppointmentDeleteComplete(response.responseText, status);
		 }
		 });
		});

function onAppointmentDeleteComplete(response, status)
{
	if (status == "success")
	{
		var resultSet = JSON.parse(response);
		if (resultSet.status.trim() == "success")
		{
			$("#alertSuccess").text("Successfully deleted.");
			$("#alertSuccess").show();
			$("#divAppGrid").html(resultSet.data);
		} else if (resultSet.status.trim() == "error")
		{
			$("#alertError").text(resultSet.data);
			$("#alertError").show();
		}
	} else if (status == "error")
	{
		$("#alertError").text("Error while deleting.");
		$("#alertError").show();
	} else
	{
		$("#alertError").text("Unknown error while deleting..");
		$("#alertError").show();
	}
}

//CLIENT-MODEL================================================================
function validateAppointmentForm()
{
	// DATE
	if ($("#date").val().trim() == "")
	{
		return "Insert date.";
	}
	// TIME
	if ($("#time").val().trim() == "")
	{
		return "Insert time.";
	}
	// PATIENT ID
	if ($("#patientID").val().trim() == "")
	{
		return "Insert Patient ID.";
	}
	//DOCTOR ID
	if ($("#doctorID").val().trim() == "")
	{
		return "Insert Doctor ID.";
	}
	//PAYMENT ID
	if ($("#paymentID").val().trim() == "")
	{
		return "Insert Payment ID.";
	}
	//APPOINTMENT STATUS
	if ($("#appointmentStatus").val().trim() == "")
	{
		return "Insert Appointment Status.";
	}
	return true;
}















