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
import com.hms.entity.User;

@WebServlet("/UserUpdateServlet")
public class UserUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("id"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");

        HttpSession session = request.getSession();

        UserDAO dao = new UserDAO(DBConnection.getConn());

        try {
            // 1. Create a User object with updated details
            User updatedUser = new User();
            updatedUser.setId(userId);
            updatedUser.setFullName(fullName);
            updatedUser.setEmail(email);

            // 2. Perform the update
            boolean f = dao.updateUser(updatedUser);

            if (f) {
                // Get the old User object from the session
                User oldUser = (User) session.getAttribute("userObj"); // <<--- FIX 1: Explicit cast to User

                // 3. Re-fetch the user object to update the session data instantly
                // Use the new email and the original password from the old user object
                User freshUser = dao.loginUser(email, oldUser.getPassword()); // <<--- FIX 2: Use the casted object

                session.setAttribute("succMsg", "Profile Details Updated Successfully!");
                session.setAttribute("userObj", freshUser); // Update the user object in session

                response.sendRedirect("view_user.jsp");
            } else {
                session.setAttribute("errorMsg", "Update failed. Something went wrong on the server.");
                response.sendRedirect("view_user.jsp");
            }

        } catch (Exception e) {
            session.setAttribute("errorMsg", "An unexpected error occurred: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("view_user.jsp");
        }
    }
}