package com.hms.user.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hms.dao.AppointmentDAO;
import com.hms.db.DBConnection;
import com.hms.entity.Appointment;

@WebServlet("/editAppointment")
public class EditAppointmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        int userId = Integer.parseInt(req.getParameter("userId"));
        String fullName = req.getParameter("fullName");
        String gender = req.getParameter("gender");
        String age = req.getParameter("age");
        String appointmentDate = req.getParameter("appointmentDate");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String diseases = req.getParameter("diseases");
        int doctorId = Integer.parseInt(req.getParameter("doctorNameSelect"));
        String address = req.getParameter("address");

        Appointment appointment = new Appointment(id, userId, fullName, gender, age, appointmentDate, email, phone, diseases, doctorId, address, "Pending");

        AppointmentDAO dao = new AppointmentDAO(DBConnection.getConn());
        boolean f = dao.updateAppointment(appointment);

        HttpSession session = req.getSession();

        if (f) {
            session.setAttribute("successMsg", "Appointment updated successfully.");
        } else {
            session.setAttribute("errorMsg", "Something went wrong while updating appointment.");
        }

        resp.sendRedirect("view_appointment.jsp");
    }
}
