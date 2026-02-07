package com.hotel.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class TestDB {
    public static void main(String[] args) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT 1");
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                System.out.println("✅ DB Connected! SELECT 1 = " + rs.getInt(1));
            }

        } catch (Exception e) {
            System.out.println("❌ DB Connection failed!");
            e.printStackTrace();
        }
    }
}
