package com.hms.doctor.servlet;

import com.hms.dao.AppointmentDAO;
import com.hms.db.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/clearComment")
public class ClearComment extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			int id = Integer.parseInt(req.getParameter("id"));
			int doctorId = Integer.parseInt(req.getParameter("doctorId"));

			AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
			boolean cleared = appDAO.clearDrAppointmentCommentStatus(id, doctorId);

			HttpSession session = req.getSession();
			if (cleared) {
				session.setAttribute("successMsg", "Comment deleted");
			} else {
				session.setAttribute("errorMsg", "Unable to delete comment");
			}

			resp.sendRedirect("doctor/patient.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}


