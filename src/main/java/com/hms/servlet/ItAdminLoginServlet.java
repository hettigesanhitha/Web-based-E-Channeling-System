package com.hms.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/itAdminLogin")
public class ItAdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        HttpSession session = req.getSession();

        if ("itadmin@gmail.com".equals(email) && "itadmin".equals(password)) {
            session.setAttribute("itAdminObj", new Object());  // Placeholder for IT admin session
            resp.sendRedirect("admin/itindex.jsp");
        } else {
            session.setAttribute("errorMsg", "Invalid credentials");
            resp.sendRedirect("login.jsp");
        }
    }
}