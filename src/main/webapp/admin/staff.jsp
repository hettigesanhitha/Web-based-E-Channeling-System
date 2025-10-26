<%@ page import="java.util.List"%>
<%@ page import="com.hms.entity.Staff"%>
<%@ page import="com.hms.dao.AdminManagementDAO"%>
<%@ page import="com.hms.db.DBConnection"%>

<%
  AdminManagementDAO dao = new AdminManagementDAO(DBConnection.getConn());
  List<Staff> staffList = dao.getAllStaff();
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Staff Management Portal</title>
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
      padding: 20px;
    }

    .page-wrapper {
      max-width: 1200px;
      margin: 0 auto;
    }

    .page-header {
      margin-bottom: 40px;
    }

    .page-header h1 {
      font-size: 2.5rem;
      color: #1a5490;
      margin-bottom: 10px;
      font-weight: 600;
      letter-spacing: -0.5px;
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
      border-bottom: 1px solid rgba(0, 0, 0, 0.1);
    }

    .section-header h2 {
      font-size: 1.5rem;
      font-weight: 600;
      letter-spacing: -0.3px;
    }

    .section-content {
      padding: 30px;
    }

    .form-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 20px;
      margin-bottom: 25px;
    }

    .form-group {
      display: flex;
      flex-direction: column;
    }

    .form-group label {
      font-weight: 600;
      color: #2c3e50;
      margin-bottom: 8px;
      font-size: 0.95rem;
    }

    .form-group input,
    .form-group select {
      padding: 12px 14px;
      border: 2px solid #e0e0e0;
      border-radius: 6px;
      font-size: 1rem;
      transition: all 0.3s ease;
      font-family: inherit;
    }

    .form-group input:focus,
    .form-group select:focus {
      outline: none;
      border-color: #667eea;
      box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
    }

    .form-group input::placeholder {
      color: #95a5a6;
    }

    .error-msg {
      color: #e74c3c;
      font-size: 0.85rem;
      margin-top: 6px;
      min-height: 20px;
    }

    .form-actions {
      display: flex;
      justify-content: flex-end;
      gap: 12px;
      margin-top: 30px;
      padding-top: 20px;
      border-top: 1px solid #e0e0e0;
    }

    .btn {
      padding: 12px 28px;
      border: none;
      border-radius: 6px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s ease;
      font-size: 1rem;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .btn-primary {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
    }

    .btn-primary:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 16px rgba(102, 126, 234, 0.4);
    }

    .btn-update {
      background-color: #3498db;
      color: white;
      padding: 8px 16px;
      font-size: 0.85rem;
      text-transform: capitalize;
      letter-spacing: 0;
    }

    .btn-update:hover {
      background-color: #2980b9;
      transform: translateY(-1px);
    }

    .btn-delete {
      background-color: #e74c3c;
      color: white;
      padding: 8px 16px;
      font-size: 0.85rem;
      text-transform: capitalize;
      letter-spacing: 0;
    }

    .btn-delete:hover {
      background-color: #c0392b;
      transform: translateY(-1px);
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
      padding: 16px 18px;
      text-align: left;
      font-weight: 600;
      color: #2c3e50;
      font-size: 0.95rem;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .styled-table td {
      padding: 16px 18px;
      border-bottom: 1px solid #f0f0f0;
      font-size: 0.95rem;
    }

    .styled-table tbody tr {
      transition: background-color 0.2s ease;
    }

    .styled-table tbody tr:hover {
      background-color: #f8f9fa;
    }

    .status-badge {
      display: inline-block;
      padding: 6px 12px;
      border-radius: 20px;
      font-weight: 600;
      font-size: 0.85rem;
      text-transform: capitalize;
    }

    .status-full {
      background-color: #d4edda;
      color: #155724;
    }

    .status-limited {
      background-color: #fff3cd;
      color: #856404;
    }

    .action-cell {
      display: flex;
      align-items: center;
      gap: 10px;
      white-space: nowrap;
    }

    .action-cell form {
      display: flex;
      align-items: center;
      gap: 8px;
      margin: 0;
    }

    .access-select {
      padding: 8px 12px;
      border: 1px solid #e0e0e0;
      border-radius: 4px;
      font-size: 0.9rem;
      background-color: white;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .access-select:focus {
      outline: none;
      border-color: #667eea;
      box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.1);
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

      .form-grid {
        grid-template-columns: 1fr;
      }

      .action-cell {
        flex-direction: column;
        align-items: flex-start;
        gap: 8px;
      }

      .action-cell form {
        width: 100%;
        flex-wrap: wrap;
      }

      .table-wrapper {
        font-size: 0.9rem;
      }

      .styled-table th,
      .styled-table td {
        padding: 12px 10px;
      }
    }
  </style>
</head>
<body>
<div class="page-wrapper">
  <div class="page-header">
    <h1>Staff Management Portal</h1>
    <p>Create, manage, and configure staff member access levels</p>
  </div>

  <!-- Create Staff Section -->
  <div class="section">
    <div class="section-header">
      <h2>Create New Staff Member</h2>
    </div>
    <div class="section-content">
      <form id="createStaffForm" action="<%= request.getContextPath() %>/adminManagement" method="post">
        <input type="hidden" name="action" value="create">

        <div class="form-grid">
          <div class="form-group">
            <label for="fullName">Full Name</label>
            <input id="fullName" name="fullName" type="text" placeholder="Enter full name" required>
            <div id="fullNameError" class="error-msg"></div>
          </div>

          <div class="form-group">
            <label for="email">Email Address</label>
            <input id="email" name="email" type="email" placeholder="Enter email" required>
            <div id="emailError" class="error-msg"></div>
          </div>

          <div class="form-group">
            <label for="password">Password</label>
            <input id="password" name="password" type="password" placeholder="Enter password" required>
            <div id="passwordError" class="error-msg"></div>
          </div>

          <div class="form-group">
            <label for="staffType">Staff Role</label>
            <select id="staffType" name="staffType" required>
              <option value="">Select a role</option>
              <option value="hospital_admin">Hospital Administrator</option>
              <option value="nurse">Nurse</option>
              <option value="receptionist">Receptionist</option>
            </select>
          </div>

          <div class="form-group">
            <label for="accessLevel">Access Level</label>
            <select id="accessLevel" name="accessLevel" required>
              <option value="">Select access level</option>
              <option value="full">Full Access</option>
              <option value="limited">Limited Access</option>
            </select>
          </div>
        </div>

        <div class="form-actions">
          <button type="submit" class="btn btn-primary">Create Staff Account</button>
        </div>
      </form>
    </div>
  </div>

  <!-- Staff Directory Section -->
  <div class="section">
    <div class="section-header">
      <h2>Staff Directory</h2>
    </div>
    <div class="section-content">
      <% if (staffList != null && !staffList.isEmpty()) { %>
      <div class="table-wrapper">
        <table class="styled-table">
          <thead>
          <tr>
            <th>ID</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Role</th>
            <th>Access Level</th>
            <th>Actions</th>
          </tr>
          </thead>
          <tbody>
          <% for (Staff s : staffList) {
            String statusClass = "full".equals(s.getAccessLevel()) ? "status-full" : "status-limited";
          %>
          <tr>
            <td><strong><%= s.getId() %></strong></td>
            <td><%= s.getFullName() %></td>
            <td><%= s.getEmail() %></td>
            <td><%= s.getStaffType().replace('_', ' ') %></td>
            <td><span class="status-badge <%= statusClass %>"><%= s.getAccessLevel() %></span></td>
            <td>
              <div class="action-cell">
                <form action="<%= request.getContextPath() %>/adminManagement" method="post">
                  <input type="hidden" name="action" value="update">
                  <input type="hidden" name="id" value="<%= s.getId() %>">
                  <select name="accessLevel" class="access-select">
                    <option value="full" <%= "full".equals(s.getAccessLevel()) ? "selected" : "" %>>Full</option>
                    <option value="limited" <%= "limited".equals(s.getAccessLevel()) ? "selected" : "" %>>Limited</option>
                  </select>
                  <button type="submit" class="btn btn-update">Update</button>
                </form>

                <form action="<%= request.getContextPath() %>/adminManagement" method="post">
                  <input type="hidden" name="action" value="delete">
                  <input type="hidden" name="id" value="<%= s.getId() %>">
                  <button type="submit" class="btn btn-delete" onclick="return confirm('Are you sure you want to delete this staff member? This action cannot be undone.')">Delete</button>
                </form>
              </div>
            </td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
      <% } else { %>
      <div class="empty-state">
        <div class="empty-state-icon">📋</div>
        <h3>No Staff Members Yet</h3>
        <p>Create your first staff member using the form above</p>
      </div>
      <% } %>
    </div>
  </div>
</div>

<script>
  const existingEmails = [
    <% for (Staff s : staffList) { %>
    '<%= s.getEmail().toLowerCase() %>',
    <% } %>
  ];

  const form = document.getElementById('createStaffForm');
  const fullName = document.getElementById('fullName');
  const email = document.getElementById('email');
  const password = document.getElementById('password');
  const staffTypeSelect = document.getElementById('staffType');
  const accessLevelSelect = document.getElementById('accessLevel');

  // Auto-set access level based on staff type
  staffTypeSelect.addEventListener('change', function() {
    const selectedStaffType = staffTypeSelect.value;
    if (selectedStaffType === 'hospital_admin') {
      accessLevelSelect.value = 'full';
    } else if (selectedStaffType === 'nurse' || selectedStaffType === 'receptionist') {
      accessLevelSelect.value = 'limited';
    }
  });

  form.addEventListener('submit', function(e) {
    let valid = true;

    // Full Name validation
    const nameVal = fullName.value.trim();
    const namePattern = /^[A-Za-z\s]{1,50}$/;
    if (!namePattern.test(nameVal)) {
      document.getElementById('fullNameError').textContent = "Full Name must contain only letters and spaces (max 50 characters).";
      valid = false;
    } else {
      document.getElementById('fullNameError').textContent = "";
    }

    // Email validation
    const emailVal = email.value.trim().toLowerCase();
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(emailVal) || emailVal.length > 50) {
      document.getElementById('emailError').textContent = "Enter a valid email (max 50 characters).";
      valid = false;
    } else if (existingEmails.includes(emailVal)) {
      document.getElementById('emailError').textContent = "This email is already registered.";
      valid = false;
    } else {
      document.getElementById('emailError').textContent = "";
    }

    // Password validation
    const passwordVal = password.value.trim();
    if (passwordVal.length < 6 || passwordVal.length > 20) {
      document.getElementById('passwordError').textContent = "Password must be between 6 and 20 characters.";
      valid = false;
    } else {
      document.getElementById('passwordError').textContent = "";
    }

    if (!valid) e.preventDefault();
  });
</script>
</body>
</html>