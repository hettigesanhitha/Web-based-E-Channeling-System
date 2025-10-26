<%@page import="com.hms.entity.Doctor"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>User Appointment</title>
	<%@include file="component/allcss.jsp"%>

	<!-- Custom CSS for this page -->
	<style type="text/css">
		* {
			margin: 0;
			padding: 0;
			box-sizing: border-box;
		}

		body {
			font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', sans-serif;
			background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
			color: #2c3e50;
			min-height: 100vh;
			padding: 30px 20px;
		}

		.page-wrapper {
			max-width: 1400px;
			margin: 0 auto;
		}

		.page-header {
			margin-bottom: 40px;
		}

		.page-header h1 {
			font-size: 2.5rem;
			color: #1a5490;
			font-weight: 700;
			letter-spacing: -0.5px;
			margin-bottom: 10px;
			text-align: center;
		}

		.page-header p {
			color: #7f8c8d;
			font-size: 1rem;
			text-align: center;
		}

		.section {
			background: white;
			border-radius: 12px;
			box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07), 0 10px 20px rgba(0, 0, 0, 0.05);
			margin-bottom: 40px;
			padding: 0;
			overflow: hidden;
		}

		.section-header {
			background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
			color: white;
			padding: 25px 30px;
			text-align: center;
		}

		.section-header h2 {
			font-size: 1.5rem;
			font-weight: 600;
			letter-spacing: -0.3px;
			margin: 0;
		}

		.section-content {
			padding: 30px;
		}

		.form-group {
			margin-bottom: 20px;
		}

		.form-label {
			font-weight: 600;
			color: #2c3e50;
			font-size: 0.9rem;
			text-transform: uppercase;
			letter-spacing: 0.5px;
			margin-bottom: 8px;
			display: block;
		}

		.form-control,
		.form-select {
			width: 100%;
			padding: 10px 14px;
			border: 1px solid #e0e0e0;
			border-radius: 8px;
			font-size: 0.95rem;
			color: #2c3e50;
			background-color: #f8f9fa;
			transition: border-color 0.2s ease;
		}

		.form-control:focus,
		.form-select:focus {
			outline: none;
			border-color: #667eea;
			box-shadow: 0 0 5px rgba(102, 126, 234, 0.3);
		}

		.form-control::placeholder,
		.form-select:invalid {
			color: #95a5a6;
		}

		.btn-submit {
			background-color: #667eea;
			color: white;
			padding: 12px 20px;
			border: none;
			border-radius: 20px;
			font-weight: 600;
			font-size: 0.95rem;
			width: 100%;
			transition: background-color 0.2s ease;
		}

		.btn-submit:hover {
			background-color: #5a6cd6;
		}

		.btn-primary {
			background-color: #007bff;
			color: white;
			padding: 12px 20px;
			border: none;
			border-radius: 20px;
			font-weight: 600;
			font-size: 0.95rem;
			width: 100%;
			transition: background-color 0.2s ease;
		}

		.btn-primary:hover {
			background-color: #0056b3;
		}

		.message-success {
			display: inline-block;
			padding: 10px 20px;
			border-radius: 20px;
			font-weight: 600;
			font-size: 1rem;
			background-color: #d4edda;
			color: #155724;
			margin-bottom: 20px;
			text-align: center;
			width: 100%;
		}

		.message-error {
			display: inline-block;
			padding: 10px 20px;
			border-radius: 20px;
			font-weight: 600;
			font-size: 1rem;
			background-color: #f8d7da;
			color: #721c24;
			margin-bottom: 20px;
			text-align: center;
			width: 100%;
		}

		.appointment-image {
			width: 100%;
			height: auto;
			max-height: 400px;
			object-fit: cover;
			border-radius: 8px;
		}

		@media (max-width: 768px) {
			.page-header h1 {
				font-size: 1.8rem;
			}

			.section-content {
				padding: 20px;
			}

			.form-control,
			.form-select {
				font-size: 0.85rem;
				padding: 8px 12px;
			}

			.form-label {
				font-size: 0.8rem;
			}

			.btn-submit,
			.btn-primary {
				font-size: 0.9rem;
				padding: 10px 16px;
			}

			.appointment-image {
				max-height: 300px;
				margin-bottom: 20px;
			}
		}
	</style>
	<!-- End of custom CSS -->
</head>
<body>
<%@include file="component/navbar.jsp"%>

