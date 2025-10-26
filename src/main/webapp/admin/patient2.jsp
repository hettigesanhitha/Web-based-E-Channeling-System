<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="com.hms.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.AppointmentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Patient Details | Admin</title>
  <style>
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

    .container-fluid {
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

    .card-style {
      background: white;
      border-radius: 12px;
      padding: 0;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07), 0 10px 20px rgba(0, 0, 0, 0.05);
      overflow: hidden;
    }

    .card-header {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      padding: 25px 30px;
      color: white;
    }

    .card-header h3 {
      font-size: 1.5rem;
      font-weight: 600;
      letter-spacing: -0.3px;
      margin: 0;
    }

    .card-body {
      padding: 30px;
    }

    .table-wrapper {
      overflow-x: auto;
    }

    .table-striped {
      width: 100%;
      border-collapse: collapse;
    }

    .table-striped thead {
      background-color: #f8f9fa;
      border-bottom: 2px solid #e0e0e0;
    }

    .table-striped th {
      padding: 16px 14px;
      text-align: left;
      font-weight: 600;
      color: #2c3e50;
      font-size: 0.9rem;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      white-space: nowrap;
    }

    .table-striped td {
      padding: 16px 14px;
      border-bottom: 1px solid #f0f0f0;
      font-size: 0.95rem;
    }

    .table-striped tbody tr {
      transition: background-color 0.2s ease;
    }

    .table-striped tbody tr:hover {
      background-color: #f8f9fa;
    }

    .table-striped tbody tr:nth-child(even) {
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
      padding: 8px 18px;
      border-radius: 20px;
      font-weight: 600;
      font-size: 0.9rem;
      margin-bottom: 20px;
    }

    @media (max-width: 768px) {
      .page-header h1 {
        font-size: 1.8rem;
      }

      .card-body {
        padding: 20px;
      }

      .table-striped th,
      .table-striped td {
        padding: 12px 8px;
        font-size: 0.85rem;
      }

      .table-striped th {
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
<div class="container-fluid">
  <!-- Page Header -->
  <div class="page-header">
    <h1>📋 Patient Details</h1>
    <p>Comprehensive view of all patient appointments and information</p>
  </div>

  <!-- Patient Details Card -->
  <div class="card-style">
    <div class="card-header">
      <h3>👥 Patient Appointments</h3>
    </div>
    <div class="card-body">
      <%
        // Database connection and DAO initialization
        AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
        DoctorDAO docDAO = new DoctorDAO(DBConnection.getConn());

        // Fetch all appointments
        List<Appointment> list = appDAO.getAllAppointment();
      %>

      <% if (list != null && !list.isEmpty()) { %>
      <div class="record-count">
        Total Records: <%= list.size() %>
      </div>

      <div class="table-wrapper">
        <table class="table-striped">
          <thead>
          <tr>
            <th>Full Name</th>
            <th>Gender</th>
            <th>Age</th>
            <th>Appointment Date</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Diseases</th>
            <th>Doctor Name</th>
            <th>Address</th>
            <th>Status</th>
          </tr>
          </thead>
          <tbody>
          <%
            // Loop through the appointments
            for(Appointment appList : list) {
              // Fetch doctor details for the current appointment
              Doctor doctor = docDAO.getDoctorById(appList.getDoctorId());

              // Determine status badge class
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
            <td><%= appList.getAppointmentDate()%></td>
            <td><%= appList.getEmail()%></td>
            <td><%= appList.getPhone()%></td>
            <td><%= appList.getDiseases()%></td>
            <td><%= (doctor != null) ? doctor.getFullName() : "N/A" %></td>
            <td><%= appList.getAddress()%></td>
            <td>
										<span class="status-badge status-<%= statusClass %>">
											<%= appList.getStatus() %>
										</span>
            </td>
          </tr>
          <%
            }
          %>
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