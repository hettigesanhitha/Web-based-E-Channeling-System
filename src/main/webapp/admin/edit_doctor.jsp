<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="com.hms.entity.Specialist"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.SpecialistDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Edit Doctor</title>
	<%@include file="../component/allcss.jsp"%>

	<style type="text/css">
		.my-card {
			box-shadow: 0px 0px 10px 1px maroon;
		}
		.error-msg {
			color: red;
			font-size: 0.8em;
			margin-top: 5px;
		}
	</style>
</head>
<body>
<%@include file="navbar.jsp"%>


<div class="container-fluid p-3">
	<div class="row">
		<div class="col-md-4 offset-4">
			<div class="card my-card">
				<div class="card-body">
					<p class="fs-3 text-center text-danger">Edit Doctor Details</p>

					<c:if test="${not empty successMsg }">
						<p class="text-center text-success fs-3">${successMsg}</p>
						<c:remove var="successMsg" scope="session" />
					</c:if>

					<c:if test="${not empty errorMsg }">
						<p class="text-center text-danger fs-3">${errorMsg}</p>
						<c:remove var="errorMsg" scope="session" />
					</c:if>
					<%
						//get specific doctor id with the help of request.getParameter()
						int id = Integer.parseInt(request.getParameter("id"));
						DoctorDAO docDAO = new DoctorDAO(DBConnection.getConn());
						Doctor doctor = docDAO.getDoctorById(id);
					%>

					<form id="editDoctorForm" action="../updateDoctor" method="post">
						<div class="mb-3">
							<label class="form-label">Full Name</label>
							<input id="fullName" name="fullName" type="text" placeholder="Enter full name"
								   class="form-control" value="<%=doctor.getFullName()%>">
							<div id="fullNameError" class="error-msg"></div>
						</div>
						<div class="mb-3">
							<label class="form-label">Date of Birth</label>
							<input id="dateOfBirth" name="dateOfBirth" type="date" placeholder="Enter DOB"
								   class="form-control" value="<%=doctor.getDateOfBirth()%>">
							<div id="dateOfBirthError" class="error-msg"></div>
						</div>
						<div class="mb-3">
							<label class="form-label">Qualification</label>
							<input id="qualification" name="qualification" type="text"
								   placeholder="Enter qualification" class="form-control"
								   value="<%=doctor.getQualification()%>">
							<div id="qualificationError" class="error-msg"></div>
						</div>

						<div class="mb-3">
							<label class="form-label">Specialist</label>
							<select id="specialist" class="form-control" name="specialist">
								<option value="<%=doctor.getSpecialist()%>"><%=doctor.getSpecialist()%></option>

								<%
									SpecialistDAO spDAO = new SpecialistDAO(DBConnection.getConn());
									List<Specialist> spList = spDAO.getAllSpecialist();
									for (Specialist sp : spList) {
										// Exclude the currently selected specialist from the list if it appears as a duplicate
										if (!sp.getSpecialistName().equals(doctor.getSpecialist())) {
								%>
								<option value="<%=sp.getSpecialistName()%>">
									<%=sp.getSpecialistName()%>
								</option>
								<%
										}
									}
								%>

							</select>
							<div id="specialistError" class="error-msg"></div>
						</div>

						<div class="mb-3">
							<label class="form-label">Email address</label>
							<input id="email" name="email" type="email" placeholder="Enter Email"
								   class="form-control" value="<%=doctor.getEmail()%>">
							<div id="emailError" class="error-msg"></div>
						</div>
						<div class="mb-3">
							<label class="form-label">Phone</label>
							<input id="phone" name="phone"
								   type="text" placeholder="Enter mobile number"
								   class="form-control" value="<%=doctor.getPhone()%>">
							<div id="phoneError" class="error-msg"></div>
						</div>
						<div class="mb-3">
							<label class="form-label">Password</label>
							<input id="password" name="password" type="text" placeholder="Enter password"
								   class="form-control" value="<%=doctor.getPassword()%>">
							<div id="passwordError" class="error-msg"></div>
						</div>

						<div class="mb-3">
							<input name="id" type="hidden" class="form-control"
								   value="<%=doctor.getId()%>">
						</div>

						<button type="submit" class="btn btn-danger text-white col-md-12">Update</button>
					</form>
				</div>

			</div>
		</div>

	</div>
</div>


<script type="text/javascript">
	document.getElementById('editDoctorForm').addEventListener('submit', function(e) {
		let valid = true;

		// Helper function to show/hide errors
		const setError = (id, message) => {
			const errorElement = document.getElementById(id + 'Error');
			if (message) {
				errorElement.textContent = message;
				valid = false;
			} else {
				errorElement.textContent = '';
			}
		};

		// 1. Full Name Validation
		const fullName = document.getElementById('fullName').value.trim();
		if (fullName === "") {
			setError('fullName', 'Full Name is required.');
		} else if (fullName.length < 3 || fullName.length > 50) {
			setError('fullName', 'Name must be between 3 and 50 characters.');
		} else if (!/^[A-Za-z\s.]+$/.test(fullName)) {
			setError('fullName', 'Name can only contain letters, spaces, and dots.');
		} else {
			setError('fullName', '');
		}

		// 2. Date of Birth Validation
		const dateOfBirth = document.getElementById('dateOfBirth').value.trim();
		if (dateOfBirth === "") {
			setError('dateOfBirth', 'Date of Birth is required.');
		} else {
			setError('dateOfBirth', '');
		}

		// 3. Qualification Validation
		const qualification = document.getElementById('qualification').value.trim();
		if (qualification === "") {
			setError('qualification', 'Qualification is required.');
		} else if (qualification.length > 100) {
			setError('qualification', 'Qualification cannot exceed 100 characters.');
		} else {
			setError('qualification', '');
		}

		// 4. Specialist Validation
		const specialist = document.getElementById('specialist').value;
		if (specialist === "") { // Assuming the initial option has an empty value if no doctor is selected
			setError('specialist', 'Please select a specialist.');
		} else {
			setError('specialist', '');
		}

		// 5. Email Validation
		const email = document.getElementById('email').value.trim();
		const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
		if (email === "") {
			setError('email', 'Email is required.');
		} else if (!emailPattern.test(email)) {
			setError('email', 'Enter a valid email address.');
		} else {
			setError('email', '');
		}

		// 6. Phone Validation
		const phone = document.getElementById('phone').value.trim();
		const phonePattern = /^\d{10}$/; // Assumes a 10-digit phone number
		if (phone === "") {
			setError('phone', 'Phone number is required.');
		} else if (!phonePattern.test(phone)) {
			setError('phone', 'Phone number must be exactly 10 digits.');
		} else {
			setError('phone', '');
		}

		// 7. Password Validation
		const password = document.getElementById('password').value.trim();
		if (password === "") {
			setError('password', 'Password is required.');
		} else if (password.length < 6 || password.length > 20) {
			setError('password', 'Password must be between 6 and 20 characters.');
		} else {
			setError('password', '');
		}

		// Prevent form submission if not valid
		if (!valid) {
			e.preventDefault();
			alert('Please correct the highlighted errors before updating.');
		}
	});
</script>


</body>
</html>