<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="com.hms.dao.SpecialistDAO"%>
<%@page import="com.hms.entity.Specialist"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Admin Dashboard</title>
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

		.dashboard-container {
			max-width: 1200px;
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

		.alert {
			padding: 16px 20px;
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

		@keyframes slideIn {
			from {
				opacity: 0;
				transform: translateY(-10px);
			}
			to {
				opacity: 1;
				transform: translateY(0);
			}
		}

		.stats-grid {
			display: grid;
			grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
			gap: 24px;
			margin-bottom: 40px;
		}

		.stat-card {
			background: white;
			border-radius: 12px;
			padding: 28px;
			box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07), 0 10px 20px rgba(0, 0, 0, 0.05);
			transition: all 0.3s ease;
			cursor: pointer;
			border: 2px solid transparent;
		}

		.stat-card:hover {
			transform: translateY(-6px);
			box-shadow: 0 12px 24px rgba(0, 0, 0, 0.12);
		}

		.stat-card.clickable {
			border-color: #667eea;
		}

		.stat-card.clickable:hover {
			background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
		}

		.stat-icon {
			font-size: 2.5rem;
			margin-bottom: 16px;
			color: #667eea;
			display: inline-block;
		}

		.stat-label {
			font-size: 0.95rem;
			color: #7f8c8d;
			font-weight: 500;
			margin-bottom: 8px;
			text-transform: uppercase;
			letter-spacing: 0.5px;
		}

		.stat-value {
			font-size: 2.5rem;
			color: #1a5490;
			font-weight: 700;
		}

		/* Modal Styling */
		.modal-content {
			border: none;
			border-radius: 12px;
			box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
		}

		.modal-header {
			background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
			border: none;
			padding: 25px 30px;
		}

		.modal-header .modal-title {
			color: white;
			font-weight: 600;
			font-size: 1.3rem;
			letter-spacing: 0.3px;
		}

		.modal-header .btn-close {
			filter: brightness(0) invert(1);
		}

		.modal-body {
			padding: 30px;
		}

		.modal-footer {
			border-top: 1px solid #e0e0e0;
			padding: 20px 30px;
			background-color: #f8f9fa;
		}

		.form-group {
			margin-bottom: 20px;
		}

		.form-group label {
			display: block;
			font-weight: 600;
			color: #2c3e50;
			margin-bottom: 8px;
			font-size: 0.95rem;
			letter-spacing: 0.3px;
		}

		.form-group input {
			width: 100%;
			padding: 12px 16px;
			border: 2px solid #e0e0e0;
			border-radius: 8px;
			font-size: 1rem;
			font-family: inherit;
			transition: all 0.3s ease;
			background-color: #fafafa;
		}

		.form-group input:focus {
			outline: none;
			background-color: white;
			border-color: #667eea;
			box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
		}

		.form-group input::placeholder {
			color: #95a5a6;
		}

		.btn {
			padding: 10px 24px;
			border-radius: 8px;
			font-weight: 600;
			transition: all 0.3s ease;
			cursor: pointer;
			text-transform: uppercase;
			letter-spacing: 0.5px;
			font-size: 0.9rem;
			border: none;
		}

		.btn-primary {
			background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
			color: white;
		}

		.btn-primary:hover {
			transform: translateY(-2px);
			box-shadow: 0 8px 16px rgba(102, 126, 234, 0.4);
		}

		.btn-secondary {
			background-color: #e0e0e0;
			color: #2c3e50;
		}

		.btn-secondary:hover {
			background-color: #d0d0d0;
		}

		.btn-center {
			display: flex;
			justify-content: center;
			margin-top: 25px;
		}

		@media (max-width: 768px) {
			.page-header h1 {
				font-size: 1.8rem;
			}

			.stats-grid {
				grid-template-columns: 1fr;
				gap: 16px;
			}

			.stat-card {
				padding: 20px;
			}

			.stat-icon {
				font-size: 2rem;
			}

			.stat-value {
				font-size: 2rem;
			}
		}
	</style>
</head>
<body>
<%@include file="navbar2.jsp"%>

<div class="dashboard-container">
	<!-- Page Header -->
	<div class="page-header">
		<h1>📊 Admin Dashboard</h1>
		<p>Hospital Management System Overview</p>
	</div>

	<!-- Alert Messages -->
	<c:if test="${not empty successMsg}">
		<div class="alert alert-success">
			✓ ${successMsg}
		</div>
		<c:remove var="successMsg" scope="session" />
	</c:if>
	<c:if test="${not empty errorMsg}">
		<div class="alert alert-danger">
			✕ ${errorMsg}
		</div>
		<c:remove var="errorMsg" scope="session" />
	</c:if>

	<%
		DoctorDAO docDAO = new DoctorDAO(DBConnection.getConn());
		int totalNumberOfDoctor = docDAO.countTotalDoctor();
		int totalNumberOfUser = docDAO.countTotalUser();
		int totalNumberOfAppointment = docDAO.countTotalAppointment();
		int totalNumberOfSpecialist = docDAO.countTotalSpecialist();

		SpecialistDAO spDAO = new SpecialistDAO(DBConnection.getConn());
		List<Specialist> spList = spDAO.getAllSpecialist();
	%>

	<!-- Statistics Grid -->
	<div class="stats-grid">
		<!-- Doctors Card -->
		<div class="stat-card">
			<div class="stat-icon">👨‍⚕️</div>
			<div class="stat-label">Total Doctors</div>
			<div class="stat-value"><%= totalNumberOfDoctor %></div>
		</div>

		<!-- Users Card -->
		<div class="stat-card">
			<div class="stat-icon">👥</div>
			<div class="stat-label">Total Users</div>
			<div class="stat-value"><%= totalNumberOfUser %></div>
		</div>

		<!-- Appointments Card -->
		<div class="stat-card">
			<div class="stat-icon">📅</div>
			<div class="stat-label">Total Appointments</div>
			<div class="stat-value"><%= totalNumberOfAppointment %></div>
		</div>

		<!-- Specialists Card (Clickable) -->
		<div class="stat-card clickable" data-bs-toggle="modal" data-bs-target="#specialistModal">
			<div class="stat-icon">🏥</div>
			<div class="stat-label">Total Specialists</div>
			<div class="stat-value"><%= totalNumberOfSpecialist %></div>
			<small style="color: #667eea; font-weight: 600;">Click to add specialist</small>
		</div>
	</div>
</div>

<!-- Add Specialist Modal -->
<div class="modal fade" id="specialistModal" tabindex="-1" aria-labelledby="specialistModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="specialistModalLabel">➕ Add New Specialist</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="addSpecialistForm" action="../addSpecialist" method="post">
					<div class="form-group">
						<label for="specialistName">Specialist Name *</label>
						<input
								type="text"
								id="specialistName"
								name="specialistName"
								placeholder="e.g., Cardiology, Neurology, Orthopedics"
								class="form-control"
								required
								maxlength="50"
								pattern="[A-Za-z\s]+"
								title="Specialist name can only contain letters and spaces, max 50 characters." />
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
				<button type="submit" form="addSpecialistForm" class="btn btn-primary">Add Specialist</button>
			</div>
		</div>
	</div>
</div>
<%@include file="/component/footer.jsp"%>
<script>
	const existingSpecialists = [
		<% for(Specialist sp : spList) { %>
		'<%= sp.getSpecialistName().toLowerCase().trim() %>',
		<% } %>
	];

	const form = document.getElementById('addSpecialistForm');
	const input = document.getElementById('specialistName');

	form.addEventListener('submit', function(e) {
		const value = input.value.toLowerCase().trim();
		if(existingSpecialists.includes(value)) {
			e.preventDefault();
			alert("This specialist already exists!");
			input.focus();
		}
	});
</script>

</body>
</html>