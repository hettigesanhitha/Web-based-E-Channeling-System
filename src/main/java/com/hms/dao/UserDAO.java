package com.hms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException; // Import SQLException for better handling

import com.hms.entity.User;

public class UserDAO {

	private Connection conn;

	public UserDAO(Connection conn) {
		super();
		this.conn = conn;
	}

	public boolean userRegister(User user) {

		boolean f = false;
		String sql = "INSERT INTO user_details(full_name, email, password) VALUES(?,?,?)";

		// FIX: Use try-with-resources
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, user.getFullName());
			pstmt.setString(2, user.getEmail());
			// IMPORTANT: Hash the password before storing in a real application!
			pstmt.setString(3, user.getPassword());

			int rowsAffected = pstmt.executeUpdate();

			if (rowsAffected == 1) {
				f = true;
			}

		} catch (SQLException e) { // Catch specific exception
			e.printStackTrace();
		}

		return f;
	}

	public User loginUser(String email, String password) {

		User user = null;
		String sql = "SELECT id, full_name, email, password FROM user_details WHERE email=? AND password=?";

		// FIX: Use try-with-resources for pstmt and resultSet
		try (PreparedStatement pstmt = this.conn.prepareStatement(sql)) {
			pstmt.setString(1, email);
			pstmt.setString(2, password);

			try (ResultSet resultSet = pstmt.executeQuery()) {
				if (resultSet.next()) {
					user = new User();
					user.setId(resultSet.getInt("id"));
					user.setFullName(resultSet.getString("full_name"));
					user.setEmail(resultSet.getString("email"));
					user.setPassword(resultSet.getString("password"));
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return user;
	}

	public boolean checkOldPassword(int userId, String oldPassword) {

		boolean f = false;
		String sql = "SELECT id FROM user_details WHERE id=? AND password=?";

		// FIX: Use try-with-resources
		try (PreparedStatement pstmt = this.conn.prepareStatement(sql)) {
			pstmt.setInt(1, userId);
			pstmt.setString(2, oldPassword);

			try (ResultSet resultSet = pstmt.executeQuery()) {
				if (resultSet.next()) { // Use if since id is unique
					f = true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return f;
	}

	public boolean changePassword(int userId, String newPassword) {

		boolean f = false;
		String sql = "UPDATE user_details SET password=? WHERE id=?";

		// FIX: Use try-with-resources
		try (PreparedStatement pstmt = this.conn.prepareStatement(sql)) {
			pstmt.setString(1, newPassword);
			pstmt.setInt(2, userId);

			int rowsAffected = pstmt.executeUpdate();
			if (rowsAffected == 1) {
				f = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return f;
	}

	// === NEW METHOD: Update User Details (Name and Password) ===
	public boolean updateUser(User user) {
		boolean f = false;
		// SQL is changed to update only full_name and email
		String sql = "UPDATE user_details SET full_name=?, email=? WHERE id=?";

		try (PreparedStatement pstmt = this.conn.prepareStatement(sql)) {
			pstmt.setString(1, user.getFullName());
			pstmt.setString(2, user.getEmail());
			pstmt.setInt(3, user.getId());

			int rowsAffected = pstmt.executeUpdate();
			if (rowsAffected == 1) {
				f = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return f;
	}

	// === NEW METHOD: Delete User Account ===
	public boolean deleteUser(int userId) {
		boolean f = false;
		String sql = "DELETE FROM user_details WHERE id=?";

		try (PreparedStatement pstmt = this.conn.prepareStatement(sql)) {
			pstmt.setInt(1, userId);

			int rowsAffected = pstmt.executeUpdate();
			if (rowsAffected == 1) {
				f = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return f;
	}
}