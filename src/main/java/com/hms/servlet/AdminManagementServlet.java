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

@WebServlet("/adminManagement")
public class AdminManagementServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        AdminManagementDAO dao = new AdminManagementDAO(DBConnection.getConn());
        HttpSession session = req.getSession();

        if ("create".equals(action)) {
            Staff staff = new Staff();
            staff.setFullName(req.getParameter("fullName"));
            staff.setEmail(req.getParameter("email"));
            staff.setPassword(req.getParameter("password"));
            staff.setStaffType(req.getParameter("staffType"));
            staff.setAccessLevel(req.getParameter("accessLevel")); // match HTML

            if (dao.createStaff(staff)) {
                session.setAttribute("successMsg", "Staff created successfully!");
            } else {
                session.setAttribute("errorMsg", "Error creating staff.");
            }
            resp.sendRedirect("admin/staff.jsp");

        } else if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            String accessLevel = req.getParameter("accessLevel"); // match HTML
            if (dao.updateStaffAccess(id, accessLevel)) {
                session.setAttribute("successMsg", "Access level updated!");
            } else {
                session.setAttribute("errorMsg", "Error updating access level.");
            }
            resp.sendRedirect("admin/staff.jsp");

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            if (dao.deleteStaff(id)) {
                session.setAttribute("successMsg", "Staff deleted!");
            } else {
                session.setAttribute("errorMsg", "Error deleting staff.");
            }
            resp.sendRedirect("admin/staff.jsp");
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
