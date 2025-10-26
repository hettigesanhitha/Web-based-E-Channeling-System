<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="com.hms.entity.Specialist"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.SpecialistDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor List</title>
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

        .table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        .table thead th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-weight: 600;
            padding: 12px 15px;
            text-align: left;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .table tbody tr {
            transition: background-color 0.2s ease;
        }

        .table tbody tr:hover {
            background-color: #f8f9fa;
        }

        .table tbody td {
            padding: 12px 15px;
            font-size: 0.9rem;
            color: #2c3e50;
            border-bottom: 1px solid #e0e0e0;
        }

        @media (max-width: 768px) {
            .page-header h1 {
                font-size: 1.8rem;
            }

            .section-content {
                padding: 20px;
            }

            .table thead th {
                font-size: 0.85rem;
                padding: 10px;
            }

            .table tbody td {
                font-size: 0.8rem;
                padding: 10px;
            }
        }

        @media (max-width: 576px) {
            .table-responsive {
                overflow-x: auto;
            }

            .table {
                min-width: 600px;
            }
        }
    </style>
    <!-- End of custom CSS -->
</head>
<body>
<%@include file="../component/navbar.jsp"%>

<div class="page-wrapper">
    <!-- Page Header -->
    <div class="page-header">
        <h1>🩺 Doctor List</h1>
        <p>Explore our team of medical professionals</p>
    </div>

    <!-- Doctor List Section -->
    <div class="section">
        <div class="section-header">
            <h2>📋 List of Hospital Doctors</h2>
        </div>
        <div class="section-content">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Full Name</th>
                        <th>Qualification</th>
                        <th>Specialist</th>
                        <th>Email</th>
                        <th>Phone</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        DoctorDAO docDAO2 = new DoctorDAO(DBConnection.getConn());
                        List<Doctor> listOfDoc = docDAO2.getAllDoctor();
                        for (Doctor doctorLst : listOfDoc) {
                    %>
                    <tr>
                        <td><%= doctorLst.getFullName() %></td>
                        <td><%= doctorLst.getQualification() %></td>
                        <td><%= doctorLst.getSpecialist() %></td>
                        <td><%= doctorLst.getEmail() %></td>
                        <td><%= doctorLst.getPhone() %></td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@include file="/component/footer.jsp"%>
</body>
</html>