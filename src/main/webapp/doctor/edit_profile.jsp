<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.entity.Specialist"%>
<%@page import="com.hms.dao.SpecialistDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- for jstl tag -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Edit Doctor Profile | Doctor</title>
	<%@include file="../component/allcss.jsp"%>

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
		}

		.page-header p {
			color: #7f8c8d;
			font-size: 1rem;
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

		.form-control {
			width: 100%;
			padding: 10px 14px;
			border: 1px solid #e0e0e0;
			border-radius: 8px;
			font-size: 0.95rem;
			color: #2c3e50;
			background-color: #f8f9fa;
			transition: border-color 0.2s ease;
		}

		.form-control[readonly] {
			background-color: #e9ecef;
			cursor: not-allowed;
		}

		.form-control:focus {
			outline: none;
			border-color: #667eea;
			box-shadow: 0 0 5px rgba(102, 126, 234, 0.3);
		}

		.form-control::placeholder {
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

		.btn-delete {
			background-color: #dc3545;
			color: white;
			padding: 12px 20px;
			border: none;
			border-radius: 20px;
			font-weight: 600;
			font-size: 0.95rem;
			width: 100%;
			transition: background-color 0.2s ease;
		}

		.btn-delete:hover {
			background-color: #c82333;
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

		@media (max-width: 768px) {
			.page-header h1 {
				font-size: 1.8rem;
			}

			.section-content {
				padding: 20px;
			}

			.form-control {
				font-size: 0.85rem;
				padding: 8px 12px;
			}

			.form-label {
				font-size: 0.8rem;
			}

			.btn-submit, .btn-delete {
				font-size: 0.9rem;
				padding: 10px 16px;
			}
		}
	</style>
	<!-- End of custom CSS -->
</head>
<body>
<%@include file="navbar.jsp"%>

<c:if test="${empty doctorObj }">
	<c:redirect url="../doctor_login.jsp"></c:redirect>
</c:if>

<div class="page-wrapper">
	<!-- Page Header -->
	<div class="page-header">
		<h1>🩺 Edit Doctor Profile</h1>
		<p>Update your profile details or change your password</p>
	</div>

	<!-- Change Password Section -->
	<div class="section">
		<div class="section-header">
			<h2>🔒 Change Password</h2>
		</div>
		<div class="section-content">
			<!-- Message print -->
			<c:if test="${not empty successMsg }">
				<div class="message-success">${successMsg}</div>
				<c:remove var="successMsg" scope="session" />
			</c:if>
			<c:if test="${not empty errorMsg }">
				<div class="message-error">${errorMsg}</div>
				<c:remove var="errorMsg" scope="session" />
			</c:if>
			<!-- End of message print -->

			<!-- Change Password Form -->
			<form action="../doctorChangePassword" method="post">
				<div class="form-group">
					<label class="form-label">Enter New Password</label>
					<input name="newPassword" type="password" placeholder="Enter new password" class="form-control" required>
				</div>
				<div class="form-group">
					<label class="form-label">Enter Old Password</label>
					<input name="oldPassword" type="password" placeholder="Enter old password" class="form-control" required>
				</div>
				<input type="hidden" value="${doctorObj.id}" name="doctorId">
				<button type="submit" class="btn-submit">Change Password</button>
			</form>

			<!-- Delete Account Form -->
			<form action="../doctorDelete" method="post" onsubmit="return confirm('Are you sure you want to delete your account? This action cannot be undone.');" style="margin-top: 20px;">
				<input type="hidden" value="${doctorObj.id}" name="doctorId">
				<button type="submit" class="btn-delete">Delete Account</button>
			</form>
		</div>
	</div>

	<!-- Edit Profile Section -->
	<div class="section">
		<div class="section-header">
			<h2>📝 Edit Profile</h2>
		</div>
		<div class="section-content">
			<!-- Message print -->
			<c:if test="${not empty successMsgForD }">
				<div class="message-success">${successMsgForD}</div>
				<c:remove var="successMsgForD" scope="session" />
			</c:if>
			<c:if test="${not empty errorMsgForD }">
				<div class="message-error">${errorMsgForD}</div>
				<c:remove var="errorMsgForD" scope="session" />
			</c:if>
			<!-- End of message print -->

			<!-- Edit Profile Form -->
			<form action="../doctorEditProfile" method="post">
				<div class="form-group">
					<label class="form-label">Full Name</label>
					<input name="fullName" type="text" placeholder="Enter full name" class="form-control" value="${doctorObj.fullName}">
				</div>
				<div class="form-group">
					<label class="form-label">Date of Birth</label>
					<input name="dateOfBirth" type="date" placeholder="Enter DOB" class="form-control" value="${doctorObj.dateOfBirth}">
				</div>
				<div class="form-group">
					<label class="form-label">Qualification</label>
					<input name="qualification" type="text" placeholder="Enter qualification" class="form-control" value="${doctorObj.qualification}">
				</div>
				<div class="form-group">
					<label class="form-label">Specialist</label>
					<select class="form-control" name="specialist">
						<option>${doctorObj.specialist}</option>
						<%
							SpecialistDAO spDAO = new SpecialistDAO(DBConnection.getConn());
							List<Specialist> spList = spDAO.getAllSpecialist();
							for (Specialist sp : spList) {
						%>
						<option><%= sp.getSpecialistName() %></option>
						<%
							}
						%>
					</select>
				</div>
				<div class="form-group">
					<label class="form-label">Email address</label>
					<input name="email" type="email" placeholder="Enter Email" class="form-control" readonly value="${doctorObj.email}">
				</div>
				<div class="form-group">
					<label class="form-label">Phone</label>
					<input name="phone" type="text" placeholder="Enter mobile number" class="form-control" value="${doctorObj.phone}">
				</div>
				<input type="hidden" value="${doctorObj.id}" name="doctorId">
				<button type="submit" class="btn-submit">Update</button>
			</form>
		</div>
	</div>
</div>
<%@include file="/component/footer.jsp"%>
</body>
</html>