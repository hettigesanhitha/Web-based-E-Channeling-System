package com.hms.dao;

import com.hms.entity.Staff;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AdminManagementDAO {
    private Connection conn;

    public AdminManagementDAO(Connection conn) {
        this.conn = conn;
    }

    // Create staff account
    public boolean createStaff(Staff staff) {
        try {
            String sql = "INSERT INTO staff (fullName, email, password, staffType, access_level) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, staff.getFullName());
            pstmt.setString(2, staff.getEmail());
            pstmt.setString(3, staff.getPassword());
            pstmt.setString(4, staff.getStaffType());
            pstmt.setString(5, staff.getAccessLevel());
            pstmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Read all staff
    public List<Staff> getAllStaff() {
        List<Staff> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM staff";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Staff staff = new Staff();
                staff.setId(rs.getInt("id"));
                staff.setFullName(rs.getString("fullName"));
                staff.setEmail(rs.getString("email"));
                staff.setPassword(rs.getString("password"));
                staff.setStaffType(rs.getString("staffType"));
                staff.setAccessLevel(rs.getString("access_level"));
                list.add(staff);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Update staff access level
    public boolean updateStaffAccess(int id, String accessLevel) {
        try {
            String sql = "UPDATE staff SET access_level = ? WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, accessLevel);
            pstmt.setInt(2, id);
            pstmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete staff
    public boolean deleteStaff(int id) {
        try {
            String sql = "DELETE FROM staff WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
