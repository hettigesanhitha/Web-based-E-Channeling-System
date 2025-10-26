<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="com.hms.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.AppointmentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%-- JSTL, EL, and CSS/Navbar includes removed as requested --%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Patient Details | Admin</title>
  <style>
    /* Minimal inline styling for readability */
    body { font-family: Arial, sans-serif; margin: 20px; }
    .container-fluid { width: 100%; padding: 15px; }
    .card-style { border: 1px solid #ccc; padding: 20px; box-shadow: 0 0 5px rgba(0,0,0,0.2); }
    h3 { text-align: center; color: #dc3545; }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
    thead th { background-color: #007bff; color: white; }
    tbody tr:nth-child(even) { background-color: #f2f2f2; }
  </style>
</head>
<body>
<div class="container-fluid">
  <div class="card-style">
    <div class="card-body">
      <h3 class="text-danger">Patient Details</h3>

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
          // Database connection and DAO initialization
          AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
          DoctorDAO docDAO = new DoctorDAO(DBConnection.getConn());

          // Fetch all appointments
          List<Appointment> list = appDAO.getAllAppointment();

          // Loop through the appointments
          for(Appointment appList : list)
          {
            // Fetch doctor details for the current appointment
            Doctor doctor = docDAO.getDoctorById(appList.getDoctorId());
        %>

        <tr>
          <td><%= appList.getFullName() %></td>
          <td><%= appList.getGender() %></td>
          <td><%= appList.getAge() %></td>
          <td><%= appList.getAppointmentDate()%></td>
          <td><%= appList.getEmail()%></td>
          <td><%= appList.getPhone()%></td>
          <td><%= appList.getDiseases()%></td>
          <td><%= (doctor != null) ? doctor.getFullName() : "N/A" %></td>
          <td><%= appList.getAddress()%></td>
          <td><%= appList.getStatus()%></td>
        </tr>


        <%
          }
        %>
        </tbody>
      </table>
    </div>
  </div>
</div>
</body>
</html>