<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Index Page | Doctor</title>
	<%@include file="../component/allcss.jsp"%>


	<style type="text/css">
		.my-card {
			box-shadow: 0px 0px 10px 1px maroon;
			/*box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.3);*/
		}
	</style>
</head>
<body>
<%@include file="navbar.jsp"%>


<c:if test="${empty doctorObj }">

	<c:redirect url="../doctor_login.jsp"></c:redirect>

</c:if>

<div class="container p-5">
	<p class="text-center text-success fs-3">Doctor DashBoard</p>

	<%


		DoctorDAO docDAO = new DoctorDAO(DBConnection.getConn());

		//get current login doctor object from session
		Doctor currentLoginDoctor = (Doctor)session.getAttribute("doctorObj");


	%>

	<div class="row">

		<div class="col-md-4">
			<div class="card my-card">
				<div class="card-body text-center text-primary">
					<i class="fa-solid fa-user-circle fa-3x"></i><br>
					<p class="fs-4 text-center">
						My Profile
					</p>
					<ul class="list-group list-group-flush">
						<li class="list-group-item"><strong>Name:</strong> ${doctorObj.fullName}</li>
						<li class="list-group-item"><strong>Specialist:</strong> ${doctorObj.specialist}</li>
						<li class="list-group-item"><strong>Email:</strong> ${doctorObj.email}</li>
						<li class="list-group-item"><strong>Phone:</strong> ${doctorObj.phone}</li>
						<li class="list-group-item"><strong>Qualification:</strong> ${doctorObj.qualification}</li>
					</ul>
				</div>
			</div>
		</div>

		<div class="col-md-4">
			<div class="card my-card">
				<div class="card-body text-center text-success">
					<i class="fa-solid fa-calendar-check fa-3x"></i><br>
					<p class="fs-4 text-center">
						Total Appointments <br> <%= docDAO.countTotalAppointmentByDoctorId(currentLoginDoctor.getId()) %>
					</p>
				</div>
			</div>

		</div>
	</div>


</div>


</body>
</html>