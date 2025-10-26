<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head><title>IT Admin Login</title><%@include file="/component/allcss.jsp"%></head>
<body>
<%@include file="/component/navbar.jsp"%>
<div class="container p-5">
  <div class="col-md-4 offset-md-4">
    <div class="card my-card">
      <div class="card-header text-white my-bg-color">IT Admin Login</div>
      <div class="card-body">
        <form action="${pageContext.request.contextPath}/itAdminLogin" method="post">
          <div class="mb-2"><label>Email</label><input name="email" type="email" class="form-control" required></div>
          <div class="mb-2"><label>Password</label><input name="password" type="password" class="form-control" required></div>
          <button class="btn my-bg-color text-white col-12">Login</button>
        </form>
      </div>
    </div>
  </div>
</div>
</body></html>
