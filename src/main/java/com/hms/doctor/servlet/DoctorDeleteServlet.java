package com.hms.doctor.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hms.dao.DoctorDAO;
import com.hms.db.DBConnection;

@WebServlet("/doctorDelete")
public class DoctorDeleteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int doctorId = Integer.parseInt(req.getParameter("doctorId"));
        DoctorDAO doctorDAO = new DoctorDAO(DBConnection.getConn());
        HttpSession session = req.getSession();

        boolean success = doctorDAO.deleteDoctorById(doctorId);

        if (success) {
            // Remove session and redirect to login page
            session.invalidate();
            resp.sendRedirect("doctor_login.jsp");
        } else {
            session.setAttribute("errorMsgForD", "Failed to delete your account.");
            resp.sendRedirect("doctor/edit_profile.jsp");
        }
    }
}
