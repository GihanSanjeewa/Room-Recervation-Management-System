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
    
    public Map<String, Object> getSummary(LocalDate from, LocalDate to) {
        Map<String, Object> m = new LinkedHashMap<>();

        // We treat "to" as inclusive. SQL uses < (to + 1)
        LocalDate toExclusive = to.plusDays(1);

        try (var con = DBConnection.getConnection()) {

            // Total reservations created in range
            m.put("totalReservations", scalarInt(con,
                    "SELECT COUNT(*) FROM reservations WHERE created_at >= ? AND created_at < ?",
                    Date.valueOf(from), Date.valueOf(toExclusive)));

            // Reserved / Cancelled created in range
            m.put("reservedCount", scalarInt(con,
                    "SELECT COUNT(*) FROM reservations WHERE status='RESERVED' AND created_at >= ? AND created_at < ?",
                    Date.valueOf(from), Date.valueOf(toExclusive)));

            m.put("cancelledCount", scalarInt(con,
                    "SELECT COUNT(*) FROM reservations WHERE status='CANCELLED' AND created_at >= ? AND created_at < ?",
                    Date.valueOf(from), Date.valueOf(toExclusive)));

            // Revenue for reservations that are RESERVED and created in range
            m.put("reservedRevenue", scalarDecimal(con,
                    "SELECT COALESCE(SUM(total_amount),0) FROM reservations " +
                    "WHERE status='RESERVED' AND created_at >= ? AND created_at < ?",
                    Date.valueOf(from), Date.valueOf(toExclusive)));

            // Check-ins in range (based on check_in)
            m.put("checkins", scalarInt(con,
                    "SELECT COUNT(*) FROM reservations WHERE status='RESERVED' AND check_in >= ? AND check_in <= ?",
                    Date.valueOf(from), Date.valueOf(to)));

            // Check-outs in range (based on check_out)
            m.put("checkouts", scalarInt(con,
                    "SELECT COUNT(*) FROM reservations WHERE status='RESERVED' AND check_out >= ? AND check_out <= ?",
                    Date.valueOf(from), Date.valueOf(to)));

            return m;

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public Map<String, Integer> getTopRooms(LocalDate from, LocalDate to, int limit) {
        String sql =
            "SELECT r.room_number, COUNT(*) cnt " +
            "FROM reservations res " +
            "JOIN rooms r ON r.id=res.room_id " +
            "WHERE res.status='RESERVED' " +
            "AND res.created_at >= ? AND res.created_at < ? " +
            "GROUP BY r.room_number ORDER BY cnt DESC LIMIT ?";

        LocalDate toExclusive = to.plusDays(1);

        try (var con = DBConnection.getConnection();
             var ps = con.prepareStatement(sql)) {

            ps.setDate(1, Date.valueOf(from));
            ps.setDate(2, Date.valueOf(toExclusive));
            ps.setInt(3, limit);

            try (var rs = ps.executeQuery()) {
                Map<String, Integer> map = new LinkedHashMap<>();
                while (rs.next()) map.put(rs.getString(1), rs.getInt(2));
                return map;
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
