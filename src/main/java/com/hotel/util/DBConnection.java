package com.hotel.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            throw new RuntimeException("MySQL Driver load failed", e);
        }
    }

    public static Connection getConnection() {
        try {
            // 1) Read from environment variables (for Render / production)
            String host = System.getenv("DB_HOST");
            String port = System.getenv("DB_PORT");
            String name = System.getenv("DB_NAME");
            String user = System.getenv("DB_USER");
            String pass = System.getenv("DB_PASS");

            // 2) Fallback to local DB (for your PC)
            if (isBlank(host) || isBlank(port) || isBlank(name) || isBlank(user)) {
                host = "localhost";
                port = "3306";
                name = "hotel_reservation_mvc";
                user = "root";
                pass = ""; // your local password if you have one
            }

            // 3) Build JDBC URL
            // Aiven requires SSL -> sslMode=REQUIRED
            String url = "jdbc:mysql://" + host + ":" + port + "/" + name
                    + "?sslMode=REQUIRED&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";

            return DriverManager.getConnection(url, user, pass);

        } catch (Exception e) {
            throw new RuntimeException("DB Connection failed", e);
        }
    }

    private static boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
