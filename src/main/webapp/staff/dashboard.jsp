<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Staff Dashboard</title>
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
      text-align: center;
    }

    .action-btn {
      padding: 12px 20px;
      border-radius: 20px;
      font-weight: 600;
      font-size: 0.95rem;
      text-transform: capitalize;
      margin: 10px;
      transition: background-color 0.2s ease, color 0.2s ease, border-color 0.2s ease;
    }

    .btn-view {
      background-color: transparent;
      color: #2c3e50;
      border: 2px solid #2c3e50;
    }

    .btn-view:hover {
      background-color: #2c3e50;
      color: white;
    }

    .btn-admin {
      background-color: #667eea;
      color: white;
      border: none;
    }

    .btn-admin:hover {
      background-color: #5a6cd6;
    }

    @media (max-width: 768px) {
      .page-header h1 {
        font-size: 1.8rem;
      }

      .section-content {
        padding: 20px;
      }

      .action-btn {
        font-size: 0.9rem;
        padding: 10px 16px;
        margin: 5px;
      }
    }
  </style>
  <!-- End of custom CSS -->
</head>
<body>
<%@include file="../component/navbar.jsp"%>

<c:if test="${empty staffObj}">
  <c:redirect url="../stafflogin.jsp" />
</c:if>

<div class="page-wrapper">
  <!-- Page Header -->
  <div class="page-header">
    <h1>🛠️ Staff Dashboard</h1>
    <p>Access hospital management tools and resources</p>
  </div>

  <!-- Actions Section -->
  <div class="section">
    <div class="section-header">
      <h2>🔧 Management Actions</h2>
    </div>
    <div class="section-content">
      <a href="${pageContext.request.contextPath}/admin/view_doctor2.jsp" class="action-btn btn-view">View Doctors</a>
      <a href="${pageContext.request.contextPath}/admin/patient2.jsp" class="action-btn btn-view">View Users</a>
      <c:if test="${staffObj.accessLevel eq 'full'}">
        <a href="${pageContext.request.contextPath}/admin/index.jsp" class="action-btn btn-admin">Hospital Administrator</a>
      </c:if>
    </div>
  </div>
</div>
<%@include file="/component/footer.jsp"%>
</body>
</html>