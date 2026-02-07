package com.hotel.dao;

import com.hotel.util.DBConnection;

import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.Map;

public class ReportDAO {

    public Map<String, Object> getSummary() {
        Map<String, Object> m = new LinkedHashMap<>();
        LocalDate today = LocalDate.now();

        try (var con = DBConnection.getConnection()) {

            // totals
            m.put("totalReservations", scalarInt(con, "SELECT COUNT(*) FROM reservations"));
            m.put("reservedCount", scalarInt(con, "SELECT COUNT(*) FROM reservations WHERE status='RESERVED'"));
            m.put("cancelledCount", scalarInt(con, "SELECT COUNT(*) FROM reservations WHERE status='CANCELLED'"));

            // today checkins / checkouts
            m.put("todayCheckins", scalarInt(con, "SELECT COUNT(*) FROM reservations WHERE status='RESERVED' AND check_in=?", Date.valueOf(today)));
            m.put("todayCheckouts", scalarInt(con, "SELECT COUNT(*) FROM reservations WHERE status='RESERVED' AND check_out=?", Date.valueOf(today)));

            // revenue
            m.put("reservedRevenue", scalarDecimal(con, "SELECT COALESCE(SUM(total_amount),0) FROM reservations WHERE status='RESERVED'"));

            return m;

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public Map<String, Integer> getTopRooms(int limit) {
        String sql =
            "SELECT r.room_number, COUNT(*) cnt " +
            "FROM reservations res JOIN rooms r ON r.id=res.room_id " +
            "WHERE res.status='RESERVED' " +
            "GROUP BY r.room_number ORDER BY cnt DESC LIMIT ?";

        try (var con = DBConnection.getConnection();
             var ps = con.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (var rs = ps.executeQuery()) {
                Map<String, Integer> map = new LinkedHashMap<>();
                while (rs.next()) map.put(rs.getString(1), rs.getInt(2));
                return map;
            }
        } catch (Exception e) { throw new RuntimeException(e); }
    }

    private int scalarInt(java.sql.Connection con, String sql, Object... params) throws Exception {
        try (var ps = con.prepareStatement(sql)) {
            for (int i=0;i<params.length;i++) ps.setObject(i+1, params[i]);
            try (var rs = ps.executeQuery()) { rs.next(); return rs.getInt(1); }
        }
    }

    private BigDecimal scalarDecimal(java.sql.Connection con, String sql, Object... params) throws Exception {
        try (var ps = con.prepareStatement(sql)) {
            for (int i=0;i<params.length;i++) ps.setObject(i+1, params[i]);
            try (var rs = ps.executeQuery()) { rs.next(); return rs.getBigDecimal(1); }
        }
    }
}
