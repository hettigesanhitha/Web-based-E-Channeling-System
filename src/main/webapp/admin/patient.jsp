<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="com.hms.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.AppointmentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Patient Details | Admin</title>

	<%@include file="../component/allcss.jsp"%>

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

		.table-wrapper {
			overflow-x: auto;
		}

		.styled-table {
			width: 100%;
			border-collapse: collapse;
		}

		.styled-table thead {
			background-color: #f8f9fa;
			border-bottom: 2px solid #e0e0e0;
		}

		.styled-table th {
			padding: 16px 14px;
			text-align: left;
			font-weight: 600;
			color: #2c3e50;
			font-size: 0.9rem;
			text-transform: uppercase;
			letter-spacing: 0.5px;
			white-space: nowrap;
		}

		.styled-table td {
			padding: 16px 14px;
			border-bottom: 1px solid #f0f0f0;
			font-size: 0.95rem;
		}

		.styled-table tbody tr {
			transition: background-color 0.2s ease;
		}

		.styled-table tbody tr:hover {
			background-color: #f8f9fa;
		}

		.styled-table tbody tr:nth-child(even) {
			background-color: #fafbfc;
		}

		.status-badge {
			display: inline-block;
			padding: 6px 14px;
			border-radius: 20px;
			font-weight: 600;
			font-size: 0.85rem;
			text-transform: capitalize;
		}

		.status-pending {
			background-color: #fff3cd;
			color: #856404;
		}

		.status-completed {
			background-color: #d4edda;
			color: #155724;
		}

		.status-cancelled {
			background-color: #f8d7da;
			color: #721c24;
		}

		.empty-state {
			text-align: center;
			padding: 60px 20px;
		}

		.empty-state-icon {
			font-size: 3rem;
			margin-bottom: 15px;
			color: #bdc3c7;
		}

		.empty-state h3 {
			color: #7f8c8d;
			margin-bottom: 10px;
			font-size: 1.2rem;
		}

		.empty-state p {
			color: #95a5a6;
		}

		.record-count {
			display: inline-block;
			background-color: #667eea;
			color: white;
			padding: 6px 16px;
			border-radius: 20px;
			font-weight: 600;
			font-size: 0.9rem;
			margin-bottom: 20px;
		}

		@media (max-width: 768px) {
			.page-header h1 {
				font-size: 1.8rem;
			}

			.section-content {
				padding: 20px;
			}

			.styled-table th,
			.styled-table td {
				padding: 12px 8px;
				font-size: 0.85rem;
			}

			.styled-table th {
				font-size: 0.8rem;
			}

			.table-wrapper {
				font-size: 0.9rem;
			}

			.status-badge {
				padding: 4px 10px;
				font-size: 0.8rem;
			}
		}
	</style>
</head>
<body>
<%@include file="navbar2.jsp"%>

<div class="page-wrapper">
	<!-- Page Header -->
	<div class="page-header">
		<h1>📋 Patient Details</h1>
		<p>Comprehensive view of all patient appointments and information</p>
	</div>

	<!-- Patient Details Section -->
	<div class="section">
		<div class="section-header">
			<h2>👥 Patient Appointments</h2>
		</div>
		<div class="section-content">
			<%
				AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
				DoctorDAO docDAO = new DoctorDAO(DBConnection.getConn());
				List<Appointment> list = appDAO.getAllAppointment();
			%>

			<% if (list != null && !list.isEmpty()) { %>
			<div class="record-count">
				Total Records: <%= list.size() %>
			</div>

			<div class="table-wrapper">
				<table class="styled-table">
					<thead>
					<tr>
						<th>Patient Name</th>
						<th>Gender</th>
						<th>Age</th>
						<th>Appointment Date</th>
						<th>Email</th>
						<th>Phone</th>
						<th>Disease/Condition</th>
						<th>Doctor</th>
						<th>Address</th>
						<th>Status</th>
					</tr>
					</thead>
					<tbody>
					<%
						for(Appointment appList : list) {
							Doctor doctor = docDAO.getDoctorById(appList.getDoctorId());
							String statusClass = "pending";
							if (appList.getStatus() != null) {
								if (appList.getStatus().equalsIgnoreCase("Completed")) {
									statusClass = "completed";
								} else if (appList.getStatus().equalsIgnoreCase("Cancelled")) {
									statusClass = "cancelled";
								}
							}
					%>
					<tr>
						<td><strong><%= appList.getFullName() %></strong></td>
						<td><%= appList.getGender() %></td>
						<td><%= appList.getAge() %></td>
						<td><%= appList.getAppointmentDate() %></td>
						<td><%= appList.getEmail() %></td>
						<td><%= appList.getPhone() %></td>
						<td><%= appList.getDiseases() %></td>
						<td><%= doctor != null ? doctor.getFullName() : "N/A" %></td>
						<td><%= appList.getAddress() %></td>
						<td>
										<span class="status-badge status-<%= statusClass %>">
											<%= appList.getStatus() %>
										</span>
						</td>
					</tr>
					<% } %>
					</tbody>
				</table>
			</div>
			<% } else { %>
			<div class="empty-state">
				<div class="empty-state-icon">📭</div>
				<h3>No Patient Records Found</h3>
				<p>There are currently no patient appointments in the system</p>
			</div>
			<% } %>
		</div>
	</div>
</div>
<%@include file="/component/footer.jsp"%>

</body>
</html>