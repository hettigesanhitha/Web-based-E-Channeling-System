<%@page import="com.hms.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile | Hospital</title>
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

        .form-control {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            font-size: 0.95rem;
            color: #2c3e50;
            background-color: #f8f9fa;
            transition: border-color 0.2s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 5px rgba(102, 126, 234, 0.3);
        }

        .form-control::placeholder {
            color: #95a5a6;
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

        .btn-delete {
            background-color: #dc3545;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.95rem;
            width: 100%;
            transition: background-color 0.2s ease;
        }

        .btn-delete:hover {
            background-color: #c82333;
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

        .list-group-item {
            border: none;
            padding: 12px 0;
            font-size: 0.95rem;
            color: #2c3e50;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .list-group-item strong {
            font-weight: 600;
        }

        hr {
            border: 0;
            height: 1px;
            background: #e0e0e0;
            margin: 20px 0;
        }

        @media (max-width: 768px) {
            .page-header h1 {
                font-size: 1.8rem;
            }

            .section-content {
                padding: 20px;
            }

            .form-control {
                font-size: 0.85rem;
                padding: 8px 12px;
            }

            .form-label {
                font-size: 0.8rem;
            }

            .btn-submit,
            .btn-delete {
                font-size: 0.9rem;
                padding: 10px 16px;
            }

            .list-group-item {
                font-size: 0.85rem;
            }
        }
    </style>
    <!-- End of custom CSS -->
</head>
<body>
<%@include file="component/navbar.jsp"%>

<!-- Security Check: Redirect if user is not logged in -->
<c:if test="${empty userObj }">
    <c:redirect url="/user_login.jsp"></c:redirect>
</c:if>

<div class="page-wrapper">
    <!-- Page Header -->
    <div class="page-header">
        <h1>👤 My Profile & Settings</h1>
        <p>Manage your account details</p>
    </div>

    <!-- Profile Section -->
    <div class="section">
        <div class="section-header">
            <h2>🛠️ Profile Management</h2>
        </div>
        <div class="section-content">
            <!-- Message Display -->
            <c:if test="${not empty succMsg}">
                <div class="message-success">${succMsg}</div>
                <c:remove var="succMsg" scope="session" />
            </c:if>
            <c:if test="${not empty errorMsg}">
                <div class="message-error">${errorMsg}</div>
                <c:remove var="errorMsg" scope="session" />
            </c:if>

            <div class="row">
                <!-- Current Details Column (Left) -->
                <div class="col-md-6 mb-4">
                    <div class="section">
                        <div class="section-header">
                            <h2>📋 Current Details</h2>
                        </div>
                        <div class="section-content">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">
                                    <strong>User ID:</strong> <span>${userObj.id}</span>
                                </li>
                                <li class="list-group-item">
                                    <strong>Full Name:</strong> <span>${userObj.fullName}</span>
                                </li>
                                <li class="list-group-item">
                                    <strong>Email:</strong> <span>${userObj.email}</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Update & Delete Column (Right) -->
                <div class="col-md-6 mb-4">
                    <div class="section">
                        <div class="section-header">
                            <h2>✏️ Update Details</h2>
                        </div>
                        <div class="section-content">
                            <!-- Update Form -->
                            <form action="UserUpdateServlet" method="post">
                                <input type="hidden" name="id" value="${userObj.id}">
                                <div class="form-group">
                                    <label class="form-label">Full Name</label>
                                    <input type="text" name="fullName" class="form-control" value="${userObj.fullName}" required maxlength="50" pattern="[A-Za-z\s]+" title="Full Name can only contain letters and spaces, max 50 characters">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Email</label>
                                    <input type="email" name="email" class="form-control" value="${userObj.email}" required maxlength="50" title="Enter a valid email address, max 50 characters">
                                </div>
                                <button type="submit" class="btn-submit">Update Profile</button>
                            </form>

                            <hr>

                            <!-- Delete Account Section -->
                            <div class="text-center">
                                <p class="text-danger fw-bold">Permanently Delete Account</p>
                                <form action="UserDeleteServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="${userObj.id}">
                                    <button type="submit" class="btn-delete" onclick="return confirm('WARNING: Are you absolutely sure you want to delete your account? This action is irreversible and will log you out immediately.')">
                                        Delete My Account
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="/component/footer.jsp"%>
</body>
</html>