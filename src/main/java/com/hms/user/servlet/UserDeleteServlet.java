package com.hms.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hms.dao.UserDAO;
import com.hms.db.DBConnection;

@WebServlet("/UserDeleteServlet")
public class UserDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();

        // IMPORTANT: In a real app, you would need to delete or anonymize all associated data (appointments, etc.)
        // or ensure your foreign keys are set to ON DELETE CASCADE!

        UserDAO dao = new UserDAO(DBConnection.getConn());

        boolean f = dao.deleteUser(userId);

        if (f) {
            session.setAttribute("succMsg", "Your account has been successfully deleted.");
            // Invalidate session and redirect to homepage/login
            session.removeAttribute("userObj");
            session.invalidate();
            response.sendRedirect("index.jsp");
        } else {
            session.setAttribute("errorMsg", "Account deletion failed. There may be dependent records.");
            response.sendRedirect("view_user.jsp");
        }
    }
}