<div class="page-wrapper">
	<!-- Page Header -->
	<div class="page-header">
		<h1>📅 Book an Appointment</h1>
		<p>Schedule your visit with our healthcare professionals</p>
	</div>

	<!-- Appointment Form Section -->
	<div class="section">
		<div class="section-header">
			<h2>🩺 User Appointment</h2>
		</div>
		<div class="section-content">
			<div class="row">
				<div class="col-md-6 mb-4 mb-md-0">
					<img src="img/doc3.jpg" alt="Doctor Image" class="appointment-image">
				</div>
				<div class="col-md-6">
					<!-- Messages -->
					<c:if test="${not empty successMsg }">
						<div class="message-success">${successMsg}</div>
						<c:remove var="successMsg" scope="session" />
					</c:if>
					<c:if test="${not empty errorMsg }">
						<div class="message-error">${errorMsg}</div>
						<c:remove var="errorMsg" scope="session" />
					</c:if>

					<!-- Form -->
					<form class="row g-3" action="addAppointment" method="post" id="appointmentForm">
						<input type="hidden" name="userId" value="${ userObj.id }">

						<div class="col-md-6">
							<div class="form-group">
								<label class="form-label">Full Name</label>
								<input required name="fullName" type="text" placeholder="Enter full name" class="form-control" maxlength="50" pattern="[A-Za-z\s]+" title="Full name can only contain letters and spaces, max 50 characters">
							</div>
						</div>

						<div class="col-md-6">
							<div class="form-group">
								<label class="form-label">Gender</label>
								<select class="form-select" name="gender" required>
									<option selected disabled>---Select Gender---</option>
									<option value="male">Male</option>
									<option value="female">Female</option>
								</select>
							</div>
						</div>

						<div class="col-md-6">
							<div class="form-group">
								<label class="form-label">Age</label>
								<input required name="age" type="number" placeholder="Enter your Age" class="form-control" min="0" max="120" title="Age must be between 0 and 120">
							</div>
						</div>

						<div class="col-md-6">
							<div class="form-group">
								<label class="form-label">Appointment Date</label>
								<input required name="appointmentDate" type="date" class="form-control" id="appointmentDate">
							</div>
						</div>

						<div class="col-md-6">
							<div class="form-group">
								<label class="form-label">Email</label>
								<input required name="email" type="email" placeholder="Enter email" class="form-control" maxlength="50" title="Enter a valid email address, max 50 characters">
							</div>
						</div>

						<div class="col-md-6">
							<div class="form-group">
								<label class="form-label">Phone</label>
								<input required name="phone" type="text" placeholder="Enter Mobile no." class="form-control" pattern="\d{10,11}" title="Phone must be 10-11 digits">
							</div>
						</div>

						<div class="col-md-6">
							<div class="form-group">
								<label class="form-label">Diseases</label>
								<input required name="diseases" type="text" placeholder="Enter diseases" class="form-control" maxlength="50" title="Max 50 characters">
							</div>
						</div>

						<div class="col-md-6">
							<div class="form-group">
								<label class="form-label">Doctor</label>
								<select required class="form-select" name="doctorNameSelect">
									<option selected disabled>---Select---</option>
									<%
										DoctorDAO doctorDAO = new DoctorDAO(DBConnection.getConn());
										List<Doctor> listOfDoctor = doctorDAO.getAllDoctor();
										for(Doctor d : listOfDoctor){
									%>
									<option value="<%= d.getId() %>"><%= d.getFullName() %> (<%= d.getSpecialist() %>)</option>
									<% } %>
								</select>
							</div>
						</div>

						<!-- View Doctors Button -->
						<div class="col-md-12">
							<div class="form-group">
								<a href="${pageContext.request.contextPath}/admin/view_doctor3.jsp" class="btn btn-primary w-100">View Doctors</a>
							</div>
						</div>

						<div class="col-md-12">
							<div class="form-group">
								<label class="form-label">Full Address</label>
								<textarea name="address" required class="form-control" rows="3" maxlength="250" title="Max 250 characters"></textarea>
							</div>
						</div>

						<div class="col-md-12">
							<button type="submit" class="btn-submit">Submit</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	const today = new Date().toISOString().split('T')[0];
	document.getElementById('appointmentDate').setAttribute('min', today);

	document.getElementById('appointmentForm').addEventListener('submit', function(e){
		if(!this.checkValidity()){
			alert("Please fill all fields correctly.");
			e.preventDefault();
		}
	});
</script>

<%@include file="component/footer.jsp"%>
</body>
</html>