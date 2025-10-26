<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>IT Admin Login</title>
  <%@include file="../component/allcss.jsp"%>

  <style type="text/css">
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    .navbar-wrapper {
      flex-shrink: 0;
    }

    .login-container {
      flex: 1;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 40px 20px;
    }

    .login-card {
      background: white;
      border-radius: 12px;
      box-shadow: 0 15px 50px rgba(0, 0, 0, 0.2);
      overflow: hidden;
      width: 100%;
      max-width: 420px;
      animation: slideIn 0.5s ease-out;
    }

    @keyframes slideIn {
      from {
        opacity: 0;
        transform: translateY(30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .login-header {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      padding: 40px 30px;
      text-align: center;
      color: white;
    }

    .login-header-icon {
      font-size: 3rem;
      margin-bottom: 15px;
      display: block;
    }

    .login-header h1 {
      font-size: 1.8rem;
      font-weight: 700;
      margin-bottom: 8px;
      letter-spacing: -0.3px;
    }

    .login-header p {
      font-size: 0.95rem;
      color: rgba(255, 255, 255, 0.9);
      margin: 0;
    }

    .login-body {
      padding: 40px 30px;
    }

    .form-group {
      margin-bottom: 24px;
    }

    .form-group label {
      display: block;
      font-weight: 600;
      color: #2c3e50;
      margin-bottom: 10px;
      font-size: 0.95rem;
      letter-spacing: 0.3px;
    }

    .form-group input {
      width: 100%;
      padding: 14px 16px;
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

    .btn-login {
      width: 100%;
      padding: 14px 24px;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 1.05rem;
      font-weight: 700;
      cursor: pointer;
      transition: all 0.3s ease;
      text-transform: uppercase;
      letter-spacing: 1px;
    }

    .btn-login:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
    }

    .btn-login:active {
      transform: translateY(0);
    }

    .login-footer {
      padding: 0 30px 30px;
      text-align: center;
      color: #7f8c8d;
      font-size: 0.9rem;
    }

    .login-footer a {
      color: #667eea;
      text-decoration: none;
      font-weight: 600;
      transition: color 0.3s ease;
    }

    .login-footer a:hover {
      color: #764ba2;
      text-decoration: underline;
    }

    .security-badge {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 6px;
      font-size: 0.85rem;
      color: #95a5a6;
      margin-top: 20px;
    }

    .security-badge::before {
      content: '🔒';
    }

    @media (max-width: 600px) {
      .login-container {
        padding: 20px;
      }

      .login-card {
        max-width: 100%;
      }

      .login-header {
        padding: 30px 20px;
      }

      .login-header h1 {
        font-size: 1.5rem;
      }

      .login-header-icon {
        font-size: 2.5rem;
      }

      .login-body {
        padding: 25px 20px;
      }

      .form-group {
        margin-bottom: 20px;
      }
    }
  </style>
</head>
<body>
<div class="navbar-wrapper">
  <%@include file="../component/navbar.jsp"%>
</div>

<div class="login-container">
  <div class="login-card">
    <!-- Login Header -->
    <div class="login-header">
      <span class="login-header-icon">🔐</span>
      <h1>IT Admin Login</h1>
      <p>Secure System Administration Access</p>
    </div>

    <!-- Login Form -->
    <div class="login-body">
      <form action="${pageContext.request.contextPath}/itAdminLogin" method="post">
        <div class="form-group">
          <label for="email">Email Address</label>
          <input
                  type="email"
                  id="email"
                  name="email"
                  placeholder="Enter your email"
                  required
                  autocomplete="email">
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input
                  type="password"
                  id="password"
                  name="password"
                  placeholder="Enter your password"
                  required
                  autocomplete="current-password">
        </div>

        <button type="submit" class="btn-login">Sign In</button>
      </form>

      <div class="security-badge">
        Encrypted Connection
      </div>
    </div>
  </div>
</div>
<%@include file="/component/footer.jsp"%>

</body>
</html>