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
	var status = validateItemForm();
	if (status != true)
	{
		$("#alertError").text(status);
		$("#alertError").show();
		return;
	}

	// If valid------------------------
	var type = ($("#hidItemIDSave").val() == "") ? "POST" : "PUT";

	$.ajax(
	{
		url : "AppointmentAPI",
		type : type,
		data : $("#formItem").serialize(),
		dataType : "text",
		complete : function(response, status)
		{
			 onItemSaveComplete(response.responseText, status);
		}
	});
});

function onItemSaveComplete(response, status)
{
	if (status == "success")
	{
		var resultSet = JSON.parse(response);
 
		if (resultSet.status.trim() == "success")
		{
			$("#alertSuccess").text("Successfully saved.");
			$("#alertSuccess").show();
			$("#divItemsGrid").html(resultSet.data);
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
	$("#hidItemIDSave").val("");
	$("#formItem")[0].reset();
}

//UPDATE==========================================
$(document).on("click", ".btnUpdate", function(event)
{
	$("#hidItemIDSave").val($(this).closest("tr").find('#hidItemIDUpdate').val());
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
		 onItemDeleteComplete(response.responseText, status);
		 }
		 });
		});

function onItemDeleteComplete(response, status)
{
	if (status == "success")
	{
		var resultSet = JSON.parse(response);
		if (resultSet.status.trim() == "success")
		{
			$("#alertSuccess").text("Successfully deleted.");
			$("#alertSuccess").show();
			$("#divItemsGrid").html(resultSet.data);
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
function validateItemForm()
{
	// CODE
	if ($("#date").val().trim() == "")
	{
		return "Insert date.";
	}
	// NAME
	if ($("#time").val().trim() == "")
	{
		return "Insert time.";
	}
	// PRICE-------------------------------
	if ($("#patientID").val().trim() == "")
	{
		return "Insert Patient ID.";
	}
	// is numerical value
	//var tmpPrice = $("#itemPrice").val().trim();
	//if (!$.isNumeric(tmpPrice))
	//{
	//	return "Insert a numerical value for Item Price.";
	//}
	// convert to decimal price
	//$("#itemPrice").val(parseFloat(tmpPrice).toFixed(2));
	// DESCRIPTION------------------------
	if ($("#doctorID").val().trim() == "")
	{
		return "Insert Doctor ID.";
	}
	if ($("#paymentID").val().trim() == "")
	{
		return "Insert Payment ID.";
	}
	if ($("#appointmentStatus").val().trim() == "")
	{
		return "Insert Appointment Status.";
	}
	return true;
}















