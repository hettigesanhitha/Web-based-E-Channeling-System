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
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Doctor Registration</title>
	<%@include file="../component/allcss.jsp"%>

	<style type="text/css">
		* {
			margin: 0;
			padding: 0;
			box-sizing: border-box;
		}

		body {
			font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', sans-serif;
			background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
			min-height: 100vh;
			display: flex;
			flex-direction: column;
		}

		.page-content {
			flex: 1;
			padding: 40px 20px;
		}

		.registration-container {
			max-width: 600px;
			margin: 0 auto;
		}

		.registration-card {
			background: white;
			border-radius: 12px;
			box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
			overflow: hidden;
			animation: slideIn 0.5s ease-out;
		}

		@keyframes slideIn {
			from {
				opacity: 0;
				transform: translateY(20px);
			}
			to {
				opacity: 1;
				transform: translateY(0);
			}
		}

		.card-header {
			background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
			padding: 30px;
			text-align: center;
		}

		.card-header h1 {
			color: white;
			font-size: 2rem;
			font-weight: 600;
			margin-bottom: 8px;
			letter-spacing: -0.5px;
		}

		.card-header p {
			color: rgba(255, 255, 255, 0.9);
			font-size: 0.95rem;
		}

		.card-body {
			padding: 40px;
		}

		.alert {
			padding: 14px 18px;
			border-radius: 8px;
			margin-bottom: 25px;
			font-weight: 500;
			animation: slideIn 0.3s ease-out;
		}

		.alert-success {
			background-color: #d4edda;
			color: #155724;
			border: 1px solid #c3e6cb;
		}

		.alert-danger {
			background-color: #f8d7da;
			color: #721c24;
			border: 1px solid #f5c6cb;
		}

		.form-group {
			margin-bottom: 22px;
		}

		.form-group label {
			display: block;
			font-weight: 600;
			color: #2c3e50;
			margin-bottom: 8px;
			font-size: 0.95rem;
			letter-spacing: 0.3px;
		}

		.form-group input,
		.form-group select {
			width: 100%;
			padding: 12px 16px;
			border: 2px solid #e0e0e0;
			border-radius: 8px;
			font-size: 1rem;
			font-family: inherit;
			transition: all 0.3s ease;
			background-color: #fafafa;
		}

		.form-group input:focus,
		.form-group select:focus {
			outline: none;
			background-color: white;
			border-color: #667eea;
			box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
		}

		.form-group input::placeholder {
			color: #95a5a6;
		}

		.form-group select option {
			padding: 8px;
		}

		.form-group select option:first-child {
			color: #95a5a6;
		}

		.btn-submit {
			width: 100%;
			padding: 14px 24px;
			background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
			color: white;
			border: none;
			border-radius: 8px;
			font-size: 1.05rem;
			font-weight: 600;
			cursor: pointer;
			transition: all 0.3s ease;
			text-transform: uppercase;
			letter-spacing: 1px;
			margin-top: 10px;
		}

		.btn-submit:hover {
			transform: translateY(-2px);
			box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
		}

		.btn-submit:active {
			transform: translateY(0);
		}

		.form-divider {
			display: flex;
			align-items: center;
			margin: 30px 0;
		}

		.form-divider::before,
		.form-divider::after {
			content: '';
			flex: 1;
			height: 1px;
			background: #e0e0e0;
		}

		.form-divider-text {
			padding: 0 15px;
			color: #95a5a6;
			font-size: 0.9rem;
			font-weight: 500;
		}

		.form-row {
			display: grid;
			grid-template-columns: 1fr 1fr;
			gap: 16px;
		}

		.form-row.full {
			grid-template-columns: 1fr;
		}

		@media (max-width: 600px) {
			.page-content {
				padding: 20px;
			}

			.card-body {
				padding: 25px;
			}

			.card-header h1 {
				font-size: 1.5rem;
			}

			.form-row {
				grid-template-columns: 1fr;
			}
		}
	</style>
</head>
<body>
<%@include file="navbar.jsp"%>

<div class="page-content">
	<div class="registration-container">
		<div class="registration-card">
			<div class="card-header">
				<h1>👨‍⚕️ Doctor Registration</h1>
				<p>Register a new doctor to the system</p>
			</div>

			<div class="card-body">
				<!-- Success Message -->
				<c:if test="${not empty successMsg}">
					<div class="alert alert-success">
						✓ ${successMsg}
					</div>
					<c:remove var="successMsg" scope="session" />
				</c:if>

				<!-- Error Message -->
				<c:if test="${not empty errorMsg}">
					<div class="alert alert-danger">
						✕ ${errorMsg}
					</div>
					<c:remove var="errorMsg" scope="session" />
				</c:if>

				<!-- Registration Form -->
				<form action="../addDoctor" method="post" novalidate>
					<!-- Personal Information -->
					<div class="form-row full">
						<div class="form-group">
							<label for="fullName">Full Name *</label>
							<input type="text" id="fullName" name="fullName"
								   placeholder="Enter your full name" required>
						</div>
					</div>

					<div class="form-row">
						<div class="form-group">
							<label for="dateOfBirth">Date of Birth *</label>
							<input type="date" id="dateOfBirth" name="dateOfBirth" required>
						</div>
						<div class="form-group">
							<label for="qualification">Qualification *</label>
							<input type="text" id="qualification" name="qualification"
								   placeholder="e.g., MBBS, MD" required>
						</div>
					</div>

					<!-- Professional Information -->
					<div class="form-divider">
						<span class="form-divider-text">Professional Details</span>
					</div>

					<div class="form-group">
						<label for="specialist">Specialist *</label>
						<select id="specialist" name="specialist" required>
							<option value="" disabled selected>--- Select Specialization ---</option>
							<%
								SpecialistDAO spDAO = new SpecialistDAO(DBConnection.getConn());
								List<Specialist> spList = spDAO.getAllSpecialist();
								for (Specialist sp : spList) {
							%>
							<option value="<%= sp.getSpecialistName() %>">
								<%= sp.getSpecialistName() %>
							</option>
							<%
								}
							%>
						</select>
					</div>

					<!-- Contact Information -->
					<div class="form-divider">
						<span class="form-divider-text">Contact & Access</span>
					</div>

					<div class="form-row">
						<div class="form-group">
							<label for="email">Email Address *</label>
							<input type="email" id="email" name="email"
								   placeholder="Enter email address" required>
						</div>
						<div class="form-group">
							<label for="phone">Phone Number *</label>
							<input type="tel" id="phone" name="phone"
								   placeholder="Enter phone number" required>
						</div>
					</div>

					<div class="form-group">
						<label for="password">Password *</label>
						<input type="password" id="password" name="password"
							   placeholder="Enter a secure password" required>
					</div>

					<button type="submit" class="btn-submit">Complete Registration</button>
				</form>
			</div>
		</div>
	</div>
</div>
<%@include file="/component/footer.jsp"%>

</body>
</html>