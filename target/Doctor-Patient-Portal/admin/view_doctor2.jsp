<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="com.hms.entity.Specialist"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.SpecialistDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%-- JSTL, EL, CSS, and Navbar includes removed as requested --%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Doctor List</title>
    <style>
        /* Minimal inline styling for a clean, readable table */
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 20px; background-color: #f4f7f6; }
        .container { max-width: 1200px; margin: 0 auto; padding: 20px; background-color: #fff; box-shadow: 0 4px 12px rgba(0,0,0,0.1); border-radius: 8px; }
        h3 { text-align: center; color: #dc3545; margin-bottom: 25px; border-bottom: 2px solid #e0e0e0; padding-bottom: 10px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 12px 15px; text-align: left; }
        thead th { background-color: #007bff; color: white; }
        tbody tr:nth-child(even) { background-color: #f8f8f8; }
        tbody tr:hover { background-color: #e8e8e8; }
    </style>
</head>
<body>

<div class="container">
    <div>
        <div>
            <h3 class="text-danger">List of Hospital Doctors</h3>

            <table>
                <thead>
                <tr>
                    <th>Full Name</th>
                    <th>DOB</th>
                    <th>Qualification</th>
                    <th>Specialist</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <%-- Action field (Edit/Delete) removed --%>
                </tr>
                </thead>
                <tbody>

                <%
                    DoctorDAO docDAO2 = new DoctorDAO(DBConnection.getConn());
                    List<Doctor> listOfDoc = docDAO2.getAllDoctor();
                    for (Doctor doctorLst : listOfDoc) {
                %>
                <tr>
                    <th><%=doctorLst.getFullName()%></th>
                    <td><%=doctorLst.getDateOfBirth()%></td>
                    <td><%=doctorLst.getQualification()%></td>
                    <td><%=doctorLst.getSpecialist()%></td>
                    <td><%=doctorLst.getEmail()%></td>
                    <td><%=doctorLst.getPhone()%></td>
                    <%-- Action buttons removed --%>
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