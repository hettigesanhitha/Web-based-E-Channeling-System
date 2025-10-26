<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html><head><title>Staff Dashboard</title><%@include file="../component/allcss.jsp"%></head>
<body><%@include file="../component/navbar.jsp"%>
<c:if test="${empty staffObj}"><c:redirect url="../stafflogin.jsp" /></c:if>
<div class="container p-4">
  <h3>Staff Dashboard</h3>
  <div class="mt-3">
    <a href="${pageContext.request.contextPath}/admin/view_doctor2.jsp" class="btn btn-outline-dark">View Doctors</a>
    <a href="${pageContext.request.contextPath}/admin/patient2.jsp" class="btn btn-outline-dark">View Users</a>
    <c:if test="${staffObj.accessLevel eq 'full'}">
      <td>
        <a href="${pageContext.request.contextPath}/admin/index.jsp" class="btn btn-primary btn-sm">Hospital Administrator</a>
      </td>
    </c:if>
  </div>
</div>
</body></html>
