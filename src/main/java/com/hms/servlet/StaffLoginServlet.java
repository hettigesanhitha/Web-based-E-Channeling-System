package com.hms.servlet;

import com.hms.dao.AdminManagementDAO;
import com.hms.db.DBConnection;
import com.hms.entity.Staff;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/staffLogin")
public class StaffLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        HttpSession session = req.getSession();

        Connection conn = DBConnection.getConn();
        AdminManagementDAO dao = new AdminManagementDAO(conn);
        List<Staff> staffList = dao.getAllStaff();

        boolean loggedIn = false;
        for (Staff s : staffList) {
            if (s.getEmail().equals(email) && s.getPassword().equals(password)) {
                session.setAttribute("staffObj", s);
                resp.sendRedirect("staff/dashboard.jsp");
                loggedIn = true;
                break;
            }
        }

        if (!loggedIn) {
            session.setAttribute("errorMsg", "Invalid credentials");
            resp.sendRedirect("stafflogin.jsp");
        }
    }
}
