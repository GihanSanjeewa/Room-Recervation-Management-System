package com.hotel.dao;

import com.hotel.model.User;
import com.hotel.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public boolean createUser(String fullName, String email, String phone, String passwordHash) {
        String sql = "INSERT INTO users(full_name,email,phone,password_hash,role,status) VALUES(?,?,?,?, 'USER','ACTIVE')";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, passwordHash);
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            // duplicate email will throw - treat as false
            return false;
        }
    }

    public User login(String email, String passwordHash) {
        String sql = "SELECT id, full_name, email, phone, role FROM users " +
                     "WHERE email=? AND password_hash=? AND status='ACTIVE'";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, passwordHash);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                return new User(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("role")
                );
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    
    public List<User> getAllUsers() {
        String sql = "SELECT id, full_name, email, phone, role FROM users ORDER BY id DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            List<User> list = new ArrayList<>();
            while (rs.next()) {
                list.add(new User(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("role")
                ));
            }
            return list;
        } catch (Exception e) { throw new RuntimeException(e); }
    }

    public boolean updateRole(int userId, String role) {
        String sql = "UPDATE users SET role=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, role);
            ps.setInt(2, userId);
            return ps.executeUpdate() == 1;
        } catch (Exception e) { throw new RuntimeException(e); }
    }

    public boolean blockUser(int userId) {
        String sql = "UPDATE users SET status='BLOCKED' WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() == 1;
        } catch (Exception e) { throw new RuntimeException(e); }
    }

    public boolean unblockUser(int userId) {
        String sql = "UPDATE users SET status='ACTIVE' WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() == 1;
        } catch (Exception e) { throw new RuntimeException(e); }
    }

}
