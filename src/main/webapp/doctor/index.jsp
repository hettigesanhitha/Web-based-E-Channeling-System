<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- for jstl tag -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Doctor Dashboard</title>
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

		.section-content {
			padding: 30px;
			text-align: center;
		}

		.section-icon {
			font-size: 3rem;
			margin-bottom: 15px;
			color: #667eea;
		}

		.section-title {
			font-size: 1.5rem;
			font-weight: 600;
			color: #2c3e50;
			margin-bottom: 15px;
		}

		.profile-list {
			list-style: none;
			padding: 0;
			margin: 0;
		}

		.profile-list li {
			padding: 12px 0;
			border-bottom: 1px solid #f0f0f0;
			font-size: 0.95rem;
			color: #2c3e50;
		}

		.profile-list li:last-child {
			border-bottom: none;
		}

		.profile-list li strong {
			color: #1a5490;
			font-weight: 600;
		}

		.stat-number {
			font-size: 1.5rem;
			font-weight: 700;
			color: #155724;
			margin-top: 10px;
		}

		@media (max-width: 768px) {
			.page-header h1 {
				font-size: 1.8rem;
			}

			.section-content {
				padding: 20px;
			}

			.section-title {
				font-size: 1.3rem;
			}

			.profile-list li {
				font-size: 0.85rem;
			}

			.section-icon {
				font-size: 2.5rem;
			}

			.stat-number {
				font-size: 1.3rem;
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
		<h1>🩺 Doctor Dashboard</h1>
		<p>Overview of your profile and appointments</p>
	</div>

	<div class="row">
		<!-- Profile Section -->
		<div class="col-md-6">
			<div class="section">
				<div class="section-content">
					<i class="fa-solid fa-user-circle section-icon"></i>
					<h2 class="section-title">My Profile</h2>
					<ul class="profile-list">
						<li><strong>Name:</strong> ${doctorObj.fullName}</li>
						<li><strong>Specialist:</strong> ${doctorObj.specialist}</li>
						<li><strong>Email:</strong> ${doctorObj.email}</li>
						<li><strong>Phone:</strong> ${doctorObj.phone}</li>
						<li><strong>Qualification:</strong> ${doctorObj.qualification}</li>
					</ul>
				</div>
			</div>
		</div>

		<!-- Appointments Section -->
		<div class="col-md-6">
			<div class="section">
				<div class="section-content">
					<i class="fa-solid fa-calendar-check section-icon"></i>
					<h2 class="section-title">Total Appointments</h2>
					<%
						DoctorDAO docDAO = new DoctorDAO(DBConnection.getConn());
						Doctor currentLoginDoctor = (Doctor)session.getAttribute("doctorObj");
					%>
					<div class="stat-number"><%= docDAO.countTotalAppointmentByDoctorId(currentLoginDoctor.getId()) %></div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@include file="/component/footer.jsp"%>
</body>
</html>