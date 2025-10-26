<%@ page import="java.sql.*,com.hms.db.DBConnection,com.hms.dao.DoctorDAO,com.hms.entity.Doctor, java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- for jstl tag -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- end of jstl tag -->
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Appointment</title>
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

    .form-control::placeholder {
      color: #95a5a6;
    }

    .form-control[readonly] {
      background-color: #e9ecef;
      cursor: not-allowed;
    }

    .btn-submit {
      background-color: #28a745;
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
      background-color: #218838;
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

      .form-control,
      .form-select {
        font-size: 0.85rem;
        padding: 8px 12px;
      }

      .form-label {
        font-size: 0.8rem;
      }

      .btn-submit {
        font-size: 0.9rem;
        padding: 10px 16px;
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
    <h1>📅 Edit Appointment</h1>
    <p>Update appointment details</p>
  </div>

  <!-- Form Section -->
  <div class="section">
    <div class="section-header">
      <h2>✏️ Appointment Details</h2>
    </div>
    <div class="section-content">
      <%
        int id = Integer.parseInt(request.getParameter("id"));
        Connection conn = DBConnection.getConn();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM appointment WHERE id=?");
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        rs.next();
      %>

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

      <!-- Form -->
      <form action="editAppointment" method="post">
        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
        <input type="hidden" name="userId" value="<%= rs.getInt("userId") %>">

        <div class="row g-3">
          <div class="col-md-6">
            <div class="form-group">
              <label class="form-label">Full Name</label>
              <input type="text" name="fullName" class="form-control" value="<%= rs.getString("fullName") %>" required maxlength="50" pattern="[A-Za-z\s]+" title="Only letters and spaces, max 50 characters">
            </div>
          </div>

          <div class="col-md-6">
            <div class="form-group">
              <label class="form-label">Gender</label>
              <select name="gender" class="form-select" required>
                <option value="Male" <%= rs.getString("gender").equals("Male") ? "selected" : "" %>>Male</option>
                <option value="Female" <%= rs.getString("gender").equals("Female") ? "selected" : "" %>>Female</option>
                <option value="Other" <%= rs.getString("gender").equals("Other") ? "selected" : "" %>>Other</option>
              </select>
            </div>
          </div>

          <div class="col-md-6">
            <div class="form-group">
              <label class="form-label">Age</label>
              <input type="text" name="age" class="form-control" value="<%= rs.getString("age") %>" required pattern="\d{1,3}" title="Enter a valid age (1-999)">
            </div>
          </div>

          <div class="col-md-6">
            <div class="form-group">
              <label class="form-label">Appointment Date</label>
              <input type="date" name="appointmentDate" class="form-control" value="<%= rs.getString("appointmentDate") %>" required min="<%= java.time.LocalDate.now() %>">
            </div>
          </div>

          <div class="col-md-6">
            <div class="form-group">
              <label class="form-label">Email</label>
              <input type="email" name="email" class="form-control" value="<%= rs.getString("email") %>" required maxlength="50">
            </div>
          </div>

          <div class="col-md-6">
            <div class="form-group">
              <label class="form-label">Phone</label>
              <input type="text" name="phone" class="form-control" value="<%= rs.getString("phone") %>" required pattern="\d{10,11}" title="Enter 10 or 11 digit phone number">
            </div>
          </div>

          <div class="col-md-12">
            <div class="form-group">
              <label class="form-label">Diseases / Symptoms</label>
              <textarea name="diseases" class="form-control" rows="2" required maxlength="200" title="Max 200 characters"><%= rs.getString("diseases") %></textarea>
            </div>
          </div>

          <div class="col-md-12">
            <div class="form-group">
              <label class="form-label">Doctor</label>
              <select name="doctorNameSelect" class="form-select" required>
                <%
                  DoctorDAO dDAO = new DoctorDAO(conn);
                  List<Doctor> doctors = dDAO.getAllDoctor();
                  for (Doctor d : doctors) {
                %>
                <option value="<%=d.getId()%>" <%= d.getId() == rs.getInt("doctorId") ? "selected" : "" %>><%=d.getFullName()%></option>
                <%
                  }
                %>
              </select>
            </div>
          </div>

          <div class="col-md-12">
            <div class="form-group">
              <label class="form-label">Address</label>
              <textarea name="address" class="form-control" rows="2" maxlength="200" title="Max 200 characters"><%= rs.getString("address") %></textarea>
            </div>
          </div>

          <div class="col-md-12">
            <button type="submit" class="btn-submit">Update Appointment</button>
          </div>
        </div>
      </form>

      <%
        rs.close();
        ps.close();
        conn.close();
      %>
    </div>
  </div>
</div>

</body>
</html>