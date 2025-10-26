<%@ page import="java.util.List"%>
<%@ page import="com.hms.entity.Staff"%>
<%@ page import="com.hms.dao.AdminManagementDAO"%>
<%@ page import="com.hms.db.DBConnection"%>

<%
  AdminManagementDAO dao = new AdminManagementDAO(DBConnection.getConn());
  List<Staff> staffList = dao.getAllStaff();
%>

<style>
  body {
    font-family: Arial, sans-serif;
    background-color: #f4f7f6;
    color: #333;
    padding: 20px;
  }
  .container {
    max-width: 1100px;
    margin: 40px auto;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
  }
  h2, h3 {
    color: #007bff; /* Primary blue for headings */
    border-bottom: 2px solid #e0e0e0;
    padding-bottom: 10px;
    margin-bottom: 25px;
  }
  .card-style {
    border: 1px solid #ddd;
    padding: 20px;
    margin-bottom: 30px;
    border-radius: 6px;
    background-color: #f9f9f9;
  }
  /* Form and Input Styling */
  .form-group {
    margin-bottom: 15px;
    display: inline-block;
    width: 49%; /* For two columns */
    padding-right: 10px;
    box-sizing: border-box;
  }
  .form-group.full-width {
    width: 100%;
    padding-right: 0;
  }
  label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
    color: #555;
  }
  input[type="text"], input[type="email"], input[type="password"], select {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box; /* Include padding and border in element's total width and height */
  }
  .btn {
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-weight: bold;
    transition: background-color 0.3s;
  }
  .btn-primary {
    background-color: #28a745; /* Green for creation */
    color: white;
  }
  .btn-primary:hover {
    background-color: #218838;
  }
  .btn-update {
    background-color: #007bff; /* Blue for update */
    color: white;
    padding: 5px 10px;
    font-size: 0.85em;
    margin-left: 5px;
  }
  .btn-delete {
    background-color: #dc3545; /* Red for delete */
    color: white;
    padding: 5px 10px;
    font-size: 0.85em;
    margin-left: 10px;
  }
  .btn-update:hover { background-color: #0056b3; }
  .btn-delete:hover { background-color: #c82333; }

  /* Table Styling */
  .styled-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
  }
  .styled-table thead tr {
    background-color: #007bff;
    color: white;
    text-align: left;
  }
  .styled-table th, .styled-table td {
    padding: 12px 15px;
    border: 1px solid #ddd;
  }
  .styled-table tbody tr:nth-child(even) {
    background-color: #f3f3f3;
  }
  .styled-table tbody tr:hover {
    background-color: #e8e8e8;
  }
  .action-cell {
    white-space: nowrap;
    display: flex;
    align-items: center;
    gap: 5px; /* Spacing between action elements */
  }
  .select-small {
    padding: 5px;
    border-radius: 4px;
    border: 1px solid #ccc;
    width: 120px;
    font-size: 0.9em;
  }
  .status-badge-full {
    background-color: #28a745; /* Green */
    color: white;
    padding: 4px 8px;
    border-radius: 12px;
    font-size: 0.8em;
  }
  .status-badge-limited {
    background-color: #ffc107; /* Yellow/Orange */
    color: #333;
    padding: 4px 8px;
    border-radius: 12px;
    font-size: 0.8em;
  }
</style>

<div class="container">
  <h2>Staff Management Portal</h2>

  <div class="card-style">
    <h3>Create New Staff</h3>
    <form action="<%= request.getContextPath() %>/adminManagement" method="post">
      <input type="hidden" name="action" value="create">
      <div style="overflow: auto;">
        <div class="form-group">
          <label>Full Name</label>
          <input name="fullName" type="text" required>
        </div>
        <div class="form-group">
          <label>Email</label>
          <input name="email" type="email" required>
        </div>

        <div class="form-group" style="width: 33%;">
          <label>Password</label>
          <input name="password" type="password" required>
        </div>
        <div class="form-group" style="width: 33%;">
          <label>Staff Type</label>
          <select name="staffType">
            <option value="hospital_admin">Hospital Administrator</option>
            <option value="nurse">Nurse</option>
            <option value="receptionist">Receptionist</option>
          </select>
        </div>
        <div class="form-group" style="width: 33%;">
          <label>Access Level</label>
          <select name="accessLevel">
            <option value="full">Full Access</option>
            <option value="limited">Limited Access</option>
          </select>
        </div>
      </div>

      <div style="margin-top: 20px; text-align: right;">
        <button type="submit" class="btn btn-primary">Create Staff Account</button>
      </div>
    </form>
  </div>

  <h3>Existing Staff Directory</h3>
  <table class="styled-table">
    <thead>
    <tr>
      <th>ID</th>
      <th>Full Name</th>
      <th>Email</th>
      <th>Role</th>
      <th>Access</th>
      <th style="text-align: center;">Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
      for (Staff s : staffList) {
        String accessClass = "full".equals(s.getAccessLevel()) ? "status-badge-full" : "status-badge-limited";
    %>
    <tr>
      <td><%= s.getId() %></td>
      <td><%= s.getFullName() %></td>
      <td><%= s.getEmail() %></td>
      <td><%= s.getStaffType().replace('_', ' ') %></td>
      <td><span class="<%= accessClass %>"><%= s.getAccessLevel() %></span></td>
      <td class="action-cell">
        <form action="<%= request.getContextPath() %>/adminManagement" method="post" style="display:flex; align-items:center;">
          <input type="hidden" name="action" value="update">
          <input type="hidden" name="id" value="<%= s.getId() %>">
          <select name="accessLevel" class="select-small">
            <option value="full" <%= "full".equals(s.getAccessLevel()) ? "selected" : "" %>>Full</option>
            <option value="limited" <%= "limited".equals(s.getAccessLevel()) ? "selected" : "" %>>Limited</option>
          </select>
          <button type="submit" class="btn btn-update">Update</button>
        </form>

        <form action="<%= request.getContextPath() %>/adminManagement" method="post" style="display:inline;">
          <input type="hidden" name="action" value="delete">
          <input type="hidden" name="id" value="<%= s.getId() %>">
          <button type="submit" class="btn btn-delete" onclick="return confirm('Are you sure you want to delete this staff member? This action cannot be undone.')">Delete</button>
        </form>
      </td>
    </tr>
    <%
      }
    %>
    </tbody>
  </table>
</div>