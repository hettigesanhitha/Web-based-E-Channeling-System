<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="com.hms.entity.User"%>
<%@page import="com.hms.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.AppointmentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>


<!-- for jstl tag -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- end of jstl tag -->

<%@page isELIgnored="false"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- for responsive -->
	<!-- <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
	<!-- for responsive -->
	<title>View Appointment Page</title>

	<!-- all css include -->
	<%@include file="../component/allcss.jsp"%>

	<!-- customs css for this page -->
	<style type="text/css">
		.my-card {
			box-shadow: 0px 0px 10px 1px maroon;
			/*box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.3);*/
		}

		/* backgournd image css */
		.my-bg-img {
			background: linear-gradient(rgba(0, 0, 0, .4), rgba(0, 0, 0, .4)),
			url("img/hospital1.jpg");
			height: 20vh;
			width: 100%;
			background-size: cover;
			background-repeat: no-repeat;
		}

		/* backgournd image css */
	</style>
	<!-- end of customs css for this page -->


</head>
<body>
<%@include file="component/navbar.jsp"%>

<!-- if not login then log in first -->
<c:if test="${empty userObj }">

	<c:redirect url="/user_login.jsp"></c:redirect>

</c:if>

<!-- start 1st Div -->

<div class="container-fluid my-bg-img p-5">
	<!-- css background image -->
	<p class="text-center fs-2 text-white"></p>

</div>

<!-- end of 1st Div -->

<!-- 2nd Div -->

<div class="container-fluid p-3">
	<p class="fs-2"></p>

	<div class="row">



		<!-- col-2 -->
		<div class="col-md-9">
			<div class="card my-card">
				<div class="card-body">
					<p class="fw-bold text-center myP-color fs-4">Appointment List</p>

					<%-- <!-- message print -->
                    <!-- for success msg -->
                    <c:if test="${not empty successMsg }">
                        <p class="text-center text-success fs-5">${successMsg}</p>
                        <c:remove var="successMsg" scope="session" />
                    </c:if>

                    <!-- for error msg -->
                    <c:if test="${not empty errorMsg }">
                        <p class="text-center text-danger fs-5">${errorMsg}</p>
                        <c:remove var="errorMsg" scope="session" />
                    </c:if>
                    <!-- End of message print --> --%>

					<table class="table table-striped">
						<thead>
						<tr class="my-bg-color text-white">
							<!-- <th scope="col">Id</th> -->
							<th scope="col">Full Name</th>
							<th scope="col">Gender</th>
							<th scope="col">Age</th>
							<th scope="col">Appointment Date</th>
							<!-- <th scope="col">Email</th> -->
							<th scope="col">Phone</th>
							<th scope="col">Diseases</th>
							<th scope="col">Doctor Name</th>
							<th scope="col">Address</th>
							<!-- <th scope="col">User Id</th> -->
							<th scope="col">Status</th>
							<th scope="col">Action</th>
						</tr>
						</thead>
						<tbody>
						<%
							User user = (User) session.getAttribute("userObj");
							DoctorDAO dDAO = new DoctorDAO(DBConnection.getConn());

							AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());

							List<Appointment> list = appDAO.getAllAppointmentByLoginUser(user.getId());
							for (Appointment apptList : list) {
								Doctor doctor = dDAO.getDoctorById(apptList.getDoctorId());
						%>


						<tr>
							<%-- <th scope="row"><%= apptList.getId() %></th> --%>
							<td><%=apptList.getFullName()%></td>
							<td><%=apptList.getGender()%></td>
							<td><%=apptList.getAge()%></td>
							<td><%=apptList.getAppointmentDate()%></td>
							<%-- <td><%= apptList.getEmail()%></td> --%>
							<td><%=apptList.getPhone()%></td>
							<td><%=apptList.getDiseases()%></td>
							<td><%=doctor.getFullName()%></td>
							<td><%= apptList.getAddress()%></td>
							<%-- <td><%= apptList.getUserId()%></td> --%>
							<td>
								<%
									if ("Pending".equals(apptList.getStatus())) {
								%> <a href="" class="btn btn-sm btn-warning">Pending</a> <%
							} else {
							%> <%=apptList.getStatus()%> <%
								}
							%>
							</td>
							<td>
								<button class="btn btn-sm btn-primary"
										onclick="openEditModal(<%=apptList.getId()%>)">Edit</button>
								<form action="deleteAppointment" method="post"
									  style="display: inline;">
									<input type="hidden" name="id" value="<%=apptList.getId()%>">
									<input type="hidden" name="userId" value="<%=user.getId()%>">
									<button type="submit" class="btn btn-sm btn-danger"
											onclick="return confirm('Are you sure you want to delete this appointment?');">
										Delete</button>
								</form>
							</td>



						</tr>


						<%
							}
						%>


						</tbody>
					</table>




				</div>
			</div>

		</div>

		<!-- col-1 -->
		<div class="col-md-3 p-3">
			<!-- for Background image -->
			<!-- <img alt="" src="img/picDoc.jpg" width="500px" height="400px"> -->
			<img alt="" src="img/wdoc.jpg" width="250" height="">
		</div>



	</div>


</div>

<!-- Edit Appointment Modal -->
<div class="modal fade" id="editModal" tabindex="-1"
	 aria-labelledby="editModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header bg-primary text-white">
				<h5 class="modal-title" id="editModalLabel">Edit Appointment</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
			</div>
			<div class="modal-body" id="editModalContent">
				<!-- Appointment form will be loaded here -->
			</div>
		</div>
	</div>
</div>

<script>
	function openEditModal(id) {
		fetch('edit_appointment.jsp?id=' + id)
				.then(response => response.text())
				.then(html => {
					document.getElementById('editModalContent').innerHTML = html;
					const modal = new bootstrap.Modal(document.getElementById('editModal'));
					modal.show();
				});
	}
</script>




</body>
</html>