package com.hms.entity;

public class Staff {
    private int id;
    private String fullName;
    private String email;
    private String password;
    private String staffType; // hospital_admin, nurse, receptionist
    private String accessLevel; // full, read_only

    public Staff() {}

    public Staff(int id, String fullName, String email, String password, String staffType, String accessLevel) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.staffType = staffType;
        this.accessLevel = accessLevel;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStaffType() {
        return staffType;
    }

    public void setStaffType(String staffType) {
        this.staffType = staffType;
    }

    public String getAccessLevel() {
        return accessLevel;
    }

    public void setAccessLevel(String accessLevel) {
        this.accessLevel = accessLevel;
    }
}