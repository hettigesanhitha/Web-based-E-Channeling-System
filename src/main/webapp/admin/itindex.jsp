<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IT Admin Dashboard</title>

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
            text-align: center;
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

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 28px;
            margin-top: 40px;
        }

        .menu-card {
            background: white;
            border-radius: 12px;
            padding: 0;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07), 0 10px 20px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .menu-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
            border-color: #667eea;
        }

        .menu-card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 25px;
            color: white;
        }

        .menu-card-icon {
            font-size: 2.5rem;
            margin-bottom: 12px;
            display: block;
        }

        .menu-card-title {
            font-size: 1.4rem;
            font-weight: 600;
            letter-spacing: -0.3px;
            margin: 0;
        }

        .menu-card-body {
            padding: 25px;
        }

        .menu-card-description {
            color: #7f8c8d;
            font-size: 0.95rem;
            margin-bottom: 20px;
            line-height: 1.5;
        }

        .menu-card-link {
            display: inline-block;
            padding: 12px 28px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
        }

        .menu-card-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(102, 126, 234, 0.4);
            color: white;
            text-decoration: none;
        }

        .menu-card-link:active {
            transform: translateY(0);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #7f8c8d;
        }

        .empty-state-icon {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            color: #2c3e50;
            margin-bottom: 10px;
        }

        @media (max-width: 768px) {
            .page-header h1 {
                font-size: 1.8rem;
            }

            .menu-grid {
                grid-template-columns: 1fr;
                gap: 16px;
            }

            .menu-card-header {
                padding: 20px;
            }

            .menu-card-body {
                padding: 20px;
            }

            .menu-card-icon {
                font-size: 2rem;
            }

            .menu-card-title {
                font-size: 1.2rem;
            }
        }

        /* Redirect security check */
        <c:if test="${empty itAdminObj}">
        body { display: none; }
        </c:if>
    </style>
</head>
<body>


<!-- Security Check - Redirect if not logged in -->
<c:if test="${empty itAdminObj}">
    <c:redirect url="login.jsp" />
</c:if>

<div class="dashboard-container">
    <!-- Page Header -->
    <div class="page-header">
        <h1>⚙️ IT Admin Dashboard</h1>
        <p>Manage and configure system administration tasks</p>
    </div>

    <!-- Menu Grid -->
    <div class="menu-grid">
        <!-- Staff Management Card -->
        <div class="menu-card">
            <div class="menu-card-header">
                <span class="menu-card-icon">👥</span>
                <h2 class="menu-card-title">Staff Management</h2>
            </div>
            <div class="menu-card-body">
                <p class="menu-card-description">
                    Create, update, and manage all staff members in the system. Control access levels and permissions.
                </p>
                <a href="${pageContext.request.contextPath}/admin/staff.jsp" class="menu-card-link">
                    Manage Staff →
                </a>
            </div>
        </div>

        <!-- Future: Add more menu items here following the same structure -->
        <!-- Example template for additional cards:
        <div class="menu-card">
            <div class="menu-card-header">
                <span class="menu-card-icon">📊</span>
                <h2 class="menu-card-title">Reports</h2>
            </div>
            <div class="menu-card-body">
                <p class="menu-card-description">
                    View and generate system reports and analytics.
                </p>
                <a href="#" class="menu-card-link">View Reports →</a>
            </div>
        </div>
        -->
    </div>
</div>


</body>
</html>