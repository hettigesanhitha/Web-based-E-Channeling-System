<%@page import="com.hms.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile | Hospital</title>

    <%@include file="/component/allcss.jsp"%>

    <style type="text/css">
        .my-card {
            box-shadow: 0px 0px 10px 1px #800000; /* maroon */
        }

        .my-bg-img {
            background: linear-gradient(rgba(0, 0, 0, .4), rgba(0, 0, 0, .4)),
            url("img/hospital1.jpg");
            height: 20vh;
            width: 100%;
            background-size: cover;
            background-repeat: no-repeat;
        }
    </style>
</head>
<body>
<%@include file="component/navbar.jsp"%>

<c:if test="${empty userObj }">
    <c:redirect url="/user_login.jsp"></c:redirect>
</c:if>
<div class="container-fluid my-bg-img p-5">
    <p class="text-center fs-2 text-white">My Profile</p>
</div>
<div class="container p-5">
    <div class="row">

        <div class="col-md-6 offset-md-3">
            <div class="card my-card">
                <div class="card-body">
                    <p class="fw-bold text-center text-success fs-4">User Details</p>

                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">
                            <strong>User ID:</strong> <span class="float-end">${userObj.id}</span>
                        </li>
                        <li class="list-group-item">
                            <strong>Full Name:</strong> <span class="float-end">${userObj.fullName}</span>
                        </li>
                        <li class="list-group-item">
                            <strong>Email:</strong> <span class="float-end">${userObj.email}</span>
                        </li>

                    </ul>



                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>