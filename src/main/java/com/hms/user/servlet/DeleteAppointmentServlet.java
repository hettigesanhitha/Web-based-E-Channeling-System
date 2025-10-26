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

@WebServlet("/deleteAppointment")
public class DeleteAppointmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int appointmentId = Integer.parseInt(req.getParameter("id"));
        int userId = Integer.parseInt(req.getParameter("userId"));

        AppointmentDAO dao = new AppointmentDAO(DBConnection.getConn());
        boolean f = dao.deleteAppointment(appointmentId, userId);

        HttpSession session = req.getSession();

        if (f) {
            session.setAttribute("successMsg", "Appointment deleted successfully.");
        } else {
            session.setAttribute("errorMsg", "Something went wrong while deleting appointment.");
        }

        resp.sendRedirect("view_appointment.jsp");
    }
}
