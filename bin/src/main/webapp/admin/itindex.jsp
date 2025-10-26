<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head><title>IT Admin Dashboard</title><%@include file="../component/allcss.jsp"%></head>
<body>
<%@include file="../component/navbar.jsp"%>
<c:if test="${empty itAdminObj}"><c:redirect url="login.jsp" /></c:if>
<div class="container p-4">
  <h3 class="text-center">IT Admin Dashboard</h3>
  <div class="row mt-3">
     <div class="col-md-6">
       <div class="card p-3 my-card">
         <h5>Staff Management</h5>
         <p><a href="${pageContext.request.contextPath}/admin/staff.jsp" class="btn btn-outline-dark">Manage Staff</a></p>
       </div>
     </div>
  </div>
</div>
</body>
</html>
