<%@page import="com.hms.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.dao.AppointmentDAO"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- for jstl tag -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- end of jstl tag -->

<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Patient Details | Doctor</title>
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

		.action-btn {
			padding: 6px 14px;
			border-radius: 20px;
			font-weight: 600;
			font-size: 0.85rem;
			text-transform: capitalize;
			margin-right: 5px;
		}

		.btn-comment {
			background-color: #28a745;
			color: white;
			border: none;
		}

		.btn-edit {
			background-color: #667eea;
			color: white;
			border: none;
		}

		.btn-delete {
			background-color: #dc3545;
			color: white;
			border: none;
		}

		.btn-comment:hover {
			background-color: #218838;
			color: white;
		}

		.btn-edit:hover {
			background-color: #5a6cd6;
			color: white;
		}

		.btn-delete:hover {
			background-color: #c82333;
			color: white;
		}

		.btn-comment.disabled, .btn-edit.disabled, .btn-delete.disabled {
			background-color: #e9ecef;
			color: #6c757d;
			cursor: not-allowed;
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

			.action-btn {
				padding: 4px 10px;
				font-size: 0.8rem;
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
		<h1>📋 Patient Details</h1>
		<p>View and manage patient appointments</p>
	</div>

	<!-- Patient Details Section -->
	<div class="section">
		<div class="section-header">
			<h2>👥 Patient Appointments</h2>
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

			<%
				Doctor doctor = (Doctor) session.getAttribute("doctorObj");
				AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
				List<Appointment> list = appDAO.getAllAppointmentByLoginDoctor(doctor.getId());
			%>

			<% if (list != null && !list.isEmpty()) { %>
			<div class="record-count">
				Total Records: <%= list.size() %>
			</div>

			<div class="table-wrapper">
				<table class="styled-table">
					<thead>
					<tr>
						<th>Full Name</th>
						<th>Gender</th>
						<th>Age</th>
						<th>Appointment Date</th>
						<th>Email</th>
						<th>Phone</th>
						<th>Diseases</th>
						<th>Status</th>
						<th>Action</th>
					</tr>
					</thead>
					<tbody>
					<%
						for (Appointment applist : list) {
							String statusClass = "pending";
							if (applist.getStatus() != null) {
								if (applist.getStatus().equalsIgnoreCase("Completed")) {
									statusClass = "completed";
								} else if (applist.getStatus().equalsIgnoreCase("Cancelled")) {
									statusClass = "cancelled";
								}
							}
							boolean isPending = "Pending".equals(applist.getStatus());
					%>
					<tr>
						<td><strong><%= applist.getFullName() %></strong></td>
						<td><%= applist.getGender() %></td>
						<td><%= applist.getAge() %></td>
						<td><%= applist.getAppointmentDate() %></td>
						<td><%= applist.getEmail() %></td>
						<td><%= applist.getPhone() %></td>
						<td><%= applist.getDiseases() %></td>
						<td>
                                <span class="status-badge status-<%= statusClass %>">
                                    <%= applist.getStatus() %>
                                </span>
						</td>
						<td>
							<a href="<%= isPending ? ("comment.jsp?id=" + applist.getId()) : "#!" %>"
							   class="action-btn btn-comment <%= isPending ? "" : "disabled" %>">Comment / Prescription</a>
							<a href="<%= !isPending ? ("comment.jsp?id=" + applist.getId()) : "#!" %>"
							   class="action-btn btn-edit <%= !isPending ? "" : "disabled" %>">Edit</a>
							<form action="../clearComment" method="post" style="display:inline-block;margin:0;">
								<input type="hidden" name="id" value="<%= applist.getId() %>">
								<input type="hidden" name="doctorId" value="<%= applist.getDoctorId() %>">
								<button type="submit" class="action-btn btn-delete <%= isPending ? "disabled" : "" %>"
										onclick="return <%= isPending ? "false" : "confirm('Delete this comment?')" %>;">Delete</button>
							</form>
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
				<p>There are currently no patient appointments assigned to you</p>
			</div>
			<% } %>
		</div>
	</div>
</div>
<%@include file="/component/footer.jsp"%>
</body>
</html>